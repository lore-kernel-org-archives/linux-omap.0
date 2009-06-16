From: "Gunasekera, Nipuna" <gunasekera@ti.com>
Subject: RE: Linux OMAP 2.6.30 kernel not booting
Date: Tue, 16 Jun 2009 17:44:56 -0500
Message-ID: <418C1D1D75DA034D9CD5F5219FA619C057EB776E@dlee07.ent.ti.com>
References: <213F5EBECAA75243A2F795E0D16AFF6AD8893BF9@dlee07.ent.ti.com>
 <418C1D1D75DA034D9CD5F5219FA619C057EB748C@dlee07.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D14BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56136 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249AbZFPWpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 18:45:00 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GMiv5o016424
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 17:45:02 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5GMivP9006950
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 17:44:57 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5GMivrh004483
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 17:44:57 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D14BB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Vikram.  I'm able to move further in the booting process using arm-2008q3-72.  However, I'm still getting a kernel panic and I'm not sure why.  If you or some others have experienced this please let me know.

1656148 bytes read                  
## Booting image at 80c00000 ...                                
   Image Name:   Linux-2.6.30-omap1-05864-gfc3c45                                                 
   Image Type:   ARM Linux Kernel Image (uncompressed)                                                      
   Data Size:    1656084 Bytes =  1.6 MB                                        
   Load Address: 80008000                         
   Entry Point:  80008000                         
   Verifying Checksum ... OK                            
OK  

Starting kernel ...                   

Linux version 2.6.30-omap1-05864-gfc3c45c (nipuna@UTA0864305) (gcc version 4.3.2eeing init                                                                      
 (Sourcery G++ Lite 2008q3-72) ) #1 Tue Jun 16 16:52:10 CDT 2009      
ps: invalid option -- ale or directorychitectu           
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387f11:27:58 PDT) multi-call binary                                
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cachewlan0 ;                 

Report process status                     
Machine: OMAP Zoom2 board        
        w       
Memory policy: ECC disabled, Data cache writeback                                          

/etc/
OMAP3430 ES3.1line 232: echo
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000                                           
twl403      


Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Error for         
Starting GPE display manager: gpe-dm:blo              
Total of 96 interrupts on 1 active controller   

INIT: Sending processes the TERM signalt
OMAP34xx GPIO hardware version 2.5                                  
PID hash table entries: 1024 (order: 10, 4096 bytes)ng Dropbear SSH server: stopped /usr/sbin/dropbear (
OMAP clockevent source: GPTIMER1 at 32768 Hz                               

modprobe: F
Console: colour dummy device 80x30.6.27.10-o                        
Dentry cache hash table entries: 32768 (order: 5, 1                 
                               
net_namespace: 520 bytes            

e 
Stoppin
NET: Registered protocol family 16id 1408)ove <pkg|regexp>          
Failed to request GPIO158 for smsc911x IRQ             
stopped klogd (pid 1410)h fi
OMAP DMA hardware revision 4.0                           
do
bio: create slab <bio-0> at 0agerarting advanced power man
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz         
ps: invalid option -- aport in      
 *[fail]        

y failur
TCP: Hash tables configured (established 8192 bind 8192)e pvrsrvkm does not exist in /proc/modules does not exis
TCP reno registered                   
NET: Registered protocol family 1                                 
NetWinder Floating Point Emulator V0.97 (double precision)oryt exis                                                 
io scheduler noop registered                  
FATAL: Co
io scheduler anticipatory registered (default)                 
mknod: missing operand after
io scheduler deadline registeredble                             
io scheduler cfq registered       
Try `mknod --help' 
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabledopened..27.10-omap1/mo                               
W
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654          
Sending all processes the TERM signal...0x48004B40 
Driver 'sd' needs updating - please use bus_type methods
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=ffffffff:01, irq=-1)
net eth0: MAC Address: 00:08:ee:03:12:29
Driver for 1-wire Dallas network protocol.
Advanced Linux Sound Architecture Driver Version 1.0.20.
ALSA device list:
  No soundcards found.
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting 1sec before mounting root device...
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "mmcblk0p2" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)



-----Original Message-----
From: Pandita, Vikram 
Sent: Tuesday, June 16, 2009 1:15 PM
To: Gunasekera, Nipuna; linux-omap-open-source@linux.omap.com
Subject: RE: Linux OMAP 2.6.30 kernel not booting

There used to be tool chain issue with older toolchain.
On moving to arm-2008q3-72 it was solved.

Also the mailing list is: linux-omap@vger.kernel.org
And not the one you specified.


>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
>bounces@linux.omap.com] On Behalf Of Gunasekera, Nipuna
>Sent: Tuesday, June 16, 2009 1:11 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: Linux OMAP 2.6.30 kernel not booting
>
>Hi all,
>
>I'm trying to use the Linux OMAP 2.6.30 kernel from here to boot an OMAP Zoom2 device:
>http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
>
>However, it seems to get stuck as indicated below (in red):
>OMAP34XX ZOOM2 # boot
>
>1653216 bytes read
>## Booting image at 80c00000 ...
>   Image Name:   Linux-2.6.30-omap1-05863-g1755d1
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    1653152 Bytes =  1.6 MB
>   Load Address: 80008000
>   Entry Point:  80008000
>   Verifying Checksum ... OK
>OK
>
>Starting kernel ...
>
>My environment is set as indicated below:
>OMAP34XX ZOOM2 # printenv
>bootdelay=3
>baudrate=115200
>ipaddr=128.247.77.90
>serverip=128.247.77.158
>netmask=255.255.254.0
>bootfile="uImage"
>bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw rootdelay=1 mem=256M init
>=/init
>bootcmd=mmcinit; fatload mmc 0 0x80c00000 uImage; bootm 0x80c00000
>stdin=serial
>stdout=serial
>stderr=serial
>Environment size: 308/131068 bytes
>
>The Zoom2 boots fine when I use 2.6.27 kernel from omapzoom.org:
>http://git.omapzoom.org/?p=repo/omapkernel.git;a=summary
>
>What am I missing to get the 2.6.30 kernel from kernel.org to boot?
>
>Thanks -Nipuna
>
>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
