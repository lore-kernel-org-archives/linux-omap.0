From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 02/14] OMAP2: Devkit8000: change lcd panel to generic
Date: Tue, 18 May 2010 14:05:23 +0200
Message-ID: <1274184335-29322-3-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62897 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0ERMGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:01 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Choose the generic panel to use with Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 887e1a1..e989136 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -175,7 +175,7 @@ static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
-	.driver_name            = "innolux_at_panel",
+	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
 	.platform_enable        = devkit8000_panel_enable_lcd,
-- 
1.6.4.4

