From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 5/5] usb: musb: da8xx: Add a primary support of PM runtime
Date: Tue, 24 Jan 2017 11:11:49 +0100
Message-ID: <20170124101149.14920-6-abailon@baylibre.com>
References: <20170124101149.14920-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124101149.14920-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently, MUSB DA8xx glue driver doesn't have PM runtime support.
Because the CPPI 4.1 is using the same clock as MUSB DA8xx and
CPPI 4.1 is a child of MUSB DA8xx glue, add support of PM runtime
to the DA8xx glue driver in order to let the CPPI 4.1 driver manage
the clock by using PM runtime.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/da8xx.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index d87fb9b..bebc9ed 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -30,7 +30,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
@@ -86,7 +85,6 @@ struct da8xx_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
 	struct platform_device	*usb_phy;
-	struct clk		*clk;
 	struct phy		*phy;
 };
 
@@ -377,11 +375,7 @@ static int da8xx_musb_init(struct musb *musb)
 
 	musb->mregs += DA8XX_MENTOR_CORE_OFFSET;
 
-	ret = clk_prepare_enable(glue->clk);
-	if (ret) {
-		dev_err(glue->dev, "failed to enable clock\n");
-		return ret;
-	}
+	pm_runtime_get_sync(musb->controller->parent);
 
 	/* Returns zero if e.g. not clocked */
 	rev = musb_readl(reg_base, DA8XX_USB_REVISION_REG);
@@ -424,7 +418,7 @@ static int da8xx_musb_init(struct musb *musb)
 err_phy_power_on:
 	phy_exit(glue->phy);
 fail:
-	clk_disable_unprepare(glue->clk);
+	pm_runtime_put(musb->controller->parent);
 	return ret;
 }
 
@@ -436,7 +430,7 @@ static int da8xx_musb_exit(struct musb *musb)
 
 	phy_power_off(glue->phy);
 	phy_exit(glue->phy);
-	clk_disable_unprepare(glue->clk);
+	pm_runtime_put(musb->controller->parent);
 
 	usb_put_phy(musb->xceiv);
 
@@ -519,7 +513,6 @@ static int da8xx_probe(struct platform_device *pdev)
 	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
 	struct da8xx_glue		*glue;
 	struct platform_device_info	pinfo;
-	struct clk			*clk;
 	struct device_node		*np = pdev->dev.of_node;
 	int				ret;
 
@@ -527,12 +520,6 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (!glue)
 		return -ENOMEM;
 
-	clk = devm_clk_get(&pdev->dev, "usb20");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
 	glue->phy = devm_phy_get(&pdev->dev, "usb-phy");
 	if (IS_ERR(glue->phy)) {
 		if (PTR_ERR(glue->phy) != -EPROBE_DEFER)
@@ -541,7 +528,6 @@ static int da8xx_probe(struct platform_device *pdev)
 	}
 
 	glue->dev			= &pdev->dev;
-	glue->clk			= clk;
 
 	if (IS_ENABLED(CONFIG_OF) && np) {
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
@@ -587,6 +573,8 @@ static int da8xx_probe(struct platform_device *pdev)
 	pinfo.data = pdata;
 	pinfo.size_data = sizeof(*pdata);
 
+	pm_runtime_enable(&pdev->dev);
+
 	glue->musb = platform_device_register_full(&pinfo);
 	ret = PTR_ERR_OR_ZERO(glue->musb);
 	if (ret) {
@@ -603,6 +591,7 @@ static int da8xx_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(glue->usb_phy);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
