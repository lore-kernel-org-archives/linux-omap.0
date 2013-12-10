From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC 4/4] phy-exynos-usb3: Fine tune LOS levels for exynos5420
Date: Tue, 10 Dec 2013 16:25:26 +0530
Message-ID: <1386672926-26885-5-git-send-email-gautam.vivek@samsung.com>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, jg1.han@samsung.com, jwerner@chromium.org
List-Id: linux-omap@vger.kernel.org

Adding phy tune callback, which facilitates tuning USB 3.0 PHY
present on Exynos5420.
Basically, Exynos5420 has 28nm PHY for which Loss-of-Signal (LOS)
Detector Threshold Level should be controlled for Super-Speed
operations. We are using CR_port for this purpose to send
required data to override the LOS values.

On testing with USB 3.0 devices on USB 3.0 port present on
SMDK5420, should see following message:
usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd

and without this patch, should see below shown message:
usb 2-1: new high-speed USB device number 2 using xhci-hcd

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/phy/phy-exynos5-usb3.c |  107 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/drivers/phy/phy-exynos5-usb3.c b/drivers/phy/phy-exynos5-usb3.c
index 2bafc9d..669f998 100644
--- a/drivers/phy/phy-exynos5-usb3.c
+++ b/drivers/phy/phy-exynos5-usb3.c
@@ -84,8 +84,20 @@
 #define PHYCLKRST_COMMONONN			(0x1 << 0)
 
 #define EXYNOS5_DRD_PHYREG0			(0x14)
+
+#define EXYNOS5_DRD_PHYREG0_SSC_REF_CLK_SEL	(1 << 21)
+#define EXYNOS5_DRD_PHYREG0_SSC_RANGE		(1 << 20)
+#define EXYNOS5_DRD_PHYREG0_CR_WRITE		(1 << 19)
+#define EXYNOS5_DRD_PHYREG0_CR_READ		(1 << 18)
+#define EXYNOS5_DRD_PHYREG0_CR_DATA_IN(_x)	((_x) << 2)
+#define EXYNOS5_DRD_PHYREG0_CR_CAP_DATA		(1 << 1)
+#define EXYNOS5_DRD_PHYREG0_CR_CAP_ADDR		(1 << 0)
+
 #define EXYNOS5_DRD_PHYREG1			(0x18)
 
+#define EXYNOS5_DRD_PHYREG1_CR_DATA_OUT(_x)	((_x) << 1)
+#define EXYNOS5_DRD_PHYREG1_CR_ACK		(1 << 0)
+
 #define EXYNOS5_DRD_PHYPARAM0			(0x1c)
 
 #define PHYPARAM0_REF_USE_PAD			(0x1 << 31)
@@ -113,6 +125,18 @@
 #define EXYNOS5_DRD_PHYRESUME			(0x34)
 #define EXYNOS5_DRD_LINKPORT			(0x44)
 
+/* USB 3.0 DRD PHY SS Function Control Reg; accessed by CR_PORT */
+#define EXYNOS5_DRD_PHYSS_LOSLEVEL_OVRD_IN		(0x15)
+
+#define LOSLEVEL_OVRD_IN_LOS_BIAS_5420			(0x5 << 13)
+#define LOSLEVEL_OVRD_IN_LOS_BIAS_DEFAULT		(0x0 << 13)
+#define LOSLEVEL_OVRD_IN_EN				(0x1 << 10)
+#define LOSLEVEL_OVRD_IN_LOS_LEVEL_DEFAULT		(0x9 << 0)
+
+#define EXYNOS5_DRD_PHYSS_TX_VBOOSTLEVEL_OVRD_IN	(0x12)
+#define TX_VBOOSTLEVEL_OVRD_IN_VBOOST_5420		(0x5 << 13)
+#define TX_VBOOSTLEVEL_OVRD_IN_VBOOST_DEFAULT		(0x4 << 13)
+
 /* Power isolation defined in power management unit */
 #define EXYNOS5_USB3DRD_PHY_PMU_REG_OFFSET	(0x704)
 #define EXYNOS5_USB3DRD_PMU_ISOL		(1 << 0)
@@ -124,6 +148,7 @@ struct usb3phy_config {
 	bool has_usb30_sclk;
 	u32 reg_pmu_offset;
 	bool has_multi_controller;
+	bool need_crport_tuning;
 };
 
 struct usb3phy_driver {
@@ -235,6 +260,53 @@ static u32 exynos5_usb3phy_set_refclk(struct usb3phy_driver *drv)
 	return reg;
 }
 
+static void crport_handshake(struct usb3phy_driver *drv, u32 val, u32 cmd)
+{
+	u32 usec = 100;
+	u32 result;
+
+	writel(val | cmd, drv->reg_phy + EXYNOS5_DRD_PHYREG0);
+
+	do {
+		result = readl(drv->reg_phy + EXYNOS5_DRD_PHYREG1);
+		if (result & EXYNOS5_DRD_PHYREG1_CR_ACK)
+			break;
+
+		udelay(1);
+	} while (usec-- > 0);
+
+	if (!usec)
+		dev_err(drv->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
+
+	usec = 100;
+
+	writel(val, drv->reg_phy + EXYNOS5_DRD_PHYREG0);
+
+	do {
+		result = readl(drv->reg_phy + EXYNOS5_DRD_PHYREG1);
+		if (!(result & EXYNOS5_DRD_PHYREG1_CR_ACK))
+			break;
+
+		udelay(1);
+	} while (usec-- > 0);
+
+	if (!usec)
+		dev_err(drv->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
+}
+
+static void crport_ctrl_write(struct usb3phy_driver *drv, u32 addr, u32 data)
+{
+	/* Write Address */
+	crport_handshake(drv, EXYNOS5_DRD_PHYREG0_CR_DATA_IN(addr),
+				EXYNOS5_DRD_PHYREG0_CR_CAP_ADDR);
+
+	/* Write Data */
+	crport_handshake(drv, EXYNOS5_DRD_PHYREG0_CR_DATA_IN(data),
+				EXYNOS5_DRD_PHYREG0_CR_CAP_DATA);
+	crport_handshake(drv, EXYNOS5_DRD_PHYREG0_CR_DATA_IN(data),
+				EXYNOS5_DRD_PHYREG0_CR_WRITE);
+}
+
 static int exynos5_usb3phy_init(struct phy *phy)
 {
 	struct usb3phy_driver *drv = phy_get_drvdata(phy);
@@ -379,11 +451,44 @@ static int exynos5_usb3phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int exynos5_usb3phy_tune(struct phy *phy)
+{
+	struct usb3phy_driver *drv = phy_get_drvdata(phy);
+
+	if (drv->cfg->need_crport_tuning) {
+		u32 temp;
+		/*
+		 * Change los_bias to (0x5) for 28nm PHY from a
+		 * default value (0x0); los_level is set as default
+		 * (0x9) as also reflected in los_level[30:26] bits
+		 * of PHYPARAM0 register.
+		 */
+		temp = LOSLEVEL_OVRD_IN_LOS_BIAS_5420 |
+			LOSLEVEL_OVRD_IN_EN |
+			LOSLEVEL_OVRD_IN_LOS_LEVEL_DEFAULT;
+		crport_ctrl_write(drv,
+				  EXYNOS5_DRD_PHYSS_LOSLEVEL_OVRD_IN,
+				  temp);
+
+		/*
+		 * Set tx_vboost_lvl to (0x5) for 28nm PHY Tuning,
+		 * to raise Tx signal level from its default value of (0x4)
+		 */
+		temp = TX_VBOOSTLEVEL_OVRD_IN_VBOOST_5420;
+		crport_ctrl_write(drv,
+				  EXYNOS5_DRD_PHYSS_TX_VBOOSTLEVEL_OVRD_IN,
+				  temp);
+	}
+
+	return 0;
+}
+
 static struct phy_ops exynos5_usb3phy_ops = {
 	.init		= exynos5_usb3phy_init,
 	.exit		= exynos5_usb3phy_exit,
 	.power_on	= exynos5_usb3phy_power_on,
 	.power_off	= exynos5_usb3phy_power_off,
+	.tune		= exynos5_usb3phy_tune,
 	.owner		= THIS_MODULE,
 };
 
@@ -391,12 +496,14 @@ const struct usb3phy_config exynos5420_usb3phy_cfg = {
 	.has_usb30_sclk		= true,
 	.reg_pmu_offset		= EXYNOS5_USB3DRD_PHY_PMU_REG_OFFSET,
 	.has_multi_controller	= true,
+	.need_crport_tuning	= true,
 };
 
 const struct usb3phy_config exynos5250_usb3phy_cfg = {
 	.has_usb30_sclk		= false,
 	.reg_pmu_offset		= EXYNOS5_USB3DRD_PHY_PMU_REG_OFFSET,
 	.has_multi_controller	= false,
+	.need_crport_tuning	= false,
 };
 
 static const struct of_device_id exynos5_usb3phy_of_match[] = {
-- 
1.7.6.5
