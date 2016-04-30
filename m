From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/6] HSI: omap_ssi: make sure probe stays available
Date: Sat, 30 Apr 2016 04:09:10 +0200
Message-ID: <1461982153-19139-4-git-send-email-sre@kernel.org>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461982153-19139-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

device can be unbind/rebind, so probe should
stay available.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.c      | 17 +++++++++--------
 drivers/hsi/controllers/omap_ssi_port.c | 19 ++++++++++---------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi.c
index 2dd46b219af2..ffb921482e76 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi.c
@@ -140,7 +140,7 @@ static const struct file_operations ssi_gdd_regs_fops = {
 	.release	= single_release,
 };
 
-static int __init ssi_debug_add_ctrl(struct hsi_controller *ssi)
+static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 {
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 	struct dentry *dir;
@@ -290,7 +290,7 @@ static unsigned long ssi_get_clk_rate(struct hsi_controller *ssi)
 	return rate;
 }
 
-static int __init ssi_get_iomem(struct platform_device *pd,
+static int ssi_get_iomem(struct platform_device *pd,
 		const char *name, void __iomem **pbase, dma_addr_t *phy)
 {
 	struct resource *mem;
@@ -310,7 +310,7 @@ static int __init ssi_get_iomem(struct platform_device *pd,
 	return 0;
 }
 
-static int __init ssi_add_controller(struct hsi_controller *ssi,
+static int ssi_add_controller(struct hsi_controller *ssi,
 						struct platform_device *pd)
 {
 	struct omap_ssi_controller *omap_ssi;
@@ -386,7 +386,7 @@ out_err:
 	return err;
 }
 
-static int __init ssi_hw_init(struct hsi_controller *ssi)
+static int ssi_hw_init(struct hsi_controller *ssi)
 {
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 	unsigned int i;
@@ -456,7 +456,7 @@ static int ssi_remove_ports(struct device *dev, void *c)
 	return 0;
 }
 
-static int __init ssi_probe(struct platform_device *pd)
+static int ssi_probe(struct platform_device *pd)
 {
 	struct platform_device *childpdev;
 	struct device_node *np = pd->dev.of_node;
@@ -522,7 +522,7 @@ out1:
 	return err;
 }
 
-static int __exit ssi_remove(struct platform_device *pd)
+static int ssi_remove(struct platform_device *pd)
 {
 	struct hsi_controller *ssi = platform_get_drvdata(pd);
 
@@ -592,7 +592,8 @@ MODULE_DEVICE_TABLE(of, omap_ssi_of_match);
 #endif
 
 static struct platform_driver ssi_pdriver = {
-	.remove	= __exit_p(ssi_remove),
+	.probe = ssi_probe,
+	.remove	= ssi_remove,
 	.driver	= {
 		.name	= "omap_ssi",
 		.pm     = DEV_PM_OPS,
@@ -600,7 +601,7 @@ static struct platform_driver ssi_pdriver = {
 	},
 };
 
-module_platform_driver_probe(ssi_pdriver, ssi_probe);
+module_platform_driver(ssi_pdriver);
 
 MODULE_ALIAS("platform:omap_ssi");
 MODULE_AUTHOR("Carlos Chinea <carlos.chinea@nokia.com>");
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 948bdc7946fb..530095ed39e7 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -171,7 +171,7 @@ static int ssi_div_set(void *data, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(ssi_sst_div_fops, ssi_div_get, ssi_div_set, "%llu\n");
 
-static int __init ssi_debug_add_port(struct omap_ssi_port *omap_port,
+static int ssi_debug_add_port(struct omap_ssi_port *omap_port,
 				     struct dentry *dir)
 {
 	struct hsi_port *port = to_hsi_port(omap_port->dev);
@@ -1007,7 +1007,7 @@ static irqreturn_t ssi_wake_isr(int irq __maybe_unused, void *ssi_port)
 	return IRQ_HANDLED;
 }
 
-static int __init ssi_port_irq(struct hsi_port *port,
+static int ssi_port_irq(struct hsi_port *port,
 						struct platform_device *pd)
 {
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
@@ -1029,7 +1029,7 @@ static int __init ssi_port_irq(struct hsi_port *port,
 	return err;
 }
 
-static int __init ssi_wake_irq(struct hsi_port *port,
+static int ssi_wake_irq(struct hsi_port *port,
 						struct platform_device *pd)
 {
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
@@ -1060,7 +1060,7 @@ static int __init ssi_wake_irq(struct hsi_port *port,
 	return err;
 }
 
-static void __init ssi_queues_init(struct omap_ssi_port *omap_port)
+static void ssi_queues_init(struct omap_ssi_port *omap_port)
 {
 	unsigned int ch;
 
@@ -1071,7 +1071,7 @@ static void __init ssi_queues_init(struct omap_ssi_port *omap_port)
 	INIT_LIST_HEAD(&omap_port->brkqueue);
 }
 
-static int __init ssi_port_get_iomem(struct platform_device *pd,
+static int ssi_port_get_iomem(struct platform_device *pd,
 		const char *name, void __iomem **pbase, dma_addr_t *phy)
 {
 	struct hsi_port *port = platform_get_drvdata(pd);
@@ -1104,7 +1104,7 @@ static int __init ssi_port_get_iomem(struct platform_device *pd,
 	return 0;
 }
 
-static int __init ssi_port_probe(struct platform_device *pd)
+static int ssi_port_probe(struct platform_device *pd)
 {
 	struct device_node *np = pd->dev.of_node;
 	struct hsi_port *port;
@@ -1217,7 +1217,7 @@ error:
 	return err;
 }
 
-static int __exit ssi_port_remove(struct platform_device *pd)
+static int ssi_port_remove(struct platform_device *pd)
 {
 	struct hsi_port *port = platform_get_drvdata(pd);
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
@@ -1370,7 +1370,8 @@ MODULE_DEVICE_TABLE(of, omap_ssi_port_of_match);
 #endif
 
 static struct platform_driver ssi_port_pdriver = {
-	.remove	= __exit_p(ssi_port_remove),
+	.probe = ssi_port_probe,
+	.remove	= ssi_port_remove,
 	.driver	= {
 		.name	= "omap_ssi_port",
 		.of_match_table = omap_ssi_port_of_match,
@@ -1378,7 +1379,7 @@ static struct platform_driver ssi_port_pdriver = {
 	},
 };
 
-module_platform_driver_probe(ssi_port_pdriver, ssi_port_probe);
+module_platform_driver(ssi_port_pdriver);
 
 MODULE_ALIAS("platform:omap_ssi_port");
 MODULE_AUTHOR("Carlos Chinea <carlos.chinea@nokia.com>");
-- 
2.8.1
