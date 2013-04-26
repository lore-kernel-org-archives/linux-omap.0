From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv5 2/2] driver: serial: omap: prevent runtime PM for "no_console_suspend"
Date: Sat, 27 Apr 2013 01:34:46 +0530
Message-ID: <1367006686-3720-3-git-send-email-sourav.poddar@ti.com>
References: <1367006686-3720-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367006686-3720-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

The driver manages "no_console_suspend" by preventing runtime PM
during the suspend path, which forces the console UART to stay awake.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 30d4f7a..9457fe3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -161,6 +161,7 @@ struct uart_omap_port {
 	u32			calc_latency;
 	struct work_struct	qos_work;
 	struct pinctrl		*pins;
+	bool			is_suspending;
 };
 
 #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
@@ -1312,6 +1313,22 @@ static struct uart_driver serial_omap_reg = {
 };
 
 #ifdef CONFIG_PM_SLEEP
+static int serial_omap_prepare(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	up->is_suspending = true;
+
+	return 0;
+}
+
+static void serial_omap_complete(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	up->is_suspending = false;
+}
+
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
@@ -1330,7 +1347,10 @@ static int serial_omap_resume(struct device *dev)
 
 	return 0;
 }
-#endif
+#else
+#define serial_omap_prepare NULL
+#define serial_omap_prepare NULL
+#endif /* CONFIG_PM_SLEEP */
 
 static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
 {
@@ -1616,6 +1636,16 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
+	/*
+	* When using 'no_console_suspend', the console UART must not be
+	* suspended. Since driver suspend is managed by runtime suspend,
+	* preventing runtime suspend (by returning error) will keep device
+	* active during suspend.
+	*/
+	if (up->is_suspending && !console_suspend_enabled &&
+	    uart_console(&up->port))
+		return -EBUSY;
+
 	if (!up)
 		return -EINVAL;
 
@@ -1666,6 +1696,8 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
 	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
 				serial_omap_runtime_resume, NULL)
+	.prepare        = serial_omap_prepare,
+	.complete       = serial_omap_complete,
 };
 
 #if defined(CONFIG_OF)
-- 
1.7.1
