From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: OMAP2+: Remove unused ti81xx platform init code
Date: Tue, 13 Jan 2015 15:13:51 -0800
Message-ID: <1421190837-4692-2-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29039 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbbAMXRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:17:51 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

The support for 81xx was never working in mainline, and it
will be only supported in device tree mode. Let's remove all
the remaining 81xx related platform code.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c   |  6 +-----
 arch/arm/mach-omap2/omap_phy_internal.c | 35 ---------------------------------
 arch/arm/mach-omap2/usb-musb.c          | 12 ++---------
 arch/arm/mach-omap2/usb.h               |  2 --
 4 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 644ff32..e79c80b 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3634,10 +3634,6 @@ int __init omap3xxx_clk_init(void)
 		omap_clocks_register(omap36xx_am35xx_omap3430es2plus_clks,
 				     ARRAY_SIZE(omap36xx_am35xx_omap3430es2plus_clks));
 		omap_clocks_register(omap3xxx_clks, ARRAY_SIZE(omap3xxx_clks));
-	} else if (soc_is_am33xx()) {
-		cpu_mask = RATE_IN_AM33XX;
-	} else if (cpu_is_ti814x()) {
-		cpu_mask = RATE_IN_TI814X;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
@@ -3681,7 +3677,7 @@ int __init omap3xxx_clk_init(void)
 	 * Lock DPLL5 -- here only until other device init code can
 	 * handle this
 	 */
-	if (!cpu_is_ti81xx() && (omap_rev() >= OMAP3430_REV_ES2_0))
+	if (omap_rev() >= OMAP3430_REV_ES2_0)
 		omap3_clk_lock_dpll5();
 
 	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 1a19fa0..8e90356 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -152,38 +152,3 @@ void am35x_set_mode(u8 musb_mode)
 
 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
-
-void ti81xx_musb_phy_power(u8 on)
-{
-	void __iomem *scm_base = NULL;
-	u32 usbphycfg;
-
-	scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
-	if (!scm_base) {
-		pr_err("system control module ioremap failed\n");
-		return;
-	}
-
-	usbphycfg = readl_relaxed(scm_base + USBCTRL0);
-
-	if (on) {
-		if (cpu_is_ti816x()) {
-			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
-			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
-		} else if (cpu_is_ti814x()) {
-			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
-				| USBPHY_DPINPUT | USBPHY_DMINPUT);
-			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
-				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
-		}
-	} else {
-		if (cpu_is_ti816x())
-			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
-		else if (cpu_is_ti814x())
-			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
-
-	}
-	writel_relaxed(usbphycfg, scm_base + USBCTRL0);
-
-	iounmap(scm_base);
-}
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index bc89723..e4562b2 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -82,16 +82,8 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (soc_is_am35xx()) {
-		oh_name = "am35x_otg_hs";
-		name = "musb-am35x";
-	} else if (cpu_is_ti81xx()) {
-		oh_name = "usb_otg_hs";
-		name = "musb-ti81xx";
-	} else {
-		oh_name = "usb_otg_hs";
-		name = "musb-omap2430";
-	}
+	oh_name = "usb_otg_hs";
+	name = "musb-omap2430";
 
         oh = omap_hwmod_lookup(oh_name);
         if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
index 4ba2ae7..3395365 100644
--- a/arch/arm/mach-omap2/usb.h
+++ b/arch/arm/mach-omap2/usb.h
@@ -68,5 +68,3 @@ extern void am35x_musb_reset(void);
 extern void am35x_musb_phy_power(u8 on);
 extern void am35x_musb_clear_irq(void);
 extern void am35x_set_mode(u8 musb_mode);
-extern void ti81xx_musb_phy_power(u8 on);
-
-- 
2.1.4

