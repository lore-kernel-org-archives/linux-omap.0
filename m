From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 05/14] OMAP2: Devkit8000: Remove unneeded VDVI
Date: Tue, 18 May 2010 14:05:26 +0200
Message-ID: <1274184335-29322-6-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55018 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

The VDVI is no longer needed with the new DSS2 interface. This
patch removes the supply from board code.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 37b047e..4611274 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -314,10 +314,6 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	{
-	.supply		= "vdvi",
-	.dev		= &devkit8000_lcd_device.dev,
-	},
-	{
 	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
@@ -370,7 +366,6 @@ static struct regulator_init_data devkit8000_vdac = {
 /* VPLL1 for digital video outputs */
 static struct regulator_init_data devkit8000_vpll1 = {
 	.constraints = {
-		.name			= "VDVI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-- 
1.6.4.4

