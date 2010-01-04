From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCH] OMAP3630 PM: Correct VDD1/VDD2 Retention and On voltage
Date: Mon, 4 Jan 2010 11:34:39 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AE8CA8C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab0ADGEz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 01:04:55 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

>From 61474f885fe048dd1b8b6f17cfbd1690ff281c49 Mon Sep 17 00:00:00 2001
From: Vijaykumar GN <vijaykumar.gn@ti.com>
Date: Mon, 21 Dec 2009 12:43:14 +0530
Subject: [PATCH] OMAP3630 PM: Correct VDD1/VDD2 Retention and On voltage

For OMAP3630 Retention Voltage must be set to OPP25
1. vdd1 retention voltage ==> 0.83
2. vdd2 retention voltage ==> 0.85

On Voltage must be at default OPP (OPP100)
1. vdd1 on voltage ==> 1.1
2. vdd2 on voltage ==> 1.375

Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |   19 +++++++++++++++++++
 arch/arm/mach-omap2/board-zoom3.c   |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index d509c08..4d464fb 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -25,6 +25,24 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+/* Update with the optimal setup values to be used on 3630sdp */
+static struct prm_setup_vc omap3_setuptime_table = {
+	.clksetup = 0x14A,
+	.voltsetup_time1 = 0x00B3,
+	.voltsetup_time2 = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	.vdd0_on = 0x28,	/* 1.1v */
+	.vdd0_onlp = 0x20,	/* 1.0v */
+	.vdd0_ret = 0x12,	/* 0.83v */
+	.vdd0_off = 0x00,	/* 0.6v */
+	.vdd1_on = 0x2B,	/* 1.1375v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x14,	/* 0.85v */
+	.vdd1_off = 0x00,	/* 0.6v */
+};
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -79,6 +97,7 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
+	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
                              NULL, NULL, NULL);
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 0778077..2c1f954 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -23,6 +23,24 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+/* Update with the optimal setup values to be used on Zoom3 */
+static struct prm_setup_vc omap3_setuptime_table = {
+	.clksetup = 0x14A,
+	.voltsetup_time1 = 0x00B3,
+	.voltsetup_time2 = 0x00A0,
+	.voltoffset = 0x118,
+	.voltsetup2 = 0x32,
+	.vdd0_on = 0x28,	/* 1.1v */
+	.vdd0_onlp = 0x20,	/* 1.0v */
+	.vdd0_ret = 0x12,	/* 0.83v */
+	.vdd0_off = 0x00,	/* 0.6v */
+	.vdd1_on = 0x2B,	/* 1.1375v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x14,	/* 0.85v */
+	.vdd1_off = 0x00,	/* 0.6v */
+};
 
 static void __init omap_zoom_map_io(void)
 {
@@ -37,6 +55,7 @@ static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
 	omap_board_config_size = ARRAY_SIZE(zoom_config);
+	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
 			     NULL, NULL, NULL);
-- 
1.5.6.3

