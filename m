From: jean-philippe francois <jp.francois@cynove.com>
Subject: Early oops on 3.4.3
Date: Thu, 21 Jun 2012 17:33:17 +0200
Message-ID: <CAGGh5h1pu=YWfLWOdf1M4p5Ncki1Ug9Whtwqb8eZABMgxy84Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:43726 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500Ab2FUPlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 11:41:18 -0400
Received: by yhnn12 with SMTP id n12so716126yhn.10
        for <linux-omap@vger.kernel.org>; Thu, 21 Jun 2012 08:41:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have a custom dm3730 board, which is booting fines with 3.2.x kernel.
However it oopses very early in the boot process with 3.4.x kernel.

I have some trouble interpreting the oops so some help is welcome.
I think what makes this board quite different from other setup is the absence
of Power Management IC.

Here is a patch that tries to hide the problem, and was needed for 3.2 not
to oopse :

Index: b/arch/arm/mach-omap2/io.c
===================================================================
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -394,7 +394,7 @@
 {
 	omap2_set_globals_3xxx();
 	omap_common_init_early();
-	omap3xxx_voltagedomains_init();
+	//	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();

I guess this is a possible culprit, but any help on booting without
PMIC is welcome.
Below is the boot log.

Thank you for your help

Starting kernel ...

<6>Booting Linux on physical CPU 0
<5>Linux version 3.4.3 (cynove@jp) (gcc version 4.3.2 (Sourcery G++
Lite 2008q3-41) ) #1 PREEMPT Thu Jun 21 16:39:44 CEST 2012
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Cynove CYDM3730
<6>Reserving 4194304 bytes SDRAM for VRAM
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 45568
<7>free_area_init_node: node 0, pgdat c0429404, node_mem_map c043f000
<7>  Normal zone: 512 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 45056 pages, LIFO batch:15
<6>OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
<3>powerdomain: wkup_pwrdm: voltagedomain wakeup does not exist
<3>powerdomain: iva2_pwrdm: voltagedomain mpu_iva does not exist
<3>powerdomain: mpu_pwrdm: voltagedomain mpu_iva does not exist
<3>powerdomain: neon_pwrdm: voltagedomain mpu_iva does not exist
<3>powerdomain: cam_pwrdm: voltagedomain core does not exist
<3>powerdomain: dss_pwrdm: voltagedomain core does not exist
<3>powerdomain: per_pwrdm: voltagedomain core does not exist
<3>powerdomain: emu_pwrdm: voltagedomain core does not exist
<3>powerdomain: dpll1_pwrdm: voltagedomain mpu_iva does not exist
<3>powerdomain: dpll2_pwrdm: voltagedomain mpu_iva does not exist
<3>powerdomain: dpll3_pwrdm: voltagedomain core does not exist
<3>powerdomain: dpll4_pwrdm: voltagedomain core does not exist
<3>powerdomain: core_pwrdm: voltagedomain core does not exist
<3>powerdomain: sgx_pwrdm: voltagedomain core does not exist
<3>powerdomain: usbhost_pwrdm: voltagedomain core does not exist
<3>powerdomain: dpll5_pwrdm: voltagedomain core does not exist
<3>clockdomain: wkup_clkdm: powerdomain wkup_pwrdm does not exist
<3>clockdomain: cm_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: prm_clkdm: powerdomain wkup_pwrdm does not exist
<3>clockdomain: mpu_clkdm: powerdomain mpu_pwrdm does not exist
<3>clockdomain: neon_clkdm: powerdomain neon_pwrdm does not exist
<3>clockdomain: iva2_clkdm: powerdomain iva2_pwrdm does not exist
<3>clockdomain: d2d_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: core_l3_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: core_l4_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: dss_clkdm: powerdomain dss_pwrdm does not exist
<3>clockdomain: cam_clkdm: powerdomain cam_pwrdm does not exist
<3>clockdomain: per_clkdm: powerdomain per_pwrdm does not exist
<3>clockdomain: emu_clkdm: powerdomain emu_pwrdm does not exist
<3>clockdomain: dpll1_clkdm: powerdomain dpll1_pwrdm does not exist
<3>clockdomain: dpll2_clkdm: powerdomain dpll2_pwrdm does not exist
<3>clockdomain: dpll3_clkdm: powerdomain dpll3_pwrdm does not exist
<3>clockdomain: dpll4_clkdm: powerdomain dpll4_pwrdm does not exist
<3>clockdomain: sgx_clkdm: powerdomain sgx_pwrdm does not exist
<3>clockdomain: dpll5_clkdm: powerdomain dpll5_pwrdm does not exist
<3>clockdomain: usbhost_clkdm: powerdomain usbhost_pwrdm does not exist
<6>Clocking rate (Crystal/Core/MPU): 19.2/400/832 MHz
<7>pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768<c>
<7>pcpu-alloc: <c>[0] <c>0 <c>
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 45056
<5>Kernel command line: console=ttyO2,115200n8 rdinit=/sbin/init
initrd=0x83000000,1536k
mtdparts=omap2-nand.0:1024k(bootloaders),3072k(linux),1536k(ramfs),-(usr)
ubi.mtd=3,2048 mem=55M@0x80000000 mem=128M@0x88000000
<6>PID hash table entries: 1024 (order: 0, 4096 bytes)
<6>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Memory: 55MB 123MB = 178MB total
<5>Memory: 174676k/174676k available, 12716k reserved, 0K highmem
<5>Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03c84b8   (3842 kB)
      .init : 0xc03c9000 - 0xc03f2000   ( 164 kB)
      .data : 0xc03f2000 - 0xc042def0   ( 240 kB)
       .bss : 0xc042df14 - 0xc043e688   (  66 kB)
<6>NR_IRQS:440
<6>IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<4>omap_hwmod: arm_fck: missing clockdomain for arm_fck.
<4>omap_hwmod: gpt1_fck: missing clockdomain for gpt1_fck.
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
<6>sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
<0>Internal error: Oops: 80000005 [#1] PREEMPT ARM
<d>Modules linked in:
CPU: 0    Not tainted  (3.4.3 #1)
PC is at 0x0
LR is at __irq_svc+0x40/0x70
pc : [<00000000>]    lr : [<c000e380>]    psr: 000001d3
sp : c03f3f88  ip : 0000000f  fp : 00000000
r10: 00000000  r9 : 413fc082  r8 : 80004059
r7 : c03f3fbc  r6 : ffffffff  r5 : 00000153  r4 : c03da4bc
r3 : c03c97f0  r2 : c03f3fd0  r1 : c03fd00c  r0 : c03f3f88
Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
<0>Process swapper (pid: 0, stack limit = 0xc03f22e8)
<0>Stack: (0xc03f3f88 to 0xc03f4000)
<0>3f80:                   00000000 400001d3 00000000 c03fa040 ffffffff c03fa08c
<0>3fa0: c03e9100 c03fd004 80004059 413fc082 00000000 00000000 0000000f c03f3fd0
<0>3fc0: c03c97f0 c03da4bc 00000153 ffffffff ffffffff ffffffff c03c9574 00000000
<0>3fe0: 00000000 c03e9104 00000000 10c53c7d c03fa08c 8000803c 00000000 00000000
[<c000e380>] (__irq_svc+0x40/0x70) from [<c03da4bc>]
(kmem_cache_init_late+0x0/0x74)
<0>Code: bad PC value
