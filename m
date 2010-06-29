From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 3/3]: OMAP3:PM: Add power state parameter for
 omap_uart_prepare_idle
Date: Tue, 29 Jun 2010 12:29:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323763485@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab0F2G7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 02:59:15 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Teerth Reddy <teerth@ti.com>

This patch has the changes which adds power state parameter
for the omap_uart_prepare_idle idle function.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index e321281..7046e74 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -119,9 +119,9 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
+	omap_uart_prepare_idle(0, PWRDM_POWER_RET);
+	omap_uart_prepare_idle(1, PWRDM_POWER_RET);
+	omap_uart_prepare_idle(2, PWRDM_POWER_RET);
 
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
-- 
1.5.4.3

