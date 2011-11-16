From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] omap-serial: Add minimal device tree support
Date: Wed, 16 Nov 2011 16:32:25 +0530
Message-ID: <1321441346-19591-3-git-send-email-rnayak@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58495 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927Ab1KPLDD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 06:03:03 -0500
In-Reply-To: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Adapt the driver to device tree and pass minimal platform
data from device tree needed for console boot.
No power management features will be suppported for now
since it requires more tweaks around OCP settings
to toggle forceidle/noidle/smaridle bits and handling
remote wakeup and dynamic muxing.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/serial/omap_serial.txt     |    9 +++++
 drivers/tty/serial/omap-serial.c                   |   37 +++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
new file mode 100644
index 0000000..bf6d631
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -0,0 +1,9 @@
+OMAP UART controller
+
+Required properties:
+- compatible : should be "ti,omap-uart"
+- ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
+
+Optional properties:
+- clock-frequency : frequency of the clock input to the UART
+- ti,console_hwmod : boolean, UART used as debug console
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e1c8527..e3419c6 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -38,6 +38,7 @@
 #include <linux/serial_core.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
@@ -1322,6 +1323,22 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
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
+					 &(*omap_up_info).uartclk);
+
+	return omap_up_info;
+}
+
+static atomic_t omap_uart_next_id = ATOMIC_INIT(0);
+
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
@@ -1329,6 +1346,11 @@ static int serial_omap_probe(struct platform_device *pdev)
 	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
 	int ret = -ENOSPC;
 
+	if (pdev->dev.of_node) {
+		omap_up_info = of_get_uart_port_info(&pdev->dev);
+		pdev->id = atomic_inc_return(&omap_uart_next_id) - 1;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
@@ -1523,7 +1545,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (!up)
 		return -EINVAL;
 
-	if (!pdata->enable_wakeup)
+	if (!pdata || !pdata->enable_wakeup)
 		return 0;
 
 	if (pdata->get_context_loss_count)
@@ -1582,12 +1604,25 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
 				serial_omap_runtime_resume, NULL)
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_serial_of_match[] = {
+	{
+		.compatible = "ti,omap-uart",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_serial_of_match);
+#else
+#define omap_serial_of_match NULL
+#endif
+
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
 	.remove         = serial_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
+		.of_match_table = omap_serial_of_match,
 	},
 };
 
-- 
1.7.1

