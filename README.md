# SSH ROOT 

### ขั้นตอนการตั้งค่า SSH ให้ root สามารถเข้าสู่ระบบได้

เปิดไฟล์การตั้งค่า SSH: แก้ไขไฟล์ /etc/ssh/sshd_config เพื่อให้ root สามารถเข้าสู่ระบบได้:
```bash
sudo nano /etc/ssh/sshd_config
```
 ค้นหาและแก้ไข 
```bash
PermitRootLogin yes
PasswordAuthentication yes
Banner /etc/issue.net
```
บันทึกและปิดไฟล์ 
#### แก้ไข Banner
```bash
sudo nano /etc/issue.net
```
ใส่ข้อความที่คุณต้องการให้แสดง เช่น: 
```bash
========================================
WARNING: You are logged in as root!
========================================
```
บันทึกและปิดไฟล์
#### ขั้นตอนการคัดลอก SSH key:
สร้างโฟลเดอร์ .ssh สำหรับ root (ถ้ายังไม่มี): คุณต้องสร้างโฟลเดอร์ .ssh ในไดเรกทอรีของ root และกำหนดสิทธิ์การเข้าถึงที่เหมาะสม:
```bash
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
```
คัดลอก SSH key จากผู้ใช้ debian ไปที่ root: ใช้คำสั่ง cat เพื่อคัดลอกเนื้อหาของไฟล์ authorized_keys ของผู้ใช้ debian ไปที่ root:
```bash
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
```
!# SSH key จากผู้ใช้ debian ที ssh keygen ไว้แล้วต่างหาก ssh โดยไม่ต้อง ใช้ password 
####  คัดลอก SSH key จากผู้ใช้ debian ไปที่ root: ใช้คำสั่ง cat เพื่อคัดลอกเนื้อหาของไฟล์ authorized_keys ของผู้ใช้ debian ไปที่ root:
```bash
sudo cat /home/debian/.ssh/authorized_keys | sudo tee -a /root/.ssh/authorized_keys
```
#### กำหนดสิทธิ์ของไฟล์ authorized_keys: หลังจากคัดลอกไฟล์แล้ว คุณต้องกำหนดสิทธิ์ให้ถูกต้อง:
```bash
sudo chmod 600 /root/.ssh/authorized_keys
sudo chown root:root /root/.ssh/authorized_keys
```
#### รีสตาร์ทบริการ SSH: เพื่อให้การเปลี่ยนแปลงมีผล รีสตาร์ทบริการ SSH:
```bash
sudo systemctl restart sshd
```
## code-server 
## ติดตั้ง Remote-SSH extension บนเซิร์ฟเวอร์
#### ติดตั้ง code-server บนเซิร์ฟเวอร์: ติดตั้ง code-server ซึ่งเป็น VSCode ที่ทำงานบนเซิร์ฟเวอร์:
 VSCode Remote - SSH extension บนเซิร์ฟเวอร์โดยตรงและเปิดให้ทำงานด้วย root ผ่านคอนฟิก SSH บนเซิร์ฟเวอร์. 
 ใช้สิทธิ์ root 
```bash
curl -fsSL https://code-server.dev/install.sh | sh
```
## Visual Studio Code Server
https://code.visualstudio.com/blogs/2022/07/07/vscode-server
Install the VS Code Server on your remote machine (or wherever you want to develop against).

Note: There are different install commands for different remote architectures, which you can review in the server documentation. This post will set up the VS Code Server in a Windows Subsystem for Linux (WSL) instance, which provides a true, isolated Linux environment on Windows and can serve as our "remote", isolated machine.

Run the following command in a WSL terminal:
```bash
wget -O- https://aka.ms/install-vscode-server/setup.sh | sh
```
Start the VS Code Server by running the following command in your WSL terminal :
```bash
code-server
```
You'll be provided a device code and URL to authenticate your GitHub account into the VS Code Server's secure tunneling service.
```bash
Please enter the code 7644-1186 on https://github.com/login/device
```
Authenticate into the tunneling service by entering the device code at the provided auth URL.

If this is your first time launching the VS Code Server from this WSL instance, you'll be prompted to enter a name for your connection. The CLI will suggest a fun default "adjective-noun" name (examples shown below), which you can choose to accept too.
```bash
? What would you like to call this machine? (elegant-pitta) >
```
