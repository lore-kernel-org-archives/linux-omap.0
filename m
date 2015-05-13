From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] serial: omap: Switch wake-up interrupt to generic wakeirq
Date: Wed, 13 May 2015 16:36:34 -0700
Message-ID: <1431560196-5722-4-git-send-email-tony@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aso-006-i440.relay.mailchannels.net ([23.91.64.121]:51435 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754715AbbEMXhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 19:37:22 -0400
In-Reply-To: <1431560196-5722-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

We can now use generic wakeirq handling and remove the custom handling
for the wake-up interrupts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/omap-serial.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 211479a..b0cadaa 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -38,6 +38,7 @@
 #include <linux/serial_core.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/gpio.h>
@@ -160,7 +161,6 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	int			context_loss_cnt;
 	u32			errata;
-	u8			wakeups_enabled;
 	u32			features;
 
 	int			rts_gpio;
@@ -209,28 +209,11 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	return pdata->get_context_loss_count(up->dev);
 }
 
-static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
-				       bool enable)
-{
-	if (!up->wakeirq)
-		return;
-
-	if (enable)
-		enable_irq(up->wakeirq);
-	else
-		disable_irq_nosync(up->wakeirq);
-}
-
+/* REVISIT: Remove this when omap3 boots in device tree only mode */
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
-	if (enable == up->wakeups_enabled)
-		return;
-
-	serial_omap_enable_wakeirq(up, enable);
-	up->wakeups_enabled = enable;
-
 	if (!pdata || !pdata->enable_wakeup)
 		return;
 
@@ -750,13 +733,12 @@ static int serial_omap_startup(struct uart_port *port)
 
 	/* Optional wake-up IRQ */
 	if (up->wakeirq) {
-		retval = request_irq(up->wakeirq, serial_omap_irq,
-				     up->port.irqflags, up->name, up);
+		retval = dev_pm_request_wake_irq(up->dev, up->wakeirq,
+						 NULL, 0, NULL);
 		if (retval) {
 			free_irq(up->port.irq, up);
 			return retval;
 		}
-		disable_irq(up->wakeirq);
 	}
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
@@ -845,8 +827,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	free_irq(up->port.irq, up);
-	if (up->wakeirq)
-		free_irq(up->wakeirq, up);
+	dev_pm_free_wake_irq(up->dev);
 }
 
 static void serial_omap_uart_qos_work(struct work_struct *work)
@@ -1139,13 +1120,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
 
-	if (!device_may_wakeup(up->dev)) {
-		if (!state)
-			pm_runtime_forbid(up->dev);
-		else
-			pm_runtime_allow(up->dev);
-	}
-
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -1838,6 +1812,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
 
 	serial_omap_enable_wakeup(up, true);
+	dev_pm_enable_wake_irq(dev);
 
 	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	schedule_work(&up->qos_work);
@@ -1852,6 +1827,7 @@ static int serial_omap_runtime_resume(struct device *dev)
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
 	serial_omap_enable_wakeup(up, false);
+	dev_pm_disable_wake_irq(dev);
 
 	if (loss_cnt < 0) {
 		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
-- 
2.1.4

