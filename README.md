# Terraform + Ansible Hands-on Micro Project

이 프로젝트는 AWS 상에 EC2 인스턴스를 **Terraform으로 프로비저닝**하고,  
**Ansible을 통해 NGINX를 자동 설치**하는 미니멀한 인프라 자동화 실습입니다.

## 📦 사용 기술

- **Terraform**: AWS 리소스 정의 및 생성
- **Ansible**: 구성 관리 (NGINX 설치)
- **Bash**: 전체 실행 및 정리 스크립트 구성
- **AWS EC2 Ubuntu 22.04**: 배포 대상 서버

---

## 🛠️ 기능 흐름

1. 사용자는 로컬에 SSH 키를 **미리 생성**해야 함 (`~/.ssh/id_rsa`, `~/.ssh/id_rsa.pub`)
2. Terraform으로 다음 리소스 자동 생성:
   - VPC, Subnet, Internet Gateway, Route Table
   - Security Group (22번 포트 허용)
   - EC2 인스턴스 (Ubuntu)
   - Key Pair 등록
3. Terraform Output으로 퍼블릭 IP 추출
4. Ansible 인벤토리 파일 자동 생성
5. Ansible을 통해 EC2에 접속 → NGINX 설치

---

## 🚀 실행 방법

### 1. SSH 키 미리 생성

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

### 2. 전체 실행

```bash
bash run.sh
```

## 🧹 정리 방법

생성된 모든 리소스를 삭제하는 하려면:

```bash
bash cleanup.sh
```

## 📁 디렉토리 구조

```text
.
├── ansible/
│   └── nginx.yml             # Ansible Playbook
├── cleanup.sh                # 리소스 정리 스크립트
├── run.sh                    # 전체 실행 스크립트
├── terraform/
│   ├── main.tf               # 리소스 정의
│   ├── outputs.tf            # EC2 퍼블릭 IP 출력
│   └── providers.tf          # AWS Provider 설정
└── README.md
```

## 📌 참고 사항

- SSH 키는 자동 생성되지 않습니다. 반드시 ~/.ssh/id_rsa.pub가 존재해야 합니다.
- Ansible은 ubuntu 유저로 접속하도록 구성되어 있으며, Ubuntu AMI에 맞춰져 있습니다.
- AWS 리전을 ap-northeast-2 (서울)로 설정해두었습니다. 필요 시 providers.tf에서 수정하세요.
