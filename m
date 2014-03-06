From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 04/13] phy: ti-pipe3: cleanup clock handling
Date: Thu, 6 Mar 2014 16:22:56 +0200
Message-ID: <1394115785-28301-5-git-send-email-rogerq@ti.com>
References: <1394115785-28301-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394115785-28301-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.comg, tony@atomide.com, balbi@ti.com
Cc: george.cherian@ti.com, balajitk@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-ide@vger.kernel.org, rogerq@ti.com, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

As this driver is no longer USB specific, use generic clock names.
- Use 'wkupclk', 'sysclk' and 'refclk' clock-names. Update DT binding i=
nfo.
- Fix PLL_SD_SHIFT from 9 to 10
- Don't separate prepare/unprepare clock from enable/disable. This
ensures optimal power savings.

Update omap5 usb3_phy device tree node.

CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 12 ++++++
 arch/arm/boot/dts/omap5.dtsi                     |  7 ++-
 drivers/phy/phy-ti-pipe3.c                       | 55 ++++++++++++----=
--------
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documen=
tation/devicetree/bindings/phy/ti-phy.txt
index 28e674b..8d13349 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -59,6 +59,12 @@ Required properties:
    filled in "reg".
  - #phy-cells: determine the number of cells that should be given in t=
he
    phandle while referencing this phy.
+ - clocks: a list of phandles and clock-specifier pairs, one for each =
entry in
+   clock-names.
+ - clock-names: should include:
+   * "wkupclk" - wakup clock.
+   * "sysclk" - system clock.
+   * "refclk" - reference clock.
=20
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to p=
ower on
@@ -74,4 +80,10 @@ usb3phy@4a084400 {
 	reg-names =3D "phy_rx", "phy_tx", "pll_ctrl";
 	ctrl-module =3D <&omap_control_usb>;
 	#phy-cells =3D <0>;
+	clocks =3D <&usb_phy_cm_clk32k>,
+		 <&sys_clkin>,
+		 <&usb_otg_ss_refclk960m>;
+	clock-names =3D	"wkupclk",
+			"sysclk",
+			"refclk";
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 859a800..e47601a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -778,7 +778,12 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names =3D "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module =3D <&omap_control_usb3phy>;
+				clocks =3D <&usb_phy_cm_clk32k>,
+					 <&sys_clkin>,
+					 <&usb_otg_ss_refclk960m>;
+				clock-names =3D	"wkupclk",
+						"sysclk",
+						"refclk";
 				#phy-cells =3D <0>;
 			};
 		};
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index fd029b1..211703c 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -45,7 +45,7 @@
 #define	PLL_SELFREQDCO_MASK	0x0000000E
 #define	PLL_SELFREQDCO_SHIFT	0x1
 #define	PLL_SD_MASK		0x0003FC00
-#define	PLL_SD_SHIFT		0x9
+#define	PLL_SD_SHIFT		10
 #define	SET_PLL_GO		0x1
 #define	PLL_TICOPWDN		0x10000
 #define	PLL_LOCK		0x2
@@ -72,7 +72,7 @@ struct ti_pipe3 {
 	struct device		*control_dev;
 	struct clk		*wkupclk;
 	struct clk		*sys_clk;
-	struct clk		*optclk;
+	struct clk		*refclk;
 };
=20
 struct pipe3_dpll_map {
@@ -270,23 +270,21 @@ static int ti_pipe3_probe(struct platform_device =
*pdev)
=20
 	phy->dev		=3D &pdev->dev;
=20
-	phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
+	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");
 	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
+		dev_err(&pdev->dev, "unable to get wkupclk\n");
 		return PTR_ERR(phy->wkupclk);
 	}
-	clk_prepare(phy->wkupclk);
=20
-	phy->optclk =3D devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
-	if (IS_ERR(phy->optclk)) {
-		dev_err(&pdev->dev, "unable to get usb_otg_ss_refclk960m\n");
-		return PTR_ERR(phy->optclk);
+	phy->refclk =3D devm_clk_get(phy->dev, "refclk");
+	if (IS_ERR(phy->refclk)) {
+		dev_err(&pdev->dev, "unable to get refclk\n");
+		return PTR_ERR(phy->refclk);
 	}
-	clk_prepare(phy->optclk);
=20
-	phy->sys_clk =3D devm_clk_get(phy->dev, "sys_clkin");
+	phy->sys_clk =3D devm_clk_get(phy->dev, "sysclk");
 	if (IS_ERR(phy->sys_clk)) {
-		pr_err("%s: unable to get sys_clkin\n", __func__);
+		dev_err(&pdev->dev, "unable to get sysclk\n");
 		return -EINVAL;
 	}
=20
@@ -326,10 +324,6 @@ static int ti_pipe3_probe(struct platform_device *=
pdev)
=20
 static int ti_pipe3_remove(struct platform_device *pdev)
 {
-	struct ti_pipe3 *phy =3D platform_get_drvdata(pdev);
-
-	clk_unprepare(phy->wkupclk);
-	clk_unprepare(phy->optclk);
 	if (!pm_runtime_suspended(&pdev->dev))
 		pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -343,8 +337,10 @@ static int ti_pipe3_runtime_suspend(struct device =
*dev)
 {
 	struct ti_pipe3	*phy =3D dev_get_drvdata(dev);
=20
-	clk_disable(phy->wkupclk);
-	clk_disable(phy->optclk);
+	if (!IS_ERR(phy->wkupclk))
+		clk_disable_unprepare(phy->wkupclk);
+	if (!IS_ERR(phy->refclk))
+		clk_disable_unprepare(phy->refclk);
=20
 	return 0;
 }
@@ -354,22 +350,27 @@ static int ti_pipe3_runtime_resume(struct device =
*dev)
 	u32 ret =3D 0;
 	struct ti_pipe3	*phy =3D dev_get_drvdata(dev);
=20
-	ret =3D clk_enable(phy->optclk);
-	if (ret) {
-		dev_err(phy->dev, "Failed to enable optclk %d\n", ret);
-		goto err1;
+	if (!IS_ERR(phy->refclk)) {
+		ret =3D clk_prepare_enable(phy->refclk);
+		if (ret) {
+			dev_err(phy->dev, "Failed to enable refclk %d\n", ret);
+			goto err1;
+		}
 	}
=20
-	ret =3D clk_enable(phy->wkupclk);
-	if (ret) {
-		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
-		goto err2;
+	if (!IS_ERR(phy->wkupclk)) {
+		ret =3D clk_prepare_enable(phy->wkupclk);
+		if (ret) {
+			dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
+			goto err2;
+		}
 	}
=20
 	return 0;
=20
 err2:
-	clk_disable(phy->optclk);
+	if (!IS_ERR(phy->refclk))
+		clk_disable_unprepare(phy->refclk);
=20
 err1:
 	return ret;
--=20
1.8.3.2
