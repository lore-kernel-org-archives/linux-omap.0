From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 24/59] omap: namespace cleanup to arch/arm/plat-omap/usb.c
Date: Wed, 12 Nov 2008 00:56:43 +0200
Message-ID: <1226444238-14614-25-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40059 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYKKXBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:18 -0500
In-Reply-To: <1226444238-14614-24-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/usb.c |   82 +++++++++++++++++++++++-----------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 67ca1e2..d7fc013 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -159,9 +159,9 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 			u32 l;
 
 			/* pulldown D+/D- */
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l = __raw_readl(USB_TRANSCEIVER_CTRL);
 			l &= ~(3 << 1);
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
+			__raw_writel(l, USB_TRANSCEIVER_CTRL);
 		}
 		return 0;
 	}
@@ -191,11 +191,11 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 		 *  - OTG support on this port not yet written
 		 */
 
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l = __raw_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~(7 << 4);
 		if (!is_device)
 			l |= (3 << 1);
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		__raw_writel(l, USB_TRANSCEIVER_CTRL);
 
 		return 3 << 16;
 	}
@@ -228,9 +228,9 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	if (cpu_class_is_omap1() && nwires != 6) {
 		u32 l;
 
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l = __raw_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~CONF_USB2_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		__raw_writel(l, USB_TRANSCEIVER_CTRL);
 	}
 
 	switch (nwires) {
@@ -255,9 +255,9 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 
 			omap_cfg_reg(AA9_USB0_VP);
 			omap_cfg_reg(R9_USB0_VM);
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l = __raw_readl(USB_TRANSCEIVER_CTRL);
 			l |= CONF_USB2_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
+			__raw_writel(l, USB_TRANSCEIVER_CTRL);
 		}
 		break;
 	default:
@@ -274,9 +274,9 @@ static u32 __init omap_usb1_init(unsigned nwires)
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
 		u32 l;
 
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l = __raw_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~CONF_USB1_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		__raw_writel(l, USB_TRANSCEIVER_CTRL);
 	}
 	if (cpu_is_omap24xx())
 		omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
@@ -341,9 +341,9 @@ static u32 __init omap_usb1_init(unsigned nwires)
 		if (!cpu_is_omap15xx()) {
 			u32 l;
 
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l = __raw_readl(USB_TRANSCEIVER_CTRL);
 			l |= CONF_USB1_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
+			__raw_writel(l, USB_TRANSCEIVER_CTRL);
 		}
 		break;
 	default:
@@ -370,9 +370,9 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
 		u32 l;
 
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
+		l = __raw_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~CONF_USB2_UNI_R;
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		__raw_writel(l, USB_TRANSCEIVER_CTRL);
 	}
 
 	/* external transceiver */
@@ -446,9 +446,9 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 
 			omap_cfg_reg(AA9_USB2_VP);
 			omap_cfg_reg(R9_USB2_VM);
-			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l = __raw_readl(USB_TRANSCEIVER_CTRL);
 			l |= CONF_USB2_UNI_R;
-			omap_writel(l, USB_TRANSCEIVER_CTRL);
+			__raw_writel(l, USB_TRANSCEIVER_CTRL);
 		}
 		break;
 	default:
@@ -588,11 +588,11 @@ omap_otg_init(struct omap_usb_config *config)
 
 	/* NOTE:  no bus or clock setup (yet?) */
 
-	syscon = omap_readl(OTG_SYSCON_1) & 0xffff;
+	syscon = __raw_readl(OTG_SYSCON_1) & 0xffff;
 	if (!(syscon & OTG_RESET_DONE))
 		pr_debug("USB resets not complete?\n");
 
-	//omap_writew(0, OTG_IRQ_EN);
+	//__raw_writew(0, OTG_IRQ_EN);
 
 	/* pin muxing and transceiver pinouts */
 	if (config->pins[0] > 2)	/* alt pingroup 2 */
@@ -600,8 +600,8 @@ omap_otg_init(struct omap_usb_config *config)
 	syscon |= omap_usb0_init(config->pins[0], is_usb0_device(config));
 	syscon |= omap_usb1_init(config->pins[1]);
 	syscon |= omap_usb2_init(config->pins[2], alt_pingroup);
-	pr_debug("OTG_SYSCON_1 = %08x\n", omap_readl(OTG_SYSCON_1));
-	omap_writel(syscon, OTG_SYSCON_1);
+	pr_debug("OTG_SYSCON_1 = %08x\n", __raw_readl(OTG_SYSCON_1));
+	__raw_writel(syscon, OTG_SYSCON_1);
 
 	syscon = config->hmc_mode;
 	syscon |= USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
@@ -611,9 +611,9 @@ omap_otg_init(struct omap_usb_config *config)
 #endif
 	if (cpu_class_is_omap1())
 		pr_debug("USB_TRANSCEIVER_CTRL = %03x\n",
-			 omap_readl(USB_TRANSCEIVER_CTRL));
-	pr_debug("OTG_SYSCON_2 = %08x\n", omap_readl(OTG_SYSCON_2));
-	omap_writel(syscon, OTG_SYSCON_2);
+			 __raw_readl(USB_TRANSCEIVER_CTRL));
+	pr_debug("OTG_SYSCON_2 = %08x\n", __raw_readl(OTG_SYSCON_2));
+	__raw_writel(syscon, OTG_SYSCON_2);
 
 	printk("USB: hmc %d", config->hmc_mode);
 	if (!alt_pingroup)
@@ -633,16 +633,16 @@ omap_otg_init(struct omap_usb_config *config)
 		u16 w;
 
 		/* leave USB clocks/controllers off until needed */
-		w = omap_readw(ULPD_SOFT_REQ);
+		w = __raw_readw(ULPD_SOFT_REQ);
 		w &= ~SOFT_USB_CLK_REQ;
-		omap_writew(w, ULPD_SOFT_REQ);
+		__raw_writew(w, ULPD_SOFT_REQ);
 
-		w = omap_readw(ULPD_CLOCK_CTRL);
+		w = __raw_readw(ULPD_CLOCK_CTRL);
 		w &= ~USB_MCLK_EN;
 		w |= DIS_USB_PVCI_CLK;
-		omap_writew(w, ULPD_CLOCK_CTRL);
+		__raw_writew(w, ULPD_CLOCK_CTRL);
 	}
-	syscon = omap_readl(OTG_SYSCON_1);
+	syscon = __raw_readl(OTG_SYSCON_1);
 	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
 
 #ifdef	CONFIG_USB_GADGET_OMAP
@@ -679,8 +679,8 @@ omap_otg_init(struct omap_usb_config *config)
 			pr_debug("can't register OTG device, %d\n", status);
 	}
 #endif
-	pr_debug("OTG_SYSCON_1 = %08x\n", omap_readl(OTG_SYSCON_1));
-	omap_writel(syscon, OTG_SYSCON_1);
+	pr_debug("OTG_SYSCON_1 = %08x\n", __raw_readl(OTG_SYSCON_1));
+	__raw_writel(syscon, OTG_SYSCON_1);
 
 	status = 0;
 }
@@ -711,9 +711,9 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	omap_usb1_init(config->pins[1]);
 	omap_usb2_init(config->pins[2], 0);
 
-	val = omap_readl(MOD_CONF_CTRL_0) & ~(0x3f << 1);
+	val = __raw_readl(MOD_CONF_CTRL_0) & ~(0x3f << 1);
 	val |= (config->hmc_mode << 1);
-	omap_writel(val, MOD_CONF_CTRL_0);
+	__raw_writel(val, MOD_CONF_CTRL_0);
 
 	printk("USB: hmc %d", config->hmc_mode);
 	if (config->pins[0])
@@ -726,22 +726,22 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	printk("\n");
 
 	/* use DPLL for 48 MHz function clock */
-	pr_debug("APLL %04x DPLL %04x REQ %04x\n", omap_readw(ULPD_APLL_CTRL),
-			omap_readw(ULPD_DPLL_CTRL), omap_readw(ULPD_SOFT_REQ));
+	pr_debug("APLL %04x DPLL %04x REQ %04x\n", __raw_readw(ULPD_APLL_CTRL),
+			__raw_readw(ULPD_DPLL_CTRL), __raw_readw(ULPD_SOFT_REQ));
 
-	w = omap_readw(ULPD_APLL_CTRL);
+	w = __raw_readw(ULPD_APLL_CTRL);
 	w &= ~APLL_NDPLL_SWITCH;
-	omap_writew(w, ULPD_APLL_CTRL);
+	__raw_writew(w, ULPD_APLL_CTRL);
 
-	w = omap_readw(ULPD_DPLL_CTRL);
+	w = __raw_readw(ULPD_DPLL_CTRL);
 	w |= DPLL_IOB | DPLL_PLL_ENABLE;
-	omap_writew(w, ULPD_DPLL_CTRL);
+	__raw_writew(w, ULPD_DPLL_CTRL);
 
-	w = omap_readw(ULPD_SOFT_REQ);
+	w = __raw_readw(ULPD_SOFT_REQ);
 	w |= SOFT_UDC_REQ | SOFT_DPLL_REQ;
-	omap_writew(w, ULPD_SOFT_REQ);
+	__raw_writew(w, ULPD_SOFT_REQ);
 
-	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
+	while (!(__raw_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
 		cpu_relax();
 
 #ifdef	CONFIG_USB_GADGET_OMAP
-- 
1.6.0.2.307.gc427

