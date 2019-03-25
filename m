From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: OMAP2+: Allocate struct omap_hwmod based on dts data
Date: Mon, 25 Mar 2019 11:38:17 -0700
Message-ID: <20190325183819.15400-6-tony@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325183819.15400-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With ti-sysc interconnect target module, we can allocate struct omap_hwmod
data based on the devicetree data. This allows dropping the static SoC
specific data eventually so we will only boot with data we actually need.

To allocate struct omap_hwmod dynamically, we need to add a mutex for
modifying the list, and remove __init for few functions.

Note that we are not initialized oh->_clk or the optional clocks and their
related quirks. That can be directly handled by the interconnect target
module driver.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 82 ++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -235,6 +235,7 @@ static struct omap_hwmod_soc_ops soc_ops;
 
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
+static DEFINE_MUTEX(list_lock);
 
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
@@ -2624,7 +2625,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
  * that the copy process would be relatively complex due to the large number
  * of substructures.
  */
-static int __init _register(struct omap_hwmod *oh)
+static int _register(struct omap_hwmod *oh)
 {
 	if (!oh || !oh->name || !oh->class || !oh->class->name ||
 	    (oh->_state != _HWMOD_STATE_UNKNOWN))
@@ -2663,7 +2664,7 @@ static int __init _register(struct omap_hwmod *oh)
  * locking in this code.  Changes to this assumption will require
  * additional locking.  Returns 0.
  */
-static int __init _add_link(struct omap_hwmod_ocp_if *oi)
+static int _add_link(struct omap_hwmod_ocp_if *oi)
 {
 	pr_debug("omap_hwmod: %s -> %s: adding link\n", oi->master->name,
 		 oi->slave->name);
@@ -3444,6 +3445,9 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 {
 	struct omap_hwmod_class_sysconfig *sysc;
 	struct omap_hwmod_class *class = NULL;
+	struct omap_hwmod_ocp_if *oi = NULL;
+	struct clockdomain *clkdm = NULL;
+	struct clk *clk = NULL;
 	void __iomem *regs = NULL;
 	unsigned long flags;
 
@@ -3476,13 +3480,62 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 			return -ENOMEM;
 	}
 
+	if (list_empty(&oh->slave_ports)) {
+		oi = kcalloc(1, sizeof(*oi), GFP_KERNEL);
+		if (!oi)
+			return -ENOMEM;
+
+		/*
+		 * Note that we assume interconnect interface clocks will be
+		 * managed by the interconnect driver for OCPIF_SWSUP_IDLE case
+		 * on omap24xx and omap3.
+		 */
+		oi->slave = oh;
+		oi->user = OCP_USER_MPU | OCP_USER_SDMA;
+	}
+
+	if (!oh->_clk) {
+		struct clk_hw_omap *hwclk;
+
+		clk = of_clk_get_by_name(dev->of_node, "fck");
+		if (!IS_ERR(clk))
+			clk_prepare(clk);
+		else
+			clk = NULL;
+
+		/*
+		 * Populate clockdomain based on dts clock. It is needed for
+		 * clkdm_deny_idle() and clkdm_allow_idle() until we have have
+		 * interconnect driver and reset driver capable of blocking
+		 * clockdomain idle during reset, enable and idle.
+		 */
+		if (clk) {
+			hwclk = to_clk_hw_omap(__clk_get_hw(clk));
+			if (hwclk && hwclk->clkdm_name)
+				clkdm = clkdm_lookup(hwclk->clkdm_name);
+		}
+
+		/*
+		 * Note that we assume interconnect driver manages the clocks
+		 * and do not need to populate oh->_clk for dynamically
+		 * allocated modules.
+		 */
+		clk_unprepare(clk);
+		clk_put(clk);
+	}
+
 	spin_lock_irqsave(&oh->_lock, flags);
 	if (regs)
 		oh->_mpu_rt_va = regs;
 	if (class)
 		oh->class = class;
 	oh->class->sysc = sysc;
+	if (oi)
+		_add_link(oi);
+	if (clkdm)
+		oh->clkdm = clkdm;
 	oh->_state = _HWMOD_STATE_INITIALIZED;
+	oh->_postsetup_state = _HWMOD_STATE_DEFAULT;
 	_setup(oh, NULL);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3509,8 +3562,29 @@ int omap_hwmod_init_module(struct device *dev,
 		return -EINVAL;
 
 	oh = _lookup(data->name);
-	if (!oh)
-		return -ENODEV;
+	if (!oh) {
+		oh = kzalloc(sizeof(*oh), GFP_KERNEL);
+		if (!oh)
+			return -ENOMEM;
+
+		oh->name = data->name;
+		oh->_state = _HWMOD_STATE_UNKNOWN;
+		lockdep_register_key(&oh->hwmod_key);
+
+		/* Unused, can be handled by PRM driver handling resets */
+		oh->prcm.omap4.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT;
+
+		oh->class = kzalloc(sizeof(*oh->class), GFP_KERNEL);
+		if (!oh->class) {
+			kfree(oh);
+			return -ENOMEM;
+		}
+
+		oh->class->name = data->name;
+		mutex_lock(&list_lock);
+		error = _register(oh);
+		mutex_unlock(&list_lock);
+	}
 
 	cookie->data = oh;
 
-- 
2.21.0
