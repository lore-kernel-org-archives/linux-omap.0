From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/10] omap3: pm: omap3630 boards: enable 3630 opp tables
Date: Tue, 24 Nov 2009 22:09:19 -0600
Message-ID: <1259122159-1583-11-git-send-email-nm@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
 <1259122159-1583-3-git-send-email-nm@ti.com>
 <1259122159-1583-4-git-send-email-nm@ti.com>
 <1259122159-1583-5-git-send-email-nm@ti.com>
 <1259122159-1583-6-git-send-email-nm@ti.com>
 <1259122159-1583-7-git-send-email-nm@ti.com>
 <1259122159-1583-8-git-send-email-nm@ti.com>
 <1259122159-1583-9-git-send-email-nm@ti.com>
 <1259122159-1583-10-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59706 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934479AbZKYEJU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 23:09:20 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAP49RNs032213
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 22:09:27 -0600
In-Reply-To: <1259122159-1583-10-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

enable the OPP tables for 3630 platforms: SDP3630, zoom3.
NOTE: This needs the corresponding clockframework changes.

Currently this dumps the following on OPP transitions on SDP3630:
[<c002d734>] (dump_backtrace+0x0/0x110) from [<c02c9698>] (dump_stack+0x18/0x1c)
r7:00000000 r6:c003bff8 r5:c034a227 r4:00000309
[<c02c9680>] (dump_stack+0x0/0x1c) from [<c0052f24>] (warn_slowpath_common+0x50/0x68)
[<c0052ed4>] (warn_slowpath_common+0x0/0x68) from [<c0052f54>] (warn_slowpath_null+0x18/0x1c)
r7:c7801000 r6:0f7f4900 r5:80000013 r4:00000000
[<c0052f3c>] (warn_slowpath_null+0x0/0x1c) from [<c003bff8>] (omap3_noncore_dpll_set_rate+0x294/0x2d8)
[<c003bd64>] (omap3_noncore_dpll_set_rate+0x0/0x2d8) from [<c0036e24>] (omap2_clk_set_rate+0x28/0x34)
[<c0036dfc>] (omap2_clk_set_rate+0x0/0x34) from [<c003ecec>] (clk_set_rate+0x54/0xb8)
[<c003ec98>] (clk_set_rate+0x0/0xb8) from [<c003c750>] (program_opp+0x120/0x228)
r7:c7801000 r6:00000000 r5:c03c9fe0 r4:c03c9fd8
[<c003c630>] (program_opp+0x0/0x228) from [<c003c990>] (resource_set_opp_level+0x138/0x1b0)
[<c003c858>] (resource_set_opp_level+0x0/0x1b0) from [<c0038534>] (vdd_opp_store+0x148/0x17c)
[<c00383ec>] (vdd_opp_store+0x0/0x17c) from [<c01b39dc>] (kobj_attr_store+0x20/0x24)
r7:c7833740 r6:c794bec0 r5:c78c8960 r4:00000001
[<c01b39bc>] (kobj_attr_store+0x0/0x24) from [<c0102c3c>] (sysfs_write_file+0x110/0x144)
[<c0102b2c>] (sysfs_write_file+0x0/0x144) from [<c00b2f90>] (vfs_write+0xb8/0x164)
[<c00b2ed8>] (vfs_write+0x0/0x164) from [<c00b3100>] (sys_write+0x44/0x70)
r8:40000000 r7:00000001 r6:c783de00 r5:00000000 r4:00000000
[<c00b30bc>] (sys_write+0x0/0x70) from [<c0029f80>] (ret_fast_syscall+0x0/0x2c)
r8:c002a104 r7:00000004 r6:001d7918 r5:40000000 r4:00000001

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |    9 ++++++++-
 arch/arm/mach-omap2/board-zoom3.c   |    9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 185f48d..7a429db 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -24,6 +24,8 @@
 #include <mach/board-zoom.h>
 
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+#include "omap3-opp.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -76,9 +78,14 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
+
+	omap3_pm_init_opp_table();
+	/* TODO: Add RET, OFF, cpu_idle params */
+
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
-                             NULL, NULL, NULL);
+			     omap3_mpu_rate_table, omap3_dsp_rate_table,
+			     omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index fe97324..0574811 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -22,6 +22,8 @@
 #include <plat/board.h>
 
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+#include "omap3-opp.h"
 
 static void __init omap_zoom_map_io(void)
 {
@@ -36,9 +38,14 @@ static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
 	omap_board_config_size = ARRAY_SIZE(zoom_config);
+
+	omap3_pm_init_opp_table();
+	/* TODO: Add RET, OFF, cpu_idle params */
+
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
-			     NULL, NULL, NULL);
+			     omap3_mpu_rate_table, omap3_dsp_rate_table,
+			     omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
-- 
1.6.3.3

