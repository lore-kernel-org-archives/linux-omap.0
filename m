From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] mfd: cpcap: Add minimal support
Date: Tue, 29 Nov 2016 08:47:02 -0800
Message-ID: <20161129164702.5334-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
or 6556002. We can support it's core features quite easily with regmap_spi
and regmap_irq.

The children of cpcap, such as regulators, ADC and USB, can be just regular
device drivers and defined in the dts file. They get probed as we call
of_platform_populate() at the end of our probe, and then the children
can just call dev_get_regmap(dev.parent, NULL) to get the regmap.

Cc: devicetree@vger.kernel.org
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes from v1:

- Addressed comments from Lee Jones except did not start
  generalizing bulk adding of IRQ chips. That can be done
  later as needed.

- Dropped the ranges translation based on comments from
  Lee Jones and Rob Herring. We are using regmap anyways.

- Changed naming to use motorola-cpcap as this is Motorola
  custom PMIC manufactured by STE and TI.

- Moved the revision and vendor check to motorola-cpcap.h.
  This keeps the undocumented register bits limited to
  these functions and the child device drivers can use
  them for the related workarounds.

- Checked that motorola-cpcap.h is really aligned despite
  how the patch looks for some of the lines.

---
 .../devicetree/bindings/mfd/motorola-cpcap.txt     |  31 +++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/motorola-cpcap.c                       | 244 +++++++++++++++++
 include/linux/mfd/motorola-cpcap.h                 | 289 +++++++++++++++++++++
 5 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
 create mode 100644 drivers/mfd/motorola-cpcap.c
 create mode 100644 include/linux/mfd/motorola-cpcap.h

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
@@ -0,0 +1,31 @@
+Motorola CPCAP PMIC device tree binding
+
+Required properties:
+- compatible		: One or both of "motorola,cpcap" or "ste,6556002"
+- reg			: SPI chip select
+- interrupt-parent	: The parent interrupt controller
+- interrupts		: The interrupt line the device is connected to
+- interrupt-controller	: Marks the device node as an interrupt controller
+- #interrupt-cells	: The number of cells to describe an IRQ, should be 2
+- #address-cells	: Child device offset number of cells, typically 1
+- #size-cells		: Child device size number of cells, typically 1
+- spi-max-frequency	: Typically set to 3000000
+- spi-cs_high		: SPI chip select direction
+
+Example:
+
+&mcspi1 {
+	cpcap: pmic@0 {
+		compatible = "motorola,cpcap", "ste,6556002";
+		reg = <0>;	/* cs0 */
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <3000000>;
+		spi-cs-high;
+	};
+};
+
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -713,6 +713,17 @@ config EZX_PCAP
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..
 
+config MFD_CPCAP
+	tristate "Support for Motorola CPCAP"
+	depends on SPI
+	depends on OF || COMPILE_TEST
+	select REGMAP_SPI
+	select REGMAP_IRQ
+	help
+	  Say yes here if you want to include driver for CPCAP.
+	  It is used on many Motorola phones and tablets as a PMIC.
+	  At least Motorola Droid 4 is known to use CPCAP.
+
 config MFD_VIPERBOARD
         tristate "Nano River Technologies Viperboard"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
+obj-$(CONFIG_MFD_CPCAP)		+= motorola-cpcap.o
 
 obj-$(CONFIG_MCP)		+= mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
new file mode 100644
--- /dev/null
+++ b/drivers/mfd/motorola-cpcap.c
@@ -0,0 +1,244 @@
+/*
+ * Motorola CPCAP PMIC core driver
+ *
+ * Copyright (C) 2016 Tony Lindgren <tony@atomide.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+
+#include <linux/mfd/motorola-cpcap.h>
+#include <linux/spi/spi.h>
+
+#define CPCAP_NR_IRQ_REG_BANKS	6
+#define CPCAP_NR_IRQ_CHIPS	3
+
+struct cpcap_ddata {
+	struct spi_device *spi;
+	struct regmap_irq *irqs;
+	struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
+	const struct regmap_config *regmap_conf;
+	struct regmap *regmap;
+};
+
+static int cpcap_check_revision(struct cpcap_ddata *cpcap)
+{
+	u16 vendor, rev;
+	int ret;
+
+	ret = cpcap_get_vendor(&cpcap->spi->dev, cpcap->regmap, &vendor);
+	if (ret)
+		return ret;
+
+	ret = cpcap_get_revision(&cpcap->spi->dev, cpcap->regmap, &rev);
+	if (ret)
+		return ret;
+
+	dev_info(&cpcap->spi->dev, "CPCAP vendor: %s rev: %i.%i (%x)\n",
+		 vendor == CPCAP_VENDOR_ST ? "ST" : "TI",
+		 CPCAP_REVISION_MAJOR(rev), CPCAP_REVISION_MINOR(rev),
+		 rev);
+
+	if (rev < CPCAP_REVISION_2_1) {
+		dev_info(&cpcap->spi->dev,
+			 "Please add old CPCAP revision support as needed\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * First two irq chips are the two private macro interrupt chips, the third
+ * irq chip is for register banks 1 - 4 and is available for drivers to use.
+ */
+static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
+	{
+		.name = "cpcap-m2",
+		.num_regs = 1,
+		.status_base = CPCAP_REG_MI1,
+		.ack_base = CPCAP_REG_MI1,
+		.mask_base = CPCAP_REG_MIM1,
+		.use_ack = true,
+	},
+	{
+		.name = "cpcap-m2",
+		.num_regs = 1,
+		.status_base = CPCAP_REG_MI2,
+		.ack_base = CPCAP_REG_MI2,
+		.mask_base = CPCAP_REG_MIM2,
+		.use_ack = true,
+	},
+	{
+		.name = "cpcap1-4",
+		.num_regs = 4,
+		.status_base = CPCAP_REG_INT1,
+		.ack_base = CPCAP_REG_INT1,
+		.mask_base = CPCAP_REG_INTM1,
+		.type_base = CPCAP_REG_INTS1,
+		.use_ack = true,
+	},
+};
+
+static int cpcap_init_irq_chip(struct cpcap_ddata *cpcap, int irq_chip,
+			       int irq_start, int nr_irqs)
+{
+	struct regmap_irq_chip *chip = &cpcap_irq_chip[irq_chip];
+	int i, ret;
+
+	for (i = irq_start; i < irq_start + nr_irqs; i++) {
+		struct regmap_irq *cpcap_irq = &cpcap->irqs[i];
+
+		cpcap_irq->reg_offset =
+			((i - irq_start) / cpcap->regmap_conf->val_bits) *
+			cpcap->regmap_conf->reg_stride;
+		cpcap_irq->mask = BIT(i % cpcap->regmap_conf->val_bits);
+	}
+	chip->irqs = &cpcap->irqs[irq_start];
+	chip->num_irqs = nr_irqs;
+	chip->irq_drv_data = cpcap;
+
+	ret = devm_regmap_add_irq_chip(&cpcap->spi->dev, cpcap->regmap,
+				       cpcap->spi->irq,
+				       IRQF_TRIGGER_RISING |
+				       IRQF_SHARED, -1,
+				       chip, &cpcap->irqdata[irq_chip]);
+	if (ret) {
+		dev_err(&cpcap->spi->dev, "could not add irq chip %i: %i\n",
+			irq_chip, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpcap_init_irq(struct cpcap_ddata *cpcap)
+{
+	int ret;
+
+	cpcap->irqs = devm_kzalloc(&cpcap->spi->dev,
+				   sizeof(*cpcap->irqs) *
+				   CPCAP_NR_IRQ_REG_BANKS *
+				   cpcap->regmap_conf->val_bits,
+				   GFP_KERNEL);
+	if (!cpcap->irqs)
+		return -ENOMEM;
+
+	ret = cpcap_init_irq_chip(cpcap, 0, 0, 16);
+	if (ret)
+		return ret;
+
+	ret = cpcap_init_irq_chip(cpcap, 1, 16, 16);
+	if (ret)
+		return ret;
+
+	ret = cpcap_init_irq_chip(cpcap, 2, 32, 64);
+	if (ret)
+		return ret;
+
+	enable_irq_wake(cpcap->spi->irq);
+
+	return 0;
+}
+
+static const struct of_device_id cpcap_of_match[] = {
+	{ .compatible = "motorola,cpcap", },
+	{ .compatible = "st,6556002", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
+static const struct regmap_config cpcap_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 4,
+	.pad_bits = 0,
+	.val_bits = 16,
+	.write_flag_mask = 0x8000,
+	.max_register = CPCAP_REG_ST_TEST2,
+	.cache_type = REGCACHE_NONE,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int cpcap_probe(struct spi_device *spi)
+{
+	const struct of_device_id *match;
+	int ret = -EINVAL;
+	struct cpcap_ddata *cpcap;
+
+	match = of_match_device(of_match_ptr(cpcap_of_match), &spi->dev);
+	if (!match)
+		return -ENODEV;
+
+	cpcap = devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
+	if (!cpcap)
+		return -ENOMEM;
+
+	cpcap->spi = spi;
+	spi_set_drvdata(spi, cpcap);
+
+	spi->bits_per_word = 16;
+	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	cpcap->regmap_conf = &cpcap_regmap_config;
+	cpcap->regmap = devm_regmap_init_spi(spi, &cpcap_regmap_config);
+	if (IS_ERR(cpcap->regmap)) {
+		ret = PTR_ERR(cpcap->regmap);
+		dev_err(&cpcap->spi->dev, "Failed to initialize regmap: %d\n",
+			ret);
+
+		return ret;
+	}
+
+	ret = cpcap_check_revision(cpcap);
+	if (ret) {
+		dev_err(&cpcap->spi->dev, "Failed to detect CPCAP: %i\n", ret);
+		return ret;
+	}
+
+	ret = cpcap_init_irq(cpcap);
+	if (ret)
+		return ret;
+
+	return of_platform_populate(spi->dev.of_node, NULL, NULL,
+				    &cpcap->spi->dev);
+}
+
+static int cpcap_remove(struct spi_device *pdev)
+{
+	struct cpcap_ddata *cpcap = spi_get_drvdata(pdev);
+
+	of_platform_depopulate(&cpcap->spi->dev);
+
+	return 0;
+}
+
+static struct spi_driver cpcap_driver = {
+	.driver = {
+		.name = "cpcap-core",
+		.of_match_table = cpcap_of_match,
+	},
+	.probe = cpcap_probe,
+	.remove = cpcap_remove,
+};
+module_spi_driver(cpcap_driver);
+
+MODULE_ALIAS("platform:cpcap");
+MODULE_DESCRIPTION("CPCAP driver");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
new file mode 100644
--- /dev/null
+++ b/include/linux/mfd/motorola-cpcap.h
@@ -0,0 +1,289 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Note that the register defines are based on earlier cpcap.h in
+ * Motorola Linux kernel tree Copyright (C) 2007-2009 Motorola, Inc.
+ *
+ * Rewritten for the real register offsets instead of enumeration
+ * to make the defines usable with Linux kernel regmap support
+ * Copyright (C) 2016 Tony Lindgren <tony@atomide.com>.
+ */
+
+#define CPCAP_VENDOR_ST		0
+#define CPCAP_VENDOR_TI		1
+
+#define CPCAP_REVISION_MAJOR(r)	(((r) >> 4) + 1)
+#define CPCAP_REVISION_MINOR(r)	((r) & 0xf)
+
+#define CPCAP_REVISION_1_0	0x08
+#define CPCAP_REVISION_1_1	0x09
+#define CPCAP_REVISION_2_0	0x10
+#define CPCAP_REVISION_2_1	0x11
+
+/* CPCAP registers */
+#define CPCAP_REG_INT1		0x0000	/* Interrupt 1 */
+#define CPCAP_REG_INT2		0x0004	/* Interrupt 2 */
+#define CPCAP_REG_INT3		0x0008	/* Interrupt 3 */
+#define CPCAP_REG_INT4		0x000c	/* Interrupt 4 */
+#define CPCAP_REG_INTM1		0x0010	/* Interrupt Mask 1 */
+#define CPCAP_REG_INTM2		0x0014	/* Interrupt Mask 2 */
+#define CPCAP_REG_INTM3		0x0018	/* Interrupt Mask 3 */
+#define CPCAP_REG_INTM4		0x001c	/* Interrupt Mask 4 */
+#define CPCAP_REG_INTS1		0x0020	/* Interrupt Sense 1 */
+#define CPCAP_REG_INTS2		0x0024	/* Interrupt Sense 2 */
+#define CPCAP_REG_INTS3		0x0028	/* Interrupt Sense 3 */
+#define CPCAP_REG_INTS4		0x002c	/* Interrupt Sense 4 */
+#define CPCAP_REG_ASSIGN1	0x0030	/* Resource Assignment 1 */
+#define CPCAP_REG_ASSIGN2	0x0034	/* Resource Assignment 2 */
+#define CPCAP_REG_ASSIGN3	0x0038	/* Resource Assignment 3 */
+#define CPCAP_REG_ASSIGN4	0x003c	/* Resource Assignment 4 */
+#define CPCAP_REG_ASSIGN5	0x0040	/* Resource Assignment 5 */
+#define CPCAP_REG_ASSIGN6	0x0044	/* Resource Assignment 6 */
+#define CPCAP_REG_VERSC1	0x0048	/* Version Control 1 */
+#define CPCAP_REG_VERSC2	0x004c	/* Version Control 2 */
+
+#define CPCAP_REG_MI1		0x0200	/* Macro Interrupt 1 */
+#define CPCAP_REG_MIM1		0x0204	/* Macro Interrupt Mask 1 */
+#define CPCAP_REG_MI2		0x0208	/* Macro Interrupt 2 */
+#define CPCAP_REG_MIM2		0x020c	/* Macro Interrupt Mask 2 */
+#define CPCAP_REG_UCC1		0x0210	/* UC Control 1 */
+#define CPCAP_REG_UCC2		0x0214	/* UC Control 2 */
+
+#define CPCAP_REG_PC1		0x021c	/* Power Cut 1 */
+#define CPCAP_REG_PC2		0x0220	/* Power Cut 2 */
+#define CPCAP_REG_BPEOL		0x0224	/* BP and EOL */
+#define CPCAP_REG_PGC		0x0228	/* Power Gate and Control */
+#define CPCAP_REG_MT1		0x022c	/* Memory Transfer 1 */
+#define CPCAP_REG_MT2		0x0230	/* Memory Transfer 2 */
+#define CPCAP_REG_MT3		0x0234	/* Memory Transfer 3 */
+#define CPCAP_REG_PF		0x0238	/* Print Format */
+
+#define CPCAP_REG_SCC		0x0400	/* System Clock Control */
+#define CPCAP_REG_SW1		0x0404	/* Stop Watch 1 */
+#define CPCAP_REG_SW2		0x0408	/* Stop Watch 2 */
+#define CPCAP_REG_UCTM		0x040c	/* UC Turbo Mode */
+#define CPCAP_REG_TOD1		0x0410	/* Time of Day 1 */
+#define CPCAP_REG_TOD2		0x0414	/* Time of Day 2 */
+#define CPCAP_REG_TODA1		0x0418	/* Time of Day Alarm 1 */
+#define CPCAP_REG_TODA2		0x041c	/* Time of Day Alarm 2 */
+#define CPCAP_REG_DAY		0x0420	/* Day */
+#define CPCAP_REG_DAYA		0x0424	/* Day Alarm */
+#define CPCAP_REG_VAL1		0x0428	/* Validity 1 */
+#define CPCAP_REG_VAL2		0x042c	/* Validity 2 */
+
+#define CPCAP_REG_SDVSPLL	0x0600	/* Switcher DVS and PLL */
+#define CPCAP_REG_SI2CC1	0x0604	/* Switcher I2C Control 1 */
+#define CPCAP_REG_Si2CC2	0x0608	/* Switcher I2C Control 2 */
+#define CPCAP_REG_S1C1		0x060c	/* Switcher 1 Control 1 */
+#define CPCAP_REG_S1C2		0x0610	/* Switcher 1 Control 2 */
+#define CPCAP_REG_S2C1		0x0614	/* Switcher 2 Control 1 */
+#define CPCAP_REG_S2C2		0x0618	/* Switcher 2 Control 2 */
+#define CPCAP_REG_S3C		0x061c	/* Switcher 3 Control */
+#define CPCAP_REG_S4C1		0x0620	/* Switcher 4 Control 1 */
+#define CPCAP_REG_S4C2		0x0624	/* Switcher 4 Control 2 */
+#define CPCAP_REG_S5C		0x0628	/* Switcher 5 Control */
+#define CPCAP_REG_S6C		0x062c	/* Switcher 6 Control */
+#define CPCAP_REG_VCAMC		0x0630	/* VCAM Control */
+#define CPCAP_REG_VCSIC		0x0634	/* VCSI Control */
+#define CPCAP_REG_VDACC		0x0638	/* VDAC Control */
+#define CPCAP_REG_VDIGC		0x063c	/* VDIG Control */
+#define CPCAP_REG_VFUSEC	0x0640	/* VFUSE Control */
+#define CPCAP_REG_VHVIOC	0x0644	/* VHVIO Control */
+#define CPCAP_REG_VSDIOC	0x0648	/* VSDIO Control */
+#define CPCAP_REG_VPLLC		0x064c	/* VPLL Control */
+#define CPCAP_REG_VRF1C		0x0650	/* VRF1 Control */
+#define CPCAP_REG_VRF2C		0x0654	/* VRF2 Control */
+#define CPCAP_REG_VRFREFC	0x0658	/* VRFREF Control */
+#define CPCAP_REG_VWLAN1C	0x065c	/* VWLAN1 Control */
+#define CPCAP_REG_VWLAN2C	0x0660	/* VWLAN2 Control */
+#define CPCAP_REG_VSIMC		0x0664	/* VSIM Control */
+#define CPCAP_REG_VVIBC		0x0668	/* VVIB Control */
+#define CPCAP_REG_VUSBC		0x066c	/* VUSB Control */
+#define CPCAP_REG_VUSBINT1C	0x0670	/* VUSBINT1 Control */
+#define CPCAP_REG_VUSBINT2C	0x0674	/* VUSBINT2 Control */
+#define CPCAP_REG_URT		0x0678	/* Useroff Regulator Trigger */
+#define CPCAP_REG_URM1		0x067c	/* Useroff Regulator Mask 1 */
+#define CPCAP_REG_URM2		0x0680	/* Useroff Regulator Mask 2 */
+
+#define CPCAP_REG_VAUDIOC	0x0800	/* VAUDIO Control */
+#define CPCAP_REG_CC		0x0804	/* Codec Control */
+#define CPCAP_REG_CDI		0x0808	/* Codec Digital Interface */
+#define CPCAP_REG_SDAC		0x080c	/* Stereo DAC */
+#define CPCAP_REG_SDACDI	0x0810	/* Stereo DAC Digital Interface */
+#define CPCAP_REG_TXI		0x0814	/* TX Inputs */
+#define CPCAP_REG_TXMP		0x0818	/* TX MIC PGA's */
+#define CPCAP_REG_RXOA		0x081c	/* RX Output Amplifiers */
+#define CPCAP_REG_RXVC		0x0820	/* RX Volume Control */
+#define CPCAP_REG_RXCOA		0x0824	/* RX Codec to Output Amps */
+#define CPCAP_REG_RXSDOA	0x0828	/* RX Stereo DAC to Output Amps */
+#define CPCAP_REG_RXEPOA	0x082c	/* RX External PGA to Output Amps */
+#define CPCAP_REG_RXLL		0x0830	/* RX Low Latency */
+#define CPCAP_REG_A2LA		0x0834	/* A2 Loudspeaker Amplifier */
+#define CPCAP_REG_MIPIS1	0x0838	/* MIPI Slimbus 1 */
+#define CPCAP_REG_MIPIS2	0x083c	/* MIPI Slimbus 2 */
+#define CPCAP_REG_MIPIS3	0x0840	/* MIPI Slimbus 3. */
+#define CPCAP_REG_LVAB		0x0844	/* LMR Volume and A4 Balanced. */
+
+#define CPCAP_REG_CCC1		0x0a00	/* Coulomb Counter Control 1 */
+#define CPCAP_REG_CRM		0x0a04	/* Charger and Reverse Mode */
+#define CPCAP_REG_CCCC2		0x0a08	/* Coincell and Coulomb Ctr Ctrl 2 */
+#define CPCAP_REG_CCS1		0x0a0c	/* Coulomb Counter Sample 1 */
+#define CPCAP_REG_CCS2		0x0a10	/* Coulomb Counter Sample 2 */
+#define CPCAP_REG_CCA1		0x0a14	/* Coulomb Counter Accumulator 1 */
+#define CPCAP_REG_CCA2		0x0a18	/* Coulomb Counter Accumulator 2 */
+#define CPCAP_REG_CCM		0x0a1c	/* Coulomb Counter Mode */
+#define CPCAP_REG_CCO		0x0a20	/* Coulomb Counter Offset */
+#define CPCAP_REG_CCI		0x0a24	/* Coulomb Counter Integrator */
+
+#define CPCAP_REG_ADCC1		0x0c00	/* A/D Converter Configuration 1 */
+#define CPCAP_REG_ADCC2		0x0c04	/* A/D Converter Configuration 2 */
+#define CPCAP_REG_ADCD0		0x0c08	/* A/D Converter Data 0 */
+#define CPCAP_REG_ADCD1		0x0c0c	/* A/D Converter Data 1 */
+#define CPCAP_REG_ADCD2		0x0c10	/* A/D Converter Data 2 */
+#define CPCAP_REG_ADCD3		0x0c14	/* A/D Converter Data 3 */
+#define CPCAP_REG_ADCD4		0x0c18	/* A/D Converter Data 4 */
+#define CPCAP_REG_ADCD5		0x0c1c	/* A/D Converter Data 5 */
+#define CPCAP_REG_ADCD6		0x0c20	/* A/D Converter Data 6 */
+#define CPCAP_REG_ADCD7		0x0c24	/* A/D Converter Data 7 */
+#define CPCAP_REG_ADCAL1	0x0c28	/* A/D Converter Calibration 1 */
+#define CPCAP_REG_ADCAL2	0x0c2c	/* A/D Converter Calibration 2 */
+
+#define CPCAP_REG_USBC1		0x0e00	/* USB Control 1 */
+#define CPCAP_REG_USBC2		0x0e04	/* USB Control 2 */
+#define CPCAP_REG_USBC3		0x0e08	/* USB Control 3 */
+#define CPCAP_REG_UVIDL		0x0e0c	/* ULPI Vendor ID Low */
+#define CPCAP_REG_UVIDH		0x0e10	/* ULPI Vendor ID High */
+#define CPCAP_REG_UPIDL		0x0e14	/* ULPI Product ID Low */
+#define CPCAP_REG_UPIDH		0x0e18	/* ULPI Product ID High */
+#define CPCAP_REG_UFC1		0x0e1c	/* ULPI Function Control 1 */
+#define CPCAP_REG_UFC2		0x0e20	/* ULPI Function Control 2 */
+#define CPCAP_REG_UFC3		0x0e24	/* ULPI Function Control 3 */
+#define CPCAP_REG_UIC1		0x0e28	/* ULPI Interface Control 1 */
+#define CPCAP_REG_UIC2		0x0e2c	/* ULPI Interface Control 2 */
+#define CPCAP_REG_UIC3		0x0e30	/* ULPI Interface Control 3 */
+#define CPCAP_REG_USBOTG1	0x0e34	/* USB OTG Control 1 */
+#define CPCAP_REG_USBOTG2	0x0e38	/* USB OTG Control 2 */
+#define CPCAP_REG_USBOTG3	0x0e3c	/* USB OTG Control 3 */
+#define CPCAP_REG_UIER1		0x0e40	/* USB Interrupt Enable Rising 1 */
+#define CPCAP_REG_UIER2		0x0e44	/* USB Interrupt Enable Rising 2 */
+#define CPCAP_REG_UIER3		0x0e48	/* USB Interrupt Enable Rising 3 */
+#define CPCAP_REG_UIEF1		0x0e4c	/* USB Interrupt Enable Falling 1 */
+#define CPCAP_REG_UIEF2		0x0e50	/* USB Interrupt Enable Falling 1 */
+#define CPCAP_REG_UIEF3		0x0e54	/* USB Interrupt Enable Falling 1 */
+#define CPCAP_REG_UIS		0x0e58	/* USB Interrupt Status */
+#define CPCAP_REG_UIL		0x0e5c	/* USB Interrupt Latch */
+#define CPCAP_REG_USBD		0x0e60	/* USB Debug */
+#define CPCAP_REG_SCR1		0x0e64	/* Scratch 1 */
+#define CPCAP_REG_SCR2		0x0e68	/* Scratch 2 */
+#define CPCAP_REG_SCR3		0x0e6c	/* Scratch 3 */
+
+#define CPCAP_REG_VMC		0x0eac	/* Video Mux Control */
+#define CPCAP_REG_OWDC		0x0eb0	/* One Wire Device Control */
+#define CPCAP_REG_GPIO0		0x0eb4	/* GPIO 0 Control */
+
+#define CPCAP_REG_GPIO1		0x0ebc	/* GPIO 1 Control */
+
+#define CPCAP_REG_GPIO2		0x0ec4	/* GPIO 2 Control */
+
+#define CPCAP_REG_GPIO3		0x0ecc	/* GPIO 3 Control */
+
+#define CPCAP_REG_GPIO4		0x0ed4	/* GPIO 4 Control */
+
+#define CPCAP_REG_GPIO5		0x0edc	/* GPIO 5 Control */
+
+#define CPCAP_REG_GPIO6		0x0ee4	/* GPIO 6 Control */
+
+#define CPCAP_REG_MDLC		0x1000	/* Main Display Lighting Control */
+#define CPCAP_REG_KLC		0x1004	/* Keypad Lighting Control */
+#define CPCAP_REG_ADLC		0x1008	/* Aux Display Lighting Control */
+#define CPCAP_REG_REDC		0x100c	/* Red Triode Control */
+#define CPCAP_REG_GREENC	0x1010	/* Green Triode Control */
+#define CPCAP_REG_BLUEC		0x1014	/* Blue Triode Control */
+#define CPCAP_REG_CFC		0x1018	/* Camera Flash Control */
+#define CPCAP_REG_ABC		0x101c	/* Adaptive Boost Control */
+#define CPCAP_REG_BLEDC		0x1020	/* Bluetooth LED Control */
+#define CPCAP_REG_CLEDC		0x1024	/* Camera Privacy LED Control */
+
+#define CPCAP_REG_OW1C		0x1200	/* One Wire 1 Command */
+#define CPCAP_REG_OW1D		0x1204	/* One Wire 1 Data */
+#define CPCAP_REG_OW1I		0x1208	/* One Wire 1 Interrupt */
+#define CPCAP_REG_OW1IE		0x120c	/* One Wire 1 Interrupt Enable */
+
+#define CPCAP_REG_OW1		0x1214	/* One Wire 1 Control */
+
+#define CPCAP_REG_OW2C		0x1220	/* One Wire 2 Command */
+#define CPCAP_REG_OW2D		0x1224	/* One Wire 2 Data */
+#define CPCAP_REG_OW2I		0x1228	/* One Wire 2 Interrupt */
+#define CPCAP_REG_OW2IE		0x122c	/* One Wire 2 Interrupt Enable */
+
+#define CPCAP_REG_OW2		0x1234	/* One Wire 2 Control */
+
+#define CPCAP_REG_OW3C		0x1240	/* One Wire 3 Command */
+#define CPCAP_REG_OW3D		0x1244	/* One Wire 3 Data */
+#define CPCAP_REG_OW3I		0x1248	/* One Wire 3 Interrupt */
+#define CPCAP_REG_OW3IE		0x124c	/* One Wire 3 Interrupt Enable */
+
+#define CPCAP_REG_OW3		0x1254	/* One Wire 3 Control */
+#define CPCAP_REG_GCAIC		0x1258	/* GCAI Clock Control */
+#define CPCAP_REG_GCAIM		0x125c	/* GCAI GPIO Mode */
+#define CPCAP_REG_LGDIR		0x1260	/* LMR GCAI GPIO Direction */
+#define CPCAP_REG_LGPU		0x1264	/* LMR GCAI GPIO Pull-up */
+#define CPCAP_REG_LGPIN		0x1268	/* LMR GCAI GPIO Pin */
+#define CPCAP_REG_LGMASK	0x126c	/* LMR GCAI GPIO Mask */
+#define CPCAP_REG_LDEB		0x1270	/* LMR Debounce Settings */
+#define CPCAP_REG_LGDET		0x1274	/* LMR GCAI Detach Detect */
+#define CPCAP_REG_LMISC		0x1278	/* LMR Misc Bits */
+#define CPCAP_REG_LMACE		0x127c	/* LMR Mace IC Support */
+
+#define CPCAP_REG_TEST		0x7c00	/* Test */
+
+#define CPCAP_REG_ST_TEST1	0x7d08	/* ST Test1 */
+
+#define CPCAP_REG_ST_TEST2	0x7d18	/* ST Test2 */
+
+/*
+ * Helpers for child devices to check the revision and vendor.
+ *
+ * REVISIT: No documentation for the bits below, please update
+ * to use proper names for defines when available.
+ */
+
+static inline int cpcap_get_revision(struct device *dev,
+				     struct regmap *regmap,
+				     u16 *revision)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, CPCAP_REG_VERSC1, &val);
+	if (ret) {
+		dev_err(dev, "Could not read revision\n");
+
+		return ret;
+	}
+
+	*revision = ((val >> 3) & 0x7) | ((val << 3) & 0x38);
+
+	return 0;
+}
+
+static inline int cpcap_get_vendor(struct device *dev,
+				   struct regmap *regmap,
+				   u16 *vendor)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, CPCAP_REG_VERSC1, &val);
+	if (ret) {
+		dev_err(dev, "Could not read vendor\n");
+
+		return ret;
+	}
+
+	*vendor = (val >> 6) & 0x7;
+
+	return 0;
+}
-- 
2.10.2
