From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: Boot fail on OMAP3430SDP
Date: Tue, 29 Jun 2010 19:45:27 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A40FBB@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305A40F8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50547 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919Ab0F2OPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 10:15:33 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5TEFTVB012514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 09:15:32 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5TEFSod024090
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 19:45:29 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305A40F8A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Here is the log from Early printk.

Bytes transferred = 2094808 (1ff6d8 hex)
## Booting image at 80300000 ...
   Image Name:   Linux-2.6.35-rc3-10791-g305f453
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2094744 Bytes =  2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.35-rc3-10791-g305f453 (vishwa@vishwa-desktop) (gcc version 4.3
.3 (Sourcery G++ Lite 2009q1-203) ) #38 PREEMPT Tue Jun 29 19:13:42 IST 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3430 3430SDP board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=17
2.24.136.185:/home/a0876481/testtarget,nolock,tcp, ip=dhcp earlyprintk
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 125508k/125508k available, 5564k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0034000   ( 176 kB)
      .text : 0xc0034000 - 0xc03ee000   (3816 kB)
      .data : 0xc03ee000 - 0xc0432280   ( 273 kB)
SLUB: Genslabs=9, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
omap_hwmod: l3_hwmod: cannot be enabled (3)
omap_hwmod: l4_core_hwmod: cannot be enabled (3)
omap_hwmod: l4_per_hwmod: cannot be enabled (3)
omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)
omap_hwmod: sr1_hwmod: cannot be enabled (3)
omap_hwmod: sr2_hwmod: cannot be enabled (3)
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
Could not get gpios_ick
Could not get gpios_fck
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
SmartReflex CLASS3 initialized
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz


Vishwa
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sripathy, Vishwanath
> Sent: Tuesday, June 29, 2010 7:06 PM
> To: linux-omap@vger.kernel.org
> Subject: Boot fail on OMAP3430SDP
> 
> Hi,
> 
> I am observing that image built using omap3_pm_defconfig on Kevin's pm branch
> does not seem to boot on OMAP3430 SDP board. It just stops after printing
> "Uncompressing Linux... done, booting the kernel". I am using console=ttyS0 as part
> of my bootargs. Any hints?
> 
> Vishwa
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
