From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] ARM: OMAP3: Use force-idle for UARTs because of DMA errata
Date: Mon, 15 Sep 2014 20:11:56 -0700
Message-ID: <1410837126-31553-2-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19668 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754050AbaIPDMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:12:51 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In sprz318f.pdf "Usage Note 2.7" says that UARTs cannot acknowledge
idle requests in smartidle mode when configured for DMA operations.
This prevents L4 from going idle. So let's use force-idle mode
instead and also force reconfiguring of the IO chain wake-up events.

Otherwise systems using Sebastian's 8250 patches with DMA will
never enter deeper idle states because of the errata above.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 61cd49d..55f088c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -490,7 +490,9 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
-	.flags		= DEBUG_TI81XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_TI81XXUART1_FLAGS |
+				HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
+				HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -509,7 +511,9 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
-	.flags		= DEBUG_TI81XXUART2_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_TI81XXUART2_FLAGS |
+				HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
+				HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -529,7 +533,8 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
 	.flags		= DEBUG_OMAP3UART3_FLAGS | DEBUG_TI81XXUART3_FLAGS |
-				HWMOD_SWSUP_SIDLE_ACT,
+				HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
+				HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
@@ -559,7 +564,9 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.mpu_irqs	= uart4_mpu_irqs,
 	.sdma_reqs	= uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
-	.flags		= DEBUG_OMAP3UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= DEBUG_OMAP3UART4_FLAGS |
+				HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
+				HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
-- 
2.1.0

