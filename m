From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v6 0/3 Resend] OMAP: Add opp data
Date: Thu,  9 Dec 2010 09:13:45 -0600
Message-ID: <1291907628-29199-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53121 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0LIPOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 10:14:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>
Cc: Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Hi,
This series introduces OPP data for OMAP3 and 4 with relevant cleanups
in OMAP's pm layer. Additional patches for cpufreq interface to OPP
library + enablement of SmartReflex, voltage layers depend on the
data made available here.

Major changes in V6:
Looping in L-a + added Paul's Ack in patch 3/3
http://marc.info/?l=linux-omap&m=129185174709566&w=2
rebased to 2.6.37-rc5

Major changes in V5:
	rebased to k.org 2.6.37-rc3
	introduced omap_opp_data.h
	couple of whitespace and offline license suggestion cleanups

V4: http://marc.info/?l=linux-omap&m=128993367112637&w=2
V3: http://marc.info/?l=linux-omap&m=128984926812800&w=2
V2: http://marc.info/?t=128753665300003&r=1&w=2

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  omap: opp: add OMAP3 OPP table data and common init
  omap4: opp: add OPP table data

 Documentation/arm/OMAP/omap_pm            |   25 +++++++
 arch/arm/mach-omap2/Kconfig               |    4 +
 arch/arm/mach-omap2/Makefile              |    6 ++
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/omap_opp_data.h       |   72 +++++++++++++++++++
 arch/arm/mach-omap2/opp.c                 |   93 +++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c        |  107 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.c        |   57 +++++++++++++++
 arch/arm/mach-omap2/pm.h                  |   14 ++++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 +++------
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +---
 11 files changed, 390 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_opp_data.h
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.c

Bloat-o-meter report for omap2plus_defconfig Vs 2.6.37-rc5:
add/remove: 22/3 grow/shrink: 4/3 up/down: 3143/-64 (3079)
function                                     old     new   delta
opp_add                                        -     576    +576
opp_set_availability                           -     524    +524
omap_init_opp_table                            -     332    +332
omap34xx_opp_def_list                          -     208    +208
static.__func__                            13783   13954    +171
opp_find_freq_floor                            -     160    +160
omap36xx_opp_def_list                          -     160    +160
opp_find_freq_ceil                             -     152    +152
opp_find_freq_exact                            -     128    +128
find_device_opp                                -     116    +116
opp_get_opp_count                              -     108    +108
omap44xx_opp_def_list                          -      96     +96
omap3_opp_init                                 -      76     +76
opp_get_voltage                                -      72     +72
opp_get_freq                                   -      72     +72
dev_opp_list_lock                              -      72     +72
omap4_opp_init                                 -      48     +48
vermagic                                      45      60     +15
linux_banner                                 131     146     +15
kernel_config_data                         13718   13727      +9
opp_enable                                     -       8      +8
opp_disable                                    -       8      +8
dev_opp_list                                   -       8      +8
__initcall_omap4_opp_init6                     -       4      +4
__initcall_omap3_opp_init6                     -       4      +4
omap_table_init                                -       1      +1
omap_pm_cpu_set_freq                          28      24      -4
mpu_opps                                       4       -      -4
l3_opps                                        4       -      -4
dsp_opps                                       4       -      -4
omap_pm_if_early_init                         20       8     -12
omap2_init_common_hw                         464     428     -36


Regards,
Nishanth Menon
