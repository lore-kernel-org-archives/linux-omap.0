From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: Welcome + Boot Error
Date: Tue, 08 Aug 2006 12:57:13 +0000
Message-ID: <BAY102-F33964DA005C427B9694D64A9540@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

This is my first post to this list. I have participated in several embedded 
linux forums before, including but not limmited to uClinux-microblaze, 
uClinux-dev, google groups such as ARM and ARCH.Embedded, etc. Thanks for 
having me and I hope I can be a useful member of the community. Now to the 
dirty business.


I'm working with the OMAP5912 OSK, an EVM board from Spectrum Digital. I've 
gone through all the steps of building the kernel, building my apps, and all 
that. I've set up my new file system with my compiled apps as an NFS share 
which I can successfully mount from the EVM board as well as other systems 
on the network. When I boot my board it should mount this file system and 
boot, but instead I see the following error:

.... boot log ....
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
802.1Q VLAN Support v1.7 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 8192K
Looking up port of RPC 100003/2 on [[[myip]]]
Looking up port of RPC 100005/1 on [[[myip]]]
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing init memory: 64K
Kernel panic: No init found.  Try passing init= option to kernel.

My bootargs from uBoot are as follows:

bootargs=console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs 
nfsroot=[[[myip]]]:/home/projects/filesys,nolock mem=30M

I tried putting a init=/bin/sh in this string in a few different places and 
as its own parameter, but that doesnt seem to solve the problem. Does anyone 
have any ideas?

Thanks,
Andy

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
