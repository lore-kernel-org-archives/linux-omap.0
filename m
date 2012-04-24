From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2] tty: omap-serial: configure wakeup mechanism based on port usage.
Date: Tue, 24 Apr 2012 19:23:48 +0530
Message-ID: <1335275628-24200-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab2DXN4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 09:56:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

With set_wakeup port ops availability from serial_core layer
which will be called when port is opened with state as true
indicating the wakeups can be enabled for this port and state
as false while port shutdown where we can disable the wakeups.

But wakeup can be also enabled/disabled when requested from sysfs.
If wakeups are disabled while entering suspend we have to enable them
back while port is used from resume. This can be done with serial_omap_pm
this uart ops has state flag indicating if port is going to be used.
serial_omap_pm gets called from serial_core layer.

Thanks to Kevin Hilman <khilman@ti.com> for suggesting this.
Discussion References:
http://www.spinics.net/lists/linux-omap/msg67764.html
http://www.spinics.net/lists/linux-omap/msg67838.html

Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---

Patch is tested using the patch as in here[1]
Tested on beagle-XM by enabling and disabling wakeups
from sysfs and opening and closing a uart port.

[1]: http://marc.info/?l=linux-omap&m=133518614022144&w=2

 arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
 drivers/tty/serial/omap-serial.c              |   40 +++++++++++++-----------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..8e6d734 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -130,7 +130,6 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
 	u32			errata;
-	u8			wakeups_enabled;
 
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d00b38e..b66818b 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -910,11 +910,23 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
 }
 
+static int serial_omap_set_wake(struct uart_port *port, unsigned int state)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
+
+	if (pdata->enable_wakeup)
+		pdata->enable_wakeup(up->pdev, state ? true : false);
+
+	return 0;
+}
+
 static void
 serial_omap_pm(struct uart_port *port, unsigned int state,
 	       unsigned int oldstate)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->port.line);
@@ -930,12 +942,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
 
-	if (!device_may_wakeup(&up->pdev->dev)) {
-		if (!state)
-			pm_runtime_forbid(&up->pdev->dev);
-		else
-			pm_runtime_allow(&up->pdev->dev);
-	}
+	if (!state && pdata->enable_wakeup)
+		pdata->enable_wakeup(up->pdev, true);
 
 	pm_runtime_put(&up->pdev->dev);
 }
@@ -1161,6 +1169,7 @@ static struct uart_ops serial_omap_pops = {
 	.shutdown	= serial_omap_shutdown,
 	.set_termios	= serial_omap_set_termios,
 	.pm		= serial_omap_pm,
+	.set_wake	= serial_omap_set_wake,
 	.type		= serial_omap_type,
 	.release_port	= serial_omap_release_port,
 	.request_port	= serial_omap_request_port,
@@ -1184,10 +1193,14 @@ static struct uart_driver serial_omap_reg = {
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
 
 	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
 		flush_work_sync(&up->qos_work);
+
+		if (!device_may_wakeup(dev))
+			pdata->enable_wakeup(up->pdev, false);
 	}
 
 	return 0;
@@ -1476,6 +1489,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_add_port;
 
+	if (omap_up_info->enable_wakeup)
+		omap_up_info->enable_wakeup(pdev, false);
+
 	pm_runtime_put(&pdev->dev);
 	platform_set_drvdata(pdev, up);
 	return 0;
@@ -1582,18 +1598,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
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
-- 
1.7.9

