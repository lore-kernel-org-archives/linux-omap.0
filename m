From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] OMAP4: otg: phy: fix charger detection
Date: Thu, 5 Jul 2012 11:42:00 +0300
Message-ID: <1341477720-6771-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Charger detection feature is not correctly used
and thus makes some regressions if OTG was used in
the host mode. Charger detection takes 500 ms so
if some device is attached to the host after 500 ms
it will be suddenly resetted.

This feature is enabled by default after reset/cold boot
so always affects PHY usage. So finally this was wrongly
interpreted as "phy requires 200ms to start".
After fixing this we can safely remove uggly mdelay after
powering on the PHY.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d52651a..a13a37c 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -42,12 +42,16 @@
 #define	SESSEND				BIT(3)
 #define	IDDIG				BIT(4)
 
+#define CONTROL_USB2PHYCORE		0x620
+#define USB2PHY_DISCHGDET		BIT(30)
+
 static struct clk *phyclk, *clk48m, *clk32k;
 static void __iomem *ctrl_base;
 static int usbotghs_control;
 
 int omap4430_phy_init(struct device *dev)
 {
+	u32 usb2phycore;
 	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
 	if (!ctrl_base) {
 		pr_err("control module ioremap failed\n");
@@ -56,6 +60,11 @@ int omap4430_phy_init(struct device *dev)
 	/* Power down the phy */
 	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
 
+	/* Disable charger detection by default */
+	usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
+	usb2phycore |= USB2PHY_DISCHGDET;
+	omap4_ctrl_pad_writel(usb2phycore, CONTROL_USB2PHYCORE);
+
 	if (!dev) {
 		iounmap(ctrl_base);
 		return 0;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
