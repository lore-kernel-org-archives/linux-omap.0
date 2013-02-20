From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the driver
Date: Wed, 20 Feb 2013 15:30:44 +0530
Message-ID: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757746Ab3BTJ71 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 04:59:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
so remove the hackery from the driver.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/tty/serial/omap-serial.c |   23 -----------------------
 1 file changed, 23 deletions(-)

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

