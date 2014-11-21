From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/11] dwc3: exynos: Add provision for suspend clock
Date: Fri, 21 Nov 2014 19:05:46 +0530
Message-ID: <1416576954-11997-4-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DWC3 controller on Exynos SoC series have separate control for
suspend clock which replaces pipe3_rx_pclk as clock source to
a small part of DWC3 core that operates when SS PHY is in its
lowest power state (P3) in states SS.disabled and U3.

Suggested-by: Anton Tikhomirov <av.tikhomirov-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-exynos.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 7109de7..af15ab3 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -35,6 +35,8 @@ struct dwc3_exynos {
 	struct device		*dev;
 
 	struct clk		*clk;
+	struct clk		*susp_clk;
+
 	struct regulator	*vdd33;
 	struct regulator	*vdd10;
 };
@@ -141,6 +143,13 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(exynos->clk);
 
+	exynos->susp_clk = devm_clk_get(dev, "usbdrd30_susp_clk");
+	if (IS_ERR(exynos->susp_clk)) {
+		dev_dbg(dev, "no suspend clk specified\n");
+		exynos->susp_clk = NULL;
+	}
+	clk_prepare_enable(exynos->susp_clk);
+
 	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
 	if (IS_ERR(exynos->vdd33)) {
 		ret = PTR_ERR(exynos->vdd33);
@@ -182,6 +191,7 @@ err4:
 err3:
 	regulator_disable(exynos->vdd33);
 err2:
+	clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 	return ret;
 }
@@ -194,6 +204,7 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
+	clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 
 	regulator_disable(exynos->vdd33);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
