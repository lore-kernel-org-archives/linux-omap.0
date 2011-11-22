From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/4] omap-serial: Add minimal device tree support
Date: Tue, 22 Nov 2011 19:14:15 +0530
Message-ID: <1321969456-24266-4-git-send-email-rnayak@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321969456-24266-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: khilman-l0cyMroinI0@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, govindraj.raja-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adapt the driver to device tree and pass minimal platform
data from device tree needed for console boot.
No power management features will be suppported for now
since it requires more tweaks around OCP settings
to toggle forceidle/noidle/smaridle bits and handling
remote wakeup and dynamic muxing.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/serial/omap_serial.txt     |   10 ++++
 drivers/tty/serial/omap-serial.c                   |   45 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
new file mode 100644
index 0000000..342eedd
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -0,0 +1,10 @@
+OMAP UART controller
+
+Required properties:
+- compatible : should be "ti,omap2-uart" for OMAP2 controllers
+- compatible : should be "ti,omap3-uart" for OMAP3 controllers
+- compatible : should be "ti,omap4-uart" for OMAP4 controllers
+- ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
+
+Optional properties:
+- clock-frequency : frequency of the clock input to the UART
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f14b9c5..5aa524e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -38,6 +38,7 @@
 #include <linux/serial_core.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
@@ -1324,6 +1325,19 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 	return;
 }
 
+static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
+{
+	struct omap_uart_port_info *omap_up_info;
+
+	omap_up_info = devm_kzalloc(dev, sizeof(*omap_up_info), GFP_KERNEL);
+	if (!omap_up_info)
+		return NULL; /* out of memory */
+
+	of_property_read_u32(dev->of_node, "clock-frequency",
+					 &omap_up_info->uartclk);
+	return omap_up_info;
+}
+
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
@@ -1331,6 +1345,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
 	int ret = -ENOSPC;
 
+	if (pdev->dev.of_node)
+		omap_up_info = of_get_uart_port_info(&pdev->dev);
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
@@ -1375,9 +1392,20 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
 	up->port.ops = &serial_omap_pops;
-	up->port.line = pdev->id;
-	sprintf(up->name, "OMAP UART%d", up->port.line);
 
+	if (pdev->dev.of_node)
+		up->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+	else
+		up->port.line = pdev->id;
+
+	if (up->port.line < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
+								up->port.line);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	sprintf(up->name, "OMAP UART%d", up->port.line);
 	up->port.mapbase = mem->start;
 	up->port.membase = ioremap(mem->start, resource_size(mem));
 	if (!up->port.membase) {
@@ -1530,7 +1558,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (!up)
 		return -EINVAL;
 
-	if (!pdata->enable_wakeup)
+	if (!pdata || !pdata->enable_wakeup)
 		return 0;
 
 	if (pdata->get_context_loss_count)
@@ -1591,12 +1619,23 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
 				serial_omap_runtime_resume, NULL)
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_serial_of_match[] = {
+	{ .compatible = "ti,omap2-uart" },
+	{ .compatible = "ti,omap3-uart" },
+	{ .compatible = "ti,omap4-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_serial_of_match);
+#endif
+
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
 	.remove         = serial_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
+		.of_match_table = of_match_ptr(omap_serial_of_match),
 	},
 };
 
-- 
1.7.1
