From: Vadim Lebedev <vadim@mbdsys.com>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 08 Jun 2007 19:39:43 +0200
Message-ID: <4669945F.5070708@mbdsys.com>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eduardo Franceschini <edumontenegro@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Eduardo Franceschini wrote:

> bootargs=console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/mtdblock4
> mem=30M
>
> and when I boot the omap, I have
>
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.107
> IP-Config: Complete:
>      device=eth0, addr=192.168.1.107, mask=255.255.255.0, gw=192.168.1.1,
>     host=192.168.1.107, domain=, nis-domain=(none),
>     bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>
> I can get an IP, but when I go to /etc/resolv.conf , I don't have an 
> IP for
> DNS server... somebody know what to do?
>
> thanks!
>
> Eduardo
>
Eduardo,

this DHCP request are sent by kernel mode dhcp client,  which has no access
to resolv.conf to store retrived information

I'dont now if somebody have developped a possibility to retriev this 
info using
user-mode app and store it into resolv.conf...

Maybe one why to do it is to modify kernale mode dhcp client to create a 
procfs entry containig info for resolv.conf
and have /etc/resolv.com  to be symlink to procfs entry
 

Thanks
Vadim

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
