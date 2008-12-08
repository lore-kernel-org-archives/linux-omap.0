From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/1] Default MUX configuration added for GPIO140-143, GPIO0 and GPIO9
Date: Mon,  8 Dec 2008 15:10:39 +0530
Message-ID: <1228729239-7757-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35205 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbYLHJkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 04:40:47 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB89ee5g019179
	for <linux-omap@vger.kernel.org>; Mon, 8 Dec 2008 03:40:46 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

Default MUX configurations for GPIO on OMAP3 EVM boards are added.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/mux.c             |   13 +++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |    6 ++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index dacb41f..68531b6 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -459,6 +459,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF6_34XX_GPIO140", 0x16c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f4362b8..8c69297 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -790,6 +790,12 @@ enum omap34xx_index {
 	 */
 	AH8_34XX_GPIO29,
 	J25_34XX_GPIO170,
+	AF26_34XX_GPIO0,
+	AF22_34XX_GPIO9,
+	AF6_34XX_GPIO140,
+	AE6_34XX_GPIO141,
+	AF5_34XX_GPIO142,
+	AE5_34XX_GPIO143
 };
 
 struct omap_mux_cfg {
-- 
1.5.6

