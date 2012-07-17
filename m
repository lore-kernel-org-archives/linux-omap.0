From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 11/11] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
Date: Tue, 17 Jul 2012 13:40:11 +0530
Message-ID: <1342512611-20529-12-git-send-email-kishon@ti.com>
References: <1342512611-20529-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342512611-20529-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

All the unnessary functions in omap-phy-internal is removed.
These functionality are now handled by omap-usb2 phy driver.

Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |  138 -------------------------------
 arch/arm/mach-omap2/twl-common.c        |    5 -
 arch/arm/mach-omap2/usb-musb.c          |    3 -
 3 files changed, 0 insertions(+), 146 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d52651a..874aecc 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -31,144 +31,6 @@
 #include <plat/usb.h>
 #include "control.h"
 
-/* OMAP control module register for UTMI PHY */
-#define CONTROL_DEV_CONF		0x300
-#define PHY_PD				0x1
-
-#define USBOTGHS_CONTROL		0x33c
-#define	AVALID				BIT(0)
-#define	BVALID				BIT(1)
-#define	VBUSVALID			BIT(2)
-#define	SESSEND				BIT(3)
-#define	IDDIG				BIT(4)
-
-static struct clk *phyclk, *clk48m, *clk32k;
-static void __iomem *ctrl_base;
-static int usbotghs_control;
-
-int omap4430_phy_init(struct device *dev)
-{
-	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
-	if (!ctrl_base) {
-		pr_err("control module ioremap failed\n");
-		return -ENOMEM;
-	}
-	/* Power down the phy */
-	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-
-	if (!dev) {
-		iounmap(ctrl_base);
-		return 0;
-	}
-
-	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
-	if (IS_ERR(phyclk)) {
-		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
-		iounmap(ctrl_base);
-		return PTR_ERR(phyclk);
-	}
-
-	clk48m = clk_get(dev, "ocp2scp_usb_phy_phy_48m");
-	if (IS_ERR(clk48m)) {
-		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_phy_48m\n");
-		clk_put(phyclk);
-		iounmap(ctrl_base);
-		return PTR_ERR(clk48m);
-	}
-
-	clk32k = clk_get(dev, "usb_phy_cm_clk32k");
-	if (IS_ERR(clk32k)) {
-		dev_err(dev, "cannot clk_get usb_phy_cm_clk32k\n");
-		clk_put(phyclk);
-		clk_put(clk48m);
-		iounmap(ctrl_base);
-		return PTR_ERR(clk32k);
-	}
-	return 0;
-}
-
-int omap4430_phy_set_clk(struct device *dev, int on)
-{
-	static int state;
-
-	if (on && !state) {
-		/* Enable the phy clocks */
-		clk_enable(phyclk);
-		clk_enable(clk48m);
-		clk_enable(clk32k);
-		state = 1;
-	} else if (state) {
-		/* Disable the phy clocks */
-		clk_disable(phyclk);
-		clk_disable(clk48m);
-		clk_disable(clk32k);
-		state = 0;
-	}
-	return 0;
-}
-
-int omap4430_phy_power(struct device *dev, int ID, int on)
-{
-	if (on) {
-		if (ID)
-			/* enable VBUS valid, IDDIG groung */
-			__raw_writel(AVALID | VBUSVALID, ctrl_base +
-							USBOTGHS_CONTROL);
-		else
-			/*
-			 * Enable VBUS Valid, AValid and IDDIG
-			 * high impedance
-			 */
-			__raw_writel(IDDIG | AVALID | VBUSVALID,
-						ctrl_base + USBOTGHS_CONTROL);
-	} else {
-		/* Enable session END and IDIG to high impedance. */
-		__raw_writel(SESSEND | IDDIG, ctrl_base +
-					USBOTGHS_CONTROL);
-	}
-	return 0;
-}
-
-int omap4430_phy_suspend(struct device *dev, int suspend)
-{
-	if (suspend) {
-		/* Disable the clocks */
-		omap4430_phy_set_clk(dev, 0);
-		/* Power down the phy */
-		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-
-		/* save the context */
-		usbotghs_control = __raw_readl(ctrl_base + USBOTGHS_CONTROL);
-	} else {
-		/* Enable the internel phy clcoks */
-		omap4430_phy_set_clk(dev, 1);
-		/* power on the phy */
-		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
-			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-			mdelay(200);
-		}
-
-		/* restore the context */
-		__raw_writel(usbotghs_control, ctrl_base + USBOTGHS_CONTROL);
-	}
-
-	return 0;
-}
-
-int omap4430_phy_exit(struct device *dev)
-{
-	if (ctrl_base)
-		iounmap(ctrl_base);
-	if (phyclk)
-		clk_put(phyclk);
-	if (clk48m)
-		clk_put(clk48m);
-	if (clk32k)
-		clk_put(clk32k);
-
-	return 0;
-}
-
 void am35x_musb_reset(void)
 {
 	u32	regval;
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..396d189 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -250,11 +250,6 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 
 #if defined(CONFIG_ARCH_OMAP4)
 static struct twl4030_usb_data omap4_usb_pdata = {
-	.phy_init	= omap4430_phy_init,
-	.phy_exit	= omap4430_phy_exit,
-	.phy_power	= omap4430_phy_power,
-	.phy_set_clock	= omap4430_phy_set_clk,
-	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct regulator_init_data omap4_vdac_idata = {
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index c4a5768..e9b4b23 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -117,7 +117,4 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	dev->dma_mask = &musb_dmamask;
 	dev->coherent_dma_mask = musb_dmamask;
 	put_device(dev);
-
-	if (cpu_is_omap44xx())
-		omap4430_phy_init(dev);
 }
-- 
1.7.5.4
