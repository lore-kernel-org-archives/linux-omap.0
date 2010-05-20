From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Thu, 20 May 2010 15:58:29 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666BDC@dbde02.ent.ti.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
 <4BF44384.40901@ti.com> <20100520010046.GL5818@atomide.com>
 <4BF48A4E.7040208@ti.com> <20100520010622.GM5818@atomide.com>
 <4BF48BAC.6080904@ti.com> <20100520012425.GN5818@atomide.com>
 <4BF4951D.8010300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45171 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab0ETK2j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 06:28:39 -0400
In-Reply-To: <4BF4951D.8010300@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

 -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, May 20, 2010 7:19 AM
> To: Tony Lindgren
> Cc: Shilimkar, Santosh; linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
> 
> Tony Lindgren had written, on 05/19/2010 08:24 PM, the following:
> > * Nishanth Menon <nm@ti.com> [100519 18:03]:
> >> Tony Lindgren had written, on 05/19/2010 08:06 PM, the following:
> >>> * Nishanth Menon <nm@ti.com> [100519 17:58]:
> >>>> Tony Lindgren had written, on 05/19/2010 08:00 PM, the following:
> >>>>> * Nishanth Menon <nm@ti.com> [100519 12:56]:
> >>>>>> looks like network is still not functional on SDP4430. different issue
> >>>>> Oh so Ethernet does not work either? What's wrong with that?
> >>>> I was told offline that the driver is somewhere in the net ML on the
> >>>> way I believe in parallel.. I dont have collaborative links though
> >>>> :(
> >>>>
> >>>> Santosh,
> >>>> Can you point out the status?
> >>> I thought I have those in omap-testing and merged into the master
> >>> branch in linux-omap:
> >>>
> >>> ks8851: Add caching of CCR register
> >>> ks8851: Low level functions for read/write to companion eeprom
> >>> ks8851: companion eeprom access through ethtool
> >> Okay then it makes this an operator error - I have been playing with
> >> vanilla linus 2.6.34 tree and adding just the basic patches I need..
> >> I can give the omap-testing a whirl..
> >
> > OK, cool.
> tried with omap_testing i pulled a few mins back, omap3_defconfig with
> CONFIG_EARLY_PRINTK enabled
> Good news:
> need as pointed out by Santosh -
> a) http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html
> b) this patch for NFS even to try.
> 
> Bad news: Same results I got as in linus tree - NAK for NFS booting :(
> full log: http://pastebin.mozilla.org/725960
> from the log, I dont see the driver probe even starting up or any
> reports as you posted above (which I guess is from Blaze)..
> 
Tried LO master and networks works great.

******************************************************
Texas Instruments X-Loader 1.41 (Jan 17 2010 - 23:12:44)
Starting OS Bootloader from EMMC ...


U-Boot 1.1.4-g0aa2aebd-dirty (Feb  6 2010 - 17:10:35)

Load address: 0x80e80000
DRAM:  512 MB
Flash:  0 kB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   Micrel KS8851SNL
OMAP44XX SDP # t;bootm

ks8851snl ethernet initialized
ethaddr rom: 00:08:01:28:43:4D
port status information = 0x8400
BOOTP broadcast 1
Using Micrel KS8851SN device
TFTP from server 172.24.190.46; our IP address is 172.24.190.176
Filename 'santosh/uImage'.
Load address: 0x90300000
Loading: T #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ######
done
Bytes transferred = 1690656 (19cc20 hex)
## Booting image at 90300000 ...
   Image Name:   Linux-2.6.34-08151-g1674c0c
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1690592 Bytes =  1.6 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.34-08151-g1674c0c (a0393909@a0393909-desktop) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #1 SMP PREEMPT Thu May 20 15:50:53 IST 2010
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP4430 4430SDP board
Memory policy: ECC disabled, Data cache writealloc
OMAP4430 ES1.0
SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0x100000
FIXME: omap44xx_sram_init not implemented
PERCPU: Embedded 6 pages/cpu @c0715000 s3584 r8192 d12800 u65536
pcpu-alloc: s3584 r8192 d12800 u65536 alloc=16*4096
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 117602
Kernel command line: mem=463M console=ttyS2,115200n8 noinitrd rootdelay=1 root=/dev/nfs rw nfsroot=172.24.190.46:/ubuntu/nfs-share/omap4_next ,nolock,tcp,rsize=1024,wsize=1024 ip=dhcp
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 463MB = 463MB total
Memory: 466420k/466420k available, 7692k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xdd000000 - 0xf8000000   ( 432 MB)
    lowmem  : 0xc0000000 - 0xdcf00000   ( 463 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc002a000   ( 136 kB)
      .text : 0xc002a000 - 0xc0326000   (3056 kB)
      .data : 0xc0326000 - 0xc0357200   ( 197 kB)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:388
GPMC revision 6.0
OMAP GPIO hardware version 0.1
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 1195.29 BogoMIPS (lpj=4669440)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
L2X0 cache controller enabled
CPU1: Booted secondary processor
Brought up 2 CPUs
SMP: Total of 2 processors activated (2395.78 BogoMIPS).
regulator: core version 0.5
NET: Registered protocol family 16
OMAP DMA hardware revision 0.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev4.0 at 400 kHz
Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl6030: PIH (irq 39) chaining IRQs 368..387
regulator: VMMC: 1200 <--> 3000 mV at 1800 mV normal standby
regulator: VPP: 1800 <--> 2500 mV at 1900 mV normal standby
regulator: VUSIM: 1200 <--> 2900 mV at 1800 mV normal standby
regulator: VANA: 2100 mV normal standby
regulator: VCXIO: 1800 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB: 3300 mV normal standby
regulator: VAUX1_6030: 1000 <--> 3000 mV at 2800 mV normal standby
regulator: VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
regulator: VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev4.0 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev4.0 at 400 kHz
i2c_omap i2c_omap.4: bus 4 rev4.0 at 400 kHz
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 910
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 104) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 105) is a ST16654
serial8250.2: ttyS2 at MMIO 0x48020000 (irq = 106) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
ks8851 spi1.0: message enable is 0
ks8851 spi1.0: revision 0, MAC ca:91:27:37:f5:4e, IRQ 194
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: Power up reset detected.
twl_rtc twl_rtc: Enabling TWL-RTC.
i2c /dev entries driver
OMAP Watchdog Timer Rev 0x00: initial timeout 60 sec
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0
regulator_init_complete: incomplete constraints, leaving VAUX3_6030 on
regulator_init_complete: incomplete constraints, leaving VAUX2_6030 on
regulator_init_complete: incomplete constraints, leaving VAUX1_6030 on
regulator_init_complete: incomplete constraints, leaving VUSB on
regulator_init_complete: incomplete constraints, leaving VDAC on
regulator_init_complete: incomplete constraints, leaving VCXIO on
regulator_init_complete: incomplete constraints, leaving VANA on
regulator_init_complete: incomplete constraints, leaving VUSIM on
regulator_init_complete: incomplete constraints, leaving VPP on
twl_rtc twl_rtc: hctosys: invalid date/time
mmc1: new high speed MMC card at address 0001
mmcblk0: mmc1:0001 MMC32G 29.8 GiB
 mmcblk0: p1
Sending DHCP requests .., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 172.24.191.10
IP-Config: Complete:
     device=eth0, addr=172.24.191.10, mask=255.255.252.0, gw=172.24.188.1,
     host=172.24.191.10, domain=india.ti.com, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=172.24.190.46, rootpath=
Waiting 1sec before mounting root device...
Looking up port of RPC 100003/2 on 172.24.190.46
Looking up port of RPC 100005/1 on 172.24.190.46
VFS: Mounted root (nfs filesystem) on device 0:10.
Freeing init memory: 136K
Mounting proc : OK
Mounting sysfs : OK
Mounting /dev : OK
Creating local mdev devices
umount: can't umount /mnt/mmc: Invalid argument

******************************************
Starting System Init for 4430SDP-4430
******************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Setting up networking
Configuring lo : OK
Configuring eth0 : OK - 172.24.191.10
Starting telnetd : OK
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : OK

Please press Enter to activate this console.
#
******************************************************
