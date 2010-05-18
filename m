From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 07/14] OMAP2: Devkit8000: Remove en-/disable for tv panel
Date: Tue, 18 May 2010 14:05:28 +0200
Message-ID: <1274184335-29322-8-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60159 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

This patch removes devkit8000_panel_enable_tv and devkit8000_panel_disable_tv
because they are already done in DSS2 code.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 7d68016..543becc 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -158,16 +158,6 @@ static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
-{
-
-	return 0;
-}
-
-static void devkit8000_panel_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -201,8 +191,6 @@ static struct omap_dss_device devkit8000_tv_device = {
 	.driver_name            = "venc",
 	.type                   = OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable        = devkit8000_panel_enable_tv,
-	.platform_disable       = devkit8000_panel_disable_tv,
 };
 
 
-- 
1.6.4.4

