From: "Eduardo Franceschini" <edumontenegro@gmail.com>
Subject: PROBLEMS WITH DNS
Date: Fri, 8 Jun 2007 14:23:24 -0300
Message-ID: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

bootargs=3Dconsole=3DttyS0,115200n8 noinitrd rw ip=3Ddhcp root=3D/dev/mtdbl=
ock4
mem=3D30M

and when I boot the omap, I have

Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.107
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.107, mask=3D255.255.255.0, gw=3D192.1=
68.1.1,
     host=3D192.168.1.107, domain=3D, nis-domain=3D(none),
     bootserver=3D0.0.0.0, rootserver=3D0.0.0.0, rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

I can get an IP, but when I go to /etc/resolv.conf , I don't have an IP for
DNS server... somebody know what to do?

thanks!

Eduardo

--=20
Eduardo Montenegro Franceschini
Engenharia de Computa=E7=E3o - UNICAMP
fone: +55-19-9778-8998
e-mail: edumontenegro@gmail.com
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
