From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] arm: omap2: fix AM33xx hwmod infos for UART2
Date: Tue, 28 May 2013 17:17:45 +0200
Message-ID: <1369754265-27712-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:57249 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934418Ab3E1PRs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 11:17:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiremath Vaibhav <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>

The UART2 hwmod structure is pointing to the EDMA channels of UART1,
which doesn't look right. This patch fixes this by making the UART2
hwmod structure to a new structure that lists the EDMA channels to be
used by the UART2.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 01d8f32..9113251 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2006,6 +2006,13 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 	},
 };
 
+/* uart2 */
+static struct omap_hwmod_dma_info uart2_edma_reqs[] = {
+	{ .name = "tx",	.dma_req = 28, },
+	{ .name = "rx",	.dma_req = 29, },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod_irq_info am33xx_uart2_irqs[] = {
 	{ .irq = 73 + OMAP_INTC_START, },
 	{ .irq = -1 },
@@ -2016,7 +2023,7 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.mpu_irqs	= am33xx_uart2_irqs,
-	.sdma_reqs	= uart1_edma_reqs,
+	.sdma_reqs	= uart2_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-- 
1.7.9.5

