From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/5] ARM: OMAP2+: omap-iommu.c conversion to ti-sysc
Date: Thu, 12 Dec 2019 15:05:40 +0200
Message-ID: <20191212130541.3657-5-t-kristo@ti.com>
References: <20191212130541.3657-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191212130541.3657-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: s-anna@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert omap2 iommu platform code to use ti-sysc instead of legacy
omap-device / hwmod interfaces.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c | 99 ++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 78247e6f4a72..54aff33e55e6 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -8,19 +8,27 @@
 
 #include <linux/platform_device.h>
 #include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/list.h>
 
-#include "omap_hwmod.h"
-#include "omap_device.h"
 #include "clockdomain.h"
 #include "powerdomain.h"
 
+struct pwrdm_link {
+	struct device *dev;
+	struct powerdomain *pwrdm;
+	struct list_head node;
+};
+
+static DEFINE_SPINLOCK(iommu_lock);
+static struct clockdomain *emu_clkdm;
+static atomic_t emu_count;
+
 static void omap_iommu_dra7_emu_swsup_config(struct platform_device *pdev,
 					     bool enable)
 {
-	static struct clockdomain *emu_clkdm;
-	static DEFINE_SPINLOCK(emu_lock);
-	static atomic_t count;
 	struct device_node *np = pdev->dev.of_node;
+	unsigned long flags;
 
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return;
@@ -31,34 +39,87 @@ static void omap_iommu_dra7_emu_swsup_config(struct platform_device *pdev,
 			return;
 	}
 
-	spin_lock(&emu_lock);
+	spin_lock_irqsave(&iommu_lock, flags);
 
-	if (enable && (atomic_inc_return(&count) == 1))
+	if (enable && (atomic_inc_return(&emu_count) == 1))
 		clkdm_deny_idle(emu_clkdm);
-	else if (!enable && (atomic_dec_return(&count) == 0))
+	else if (!enable && (atomic_dec_return(&emu_count) == 0))
 		clkdm_allow_idle(emu_clkdm);
 
-	spin_unlock(&emu_lock);
+	spin_unlock_irqrestore(&iommu_lock, flags);
+}
+
+static struct powerdomain *_get_pwrdm(struct device *dev)
+{
+	struct clk *clk;
+	struct clk_hw_omap *hwclk;
+	struct clockdomain *clkdm;
+	struct powerdomain *pwrdm = NULL;
+	struct pwrdm_link *entry;
+	unsigned long flags;
+	static LIST_HEAD(cache);
+
+	spin_lock_irqsave(&iommu_lock, flags);
+
+	list_for_each_entry(entry, &cache, node) {
+		if (entry->dev == dev) {
+			pwrdm = entry->pwrdm;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&iommu_lock, flags);
+
+	if (pwrdm)
+		return pwrdm;
+
+	clk = of_clk_get(dev->of_node->parent, 0);
+	if (!clk) {
+		dev_err(dev, "no fck found\n");
+		return NULL;
+	}
+
+	hwclk = to_clk_hw_omap(__clk_get_hw(clk));
+	clk_put(clk);
+	if (!hwclk || !hwclk->clkdm_name) {
+		dev_err(dev, "no hwclk data\n");
+		return NULL;
+	}
+
+	clkdm = clkdm_lookup(hwclk->clkdm_name);
+	if (!clkdm) {
+		dev_err(dev, "clkdm not found: %s\n", hwclk->clkdm_name);
+		return NULL;
+	}
+
+	pwrdm = clkdm_get_pwrdm(clkdm);
+	if (!pwrdm) {
+		dev_err(dev, "pwrdm not found: %s\n", clkdm->name);
+		return NULL;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->dev = dev;
+		entry->pwrdm = pwrdm;
+		spin_lock_irqsave(&iommu_lock, flags);
+		list_add(&entry->node, &cache);
+		spin_unlock_irqrestore(&iommu_lock, flags);
+	}
+
+	return pwrdm;
 }
 
 int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev, bool request,
 				    u8 *pwrst)
 {
 	struct powerdomain *pwrdm;
-	struct omap_device *od;
 	u8 next_pwrst;
 	int ret = 0;
 
-	od = to_omap_device(pdev);
-	if (!od)
-		return -ENODEV;
-
-	if (od->hwmods_cnt != 1)
-		return -EINVAL;
-
-	pwrdm = omap_hwmod_get_pwrdm(od->hwmods[0]);
+	pwrdm = _get_pwrdm(&pdev->dev);
 	if (!pwrdm)
-		return -EINVAL;
+		return -ENODEV;
 
 	if (request) {
 		*pwrst = pwrdm_read_next_pwrst(pwrdm);
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
