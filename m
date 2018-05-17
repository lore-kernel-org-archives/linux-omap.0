From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] pinctrl: pinctrl-single: Add functions to save and restore
 pinctrl context
Date: Thu, 17 May 2018 10:10:21 +0530
Message-ID: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linus.walleij@linaro.org
Cc: t-kristo@ti.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

This adds a pair of context save/restore functions to save/restore the
state of a set of pinctrl registers. The context is lost during rtc only
suspend with ddr in self-refresh on am43xx. Currently the save/restore
is being done unconditionally. This will be optimized later with a
pdata-quirk function which will allow is to save/restore only when doing
the rtc only mode with ddr in self refresh.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * As this is needed only the in the suspend/resume path
    removed the cpu_pm notifier and added the save/restore in
    the suspend/resume calls.
  * Saving/Restoring unconditionally at the moment. This will
    be optimized later with the help of a pdata-quirk function.

 drivers/pinctrl/pinctrl-single.c | 72 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a7c5eb3..9c3c005 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -144,6 +144,7 @@ struct pcs_soc_data {
  * struct pcs_device - pinctrl device instance
  * @res:	resources
  * @base:	virtual address of the controller
+ * @saved_vals: saved values for the controller
  * @size:	size of the ioremapped area
  * @dev:	device entry
  * @np:		device tree node
@@ -172,11 +173,13 @@ struct pcs_soc_data {
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
@@ -1576,6 +1579,67 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 }
 
 #ifdef CONFIG_PM
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
 static int pinctrl_single_suspend(struct platform_device *pdev,
 					pm_message_t state)
 {
@@ -1585,6 +1649,9 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
 	if (!pcs)
 		return -EINVAL;
 
+	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
+		pcs_save_context(pcs);
+
 	return pinctrl_force_sleep(pcs->pctl);
 }
 
@@ -1596,6 +1663,9 @@ static int pinctrl_single_resume(struct platform_device *pdev)
 	if (!pcs)
 		return -EINVAL;
 
+	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
+		pcs_restore_context(pcs);
+
 	return pinctrl_force_default(pcs->pctl);
 }
 #endif
@@ -1824,7 +1894,7 @@ static int pcs_remove(struct platform_device *pdev)
 };
 
 static const struct pcs_soc_data pinctrl_single_am437x = {
-	.flags = PCS_QUIRK_SHARED_IRQ,
+	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
 	.irq_enable_mask = (1 << 29),   /* OMAP_WAKEUP_EN */
 	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
 };
-- 
1.9.1
