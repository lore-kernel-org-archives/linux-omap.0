From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 09/11] OMAP2+: l3-noc: Add support for device-tree
Date: Fri, 23 Sep 2011 22:23:17 +0200
Message-ID: <1316809399-19579-10-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52470 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab1IWUYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 16:24:44 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add device-tree support for the l3-noc driver.

Use platform_driver_register to defer the probing at device init
time.

Add documentation for the l3-noc bindings.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   19 ++++++++++++++++
 arch/arm/mach-omap2/omap_l3_noc.c                  |   23 +++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
new file mode 100644
index 0000000..6888a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
@@ -0,0 +1,19 @@
+* TI - L3 Network On Chip (NoC)
+
+This version is an implementation of the generic NoC IP
+provided by Arteris.
+
+Required properties:
+- compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
+               Should be "ti,omap4-l3-noc" for OMAP4 family
+- ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
+
+Examples:
+
+ocp {
+	compatible = "ti,omap4-l3-noc", "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+};
diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 7b9f190..d618c9d 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -120,7 +120,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	return IRQ_HANDLED;
 }
 
-static int __init omap4_l3_probe(struct platform_device *pdev)
+static int __devinit omap4_l3_probe(struct platform_device *pdev)
 {
 	static struct omap4_l3		*l3;
 	struct resource		*res;
@@ -214,7 +214,7 @@ err0:
 	return ret;
 }
 
-static int __exit omap4_l3_remove(struct platform_device *pdev)
+static int __devexit omap4_l3_remove(struct platform_device *pdev)
 {
 	struct omap4_l3         *l3 = platform_get_drvdata(pdev);
 
@@ -228,16 +228,29 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id l3_noc_match[] = {
+	{.compatible = "ti,omap4-l3-noc", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, l3_noc_match);
+#else
+#define l3_noc_match NULL
+#endif
+
 static struct platform_driver omap4_l3_driver = {
-	.remove		= __exit_p(omap4_l3_remove),
+	.probe		= omap4_l3_probe,
+	.remove		= __devexit_p(omap4_l3_remove),
 	.driver		= {
-	.name		= "omap_l3_noc",
+		.name		= "omap_l3_noc",
+		.owner		= THIS_MODULE,
+		.of_match_table = l3_noc_match,
 	},
 };
 
 static int __init omap4_l3_init(void)
 {
-	return platform_driver_probe(&omap4_l3_driver, omap4_l3_probe);
+	return platform_driver_register(&omap4_l3_driver);
 }
 postcore_initcall_sync(omap4_l3_init);
 
-- 
1.7.0.4

