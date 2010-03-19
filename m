From: hvaibhav@ti.com
Subject: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with vdds_dsi
Date: Fri, 19 Mar 2010 16:51:19 +0530
Message-ID: <1268997679-27869-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36453 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab0CSLV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 07:21:29 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With recent changes happened in OMAP2/3 DSS library for regulator interface, it
is required to define DSI regulator supply, without this DSS (in turn Fbdev)
fails to get regulator.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..74bbdcb 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -514,14 +514,11 @@ static struct regulator_init_data omap3_evm_vdac = {
 };

 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_evm_lcd_device.dev,
-};
+static struct regulator_consumer_supply omap3_evm_vpll2_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");

 static struct regulator_init_data omap3_evm_vpll2 = {
 	.constraints = {
-		.name			= "VDVI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
--
1.6.2.4

