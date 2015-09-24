From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/17] ARM: OMAP2+: PRM: add support for reset controller
Date: Thu, 24 Sep 2015 17:26:42 +0300
Message-ID: <1443104818-993-2-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

PRM driver now supports reset controller for the defined reset lines.
Reset configurations are provided through device tree. Later, functionality
like hwmod and system reboot will be changed to use the generic framework.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Kconfig      |    1 +
 arch/arm/mach-omap2/prm_common.c |  167 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 07d2e10..ac3ef43 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -92,6 +92,7 @@ config ARCH_OMAP2PLUS
 	select SOC_BUS
 	select TI_PRIV_EDMA
 	select OMAP_IRQCHIP
+	select RESET_CONTROLLER
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 3fc2cbe..161d8ab 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -27,6 +27,8 @@
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
 
 #include "soc.h"
 #include "prm2xxx_3xxx.h"
@@ -51,6 +53,11 @@
 #define OMAP_PRCM_MAX_NR_PENDING_REG		2
 
 /*
+ * Default partition for OMAP resets, maps to PRM
+ */
+#define OMAP_RESET_DEFAULT_PARTITION		1
+
+/*
  * prcm_irq_chips: an array of all of the "generic IRQ chips" in use
  * by the PRCM interrupt handler code.  There will be one 'chip' per
  * PRM_{IRQSTATUS,IRQENABLE}_MPU register pair.  (So OMAP3 will have
@@ -737,6 +744,162 @@ static const struct of_device_id const omap_prcm_dt_match_table[] __initconst =
 	{ }
 };
 
+struct ti_reset_data {
+	s16 module;
+	u16 offset;
+	u16 st_offset;
+	u8 shift;
+	u8 st_shift;
+	u8 part;
+};
+
+struct ti_reset_ctrl {
+	struct reset_controller_dev rcdev;
+	struct ti_reset_data **resets;
+	int num_resets;
+	int max_resets;
+	s16 offset;
+};
+
+#define to_ti_reset_ctrl(_rcdev) container_of(_rcdev, struct ti_reset_ctrl, \
+					      rcdev)
+
+static struct ti_reset_data *_get_reset(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	struct ti_reset_ctrl *ctrl = to_ti_reset_ctrl(rcdev);
+
+	return ctrl->resets[id];
+}
+
+static int ti_reset_assert(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	struct ti_reset_data *reset = _get_reset(rcdev, id);
+
+	return omap_prm_assert_hardreset(reset->shift, reset->part,
+					 reset->module, reset->offset);
+}
+
+static int ti_reset_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct ti_reset_data *reset = _get_reset(rcdev, id);
+
+	return omap_prm_deassert_hardreset(reset->shift, reset->st_shift,
+					   reset->part, reset->module,
+					   reset->offset, reset->st_offset);
+}
+
+static int ti_reset_status(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	struct ti_reset_data *reset = _get_reset(rcdev, id);
+
+	return omap_prm_is_hardreset_asserted(reset->shift, reset->part,
+					      reset->module, reset->offset);
+}
+
+static struct reset_control_ops ti_reset_ops = {
+	.assert = ti_reset_assert,
+	.deassert = ti_reset_deassert,
+	.status = ti_reset_status,
+};
+
+static int ti_reset_xlate(struct reset_controller_dev *rcdev,
+			  const struct of_phandle_args *reset_spec)
+{
+	struct ti_reset_ctrl *ctrl = to_ti_reset_ctrl(rcdev);
+	s16 module;
+	u16 offset, st_offset;
+	u8 shift, st_shift;
+	int index = 0;
+	struct ti_reset_data *reset;
+
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	module = reset_spec->args[0] - ctrl->offset;
+	offset = reset_spec->args[1];
+	shift = reset_spec->args[2];
+	st_offset = reset_spec->args[3];
+	st_shift = reset_spec->args[4];
+
+	for (index = 0; index < ctrl->num_resets; index++) {
+		reset = ctrl->resets[index];
+
+		if (module == reset->module && offset == reset->offset &&
+		    st_offset == reset->st_offset && shift == reset->shift &&
+		    st_shift == reset->st_shift)
+			return index;
+	}
+
+	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
+
+	reset->module = module;
+	reset->offset = offset;
+	reset->st_offset = st_offset;
+	reset->shift = shift;
+	reset->st_shift = st_shift;
+	reset->part = OMAP_RESET_DEFAULT_PARTITION;
+
+	if (ctrl->num_resets + 1 > ctrl->max_resets) {
+		struct ti_reset_data **arr;
+		int num;
+
+		num = ctrl->num_resets;
+		num *= 2;
+		if (!num)
+			num = 1;
+
+		arr = kcalloc(num, sizeof(*arr), GFP_KERNEL);
+		ctrl->max_resets = num;
+		if (ctrl->num_resets)
+			memcpy(arr, ctrl->resets,
+			       sizeof(*arr) * ctrl->num_resets);
+
+		kfree(ctrl->resets);
+		ctrl->resets = arr;
+	}
+
+	ctrl->resets[index] = reset;
+	ctrl->num_resets++;
+
+	return index;
+}
+
+/**
+ * omap2_prm_reset_controller_register - register reset controller for a node
+ * @node: device node to register reset controller for
+ * @data: PRM init data for the node
+ *
+ * Registers a reset controller for the PRM node if applicable. Return 0
+ * in success, negative error value in failure.
+ */
+int __init
+omap2_prm_reset_controller_register(struct device_node *np,
+				    const struct omap_prcm_init_data *data)
+{
+	struct ti_reset_ctrl *ctrl;
+
+	/* Reset controllers available only for PRM nodes */
+	if (data->index != TI_CLKM_PRM)
+		return 0;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+
+	ctrl->rcdev.of_node = np;
+	ctrl->rcdev.of_reset_n_cells = 5;
+	ctrl->rcdev.ops = &ti_reset_ops;
+	ctrl->rcdev.of_xlate = &ti_reset_xlate;
+
+	ctrl->offset = data->offset;
+
+	reset_controller_register(&ctrl->rcdev);
+
+	return 0;
+}
+
 /**
  * omap2_prm_base_init - initialize iomappings for the PRM driver
  *
@@ -802,6 +965,10 @@ int __init omap_prcm_init(void)
 		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
+
+		ret = omap2_prm_reset_controller_register(np, data);
+		if (ret)
+			return ret;
 	}
 
 	omap_cm_init();
-- 
1.7.9.5
