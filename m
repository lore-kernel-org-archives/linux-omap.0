From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Mon, 19 Nov 2012 23:29:16 +0800
Message-ID: <1353338956-19420-4-git-send-email-zonque@gmail.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:49535 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab2KSP3r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 10:29:47 -0500
In-Reply-To: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>

This patch adds basic DT bindings for OMAP GPMC.

The actual peripherals are instanciated from child nodes within the GPMC
node, and the only type of device that is currently supported is NAND.

Code was added to parse the generic GPMC timing parameters and some
documentation with examples on how to use them.

Successfully tested on an AM33xx board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  84 ++++++++++
 arch/arm/mach-omap2/gpmc.c                         | 170 +++++++++++++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
new file mode 100644
index 0000000..20aa5b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -0,0 +1,84 @@
+Device tree bindings for GPMC connected NANDs
+
+GPMC connected NAND (found on OMAP boards) are represented as child nodes of
+the GPMC controller with a name of "nand".
+
+All timing relevant properties as well as generic gpmc child properties are
+explained in a separate documents - please refer to
+Documentation/devicetree/bindings/bus/ti-gpmc.txt
+
+For NAND specific properties such as ECC modes or bus width, please refer to
+Documentation/devicetree/bindings/mtd/nand.txt
+
+
+Required properties:
+
+ - reg:		The CS line the peripheral is connected to
+
+Optional properties:
+
+ - nand-bus-width: 		Set this numeric value to 16 if the hardware
+				is wired that way. If not specified, a bus
+				width of 8 is assumed.
+ - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
+
+	Layouts for 1-bit ecc: stored at end of spare area:
+
+		"software"	Software method (default)
+		"hw"		Hardware method (let gpmc do the error detection)
+
+	Layouts for 1-bit ecc: stored at beginning of spare area as romcode:
+
+		"hw-romcode"	gpmc method & romcode layout
+		"bch4"		4-bit BCH ecc code
+		"bch8"		8-bit BCH ecc code
+
+ - ti,nand-ecc-use-elm:		Property without value to specify that the
+				hardware error correction mode should be used.
+
+For inline partiton table parsing (optional):
+
+ - #address-cells: should be set to 1
+ - #size-cells: should be set to 1
+
+Example for an AM33xx board:
+
+	gpmc: gpmc@50000000 {
+		compatible = "ti,gpmc";
+		ti,hwmods = "gpmc";
+		reg = <0x50000000 0x1000000>;
+		interrupts = <100>;
+		num-cs = <8>;
+		num-waitpins = <8>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+
+		nand@0,0 {
+			reg = <0 0 0>; /* CS0, offset 0 */
+			nand-bus-width = <16>;
+			ti,nand-ecc-opt = "none";
+			ti,nand-ecc-use-elm;
+
+			gpmc,sync-clk = <0>;
+			gpmc,cs-on = <0>;
+			gpmc,cs-rd-off = <44>;
+			gpmc,cs-wr-off = <44>;
+			gpmc,adv-on = <6>;
+			gpmc,adv-rd-off = <34>;
+			gpmc,adv-wr-off = <44>;
+			gpmc,we-off = <40>;
+			gpmc,oe-off = <54>;
+			gpmc,access = <64>;
+			gpmc,rd-cycle = <82>;
+			gpmc,wr-cycle = <82>;
+			gpmc,wr-access = <40>;
+			gpmc,wr-data-mux-bus = <0>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* partitions go here */
+		};
+	};
+
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 7660a56..971a2bf 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -25,6 +25,10 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_mtd.h>
+#include <linux/of_device.h>
+#include <linux/mtd/nand.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 
@@ -34,6 +38,7 @@
 #include "common.h"
 #include "omap_device.h"
 #include "gpmc.h"
+#include "gpmc-nand.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
@@ -748,6 +753,162 @@ static int __devinit gpmc_mem_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id gpmc_dt_ids[] = {
+	{ .compatible = "ti,gpmc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
+
+static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
+						struct gpmc_timings *gpmc_t)
+{
+	u32 val;
+
+	memset(gpmc_t, 0, sizeof(*gpmc_t));
+
+	/* minimum clock period for syncronous mode */
+	if (!of_property_read_u32(np, "gpmc,sync-clk", &val))
+		gpmc_t->sync_clk = val;
+
+	/* chip select timtings */
+	if (!of_property_read_u32(np, "gpmc,cs-on", &val))
+		gpmc_t->cs_on = val;
+
+	if (!of_property_read_u32(np, "gpmc,cs-rd-off", &val))
+		gpmc_t->cs_rd_off = val;
+
+	if (!of_property_read_u32(np, "gpmc,cs-wr-off", &val))
+		gpmc_t->cs_wr_off = val;
+
+	/* ADV signal timings */
+	if (!of_property_read_u32(np, "gpmc,adv-on", &val))
+		gpmc_t->adv_on = val;
+
+	if (!of_property_read_u32(np, "gpmc,adv-rd-off", &val))
+		gpmc_t->adv_rd_off = val;
+
+	if (!of_property_read_u32(np, "gpmc,adv-wr-off", &val))
+		gpmc_t->adv_wr_off = val;
+
+	/* WE signal timings */
+	if (!of_property_read_u32(np, "gpmc,we-on", &val))
+		gpmc_t->we_on = val;
+
+	if (!of_property_read_u32(np, "gpmc,we-off", &val))
+		gpmc_t->we_off = val;
+
+	/* OE signal timings */
+	if (!of_property_read_u32(np, "gpmc,oe-on", &val))
+		gpmc_t->oe_on = val;
+
+	if (!of_property_read_u32(np, "gpmc,oe-off", &val))
+		gpmc_t->oe_off = val;
+
+	/* access and cycle timings */
+	if (!of_property_read_u32(np, "gpmc,page-burst-access", &val))
+		gpmc_t->page_burst_access = val;
+
+	if (!of_property_read_u32(np, "gpmc,access", &val))
+		gpmc_t->access = val;
+
+	if (!of_property_read_u32(np, "gpmc,rd-cycle", &val))
+		gpmc_t->rd_cycle = val;
+
+	if (!of_property_read_u32(np, "gpmc,wr-cycle", &val))
+		gpmc_t->wr_cycle = val;
+
+	/* only for OMAP3430 */
+	if (!of_property_read_u32(np, "gpmc,wr-access", &val))
+		gpmc_t->wr_access = val;
+
+	if (!of_property_read_u32(np, "gpmc,wr-data-mux-bus", &val))
+		gpmc_t->wr_data_mux_bus = val;
+}
+
+#ifdef CONFIG_MTD_NAND
+
+static const char *nand_ecc_opts[] = {
+	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "software",
+	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
+	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
+	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
+	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
+};
+
+static int __devinit gpmc_probe_nand_child(struct platform_device *pdev,
+					   struct device_node *child)
+{
+	u32 val;
+	const char *s;
+	struct gpmc_timings gpmc_t;
+	struct omap_nand_platform_data *gpmc_nand_data;
+
+	if (of_property_read_u32(child, "reg", &val) < 0) {
+		dev_err(&pdev->dev, "%s has no 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	gpmc_nand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_nand_data),
+				      GFP_KERNEL);
+	if (!gpmc_nand_data)
+		return -ENOMEM;
+
+	gpmc_nand_data->cs = val;
+	gpmc_nand_data->of_node = child;
+
+	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
+		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
+			if (!strcasecmp(s, nand_ecc_opts[val]))
+				gpmc_nand_data->ecc_opt = val;
+
+	if (of_get_property(child, "ti,nand-ecc-use-elm", NULL))
+		gpmc_nand_data->is_elm_used = 1;
+
+	val = of_get_nand_bus_width(child);
+	if (val == 16)
+		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
+
+	gpmc_read_timings_dt(child, &gpmc_t);
+	gpmc_nand_init(gpmc_nand_data, &gpmc_t);
+
+	return 0;
+}
+#else
+static int __devinit gpmc_probe_nand_child(struct platform_device *pdev,
+					   struct device_node *child)
+{
+	return 0;
+}
+#endif
+
+static int __devinit gpmc_probe_dt(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *child;
+	const struct of_device_id *of_id =
+		of_match_device(gpmc_dt_ids, &pdev->dev);
+
+	if (!of_id)
+		return 0;
+
+	for_each_node_by_name(child, "nand") {
+		ret = gpmc_probe_nand_child(pdev, child);
+		of_node_put(child);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+#else
+static int __devinit gpmc_probe_dt(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -801,6 +962,14 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
+	rc = gpmc_probe_dt(pdev);
+	if (rc < 0) {
+		clk_disable_unprepare(gpmc_l3_clk);
+		clk_put(gpmc_l3_clk);
+		dev_err(gpmc_dev, "failed to probe DT parameters\n");
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -818,6 +987,7 @@ static struct platform_driver gpmc_driver = {
 	.driver		= {
 		.name	= DEVICE_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(gpmc_dt_ids),
 	},
 };
 
-- 
1.7.11.7

