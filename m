From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] serial: omap: Switch wake-up interrupt to generic wakeirq
Date: Thu,  5 Mar 2015 16:34:08 -0800
Message-ID: <1425602049-2674-4-git-send-email-tony@atomide.com>
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
 drivers/tty/serial/omap-serial.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 10256fa..1e82365 100644
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
@@ -135,6 +136,7 @@ struct uart_omap_port {
 	struct uart_port	port;
 	struct uart_omap_dma	uart_dma;
 	struct device		*dev;
+	struct wakeirq_source	*wirq;
 	int			wakeirq;
 
 	unsigned char		ier;
@@ -160,7 +162,6 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	int			context_loss_cnt;
 	u32			errata;
-	u8			wakeups_enabled;
 	u32			features;
 
 	int			rts_gpio;
@@ -209,28 +210,11 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
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
 
@@ -750,13 +734,16 @@ static int serial_omap_startup(struct uart_port *port)
 
 	/* Optional wake-up IRQ */
 	if (up->wakeirq) {
-		retval = request_irq(up->wakeirq, serial_omap_irq,
-				     up->port.irqflags, up->name, up);
+		up->wirq = devm_kzalloc(up->dev, sizeof(*up->wirq),
+					GFP_KERNEL);
+		if (!up->wirq)
+			return -ENOMEM;
+		retval = dev_pm_wakeirq_request(up->dev, up->wakeirq,
+						NULL, 0, NULL, up->wirq);
 		if (retval) {
 			free_irq(up->port.irq, up);
 			return retval;
 		}
-		disable_irq(up->wakeirq);
 	}
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
@@ -845,8 +832,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	free_irq(up->port.irq, up);
-	if (up->wakeirq)
-		free_irq(up->wakeirq, up);
+	dev_pm_wakeirq_free(up->wirq);
 }
 
 static void serial_omap_uart_qos_work(struct work_struct *work)
@@ -1479,6 +1465,8 @@ static int serial_omap_suspend(struct device *dev)
 	else
 		serial_omap_enable_wakeup(up, false);
 
+	dev_pm_wakeirq_arm_for_suspend(up->wirq);
+
 	return 0;
 }
 
@@ -1838,6 +1826,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
 
 	serial_omap_enable_wakeup(up, true);
+	dev_pm_wakeirq_enable(up->wirq);
 
 	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	schedule_work(&up->qos_work);
@@ -1852,6 +1841,7 @@ static int serial_omap_runtime_resume(struct device *dev)
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
 	serial_omap_enable_wakeup(up, false);
+	dev_pm_wakeirq_disable(up->wirq);
 
 	if (loss_cnt < 0) {
 		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
-- 
2.1.4
