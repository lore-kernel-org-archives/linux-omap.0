From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH usb-next v10 6/8] usb: host: ehci-platform: remove custom USB
 PHY handling
Date: Sun, 18 Feb 2018 19:45:02 +0100
Message-ID: <20180218184504.3331-7-martin.blumenstingl@googlemail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180218184504.3331-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The new PHY wrapper is now wired up in the core HCD code. This means
that PHYs are now controlled (initialized, enabled, disabled, exited)
without requiring any host-driver specific code.
Remove the custom USB PHY handling from the ehci-platform driver as the
core HCD code now handles this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 drivers/usb/host/ehci-platform.c | 55 +++-------------------------------------
 1 file changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b91eea8c73ae..4c306fb6b069 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -27,7 +27,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/usb.h>
@@ -44,8 +43,6 @@
 struct ehci_platform_priv {
 	struct clk *clks[EHCI_MAX_CLKS];
 	struct reset_control *rsts;
-	struct phy **phys;
-	int num_phys;
 	bool reset_on_resume;
 };
 
@@ -80,7 +77,7 @@ static int ehci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
-	int clk, ret, phy_num;
+	int clk, ret;
 
 	for (clk = 0; clk < EHCI_MAX_CLKS && priv->clks[clk]; clk++) {
 		ret = clk_prepare_enable(priv->clks[clk]);
@@ -88,24 +85,8 @@ static int ehci_platform_power_on(struct platform_device *dev)
 			goto err_disable_clks;
 	}
 
-	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-		ret = phy_init(priv->phys[phy_num]);
-		if (ret)
-			goto err_exit_phy;
-		ret = phy_power_on(priv->phys[phy_num]);
-		if (ret) {
-			phy_exit(priv->phys[phy_num]);
-			goto err_exit_phy;
-		}
-	}
-
 	return 0;
 
-err_exit_phy:
-	while (--phy_num >= 0) {
-		phy_power_off(priv->phys[phy_num]);
-		phy_exit(priv->phys[phy_num]);
-	}
 err_disable_clks:
 	while (--clk >= 0)
 		clk_disable_unprepare(priv->clks[clk]);
@@ -117,12 +98,7 @@ static void ehci_platform_power_off(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
-	int clk, phy_num;
-
-	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-		phy_power_off(priv->phys[phy_num]);
-		phy_exit(priv->phys[phy_num]);
-	}
+	int clk;
 
 	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
 		if (priv->clks[clk])
@@ -149,7 +125,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
-	int err, irq, phy_num, clk = 0;
+	int err, irq, clk = 0;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -202,29 +178,6 @@ static int ehci_platform_probe(struct platform_device *dev)
 					  "has-transaction-translator"))
 			hcd->has_tt = 1;
 
-		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
-				"phys", "#phy-cells");
-
-		if (priv->num_phys > 0) {
-			priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
-					    sizeof(struct phy *), GFP_KERNEL);
-			if (!priv->phys)
-				return -ENOMEM;
-		} else
-			priv->num_phys = 0;
-
-		for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-			priv->phys[phy_num] = devm_of_phy_get_by_index(
-					&dev->dev, dev->dev.of_node, phy_num);
-			if (IS_ERR(priv->phys[phy_num])) {
-				err = PTR_ERR(priv->phys[phy_num]);
-					goto err_put_hcd;
-			} else {
-				/* Avoiding phy_get() in usb_add_hcd() */
-				hcd->skip_phy_initialization = 1;
-			}
-		}
-
 		for (clk = 0; clk < EHCI_MAX_CLKS; clk++) {
 			priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
 			if (IS_ERR(priv->clks[clk])) {
@@ -306,7 +259,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 err_put_clks:
 	while (--clk >= 0)
 		clk_put(priv->clks[clk]);
-err_put_hcd:
+
 	if (pdata == &ehci_platform_defaults)
 		dev->dev.platform_data = NULL;
 
-- 
2.16.1
