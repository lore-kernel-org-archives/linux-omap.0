From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 08/10] usb: phy: samsung: Add support for external reference
 clock
Date: Sat, 02 Mar 2013 18:53:09 +0530
Message-ID: <1362230590-20960-9-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

The PHY controller can choose between ref_pad_clk (XusbXTI-external PLL),
or EXTREFCLK (XXTI-internal clock crystal) to generate the required clock.
Adding the provision for ref_pad_clk here.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/samsung-usb3phy.c |   46 ++++++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/samsung-usb3phy.c b/drivers/usb/phy/samsung-usb3phy.c
index 7594cc7..46dd97c 100644
--- a/drivers/usb/phy/samsung-usb3phy.c
+++ b/drivers/usb/phy/samsung-usb3phy.c
@@ -33,7 +33,7 @@
 /*
  * Sets the phy clk as EXTREFCLK (XXTI) which is internal clock from clock core.
  */
-static u32 samsung_usb3phy_set_refclk(struct samsung_usbphy *sphy)
+static u32 samsung_usb3phy_set_refclk_int(struct samsung_usbphy *sphy)
 {
 	u32 reg;
 	u32 refclk;
@@ -66,7 +66,22 @@ static u32 samsung_usb3phy_set_refclk(struct samsung_usbphy *sphy)
 	return reg;
 }
 
-static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
+/*
+ * Sets the phy clk as ref_pad_clk (XusbXTI) which is clock from external PLL.
+ */
+static u32 samsung_usb3phy_set_refclk_ext(void)
+{
+	u32 reg;
+
+	reg = PHYCLKRST_REFCLKSEL_PAD_REFCLK |
+		PHYCLKRST_FSEL_PAD_100MHZ |
+		PHYCLKRST_MPLL_MULTIPLIER_100MHZ_REF;
+
+	return reg;
+}
+
+static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy,
+							bool use_ext_clk)
 {
 	void __iomem *regs = sphy->regs;
 	u32 phyparam0;
@@ -81,7 +96,10 @@ static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
 
 	phyparam0 = readl(regs + EXYNOS5_DRD_PHYPARAM0);
 	/* Select PHY CLK source */
-	phyparam0 &= ~PHYPARAM0_REF_USE_PAD;
+	if (use_ext_clk)
+		phyparam0 |= PHYPARAM0_REF_USE_PAD;
+	else
+		phyparam0 &= ~PHYPARAM0_REF_USE_PAD;
 	/* Set Loss-of-Signal Detector sensitivity */
 	phyparam0 &= ~PHYPARAM0_REF_LOSLEVEL_MASK;
 	phyparam0 |= PHYPARAM0_REF_LOSLEVEL;
@@ -116,7 +134,10 @@ static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
 	/* UTMI Power Control */
 	writel(PHYUTMI_OTGDISABLE, regs + EXYNOS5_DRD_PHYUTMI);
 
-	phyclkrst = samsung_usb3phy_set_refclk(sphy);
+	if (use_ext_clk)
+		phyclkrst = samsung_usb3phy_set_refclk_ext();
+	else
+		phyclkrst = samsung_usb3phy_set_refclk_int(sphy);
 
 	phyclkrst |= PHYCLKRST_PORTRESET |
 			/* Digital power supply in normal operating mode */
@@ -164,7 +185,7 @@ static void samsung_exynos5_usb3phy_disable(struct samsung_usbphy *sphy)
 	writel(phytest, regs + EXYNOS5_DRD_PHYTEST);
 }
 
-static int samsung_usb3phy_init(struct usb_phy *phy)
+static int samsung_exynos5_usb3phy_init(struct usb_phy *phy, bool use_ext_clk)
 {
 	struct samsung_usbphy *sphy;
 	unsigned long flags;
@@ -188,7 +209,7 @@ static int samsung_usb3phy_init(struct usb_phy *phy)
 	samsung_usbphy_set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
-	samsung_exynos5_usb3phy_enable(sphy);
+	samsung_exynos5_usb3phy_enable(sphy, use_ext_clk);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -199,6 +220,19 @@ static int samsung_usb3phy_init(struct usb_phy *phy)
 }
 
 /*
+ * The function passed to the usb driver for phy initialization
+ */
+static int samsung_usb3phy_init(struct usb_phy *phy)
+{
+	/*
+	 * We start with using PHY refclk from external PLL,
+	 * once runtime suspend for the device is called this
+	 * will change to internal core clock
+	 */
+	return samsung_exynos5_usb3phy_init(phy, true);
+}
+
+/*
  * The function passed to the usb driver for phy shutdown
  */
 static void samsung_usb3phy_shutdown(struct usb_phy *phy)
-- 
1.7.6.5
