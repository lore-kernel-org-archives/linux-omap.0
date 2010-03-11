From: hvaibhav@ti.com
Subject: [PATCH] OMAP: Replace vdvi with vdds_dsi regulator supply in OMAP3EVM board file
Date: Thu, 11 Mar 2010 15:00:42 +0530
Message-ID: <1268299842-8070-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41938 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0CKJa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:30:58 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Tomi.Valkeinen@nokia.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With recent changes happened in OMAP2/3 DSS library for regulator interface, it
is required to define DSI regulator supply, and since we don't need VDVI
supply so remove it.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..ea1014b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -515,8 +515,8 @@ static struct regulator_init_data omap3_evm_vdac = {

 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_evm_lcd_device.dev,
+	.supply		= "vdds_dsi",
+	.dev		= &omap3_evm_dss_device.dev,
 };

 static struct regulator_init_data omap3_evm_vpll2 = {
--
1.6.2.4

