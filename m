From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 2/3] usb: ehci-exynos: Make provision for vdd regulators
Date: Mon, 21 Apr 2014 17:46:43 +0530
Message-ID: <1398082604-3013-2-git-send-email-gautam.vivek@samsung.com>
References: <1398082604-3013-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398082604-3013-1-git-send-email-gautam.vivek@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, gregkh@linuxfoundation.org, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, balbi@ti.com, stern@rowland.harvard.edu, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Facilitate getting required 3.3V and 1.0V VDD supply for
EHCI controller on Exynos.

With patches for regulators' nodes merged in 3.15:
c8c253f ARM: dts: Add regulator entries to smdk5420
275dcd2 ARM: dts: add max77686 pmic node for smdk5250,

certain perripherals will now need to ensure that,
they request VDD regulators in their drivers, and enable
them so as to make them working.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Jingoo Han <jg1.han@samsung.com>
---

Based on 'usb-next' branch of Greg's usb tree.

 drivers/usb/host/ehci-exynos.c |   47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index d1d8c47..a3ca8cc 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/samsung_usb_phy.h>
 #include <linux/usb.h>
@@ -46,6 +47,8 @@ struct exynos_ehci_hcd {
 	struct clk *clk;
 	struct usb_phy *phy;
 	struct usb_otg *otg;
+	struct regulator *vdd33;
+	struct regulator *vdd10;
 };
 
 #define to_exynos_ehci(hcd) (struct exynos_ehci_hcd *)(hcd_to_ehci(hcd)->priv)
@@ -112,6 +115,28 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 		exynos_ehci->otg = phy->otg;
 	}
 
+	exynos_ehci->vdd33 = devm_regulator_get(&pdev->dev, "vdd33");
+	if (IS_ERR(exynos_ehci->vdd33)) {
+		err = PTR_ERR(exynos_ehci->vdd33);
+		goto fail_regulator1;
+	}
+	err = regulator_enable(exynos_ehci->vdd33);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable VDD33 supply\n");
+		goto fail_regulator1;
+	}
+
+	exynos_ehci->vdd10 = devm_regulator_get(&pdev->dev, "vdd10");
+	if (IS_ERR(exynos_ehci->vdd10)) {
+		err = PTR_ERR(exynos_ehci->vdd10);
+		goto fail_regulator2;
+	}
+	err = regulator_enable(exynos_ehci->vdd10);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable VDD10 supply\n");
+		goto fail_regulator2;
+	}
+
 skip_phy:
 
 	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
@@ -178,6 +203,10 @@ fail_add_hcd:
 fail_io:
 	clk_disable_unprepare(exynos_ehci->clk);
 fail_clk:
+	regulator_disable(exynos_ehci->vdd10);
+fail_regulator2:
+	regulator_disable(exynos_ehci->vdd33);
+fail_regulator1:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -197,6 +226,9 @@ static int exynos_ehci_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(exynos_ehci->clk);
 
+	regulator_disable(exynos_ehci->vdd10);
+	regulator_disable(exynos_ehci->vdd33);
+
 	usb_put_hcd(hcd);
 
 	return 0;
@@ -221,6 +253,9 @@ static int exynos_ehci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ehci->clk);
 
+	regulator_disable(exynos_ehci->vdd10);
+	regulator_disable(exynos_ehci->vdd33);
+
 	return rc;
 }
 
@@ -228,6 +263,18 @@ static int exynos_ehci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
+	int ret;
+
+	ret = regulator_enable(exynos_ehci->vdd33);
+	if (ret) {
+		dev_err(dev, "Failed to enable VDD33 supply\n");
+		return ret;
+	}
+	ret = regulator_enable(exynos_ehci->vdd10);
+	if (ret) {
+		dev_err(dev, "Failed to enable VDD10 supply\n");
+		return ret;
+	}
 
 	clk_prepare_enable(exynos_ehci->clk);
 
-- 
1.7.10.4
