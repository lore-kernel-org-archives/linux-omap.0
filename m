From: Belisko Marek <marek.belisko@gmail.com>
Subject: kernel 3.2.1 crash on Pandaboard during boot
Date: Fri, 27 Jan 2012 17:01:58 +0100
Message-ID: <CAAfyv37NgOwscWia7twoOhhgvGjBJ=D5kE_KM+Zv6Y7=YSzz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43870 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088Ab2A0QB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 11:01:59 -0500
Received: by vcbgb30 with SMTP id gb30so1270151vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 08:01:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to run 3.2.1 stable kernel release on Pandaboard.
With enabled earlyprintk I got following:

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.2.0-03025-g2bf90aa
(open-nandra@nandra-host) (gcc version 4.5.1 (Sourcery G++ Lite
2010.09-50) ) #3 SMP Fri Jan 27 16:55:20 CET 2012
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Truncating RAM at 80000000-bfffffff to -af7fffff
(vmalloc region overlap).
[    0.000000] Reserving 33554432 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.1
[    0.000000] powerdomain: waited too long for powerdomain dss_pwrdm
to complete transition
[    0.000000] PERCPU: Embedded 8 pages/cpu @c11f9000 s10656 r8192 d13920 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 184848
[    0.000000] Kernel command line: console=ttyO2,115200 earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 728MB = 728MB total
[    0.000000] Memory: 726216k/726216k available, 52024k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05fb454   (6094 kB)
[    0.000000]       .init : 0xc05fc000 - 0xc06389a0   ( 243 kB)
[    0.000000]       .data : 0xc063a000 - 0xc06a6358   ( 433 kB)
[    0.000000]        .bss : 0xc06a637c - 0xc0bfbb8c   (5463 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:410
[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for
dpll_mpu_m2_ck.
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.057098] Calibrating delay loop... 1194.24 BogoMIPS (lpj=4665344)
[    0.129791] pid_max: default: 32768 minimum: 301
[    0.135437] Security Framework initialized
[    0.140045] Mount-cache hash table entries: 512
[    0.150177] CPU: Testing write buffer coherency: ok
[    0.156433] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.162597] smp_twd: clock not found: -2
[    0.166778] Calibrating local timer... 292.86MHz.
[    0.214202] Setting up static identity map for 0x80441358 - 0x804413b0
[    0.221069] L310 cache controller enabled
[    0.225311] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL
0x7e470000, Cache size: 1048576 B
[    0.237548] CPU1: Booted secondary processor
[    0.267517] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.267547] CPU1: Unknown IPI message 0x1
[    0.267761] Brought up 2 CPUs
[    0.267791] SMP: Total of 2 processors activated (2359.07 BogoMIPS).
[    0.305114] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
[    0.315582] omap_hwmod: dmm: _wait_target_disable failed
[    0.323822] omap_hwmod: emif_fw: _wait_target_disable failed
[    0.332427] omap_hwmod: l3_main_1: _wait_target_disable failed
[    0.341217] omap_hwmod: l3_main_2: _wait_target_disable failed
[    0.350036] omap_hwmod: l4_abe: _wait_target_disable failed
[    0.358520] omap_hwmod: l4_cfg: _wait_target_disable failed
[    0.367034] omap_hwmod: l4_per: _wait_target_disable failed
[    0.376068] omap_hwmod: l4_wkup: _wait_target_disable failed
[    0.384674] omap_hwmod: dma_system: _wait_target_disable failed
[    0.393646] omap_hwmod: dss_core: _wait_target_disable failed
[    0.402343] omap_hwmod: dss_dispc: _wait_target_disable failed
[    0.411132] omap_hwmod: dss_dsi1: _wait_target_disable failed
[    0.419830] omap_hwmod: dss_dsi2: _wait_target_disable failed
[    0.428527] omap_hwmod: dss_hdmi: _wait_target_disable failed
[    0.437225] omap_hwmod: dss_rfbi: _wait_target_disable failed
[    0.445922] omap_hwmod: dss_venc: _wait_target_disable failed
[    0.455871] omap_hwmod: mailbox: _wait_target_disable failed
[    0.464569] omap_hwmod: mcpdm: cannot be enabled (3)
[    0.472747] omap_hwmod: spinlock: _wait_target_disable failed
[    0.485565] print_constraints: dummy:
[    0.491149] NET: Registered protocol family 16
[    0.496704] GPMC revision 6.0
[    0.499938] ------------[ cut here ]------------
[    0.504760] Kernel BUG at c0604ac0 [verbose debug info unavailable]
[    0.511291] Internal error: Oops - undefined instruction: 0 [#1] SMP
[    0.517913] Modules linked in:
[    0.521148] CPU: 0    Not tainted  (3.2.0-03025-g2bf90aa #3)
[    0.527069] PC is at gpmc_init+0x16c/0x248
[    0.531372] LR is at gpmc_init+0x164/0x248
[    0.535675] pc : [<c0604ac0>]    lr : [<c0604ab8>]    psr: a0000013
[    0.535675] sp : ed033fa0  ip : 00ffffff  fp : 00000000
[    0.547637] r10: 00000000  r9 : 00000000  r8 : 00ffffff
[    0.553100] r7 : fffffff0  r6 : 00000000  r5 : 00000034  r4 : 00000000
[    0.559906] r3 : c06a6a84  r2 : 00000000  r1 : 00000450  r0 : c065593c
[    0.566711] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    0.574310] Control: 10c5387d  Table: 8000404a  DAC: 00000015
[    0.580322] Process swapper/0 (pid: 1, stack limit = 0xed0322f8)
[    0.586578] Stack: (0xed033fa0 to 0xed034000)
[    0.591156] 3fa0: c0604954 00000450 c06350a0 c0635024 c001318c
c0604954 00000000 c00088d0
[    0.599639] 3fc0: c0604954 00000450 c06a6380 c0635554 c06350a0
c0635024 c001318c 00000013
[    0.608154] 3fe0: 00000000 c05fc84c ed031380 00000000 c05fc7c8
c001318c 4045e253 54d55754
[    0.616668] [<c0604ac0>] (gpmc_init+0x16c/0x248) from [<c00088d0>]
(do_one_initcall+0x94/0x168)
[    0.625732] [<c00088d0>] (do_one_initcall+0x94/0x168) from
[<c05fc84c>] (kernel_init+0x84/0x130)
[    0.634887] [<c05fc84c>] (kernel_init+0x84/0x130) from [<c001318c>]
(kernel_thread_exit+0x0/0x8)
[    0.644012] Code: e59f00c4 ebf8dff7 e3570000 aa000000 (e7f001f2)
[    0.650421] ---[ end trace 1b75b31a2719ed1c ]---
[    0.655273] Kernel panic - not syncing: Attempted to kill init!
[    0.661468] CPU1: stopping
[    0.664367] [<c0018bd0>] (unwind_backtrace+0x0/0xe0) from
[<c0017198>] (handle_IPI+0xec/0x168)
[    0.673339] [<c0017198>] (handle_IPI+0xec/0x168) from [<c0008644>]
(gic_handle_irq+0x90/0x9c)
[    0.682189] [<c0008644>] (gic_handle_irq+0x90/0x9c) from
[<c043cc84>] (__irq_svc+0x44/0x60)
[    0.690887] Exception stack(0xed075fa0 to 0xed075fe8)
[    0.696166] 5fa0: c00131f0 00000001 ed075fe8 00000000 ad03806a
00000015 10c0387d c06a65e8
[    0.704681] 5fc0: 8000406a 411fc092 00000000 00000000 00000000
ed075fe8 c00131f0 c00131f4
[    0.713165] 5fe0: 60000113 ffffffff
[    0.716857] [<c043cc84>] (__irq_svc+0x44/0x60) from [<c00131f4>]
(default_idle+0x28/0x2c)
[    0.725372] [<c00131f4>] (default_idle+0x28/0x2c) from [<c001340c>]
(cpu_idle+0xa0/0x110)
[    0.733856] [<c001340c>] (cpu_idle+0xa0/0x110) from [<80435e74>] (0x80435e74)

It is known problem? Bootloader is barebox.

Regards,

marek
-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
