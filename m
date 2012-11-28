From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Wed, 28 Nov 2012 17:58:59 +0100
Message-ID: <1354121939-11246-5-git-send-email-zonque@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:41538 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab2K1Q7I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 11:59:08 -0500
In-Reply-To: <1354121939-11246-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

This patch adds basic DT bindings for OMAP GPMC.

The actual peripherals are instantiated from child nodes within the GPMC
node, and the only type of device that is currently supported is NAND.

Code was added to parse the generic GPMC timing parameters and some
documentation with examples on how to use them.

Successfully tested on an AM33xx board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  76 +++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  81 +++++++++
 arch/arm/mach-omap2/gpmc.c                         | 181 ++++++++++++++++++++-
 3 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
new file mode 100644
index 0000000..ba3d6a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -0,0 +1,76 @@
+Device tree bindings for OMAP general purpose memory controllers (GPMC)
+
+The actual devices are instantiated from the child nodes of a GPMC node.
+
+Required properties:
+
+ - compatible:		Should be set to "ti,gpmc"
+ - reg:			A resource specifier for the register space
+			(see the example below)
+ - ti,hwmods:		Should be set to "ti,gpmc" until the DT transition is
+			completed.
+ - #address-cells:	Must be set to 2 to allow memory address translation
+ - #size-cells:		Must be set to 1 to allow CS address passing
+ - num-cs:		The maximum number of chip-select lines that controller
+			can support.
+ - num-waitpins:	The maximum number of wait pins that controller can
+			support.
+ - ranges:		Must be set up to reflect the memory layout with four
+			integer values for each chip-select line in use:
+
+			   <cs-number> 0 <physical address of mapping> <size>
+
+			Note that this property is not currently parsed.
+			Calculated values derived from the contents of the
+			per-CS register GPMC_CONFIG7 (as set up by the
+			bootloader) are used. That will change in the future,
+			so be sure to fill the correct values here.
+
+Timing properties for child nodes. All are optional and default to 0.
+
+ - gpmc,sync-clk:	Minimum clock period for synchronous mode, in picoseconds
+
+ Chip-select signal timings corresponding to GPMC_CONFIG2:
+ - gpmc,cs-on:		Assertion time
+ - gpmc,cs-rd-off:	Read deassertion time
+ - gpmc,cs-wr-off:	Write deassertion time
+
+ ADV signal timings corresponding to GPMC_CONFIG3:
+ - gpmc,adv-on:		Assertion time
+ - gpmc,adv-rd-off:	Read deassertion time
+ - gpmc,adv-wr-off:	Write deassertion time
+
+ WE signals timings corresponding to GPMC_CONFIG4:
+ - gpmc,we-on:		Assertion time
+ - gpmc,we-off:		Deassertion time
+
+ OE signals timings corresponding to GPMC_CONFIG4:
+ - gpmc,oe-on:		Assertion time
+ - gpmc,oe-off:		Deassertion time
+
+ Access time and cycle time timings corresponding to GPMC_CONFIG5:
+ - gpmc,page-burst-access: Multiple access word delay
+ - gpmc,access:		Start-cycle to first data valid delay
+ - gpmc,rd-cycle:	Total read cycle time
+ - gpmc,wr-cycle:	Total write cycle time
+
+The following are only on OMAP3430:
+ - gpmc,wr-access
+ - gpmc,wr-data-mux-bus
+
+
+Example for an AM33xx board:
+
+	gpmc: gpmc@50000000 {
+		compatible = "ti,gpmc";
+		ti,hwmods = "gpmc";
+		reg = <0x50000000 0x2000>;
+		interrupts = <100>;
+
+		num-cs = <8>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x08000000 0x10000000>; /* CS0 @addr 0x8000000, size 0x10000000 */
+
+		/* child nodes go here */
+	};
diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
new file mode 100644
index 0000000..635f550
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -0,0 +1,81 @@
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
+		"sw"		Software method (default)
+		"hw"		Hardware method
+		"hw-romcode"	gpmc hamming mode method & romcode layout
+		"bch4"		4-bit BCH ecc code
+		"bch8"		8-bit BCH ecc code
+		"bch8-am335xrbl-compatible"
+				Use an RBL compatible BCH8 ECC mode.
+				Note that this mode requires the runtime
+				detection of the error location module (ELM),
+				which must hence be enabled in the kernel
+				config.
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
+			ti,nand-ecc-opt = "bch8-am335xrbl-compatible";
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
index ff869a3..61597ff 100644
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
 
@@ -37,6 +41,7 @@
 #include "soc.h"
 #include "common.h"
 #include "gpmc.h"
+#include "gpmc-nand.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
@@ -751,7 +756,172 @@ static int __devinit gpmc_mem_init(void)
 	return 0;
 }
 
-static __devinit int gpmc_probe(struct platform_device *pdev)
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
+	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
+	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
+	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
+	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
+	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
+};
+
+static int gpmc_probe_nand_child(struct platform_device *pdev,
+				 struct device_node *child)
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
+	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
+		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
+			if (!strcasecmp(s, nand_ecc_opts[val])) {
+				gpmc_nand_data->ecc_opt = val;
+				break;
+			}
+
+		/*
+		 *  AM335x RBL compatibility mode - dependns on runtime
+		 * detection of the error location module.
+		 */
+		if (!strcasecmp(s, "bch8-am335xrbl-compatible")) {
+			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
+			gpmc_nand_data->is_elm_used = true;
+		}
+	}
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
+static int gpmc_probe_nand_child(struct platform_device *pdev,
+				 struct device_node *child)
+{
+	return 0;
+}
+#endif
+
+static int gpmc_probe_dt(struct platform_device *pdev)
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
+static int gpmc_probe_dt(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
+static int __devinit gpmc_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 l;
@@ -804,6 +974,14 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
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
 
@@ -821,6 +999,7 @@ static struct platform_driver gpmc_driver = {
 	.driver		= {
 		.name	= DEVICE_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(gpmc_dt_ids),
 	},
 };
 
-- 
1.7.11.7

