From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] serial: 8250_omap: Move wake-up interrupt to generic wakeirq
Date: Thu,  5 Mar 2015 16:34:07 -0800
Message-ID: <1425602049-2674-3-git-send-email-tony@atomide.com>
References: <1425602049-2674-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425602049-2674-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can now use generic wakeirq handling and remove the custom handling
for the wake-up interrupts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 67 ++++++++-----------------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fe6d2e51..e3e7851 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 
 #include "8250.h"
@@ -99,6 +100,7 @@ struct omap8250_priv {
 	struct pm_qos_request pm_qos_request;
 	struct work_struct qos_work;
 	struct uart_8250_dma omap8250_dma;
+	struct wakeirq_source *wirq;
 };
 
 static u32 uart_read(struct uart_8250_port *up, u32 reg)
@@ -552,17 +554,6 @@ static void omap8250_uart_qos_work(struct work_struct *work)
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
@@ -572,11 +563,15 @@ static int omap_8250_startup(struct uart_port *port)
 	int ret;
 
 	if (priv->wakeirq) {
-		ret = request_irq(priv->wakeirq, omap_wake_irq,
-				  port->irqflags, "uart wakeup irq", port);
+		priv->wirq = devm_kzalloc(port->dev,
+					  sizeof(*priv->wirq),
+					  GFP_KERNEL);
+		if (!priv->wirq)
+			return -ENOMEM;
+		ret = dev_pm_wakeirq_request(port->dev, priv->wakeirq,
+					     NULL, 0, NULL, priv->wirq);
 		if (ret)
 			return ret;
-		disable_irq(priv->wakeirq);
 	}
 
 	pm_runtime_get_sync(port->dev);
@@ -604,8 +599,7 @@ static int omap_8250_startup(struct uart_port *port)
 err:
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
-	if (priv->wakeirq)
-		free_irq(priv->wakeirq, port);
+	dev_pm_wakeirq_free(priv->wirq);
 	return ret;
 }
 
@@ -627,8 +621,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 
-	if (priv->wakeirq)
-		free_irq(priv->wakeirq, port);
+	dev_pm_wakeirq_free(priv->wirq);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
@@ -1130,31 +1123,6 @@ static int omap8250_remove(struct platform_device *pdev)
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
@@ -1181,11 +1149,7 @@ static int omap8250_suspend(struct device *dev)
 
 	serial8250_suspend_port(priv->line);
 	flush_work(&priv->qos_work);
-
-	if (device_may_wakeup(dev))
-		omap8250_enable_wakeup(priv, true);
-	else
-		omap8250_enable_wakeup(priv, false);
+	dev_pm_wakeirq_arm_for_suspend(priv->wirq);
 	return 0;
 }
 
@@ -1193,9 +1157,6 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(dev))
-		omap8250_enable_wakeup(priv, false);
-
 	serial8250_resume_port(priv->line);
 	return 0;
 }
@@ -1237,7 +1198,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 			return -EBUSY;
 	}
 
-	omap8250_enable_wakeup(priv, true);
+	dev_pm_wakeirq_enable(priv->wirq);
 	if (up->dma)
 		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
 
@@ -1258,7 +1219,7 @@ static int omap8250_runtime_resume(struct device *dev)
 		return 0;
 
 	up = serial8250_get_port(priv->line);
-	omap8250_enable_wakeup(priv, false);
+	dev_pm_wakeirq_disable(priv->wirq);
 	loss_cntx = omap8250_lost_context(up);
 
 	if (loss_cntx)
-- 
2.1.4
