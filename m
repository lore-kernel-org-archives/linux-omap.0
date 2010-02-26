From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v2][PATCH 0/5] OMAP3630: UART4 startup
Date: Fri, 26 Feb 2010 09:53:07 -0600
Message-ID: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965185Ab0BZPxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 10:53:06 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1QFr3bq015984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 09:53:03 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Hi,

This is the v2 of the RFC for UART4 addition for 3630 chips.

Changes with respect to v1 [1]:
 - Added AUTOIDLE handling.
 - Added respective entries to prcm_setup_regs.

Indirect dependencies:
 - Tested with Thomas Weber's patch [2].

Known issues:
 - After enabling earlyprintk in 3630sdp, this is shown in the logs
   during bootup:

 --- LOG START ---
 Unhandled fault: imprecise external abort (0x1c06) at 0xc000e71c
 Internal error: : 1c06 [#1]
 last sysfs file:
 Modules linked in:
 CPU: 0    Not tainted  (2.6.33-rc8-07945-gac969e9 #13)
 PC is at init_timer_key+0x0/0x1c
 LR is at omap_serial_init_port+0xdc/0x2d4
 pc : [<c005cee0>]    lr : [<c000e54c>]    psr: 60000013
 sp : cf823f70  ip : d0800000  fp : c0381b68
 r10: c0381ed0  r9 : 00000360  r8 : c0381ec8
 r7 : 00000015  r6 : 00000000  r5 : 00000020  r4 : c0381b08
 r3 : c0035db8  r2 : 00000000  r1 : 00000000  r0 : c0381ed0
 Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
 Control: 10c5387f  Table: 80004019  DAC: 00000017
 Process swapper (pid: 1, stack limit = 0xcf8222e8)
 Stack: (0xcf823f70 to 0xcf824000)
 3f60:                                     00000003 fb020000 c0381aa8 00000004
 3f80: 00000004 c000b380 00000000 00000000 00000000 00000000 00000000 c000e76c
 3fa0: c00232e4 00000000 c000b380 c000fd78 c00232e4 c000fca4 c00232e4 c000b398
 3fc0: c00232e4 c002b33c 00000031 00000000 00000000 00000192 00000000 c00232e4
 3fe0: 00000000 00000000 00000000 c0008578 00000000 c002cdbc 00000000 00000000
 [<c005cee0>] (init_timer_key+0x0/0x1c) from [<c000e54c>] (omap_serial_init_port+0xdc/0x2d4)
 [<c000e54c>] (omap_serial_init_port+0xdc/0x2d4) from [<c000e76c>] (omap_serial_init+0x28/0x34)
 [<c000e76c>] (omap_serial_init+0x28/0x34) from [<c000fd78>] (zoom_peripherals_init+0x44/0x68)
 [<c000fd78>] (zoom_peripherals_init+0x44/0x68) from [<c000fca4>] (omap_sdp_init+0x14/0x50)
 [<c000fca4>] (omap_sdp_init+0x14/0x50) from [<c000b398>] (customize_machine+0x18/0x24)
 [<c000b398>] (customize_machine+0x18/0x24) from [<c002b33c>] (do_one_initcall+0x5c/0x1b4)
 [<c002b33c>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>] (kernel_init+0x90/0x10c)
 [<c0008578>] (kernel_init+0x90/0x10c) from [<c002cdbc>] (kernel_thread_exit+0x0/0x8)
 Code: e5801004 e5831000 e5813004 e12fff1e (e3a03000)
 ---[ end trace 1b75b31a2719ed1c ]---
 Kernel panic - not syncing: Attempted to kill init!
 --- LOG END ---

Detailed patchlist summary:

Sergio Aguirre (5):
  ARM: OMAP3630: PRCM: Add UART4 control bits
  OMAP clock: Add UART4 autoidle bit for 3630
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  omap3: serial: Add uart4 wakeup handling

 arch/arm/mach-omap2/clock3xxx_data.c  |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 arch/arm/mach-omap2/pm34xx.c          |    8 ++++++--
 arch/arm/mach-omap2/prcm-common.h     |    4 ++++
 arch/arm/mach-omap2/serial.c          |    4 ++++
 5 files changed, 38 insertions(+), 2 deletions(-)

Regards,
Sergio

[1] http://marc.info/?l=linux-omap&m=126710887505294&w=2
[2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2

