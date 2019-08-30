From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 05/10] soc: ti: omap-prm: sync func clock status with resets
Date: Fri, 30 Aug 2019 15:18:11 +0300
Message-ID: <20190830121816.30034-6-t-kristo@ti.com>
References: <20190830121816.30034-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830121816.30034-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ssantosh@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hardware reset signals are tightly coupled with associated clocks, and
basically de-asserting a reset won't succeed properly if the clock is
not enabled, and vice-versa. Also, disabling a clock won't fully succeed
if the associated hardware resets are not asserted. Add status sync
functionality between these two for TI drivers so that the situations
can be handled properly without generating any timeouts.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 0b6a300f935b..7c8fdc5e6c50 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -15,6 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/clk/ti.h>
 
 #include <linux/platform_data/ti-prm.h>
 
@@ -44,6 +46,7 @@ struct omap_reset_data {
 	u32 mask;
 	spinlock_t lock;
 	struct clockdomain *clkdm;
+	struct clk *clk;
 	struct device *dev;
 };
 
@@ -128,6 +131,8 @@ static int omap_reset_assert(struct reset_controller_dev *rcdev,
 	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctrl);
 	spin_unlock_irqrestore(&reset->lock, flags);
 
+	ti_clk_notify_resets(reset->clk, v == reset->mask);
+
 	return 0;
 }
 
@@ -164,9 +169,19 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctrl);
 	spin_unlock_irqrestore(&reset->lock, flags);
 
+	ti_clk_notify_resets(reset->clk, v == reset->mask);
+
 	if (!has_rstst)
 		goto exit;
 
+	/* If associated clock is disabled, we can't poll completion status */
+	if (reset->clk) {
+		struct clk_hw *hw = __clk_get_hw(reset->clk);
+
+		if (!clk_hw_is_enabled(hw))
+			return ret;
+	}
+
 	/* wait for the status to be set */
 	ret = readl_relaxed_poll_timeout(reset->prm->base +
 					 reset->prm->data->rstst,
@@ -207,6 +222,7 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	const struct omap_rst_map *map;
 	struct ti_prm_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	char buf[32];
+	u32 v;
 
 	/*
 	 * Check if we have controllable resets. If either rstctrl is non-zero
@@ -237,6 +253,13 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	reset->rcdev.of_reset_n_cells = 1;
 	reset->dev = &pdev->dev;
 	spin_lock_init(&reset->lock);
+	reset->clk = of_clk_get(pdev->dev.of_node, 0);
+
+	if (PTR_ERR(reset->clk) == -ENOENT)
+		reset->clk = NULL;
+
+	if (IS_ERR(reset->clk))
+		return PTR_ERR(reset->clk);
 
 	reset->prm = prm;
 
@@ -254,6 +277,11 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 		map++;
 	}
 
+	if (reset->clk) {
+		v = readl_relaxed(reset->prm->base + reset->prm->data->rstctrl);
+		ti_clk_notify_resets(reset->clk, v == reset->mask);
+	}
+
 	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
 }
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
