From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/19] omap: Add DSI regulator supply to OMAP3EVM board file
Date: Thu, 11 Mar 2010 15:48:47 -0800
Message-ID: <20100311234847.4500.24584.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52881 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:23 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With recent changes happened in OMAP2/3 DSS library for regulator interface, it
is required to define DSI regulator supply, without this DSS (in turn Fbdev)
fails to get regulator.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

