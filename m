From: jean.pihet@newoldbits.com
Subject: [PATCH 1/5] OMAP3 cpuidle: remove useless SDP specific timings
Date: Fri, 29 Apr 2011 11:26:22 +0200
Message-ID: <1304069186-3086-2-git-send-email-j-pihet@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33081 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab1D2J0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 05:26:53 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2712160wya.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 02:26:52 -0700 (PDT)
In-Reply-To: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The cpuidle states settings can be overriden by some board-
specific settings, by calling omap3_pm_init_cpuidle.
Remove the 3430SDP specific states settings registration
since the figures are identical to the default ones (in cpuidle34xx.c).

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..7ffad7b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -59,24 +59,6 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
-/* FIXME: These values need to be updated based on more profiling on 3430sdp*/
-static struct cpuidle_params omap3_cpuidle_params_table[] = {
-	/* C1 */
-	{1, 2, 2, 5},
-	/* C2 */
-	{1, 10, 10, 30},
-	/* C3 */
-	{1, 50, 50, 300},
-	/* C4 */
-	{1, 1500, 1800, 4000},
-	/* C5 */
-	{1, 2500, 7500, 12000},
-	/* C6 */
-	{1, 3000, 8500, 15000},
-	/* C7 */
-	{1, 10000, 30000, 300000},
-};
-
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -883,7 +865,6 @@ static void __init omap_3430sdp_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
-	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap3430_i2c_init();
 	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
-- 
1.7.1

