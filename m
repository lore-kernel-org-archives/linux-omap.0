From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/3] EDAC: ti: add support for TI keystone and DRA7xx EDAC
Date: Tue, 7 Nov 2017 22:38:58 +0200
Message-ID: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
correct one bit errors and detect two bit errors. Add EDAC driver for this
feature which plugs into the generic kernel EDAC framework.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/edac/Kconfig   |   7 ++
 drivers/edac/Makefile  |   1 +
 drivers/edac/ti_edac.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/edac/ti_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2a..54f0184 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -457,4 +457,11 @@ config EDAC_XGENE
 	  Support for error detection and correction on the
 	  APM X-Gene family of SOCs.
 
+config EDAC_TI
+	tristate "Texas Instruments DDR3 ECC handler"
+	depends on ARCH_KEYSTONE || SOC_DRA7XX
+	help
+	  Support for error detection and correction on the
+          TI SoCs.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 0fd9ffa..b54912e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
+obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
new file mode 100644
index 0000000..54bacf3
--- /dev/null
+++ b/drivers/edac/ti_edac.c
@@ -0,0 +1,306 @@
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Texas Instruments DDR3 ECC error correction and detection driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/edac.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+
+#include "edac_module.h"
+
+/* EMIF controller registers */
+#define EMIF_SDRAM_CONFIG		0x008
+#define EMIF_IRQ_STATUS			0x0ac
+#define EMIF_IRQ_ENABLE_SET		0x0b4
+#define EMIF_ECC_CTRL			0x110
+#define EMIF_1B_ECC_ERR_CNT		0x130
+#define EMIF_1B_ECC_ERR_THRSH		0x134
+#define EMIF_1B_ECC_ERR_ADDR_LOG	0x13c
+#define EMIF_2B_ECC_ERR_ADDR_LOG	0x140
+
+/* Bit definitions for EMIF_SDRAM_CONFIG */
+#define SDRAM_TYPE_SHIFT		29
+#define SDRAM_TYPE_MASK			GENMASK(31,29)
+#define SDRAM_TYPE_DDR3			(3 << SDRAM_TYPE_SHIFT)
+#define SDRAM_TYPE_DDR2			(2 << SDRAM_TYPE_SHIFT)
+#define SDRAM_NARROW_MODE_MASK		GENMASK(15,14)
+#define SDRAM_K2_NARROW_MODE_SHIFT	12
+#define SDRAM_K2_NARROW_MODE_MASK	GENMASK(13,12)
+#define SDRAM_ROWSIZE_SHIFT		7
+#define SDRAM_ROWSIZE_MASK		GENMASK(9,7)
+#define SDRAM_IBANK_SHIFT		4
+#define SDRAM_IBANK_MASK		GENMASK(6,4)
+#define SDRAM_K2_IBANK_SHIFT		5
+#define SDRAM_K2_IBANK_MASK		GENMASK(6,5)
+#define SDRAM_K2_EBANK_SHIFT		3
+#define SDRAM_K2_EBANK_MASK		BIT(SDRAM_K2_EBANK_SHIFT)
+#define SDRAM_PAGESIZE_SHIFT		0
+#define SDRAM_PAGESIZE_MASK		GENMASK(2,0)
+#define SDRAM_K2_PAGESIZE_SHIFT		0
+#define SDRAM_K2_PAGESIZE_MASK		GENMASK(1,0)
+
+#define EMIF_1B_ECC_ERR_THRSH_SHIFT	24
+
+/* IRQ bit definitions */
+#define EMIF_1B_ECC_ERR			BIT(5)
+#define EMIF_2B_ECC_ERR			BIT(4)
+#define EMIF_WR_ECC_ERR			BIT(3)
+#define EMIF_SYS_ERR			BIT(0)
+/* Bit 31 enables ECC and 28 enables RMW */
+#define ECC_ENABLED			(BIT(31) | BIT(28))
+
+enum {
+	EMIF_TYPE_DRA7,
+	EMIF_TYPE_K2
+};
+
+struct ti_edac {
+	void __iomem *reg;
+};
+
+static DEFINE_MUTEX(ti_edac_lock);
+
+static u32 ti_edac_readl(struct ti_edac *edac, u16 offset)
+{
+	return readl_relaxed(edac->reg + offset);
+}
+
+static void ti_edac_writel(struct ti_edac *edac, u32 val, u16 offset)
+{
+	writel_relaxed(val, edac->reg + offset);
+}
+
+static irqreturn_t ti_edac_isr(int irq, void *data)
+{
+	struct mem_ctl_info *mci = data;
+	struct ti_edac *edac = mci->pvt_info;
+	u32 irq_status;
+	u32 err_addr;
+	int err_count;
+
+	irq_status = ti_edac_readl(edac, EMIF_IRQ_STATUS);
+
+	if (irq_status & EMIF_1B_ECC_ERR) {
+		err_addr = ti_edac_readl(edac, EMIF_1B_ECC_ERR_ADDR_LOG);
+		err_count = ti_edac_readl(edac, EMIF_1B_ECC_ERR_CNT);
+		ti_edac_writel(edac, err_count, EMIF_1B_ECC_ERR_CNT);
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
+				     err_addr >> PAGE_SHIFT,
+				     err_addr & ~PAGE_MASK, -1, 0, 0, 0,
+				     mci->ctl_name, "1B");
+	}
+
+	if (irq_status & EMIF_2B_ECC_ERR) {
+		err_addr = ti_edac_readl(edac, EMIF_2B_ECC_ERR_ADDR_LOG);
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
+				     err_addr >> PAGE_SHIFT,
+				     err_addr & ~PAGE_MASK, -1, 0, 0, 0,
+				     mci->ctl_name, "2B");
+	}
+
+	if (irq_status & EMIF_WR_ECC_ERR)
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
+				     0, 0, -1, 0, 0, 0,
+				     mci->ctl_name, "WR");
+
+	ti_edac_writel(edac, irq_status, EMIF_IRQ_STATUS);
+
+	return IRQ_HANDLED;
+}
+
+static void ti_edac_setup_dimm(struct mem_ctl_info *mci, u32 type)
+{
+	struct dimm_info *dimm;
+	struct ti_edac *edac = mci->pvt_info;
+	int bits;
+	u32 val;
+	u32 memsize;
+
+	dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, 0, 0, 0);
+
+	val = ti_edac_readl(edac, EMIF_SDRAM_CONFIG);
+
+	if (type == EMIF_TYPE_DRA7) {
+		bits = ((val & SDRAM_PAGESIZE_MASK) >>
+			SDRAM_PAGESIZE_SHIFT) + 8;
+		bits += ((val & SDRAM_ROWSIZE_MASK) >>
+			SDRAM_ROWSIZE_SHIFT) + 9;
+		bits += (val & SDRAM_IBANK_MASK) >> SDRAM_IBANK_SHIFT;
+
+		if (val & SDRAM_NARROW_MODE_MASK) {
+			bits++;
+			dimm->dtype = DEV_X16;
+		} else {
+			bits += 2;
+			dimm->dtype = DEV_X32;
+		}
+	} else {
+		bits = 16;
+		bits += ((val & SDRAM_K2_PAGESIZE_MASK) >>
+			SDRAM_K2_PAGESIZE_SHIFT) + 8;
+		bits += (val & SDRAM_K2_IBANK_MASK) >> SDRAM_K2_IBANK_SHIFT;
+		bits += (val & SDRAM_K2_EBANK_MASK) >> SDRAM_K2_EBANK_SHIFT;
+
+		val = (val & SDRAM_K2_NARROW_MODE_MASK) >>
+			SDRAM_K2_NARROW_MODE_SHIFT;
+		switch (val) {
+		case 0:
+			bits += 3;
+			dimm->dtype = DEV_X64;
+			break;
+		case 1:
+			bits += 2;
+			dimm->dtype = DEV_X32;
+			break;
+		case 2:
+			bits ++;
+			dimm->dtype = DEV_X16;
+			break;
+		}
+	}
+
+	memsize = 1 << bits;
+
+	dimm->nr_pages = memsize >> PAGE_SHIFT;
+	dimm->grain = 4;
+	if ((val & SDRAM_TYPE_MASK) == SDRAM_TYPE_DDR2)
+		dimm->mtype = MEM_DDR2;
+	else
+		dimm->mtype = MEM_DDR3;
+
+	val = ti_edac_readl(edac, EMIF_ECC_CTRL);
+	if (val & ECC_ENABLED)
+		dimm->edac_mode = EDAC_SECDED;
+	else
+		dimm->edac_mode = EDAC_NONE;
+}
+
+static const struct of_device_id ti_edac_of_match[] = {
+	{ .compatible = "ti,emif-keystone", .data = (void *)EMIF_TYPE_K2 },
+	{ .compatible = "ti,emif-dra7xx", .data = (void *)EMIF_TYPE_DRA7 },
+	{},
+};
+
+static int ti_edac_probe(struct platform_device *pdev)
+{
+	int error_irq = 0, ret = -ENODEV;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *reg;
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[1];
+	const struct of_device_id *id;
+	struct ti_edac *edac;
+	static int edac_id;
+	int my_id;
+
+	id = of_match_device(ti_edac_of_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg)) {
+		dev_err(dev, "DDR3 controller regs not defined\n");
+		return PTR_ERR(reg);
+	}
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = 1;
+
+	/* Allocate ID number for our EMIF controller */
+	mutex_lock(&ti_edac_lock);
+	my_id = edac_id++;
+	mutex_unlock(&ti_edac_lock);
+
+	mci = edac_mc_alloc(my_id, 1, layers, sizeof(*edac));
+	if (!mci)
+		return -ENOMEM;
+
+	mci->pdev = &pdev->dev;
+	edac = mci->pvt_info;
+	edac->reg = reg;
+	platform_set_drvdata(pdev, mci);
+
+	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED | EDAC_FLAG_NONE;
+	mci->mod_name = pdev->dev.driver->name;
+	mci->ctl_name = id->compatible;
+	mci->dev_name = dev_name(&pdev->dev);
+
+	/* Setup memory layout */
+	ti_edac_setup_dimm(mci, (u32)(id->data));
+
+	if (edac_mc_add_mc(mci)) {
+		pr_err("%s: Failed to register mci.\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* add EMIF ECC error handler */
+	error_irq = platform_get_irq(pdev, 0);
+	if (!error_irq) {
+		dev_err(dev, "DDR3 EDAC irq number not defined\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(dev, error_irq, ti_edac_isr, 0,
+			       "ddr3-edac-irq", mci);
+	if (ret) {
+		dev_err(dev, "request_irq fail for DDR3 EDAC error irq\n");
+		return ret;
+	}
+
+	/* Generate an interrupt with each 1b error */
+	ti_edac_writel(edac, 1 << EMIF_1B_ECC_ERR_THRSH_SHIFT,
+		       EMIF_1B_ECC_ERR_THRSH);
+
+	/* Enable interrupts */
+	ti_edac_writel(edac,
+		       EMIF_1B_ECC_ERR | EMIF_2B_ECC_ERR | EMIF_WR_ECC_ERR,
+		       EMIF_IRQ_ENABLE_SET);
+
+	return ret;
+}
+
+static int ti_edac_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static struct platform_driver ti_edac_driver = {
+	.probe = ti_edac_probe,
+	.remove = ti_edac_remove,
+	.driver = {
+		   .name = "ti_edac",
+		   .of_match_table = ti_edac_of_match,
+	},
+};
+
+module_platform_driver(ti_edac_driver);
+
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("EDAC Driver for Texas Instruments DDR3 MC");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
