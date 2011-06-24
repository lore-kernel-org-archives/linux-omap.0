From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Fri, 24 Jun 2011 22:02:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F39@dbde02.ent.ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35248 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab1FXQdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 12:33:12 -0400
In-Reply-To: <1308932625-17632-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Friday, June 24, 2011 9:54 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Premi, Sanjeev; Paul Walmsley
> Subject: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents

[sp] I do notice a typo in subject.
     Will fix in next rev with any other comments - if any.

> 
> The current selection of the GPTIMER on was result of
> a hardware issue in early versions of the Beagleboards
> (Ax and B1 thru B4). [1] [2]
> 
> Its been long since the hardware issue has been fixed.
> This patch uses GPTIMER 1 for all newer board revisions
> incl. Beagleboard XM.
> 
>  [1] 
> http://thread.gmane.org/gmane.comp.hardware.beagleboard.general/91
>  [2] Errata #7 at http://elinux.org/BeagleBoard#Errata
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Few lines from top of boot log on Beagleboard XM:

[    0.000000] Linux version 3.0.0-rc3-14001-gba7aaf5-dirty (premi@mylinux) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #18 SMP Fri Jun 24 20:40:30 IST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Reserving 12582912 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] Reprogramming SDRC clock to 400000000 Hz
[    0.000000] dpll3_m2_clk rate change failed: -22
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0bdd000 s5504 r8192 d14976 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 61952
[    0.000000] Kernel command line: console=ttyO2,115200n8 vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapdss.def_disp=dvi root=/dev/ram0 rw initrd=0x81600000,24M earlyprintk=serial,ttyO0,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 244MB = 244MB total
[    0.000000] Memory: 212904k/212904k available, 49240k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc003e000   ( 216 kB)
[    0.000000]       .text : 0xc003e000 - 0xc04330f0   (4053 kB)
[    0.000000]       .data : 0xc0434000 - 0xc048aaf0   ( 347 kB)
[    0.000000] Hierarchical RCU 00000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000823] Calibrating delay loop... 597.64 BogoMIPS (lpj=2334720)
[    0.093780] pid_max: default: 32768 minimum: 301
[    0.094329] Security Framework initialized
[    0.094635] Mount-cache hash table entries: 512
[    0.098175] CPU: Testing write buffer coherency: ok
[    0.101074] Brought up 1 CPUs
[    0.101104] SMP: Total of 1 processors activated (597.64 BogoMIPS).

