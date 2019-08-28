From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 06/11] soc: ti: omap-prm: support resets with no associated
 clockdomain
Date: Wed, 28 Aug 2019 10:19:36 +0300
Message-ID: <20190828071941.32378-7-t-kristo@ti.com>
References: <20190828071941.32378-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190828071941.32378-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Typically hardware resets on TI SoCs are associated with a clockdomain
which must be forced to be active while the reset is being de-asserted.
Otherwise the reset may not de-assert properly leaving the IP in some
weird metastate. However, some hardware reset lines don't have this
association in place, so add support for a new PRM flag for this
purpose.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index e876bad8f8d5..d7a29e282788 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -56,6 +56,7 @@ struct omap_reset_data {
 
 #define OMAP_PRM_HAS_RSTCTRL	BIT(0)
 #define OMAP_PRM_HAS_RSTST	BIT(1)
+#define OMAP_PRM_HAS_NO_CLKDM	BIT(2)
 
 #define OMAP_PRM_HAS_RESETS	(OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_RSTST)
 
@@ -162,7 +163,8 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 		writel_relaxed(v, reset->prm->base + reset->prm->data->rstst);
 	}
 
-	pdata->clkdm_deny_idle(reset->clkdm);
+	if (reset->clkdm)
+		pdata->clkdm_deny_idle(reset->clkdm);
 
 	/* de-assert the reset control line */
 	v = readl_relaxed(reset->prm->base + reset->prm->data->rstctrl);
@@ -200,7 +202,8 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	}
 
 exit:
-	pdata->clkdm_allow_idle(reset->clkdm);
+	if (reset->clkdm)
+		pdata->clkdm_allow_idle(reset->clkdm);
 
 	return ret;
 }
@@ -229,7 +232,7 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 		return 0;
 
 	/* Check if we have the pdata callbacks in place */
-	if (!pdata->clkdm_lookup || !pdata->clkdm_deny_idle ||
+	if (!pdata || !pdata->clkdm_lookup || !pdata->clkdm_deny_idle ||
 	    !pdata->clkdm_allow_idle)
 		return -EINVAL;
 
@@ -256,9 +259,11 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	sprintf(buf, "%s_clkdm", prm->data->clkdm_name ? prm->data->clkdm_name :
 		prm->data->name);
 
-	reset->clkdm = pdata->clkdm_lookup(buf);
-	if (!reset->clkdm)
-		return -EINVAL;
+	if (!(prm->data->flags & OMAP_PRM_HAS_NO_CLKDM)) {
+		reset->clkdm = pdata->clkdm_lookup(buf);
+		if (!reset->clkdm)
+			return -EINVAL;
+	}
 
 	while (map->rst >= 0) {
 		reset->mask |= BIT(map->rst);
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
