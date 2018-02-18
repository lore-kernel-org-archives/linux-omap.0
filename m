From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH usb-next v10 7/8] usb: host: ohci-platform: remove custom USB
 PHY handling
Date: Sun, 18 Feb 2018 19:45:03 +0100
Message-ID: <20180218184504.3331-8-martin.blumenstingl@googlemail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-usb@vger.kernel.org, mathias.nyman@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Peter.Chen@nxp.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, narmstrong@baylibre.com, yixun.lan@amlogic.com, robh+dt@kernel.org, jonathanh@nvidia.com, linux@prisktech.co.nz, matthias.bgg@gmail.com, thierry.reding@gmail.com, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The new PHY wrapper is now wired up in the core HCD code. This means
that PHYs are now controlled (initialized, enabled, disabled, exited)
without requiring any host-driver specific code.
Remove the custom USB PHY handling from the ohci-platform driver as the
core HCD code now handles this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-platform.c | 56 ++++------------------------------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 62ef36a9333f..65a1c3fdc88c 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/err.h>
-#include <linux/phy/phy.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -38,8 +38,6 @@
 struct ohci_platform_priv {
 	struct clk *clks[OHCI_MAX_CLKS];
 	struct reset_control *resets;
-	struct phy **phys;
-	int num_phys;
 };
 
 static const char hcd_name[] = "ohci-platform";
@@ -48,7 +46,7 @@ static int ohci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
-	int clk, ret, phy_num;
+	int clk, ret;
 
 	for (clk = 0; clk < OHCI_MAX_CLKS && priv->clks[clk]; clk++) {
 		ret = clk_prepare_enable(priv->clks[clk]);
@@ -56,24 +54,8 @@ static int ohci_platform_power_on(struct platform_device *dev)
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
@@ -85,12 +67,7 @@ static void ohci_platform_power_off(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
-	int clk, phy_num;
-
-	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-		phy_power_off(priv->phys[phy_num]);
-		phy_exit(priv->phys[phy_num]);
-	}
+	int clk;
 
 	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
 		if (priv->clks[clk])
@@ -117,7 +94,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ohci_platform_priv *priv;
 	struct ohci_hcd *ohci;
-	int err, irq, phy_num, clk = 0;
+	int err, irq, clk = 0;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -169,29 +146,6 @@ static int ohci_platform_probe(struct platform_device *dev)
 		of_property_read_u32(dev->dev.of_node, "num-ports",
 				     &ohci->num_ports);
 
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
-				goto err_put_hcd;
-			} else {
-				/* Avoiding phy_get() in usb_add_hcd() */
-				hcd->skip_phy_initialization = 1;
-			}
-		}
-
 		for (clk = 0; clk < OHCI_MAX_CLKS; clk++) {
 			priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
 			if (IS_ERR(priv->clks[clk])) {
@@ -277,7 +231,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 err_put_clks:
 	while (--clk >= 0)
 		clk_put(priv->clks[clk]);
-err_put_hcd:
+
 	if (pdata == &ohci_platform_defaults)
 		dev->dev.platform_data = NULL;
 
-- 
2.16.1
