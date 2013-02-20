From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/8] ARM: OMAP2+: serial: Remove the un-used slave idle hooks
Date: Wed, 20 Feb 2013 15:31:09 +0530
Message-ID: <1361354469-18275-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60041 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797Ab3BTJ7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 04:59:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

UART IP idle handling now taken care by runtime pm backend(hwmod) indirectly
and OMAP serial driver is also cleaned up accordingly.

So remove the un-used slave idle platforms hooks now.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/serial.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 04fdbc4..037e691 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -95,38 +95,9 @@ static void omap_uart_enable_wakeup(struct device *dev, bool enable)
 		omap_hwmod_disable_wakeup(od->hwmods[0]);
 }
 
-/*
- * Errata i291: [UART]:Cannot Acknowledge Idle Requests
- * in Smartidle Mode When Configured for DMA Operations.
- * WA: configure uart in force idle mode.
- */
-static void omap_uart_set_noidle(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *od = to_omap_device(pdev);
-
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
-}
-
-static void omap_uart_set_smartidle(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *od = to_omap_device(pdev);
-	u8 idlemode;
-
-	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
-		idlemode = HWMOD_IDLEMODE_SMART_WKUP;
-	else
-		idlemode = HWMOD_IDLEMODE_SMART;
-
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
-}
-
 #else
 static void omap_uart_enable_wakeup(struct device *dev, bool enable)
 {}
-static void omap_uart_set_noidle(struct device *dev) {}
-static void omap_uart_set_smartidle(struct device *dev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
@@ -299,8 +270,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
-	omap_up.set_forceidle = omap_uart_set_smartidle;
-	omap_up.set_noidle = omap_uart_set_noidle;
 	omap_up.enable_wakeup = omap_uart_enable_wakeup;
 	omap_up.dma_rx_buf_size = info->dma_rx_buf_size;
 	omap_up.dma_rx_timeout = info->dma_rx_timeout;
-- 
1.7.9.5

