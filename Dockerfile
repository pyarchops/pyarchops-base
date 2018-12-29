FROM base/archlinux
RUN pacman -Sy && pacman -Su --noconfirm docker ansible systemd systemd-sysvcompat openssh bash sudo && pacman -Scc --noconfirm
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN sed "s@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g" -i /etc/pam.d/sshd
RUN echo "root:*" | chpasswd -e
RUN systemctl enable sshd
COPY id_rsa.pub /root/.ssh/authorized_keys
EXPOSE 22
CMD ["/lib/systemd/systemd"]
