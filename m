From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by default
Date: Mon, 16 Apr 2012 18:00:07 +0530
Message-ID: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja@ti.com>

The wakeups can be left enabled by default and should be disabled
only when disabled from sysfs and while entering suspend.

Thanks to Kevin Hilman <khilman@ti.com> for suggesting this.
Discussion References:
http://www.spinics.net/lists/linux-omap/msg67764.html
http://www.spinics.net/lists/linux-omap/msg67838.html

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |   30 +++++++++++-------------------
 1 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d00b38e..4a92447 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -930,13 +930,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
 
-	if (!device_may_wakeup(&up->pdev->dev)) {
-		if (!state)
-			pm_runtime_forbid(&up->pdev->dev);
-		else
-			pm_runtime_allow(&up->pdev->dev);
-	}
-
 	pm_runtime_put(&up->pdev->dev);
 }
 
@@ -1184,10 +1177,16 @@ static struct uart_driver serial_omap_reg = {
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
 
 	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
 		flush_work_sync(&up->qos_work);
+
+		if (!device_may_wakeup(dev)) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wakeups_enabled = false;
+		}
 	}
 
 	return 0;
@@ -1582,18 +1581,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt = pdata->get_context_loss_count(dev);
 
-	if (device_may_wakeup(dev)) {
-		if (!up->wakeups_enabled) {
-			pdata->enable_wakeup(up->pdev, true);
-			up->wakeups_enabled = true;
-		}
-	} else {
-		if (up->wakeups_enabled) {
-			pdata->enable_wakeup(up->pdev, false);
-			up->wakeups_enabled = false;
-		}
-	}
-
 	/* Errata i291 */
 	if (up->use_dma && pdata->set_forceidle &&
 			(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
@@ -1618,6 +1605,11 @@ static int serial_omap_runtime_resume(struct device *dev)
 				serial_omap_restore_context(up);
 		}
 
+		if (!up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wakeups_enabled = true;
+		}
+
 		/* Errata i291 */
 		if (up->use_dma && pdata->set_noidle &&
 				(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
-- 
1.7.9

