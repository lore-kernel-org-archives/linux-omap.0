From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 2/5] w1: omap_hdq: Add compatible property for omap hdq driver.
Date: Thu, 8 May 2014 11:30:05 +0530
Message-ID: <1399528808-6920-3-git-send-email-sourav.poddar@ti.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbaEHGAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 02:00:54 -0400
In-Reply-To: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add compatible property for omap hdq driver.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 .../devicetree/bindings/hdq1w/omap_hdq.txt         |   20 ++++++++++++++++++++
 drivers/w1/masters/omap_hdq.c                      |    8 ++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hdq1w/omap_hdq.txt

diff --git a/Documentation/devicetree/bindings/hdq1w/omap_hdq.txt b/Documentation/devicetree/bindings/hdq1w/omap_hdq.txt
new file mode 100644
index 0000000..a7e011e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hdq1w/omap_hdq.txt
@@ -0,0 +1,20 @@
+HDQ/1w for OMAP platforms
+
+Required properties :
+- compatible : Must be "ti,am43xx-hdq".
+- ti,hwmods : Must be "hdq1w".
+- reg: Should contain register location and length.
+- interrupts: Should contain interrupt.
+- clock: Clock input to HDQ1w controller.
+
+Example:
+
+	hdq: hdq@48347000 {
+		compatible = "ti,am43xx-hdq";
+		reg = <0x48347000 0x1000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&func_12m_clk>;
+		clock-names = "fck";
+		ti,hwmods = "hdq1w";
+		status = "disabled";
+	};
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index ca3623c..97a8412 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/sched.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include "../w1.h"
 #include "../w1_int.h"
@@ -73,11 +74,18 @@ struct hdq_data {
 static int omap_hdq_probe(struct platform_device *pdev);
 static int omap_hdq_remove(struct platform_device *pdev);
 
+static const struct of_device_id omap_hdq_dt_match[] = {
+	{ .compatible = "ti,am43xx-hdq"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_hdq_dt_match);
+
 static struct platform_driver omap_hdq_driver = {
 	.probe =	omap_hdq_probe,
 	.remove =	omap_hdq_remove,
 	.driver =	{
 		.name =	"omap_hdq",
+		.of_match_table = of_match_ptr(omap_hdq_dt_match),
 	},
 };
 
-- 
1.7.9.5

