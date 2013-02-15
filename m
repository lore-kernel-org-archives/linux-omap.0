From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from the driver
Date: Fri, 15 Feb 2013 17:38:55 +0530
Message-ID: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38640 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932773Ab3BOMHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:07:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra nayak <rnayak@ti.com>

UART IP idle handling now taken care by runtime pm apis so remove
the hackery from the driver.

Signed-off-by: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   31 -------------------------------
 drivers/tty/serial/omap-serial.c |   23 -----------------------
 2 files changed, 54 deletions(-)

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
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 57d6b29..5722eaf 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -201,26 +201,6 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
-static void serial_omap_set_forceidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_forceidle)
-		return;
-
-	pdata->set_forceidle(up->dev);
-}
-
-static void serial_omap_set_noidle(struct uart_omap_port *up)
-{
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
-
-	if (!pdata || !pdata->set_noidle)
-		return;
-
-	pdata->set_noidle(up->dev);
-}
-
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
@@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	serial_omap_set_forceidle(up);
-
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 	pm_runtime_get_sync(up->dev);
 	serial_omap_enable_ier_thri(up);
-	serial_omap_set_noidle(up);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
-- 
1.7.9.5

