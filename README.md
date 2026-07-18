# Linux Privilege Escalation Deep Dive

Bài huấn luyện CyberRangeCZ/KYPO mô phỏng chuỗi leo thang đặc quyền Linux:

`user → dev → ops → root`

## Topology

| Host | IP | Vai trò |
|---|---:|---|
| attacker | 10.0.1.50 | Kali, phục vụ linPEAS và hashcat |
| target-linux | 10.0.1.10 | Ubuntu chứa các cấu hình sai có chủ đích |

## Chuỗi bài

1. Enumeration và linPEAS.
2. Khai thác `/usr/local/bin/find-dev` có SUID để trở thành `dev`.
3. Lợi dụng quy tắc sudo Vim để trở thành `ops`.
4. Sửa `/opt/scripts/backup.sh` được cron chạy bằng root để lấy private key.
5. Lạm dụng `cap_dac_read_search` trên Python để đọc `/etc/shadow`.
6. Dùng SSH key hoặc crack sha512crypt rồi `su - root` để đọc flag cuối.

## Thông tin truy cập

- Attacker GUI: `user / Password123`
- Target SSH: `user / changeme`

## Lưu ý triển khai

- Attacker tải linPEAS từ GitHub trong provisioning, do đó cần Internet khi tạo sandbox.
- Root chỉ được SSH bằng key (`PermitRootLogin prohibit-password`). Password crack được sử dụng với `su - root`.
- Bài sử dụng Python mặc định của hệ thống thay vì hard-code một phiên bản cụ thể.
- Không sửa binary `/usr/bin/find`; bài tạo bản sao dễ tổn thương tại `/usr/local/bin/find-dev`.
