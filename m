From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/27] ARM: OMAP: add vdds_dsi supply for dpi.0
Date: Thu, 30 May 2013 12:36:19 +0300
Message-ID: <1369906580-27585-27-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030436Ab3E3JhY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:37:24 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DPI driver gets currently the vdds_dsi regulator via omapdss device.
This is not correct, and we'll change the DPI driver to get the
regulator directly.

This patch changes the relevant board files to add vdds_dsi supply for
dpi.0 device.

Note that the vdds_dsi supply for omapdss device is still left there, as
the current display driver uses it. When both the board files and the
display driver has been changed, we can remove the unused supply.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c       | 1 +
 arch/arm/mach-omap2/board-devkit8000.c   | 1 +
 arch/arm/mach-omap2/board-ldp.c          | 1 +
 arch/arm/mach-omap2/board-omap3pandora.c | 1 +
 arch/arm/mach-omap2/twl-common.c         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ce00968..d4622ed 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -293,6 +293,7 @@ static struct regulator_consumer_supply cm_t35_vsim_supply[] = {
 static struct regulator_consumer_supply cm_t35_vio_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi1.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5764205..f1d91ba 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -222,6 +222,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 3dbc881..62e4f70 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -272,6 +272,7 @@ static struct regulator_init_data ldp_vaux1 = {
 
 static struct regulator_consumer_supply ldp_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 28133d5..b1547a0 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -343,6 +343,7 @@ static struct regulator_consumer_supply pandora_vmmc3_supply[] = {
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 51e138c..c05898f 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -140,6 +140,7 @@ static struct regulator_init_data omap3_vdac_idata = {
 
 static struct regulator_consumer_supply omap3_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
-- 
1.8.1.2

