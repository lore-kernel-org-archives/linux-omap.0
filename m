From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 2/6] Devkit8000: Remove unneeded VDVI
Date: Sat,  8 May 2010 06:31:19 +0200
Message-ID: <1273293083-24063-3-git-send-email-weber@corscience.de>
References: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34370 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0EHEbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:45 -0400
In-Reply-To: <1273293083-24063-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Removes the VDVI from board code because
the VDVI is no longer needed with the new
DSS2 interface.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 7ad5684..e557bae 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -288,10 +288,6 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	{
-	.supply		= "vdvi",
-	.dev		= &devkit8000_lcd_device.dev,
-	},
-	{
 	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
@@ -344,7 +340,6 @@ static struct regulator_init_data devkit8000_vdac = {
 /* VPLL1 for digital video outputs */
 static struct regulator_init_data devkit8000_vpll1 = {
 	.constraints = {
-		.name			= "VDVI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-- 
1.6.4.4

