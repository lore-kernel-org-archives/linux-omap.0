From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/10] OMAP: DSS2: Change DSI device naming
Date: Tue, 20 Sep 2011 11:18:17 +0300
Message-ID: <1316506706-18941-2-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40581 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995Ab1ITISr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:18:47 -0400
Received: by mail-bw0-f48.google.com with SMTP id zu5so234987bkb.7
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:18:46 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>

Currently, there are 2 differently named platform devices generated for
the 2 DSS DSI modules. In order to use the same driver, the dsi devices
should be 2 instances of the same platform device.

Change the platform device names from "omapdss_dsi1" and "omapdss_dsi2"
to omapdss_dsi", and set the device indices to 0 and 1.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c   |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/display.c            |    6 +++---
 arch/arm/mach-omap2/twl-common.c         |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b6002ec..d3941e6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -267,7 +267,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 080d7bd..3f10001 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -335,7 +335,7 @@ static struct regulator_consumer_supply pandora_vmmc3_supply[] = {
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply[] = {
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a5b7a23..c42df11 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -61,7 +61,7 @@ static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
 };
 
 static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
@@ -69,8 +69,8 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
-	{ "dss_dsi2", "omapdss_dsi2", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
+	{ "dss_dsi2", "omapdss_dsi", 1 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index daa056e..4f6d216 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -99,7 +99,7 @@ static struct regulator_init_data omap3_vdac_idata = {
 
 static struct regulator_consumer_supply omap3_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data omap3_vpll2_idata = {
-- 
1.7.4.1

