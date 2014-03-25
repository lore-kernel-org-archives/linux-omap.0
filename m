From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] serial: omap: Fix missing pm_runtime_resume handling by
 simplifying code
Date: Tue, 25 Mar 2014 11:48:47 -0700
Message-ID: <20140325184846.GB31906@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

The lack of pm_runtime_resume handling for the device state leads into
device wake-up interrupts not working after a while for runtime PM.

Also, serial-omap is confused about the use of device_may_wakeup.
The checks for device_may_wakeup should only be done for suspend and
resume, not for pm_runtime_suspend and pm_runtime_resume. The wake-up
events for PM runtime should always be enabled.

The lack of pm_runtime_resume handling leads into device wake-up
interrupts not working after a while for runtime PM.

Rather than try to patch over the issue of adding complex tests to
the pm_runtime_resume, let's fix the issues properly:

1. Make serial_omap_enable_wakeup deal with all internal PM state
   handling so we don't need to test for up->wakeups_enabled elsewhere.

   Later on once omap3 boots in device tree only mode we can also
   remove the up->wakeups_enabled flag and rely on the wake-up
   interrupt enable/disable state alone.

2. Do the device_may_wakeup checks in suspend and resume only,
   for runtime PM the wake-up events need to be always enabled.

3. Finally just call serial_omap_enable_wakeup and make sure we
   call it also in pm_runtime_resume.

4. Note that we also have to use disable_irq_nosync as serial_omap_irq
   calls pm_runtime_get_sync.

Fixes: 2a0b965cfb6e (serial: omap: Add support for optional wake-up)
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -225,14 +225,19 @@ static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
 	if (enable)
 		enable_irq(up->wakeirq);
 	else
-		disable_irq(up->wakeirq);
+		disable_irq_nosync(up->wakeirq);
 }
 
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
+	if (enable == up->wakeups_enabled)
+		return;
+
 	serial_omap_enable_wakeirq(up, enable);
+	up->wakeups_enabled = enable;
+
 	if (!pdata || !pdata->enable_wakeup)
 		return;
 
@@ -1495,6 +1500,11 @@ static int serial_omap_suspend(struct device *dev)
 	uart_suspend_port(&serial_omap_reg, &up->port);
 	flush_work(&up->qos_work);
 
+	if (device_may_wakeup(dev))
+		serial_omap_enable_wakeup(up, true);
+	else
+		serial_omap_enable_wakeup(up, false);
+
 	return 0;
 }
 
@@ -1502,6 +1512,9 @@ static int serial_omap_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
+	if (device_may_wakeup(dev))
+		serial_omap_enable_wakeup(up, false);
+
 	uart_resume_port(&serial_omap_reg, &up->port);
 
 	return 0;
@@ -1877,17 +1890,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 
 	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
 
-	if (device_may_wakeup(dev)) {
-		if (!up->wakeups_enabled) {
-			serial_omap_enable_wakeup(up, true);
-			up->wakeups_enabled = true;
-		}
-	} else {
-		if (up->wakeups_enabled) {
-			serial_omap_enable_wakeup(up, false);
-			up->wakeups_enabled = false;
-		}
-	}
+	serial_omap_enable_wakeup(up, true);
 
 	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	schedule_work(&up->qos_work);
@@ -1901,6 +1904,8 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
+	serial_omap_enable_wakeup(up, false);
+
 	if (loss_cnt < 0) {
 		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
 			loss_cnt);
