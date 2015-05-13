From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] serial: 8250_omap: Move wake-up interrupt to generic wakeirq
Date: Wed, 13 May 2015 16:36:35 -0700
Message-ID: <1431560196-5722-5-git-send-email-tony@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i765.relay.mailchannels.net ([50.61.143.65]:41456 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754387AbbEMXhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 19:37:19 -0400
In-Reply-To: <1431560196-5722-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

We can now use generic wakeirq handling and remove the custom handling
for the wake-up interrupts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 61 +++++--------------------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9289999..ae9950b 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -22,6 +22,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 
 #include "8250.h"
@@ -551,17 +552,6 @@ static void omap8250_uart_qos_work(struct work_struct *work)
 	pm_qos_update_request(&priv->pm_qos_request, priv->latency);
 }
 
-static irqreturn_t omap_wake_irq(int irq, void *dev_id)
-{
-	struct uart_port *port = dev_id;
-	int ret;
-
-	ret = port->handle_irq(port);
-	if (ret)
-		return IRQ_HANDLED;
-	return IRQ_NONE;
-}
-
 static int omap_8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up =
@@ -571,11 +561,10 @@ static int omap_8250_startup(struct uart_port *port)
 	int ret;
 
 	if (priv->wakeirq) {
-		ret = request_irq(priv->wakeirq, omap_wake_irq,
-				  port->irqflags, "uart wakeup irq", port);
+		ret = dev_pm_request_wake_irq(port->dev, priv->wakeirq,
+					      NULL, 0, NULL);
 		if (ret)
 			return ret;
-		disable_irq(priv->wakeirq);
 	}
 
 	pm_runtime_get_sync(port->dev);
@@ -603,8 +592,7 @@ static int omap_8250_startup(struct uart_port *port)
 err:
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
-	if (priv->wakeirq)
-		free_irq(priv->wakeirq, port);
+	dev_pm_free_wake_irq(port->dev);
 	return ret;
 }
 
@@ -625,9 +613,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
-
-	if (priv->wakeirq)
-		free_irq(priv->wakeirq, port);
+	dev_pm_free_wake_irq(port->dev);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
@@ -1129,31 +1115,6 @@ static int omap8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
-static inline void omap8250_enable_wakeirq(struct omap8250_priv *priv,
-					   bool enable)
-{
-	if (!priv->wakeirq)
-		return;
-
-	if (enable)
-		enable_irq(priv->wakeirq);
-	else
-		disable_irq_nosync(priv->wakeirq);
-}
-
-static void omap8250_enable_wakeup(struct omap8250_priv *priv,
-				   bool enable)
-{
-	if (enable == priv->wakeups_enabled)
-		return;
-
-	omap8250_enable_wakeirq(priv, enable);
-	priv->wakeups_enabled = enable;
-}
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 static int omap8250_prepare(struct device *dev)
 {
@@ -1180,11 +1141,6 @@ static int omap8250_suspend(struct device *dev)
 
 	serial8250_suspend_port(priv->line);
 	flush_work(&priv->qos_work);
-
-	if (device_may_wakeup(dev))
-		omap8250_enable_wakeup(priv, true);
-	else
-		omap8250_enable_wakeup(priv, false);
 	return 0;
 }
 
@@ -1192,9 +1148,6 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(dev))
-		omap8250_enable_wakeup(priv, false);
-
 	serial8250_resume_port(priv->line);
 	return 0;
 }
@@ -1236,7 +1189,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 			return -EBUSY;
 	}
 
-	omap8250_enable_wakeup(priv, true);
+	dev_pm_enable_wake_irq(dev);
 	if (up->dma)
 		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
 
@@ -1257,7 +1210,7 @@ static int omap8250_runtime_resume(struct device *dev)
 		return 0;
 
 	up = serial8250_get_port(priv->line);
-	omap8250_enable_wakeup(priv, false);
+	dev_pm_disable_wake_irq(dev);
 	loss_cntx = omap8250_lost_context(up);
 
 	if (loss_cntx)
-- 
2.1.4

