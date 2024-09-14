#!/bin/bash

# เปิดไฟล์การตั้งค่า SSH และแก้ไขค่า PermitRootLogin และ PasswordAuthentication
echo "แก้ไขไฟล์ /etc/ssh/sshd_config เพื่อให้ root สามารถเข้าสู่ระบบได้"
sudo sed -i 's/^#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#Banner .*/Banner /etc/issue.net/' /etc/ssh/sshd_config

Banner /etc/issue.net

# แก้ไข Banner
echo "แก้ไขไฟล์ /etc/issue.net"
echo -e "========================================\nWARNING: You are logged in as root!\n========================================" | sudo tee /etc/issue.net > /dev/null

# สร้างโฟลเดอร์ .ssh สำหรับ root และกำหนดสิทธิ์
echo "สร้างโฟลเดอร์ .ssh สำหรับ root"
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh

# คัดลอก SSH key จากผู้ใช้ debian ไปที่ root
echo "คัดลอก SSH key จากผู้ใช้ debian ไปที่ root"
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
sudo cat /home/debian/.ssh/authorized_keys | sudo tee -a /root/.ssh/authorized_keys > /dev/null

# กำหนดสิทธิ์ของไฟล์ authorized_keys
echo "กำหนดสิทธิ์ของไฟล์ authorized_keys"
sudo chmod 600 /root/.ssh/authorized_keys
sudo chown root:root /root/.ssh/authorized_keys

# รีสตาร์ทบริการ SSH
echo "รีสตาร์ทบริการ SSH"
sudo systemctl restart sshd

echo "การตั้งค่าเสร็จสมบูรณ์"
