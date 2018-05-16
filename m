From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl context
Date: Wed, 16 May 2018 11:10:30 +0530
Message-ID: <1526449230-27618-3-git-send-email-j-keerthy@ti.com>
References: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, linus.walleij@linaro.org, t-kristo@ti.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This adds a pair of context save/restore functions to save/restore the
state of a set of pinctrl registers. This simplifies some of the AM33XX
PM code as some of the pinctrl registers are lost when the per power
domain loses power. The pincrtl code can perform the necessary
save/restore.

This will also be necessary for hibernation and RTC only sleep, as all
pinctrl registers all lost.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/pinctrl/pinctrl-single.c | 95 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a7c5eb3..3062ebb 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
+#include <linux/cpu_pm.h>
 
 #include <linux/irqchip/chained_irq.h>
 
@@ -144,6 +145,7 @@ struct pcs_soc_data {
  * struct pcs_device - pinctrl device instance
  * @res:	resources
  * @base:	virtual address of the controller
+ * @saved_vals: saved values for the controller
  * @size:	size of the ioremapped area
  * @dev:	device entry
  * @np:		device tree node
@@ -172,11 +174,13 @@ struct pcs_soc_data {
 struct pcs_device {
 	struct resource *res;
 	void __iomem *base;
+	void *saved_vals;
 	unsigned size;
 	struct device *dev;
 	struct device_node *np;
 	struct pinctrl_dev *pctl;
 	unsigned flags;
+#define PCS_CONTEXT_LOSS_OFF	(1 << 3)
 #define PCS_QUIRK_SHARED_IRQ	(1 << 2)
 #define PCS_FEAT_IRQ		(1 << 1)
 #define PCS_FEAT_PINCONF	(1 << 0)
@@ -195,6 +199,7 @@ struct pcs_device {
 	struct list_head gpiofuncs;
 	struct list_head irqs;
 	struct irq_chip chip;
+	struct notifier_block nb;
 	struct irq_domain *domain;
 	struct pinctrl_desc desc;
 	unsigned (*read)(void __iomem *reg);
@@ -1649,6 +1654,86 @@ static int pcs_quirk_missing_pinctrl_cells(struct pcs_device *pcs,
 	return error;
 }
 
+static int pcs_save_context(struct pcs_device *pcs)
+{
+	int i, mux_bytes;
+	u64 *regsl;
+	u32 *regsw;
+	u16 *regshw;
+
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+
+	if (!pcs->saved_vals)
+		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
+
+	switch (pcs->width) {
+	case 64:
+		regsl = (u64 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			regsl[i] = pcs->read(pcs->base + i * mux_bytes);
+		break;
+	case 32:
+		regsw = (u32 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			regsw[i] = pcs->read(pcs->base + i * mux_bytes);
+		break;
+	case 16:
+		regshw = (u16 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			regshw[i] = pcs->read(pcs->base + i * mux_bytes);
+		break;
+	}
+
+	return 0;
+}
+
+static void pcs_restore_context(struct pcs_device *pcs)
+{
+	int i, mux_bytes;
+	u64 *regsl;
+	u32 *regsw;
+	u16 *regshw;
+
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+
+	switch (pcs->width) {
+	case 64:
+		regsl = (u64 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			pcs->write(regsl[i], pcs->base + i * mux_bytes);
+		break;
+	case 32:
+		regsw = (u32 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			pcs->write(regsw[i], pcs->base + i * mux_bytes);
+		break;
+	case 16:
+		regshw = (u16 *)pcs->saved_vals;
+		for (i = 0; i < pcs->size / mux_bytes; i++)
+			pcs->write(regshw[i], pcs->base + i * mux_bytes);
+		break;
+	}
+}
+
+static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
+{
+	struct pcs_device *pcs = container_of(nb, struct pcs_device, nb);
+	struct pcs_pdata *pdata = dev_get_platdata(pcs->dev);
+
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (pdata->context_may_be_lost())
+			pcs_save_context(pcs);
+		break;
+	case CPU_CLUSTER_PM_EXIT:
+		if (pdata->context_may_be_lost())
+			pcs_restore_context(pcs);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1792,6 +1877,11 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
+	if (soc->flags & PCS_CONTEXT_LOSS_OFF) {
+		pcs->nb.notifier_call = cpu_notifier;
+		cpu_pm_register_notifier(&pcs->nb);
+	}
+
 	return pinctrl_enable(pcs->pctl);
 
 free:
@@ -1807,6 +1897,9 @@ static int pcs_remove(struct platform_device *pdev)
 	if (!pcs)
 		return 0;
 
+	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
+		cpu_pm_unregister_notifier(&pcs->nb);
+
 	pcs_free_resources(pcs);
 
 	return 0;
@@ -1824,7 +1917,7 @@ static int pcs_remove(struct platform_device *pdev)
 };
 
 static const struct pcs_soc_data pinctrl_single_am437x = {
-	.flags = PCS_QUIRK_SHARED_IRQ,
+	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
 	.irq_enable_mask = (1 << 29),   /* OMAP_WAKEUP_EN */
 	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
 };
-- 
1.9.1
