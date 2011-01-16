From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: State of SDP4430 platform
Date: Sun, 16 Jan 2011 01:09:36 +0000
Message-ID: <20110116010936.GA21795@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59593 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1APBJm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jan 2011 20:09:42 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PeH7h-0000xT-VP
	for linux-omap@vger.kernel.org; Sun, 16 Jan 2011 01:09:38 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PeH7g-0005iX-NQ
	for linux-omap@vger.kernel.org; Sun, 16 Jan 2011 01:09:36 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

It's probably best if I just quote the boot log, and people see about
fixing the masses of WARN_ON()s.  Notice that it completely obliterates
the early part of the boot log due to the number of WARN_ON()s triggered.

Other stuff that shows in this boot log:
- There's a couple of complaints about missing clock domains for some clocks
- Bunch of regulators are returning errors (is this a problem?)
- I2C timeouts which add quite a bit to the boot-time
- missing vdd_mpu/vdd_iva? (with additional blank lines emitted)

Uncompressing Linux... done, booting the kernel.
060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00002502 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359b4c
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed2d ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:004cff02 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359b20
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed2e ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000002 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359af4
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed2f ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000102 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359ac8
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed30 ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000302 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359a9c
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed31 ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000102 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359a70
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed32 ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000001 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359a44
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed33 ]---
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-2.6-rmk/arch/arm/mach-omap2/prm2xxx_3xxx.h:264 clkdm_clear_all_wkdeps+0x80/0x90()
prm: omap2xxx/omap3xxx specific function and not suppose to be used on omap4
Modules linked in:
Backtrace:
[<c003ec64>] (dump_backtrace+0x0/0x10c) from [<c0288be0>] (dump_stack+0x18/0x1c)
 r7:c0347f08 r6:c004c84c r5:c030684e r4:00000108
[<c0288bc8>] (dump_stack+0x0/0x1c) from [<c00607c0>] (warn_slowpath_common+0x58/0x70)
[<c0060768>] (warn_slowpath_common+0x0/0x70) from [<c006087c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0359a10 r7:00000000 r6:00000060 r5:00000000 r4:00000000
[<c0060844>] (warn_slowpath_fmt+0x0/0x40) from [<c004c84c>] (clkdm_clear_all_wkdeps+0x80/0x90)
 r3:00000002 r2:c030688d
[<c004c7cc>] (clkdm_clear_all_wkdeps+0x0/0x90) from [<c004cf60>] (clkdm_init+0x14c/0x17c)
 r5:c0359a10 r4:c0359a18
[<c004ce14>] (clkdm_init+0x0/0x17c) from [<c0011758>] (omap44xx_clockdomains_init+0x18/0x20)
[<c0011740>] (omap44xx_clockdomains_init+0x0/0x20) from [<c000f0b0>] (omap2_init_common_infrastructure+0x28/0xa4)
[<c000f088>] (omap2_init_common_infrastructure+0x0/0xa4) from [<c0011d78>] (omap_4430sdp_init_irq+0x2c/0x54)
 r4:00000001
[<c0011d4c>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000b87c>] (init_IRQ+0x1c/0x24)
 r4:bfffffff
[<c000b860>] (init_IRQ+0x0/0x24) from [<c0008a78>] (start_kernel+0x194/0x314)
[<c00088e4>] (start_kernel+0x0/0x314) from [<80008040>] (0x80008040)
 r8:80000000 r7:c0357c84 r6:c0028678 r5:c0354b70 r4:10c53c7d
---[ end trace 1b75b31a2719ed34 ]---
omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
GPMC revision 6.0
OMAP clockevent source: GPTIMER1 at 32768 Hz
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
Console: colour dummy device 80x30
Calibrating delay loop... 2013.49 BogoMIPS (lpj=7864320)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c2, AUX_CTRL 0x0e050000, Cache size: 524288 B
CPU1: Booted secondary processor
CPU1: Unknown IPI message 0x1
Brought up 2 CPUs
SMP: Total of 2 processors activated (4026.98 BogoMIPS).
print_constraints: dummy:
NET: Registered protocol family 16
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
omap_mux_init: Add partition: #1: core, flags: 2
omap_mux_init: Add partition: #2: wkup, flags: 2
omap_device: omap_uart.1: new worst case deactivate latency 0: 30517
omap_device: omap_uart.3: new worst case activate latency 0: 30517
pm_dbg_init: only OMAP3 supported
OMAP DMA hardware revision 0.0
bio: create slab <bio-0> at 0
omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz
Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl6030: PIH (irq 39) chaining IRQs 368..387
print_constraints: VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
print_constraints: VPP: 1800 <--> 2500 mV at 1900 mV normal standby
print_constraints: VUSIM: 1200 <--> 2900 mV at 1800 mV normal standby
machine_constraints_voltage: VANA: failed to apply 2100000uV constraint
twl_reg twl_reg.43: can't register VANA, -22
twl_reg: probe of twl_reg.43 failed with error -22
machine_constraints_voltage: VCXIO: failed to apply 1800000uV constraint
twl_reg twl_reg.44: can't register VCXIO, -22
twl_reg: probe of twl_reg.44 failed with error -22
machine_constraints_voltage: VDAC: failed to apply 1800000uV constraint
twl_reg twl_reg.45: can't register VDAC, -22
twl_reg: probe of twl_reg.45 failed with error -22
print_constraints: VAUX1_6030: 1000 <--> 3000 mV at 2800 mV normal standby
print_constraints: VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
print_constraints: VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
omap_i2c omap_i2c.2: bus 2 rev4.0 at 400 kHz
omap_i2c omap_i2c.3: bus 3 rev4.0 at 400 kHz
omap_i2c omap_i2c.4: bus 4 rev4.0 at 400 kHz
DMA-API: preallocated 4096 debug entries
DMA-API: debugging enabled by kernel config
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 1, 12288 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
UDP hash table entries: 128 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 48
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 104) is a OMAP UART0
omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 105) is a OMAP UART1
omap_uart.2: ttyO2 at MMIO 0x48020000 (irq = 106) is a OMAP UART2
console [ttyO2] enabled
omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq = 102) is a OMAP UART3
brd: module loaded
loop: module loaded
ks8851 spi1.0: message enable is 0
ks8851 spi1.0: eth0: revision 0, MAC ce:9f:77:f1:2c:21, IRQ 194
input: gpio-keys as /devices/platform/gpio-keys/input/input0
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: Power up reset detected.
omap_device: omap_i2c.1: new worst case deactivate latency 0: 30517
twl_rtc twl_rtc: Enabling TWL-RTC.
i2c /dev entries driver
omap_device: omap_i2c.3: new worst case activate latency 0: 30517
lm75 3-0048: hwmon0: sensor 'tmp105'
omap_i2c omap_i2c.1: controller timed out
omap_i2c omap_i2c.1: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
omap2_set_init_voltage: Unable to put vdd_mpu to its init voltage

omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Power Management for TI OMAP4.
regulator_init_complete: VAUX3_6030: incomplete constraints, leaving on
regulator_init_complete: VAUX2_6030: incomplete constraints, leaving on
regulator_init_complete: VUSIM: incomplete constraints, leaving on
regulator_init_complete: VPP: incomplete constraints, leaving on
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
 mmcblk0: p1 p2
omap_i2c omap_i2c.1: controller timed out
twl: i2c_read failed to transfer all messages
twl_rtc twl_rtc: rtc_read_time error -110
twl_rtc twl_rtc: hctosys: unable to read the hardware clock
Waiting 2sec before mounting root device...
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 MMC32G 29.8 GiB
 mmcblk1: p1
EXT3-fs: barriers not enabled
EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 156K

