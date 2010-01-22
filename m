From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 3/3] OMAP3: VC: 3430SDP: remove prm_setup_vc, done in common VC code
Date: Thu, 21 Jan 2010 17:02:21 -0800
Message-ID: <1264122141-17886-4-git-send-email-khilman@deeprootsystems.com>
References: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:60567 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab0AVBC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 20:02:29 -0500
Received: by mail-iw0-f196.google.com with SMTP id 34so557850iwn.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 17:02:29 -0800 (PST)
In-Reply-To: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>

OMAP3430SDP board can use the common default values defined in
VC init code.  No need to define custom values in board file.

---
 arch/arm/mach-omap2/board-3430sdp.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 65ab469..c924950 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -48,7 +48,6 @@
 #include "mmc-twl4030.h"
 #include "pm.h"
 #include "omap3-opp.h"
-#include "vc.h"
 
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
 #define SDP3430_TS_GPIO_IRQ_SDPV2	2
@@ -76,23 +75,6 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{1, 10000, 30000, 300000},
 };
 
-/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
-static struct prm_setup_vc omap3_setuptime_table = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,
-	.vdd0_onlp = 0x20,
-	.vdd0_ret = 0x1e,
-	.vdd0_off = 0x00,
-	.vdd1_on = 0x2c,
-	.vdd1_onlp = 0x20,
-	.vdd1_ret = 0x1e,
-	.vdd1_off = 0x00,
-};
-
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -344,7 +326,6 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
-- 
1.6.6

