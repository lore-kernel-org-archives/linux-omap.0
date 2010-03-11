From: hvaibhav@ti.com
Subject: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board file
Date: Thu, 11 Mar 2010 14:25:17 +0530
Message-ID: <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab0CKIz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 03:55:28 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Tomi.Valkeinen@nokia.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With recent changes happened in OMAP2/3 DSS library for regulator interface, it
is required to define DSI regulator supply, without this DSS (in turn Fbdev)
fails to get regulator.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..a05de10 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac = {
 };

 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_evm_lcd_device.dev,
+static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
+	{
+		.supply		= "vdvi",
+		.dev		= &omap3_evm_lcd_device.dev,
+	},
+	{
+		.supply		= "vdds_dsi",
+		.dev		= &omap3_evm_dss_device.dev,
+	},
 };

 static struct regulator_init_data omap3_evm_vpll2 = {
@@ -530,8 +536,8 @@ static struct regulator_init_data omap3_evm_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &omap3_evm_vpll2_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(omap3_evm_vpll2_supplies),
+	.consumer_supplies	= omap3_evm_vpll2_supplies,
 };

 static struct twl4030_platform_data omap3evm_twldata = {
--
1.6.2.4

