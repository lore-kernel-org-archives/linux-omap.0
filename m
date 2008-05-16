From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] musb_hdrc: Change __REG access to omap_read/write for multi-boot
Date: Fri, 16 May 2008 14:07:55 -0700
Message-ID: <1210972076-23911-5-git-send-email-tony@atomide.com>
References: <1210972076-23911-1-git-send-email-tony@atomide.com>
 <1210972076-23911-2-git-send-email-tony@atomide.com>
 <1210972076-23911-3-git-send-email-tony@atomide.com>
 <1210972076-23911-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57541 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395AbYEPVIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 17:08:05 -0400
In-Reply-To: <1210972076-23911-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, Tony Lindgren <tony@atomide.com>

Change __REG access to omap_read/write for multi-boot

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/omap2430.c |   48 ++++++++++++++++++++++++++++++------------
 drivers/usb/musb/omap2430.h |   14 ++++++------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 36f1739..472c304 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -216,6 +216,7 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 int __init musb_platform_init(struct musb *musb)
 {
 	struct otg_transceiver *xceiv = otg_get_transceiver();
+	u32 l;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
@@ -224,20 +225,25 @@ int __init musb_platform_init(struct musb *musb)
 	musb->xceiv = *xceiv;
 	musb_platform_resume(musb);
 
-	OTG_SYSCONFIG_REG &= ~ENABLEWAKEUP;	/* disable wakeup */
-	OTG_SYSCONFIG_REG &= ~NOSTDBY;		/* remove possible nostdby */
-	OTG_SYSCONFIG_REG |= SMARTSTDBY;	/* enable smart standby */
-	OTG_SYSCONFIG_REG &= ~AUTOIDLE;		/* disable auto idle */
-	OTG_SYSCONFIG_REG &= ~NOIDLE;		/* remove possible noidle */
-	OTG_SYSCONFIG_REG |= SMARTIDLE;		/* enable smart idle */
-	OTG_SYSCONFIG_REG |= AUTOIDLE;		/* enable auto idle */
+	l = omap_readl(OTG_SYSCONFIG);
+	l &= ~ENABLEWAKEUP;	/* disable wakeup */
+	l &= ~NOSTDBY;		/* remove possible nostdby */
+	l |= SMARTSTDBY;	/* enable smart standby */
+	l &= ~AUTOIDLE;		/* disable auto idle */
+	l &= ~NOIDLE;		/* remove possible noidle */
+	l |= SMARTIDLE;		/* enable smart idle */
+	l |= AUTOIDLE;		/* enable auto idle */
+	omap_writel(l, OTG_SYSCONFIG);
 
-	OTG_INTERFSEL_REG |= ULPI_12PIN;
+	l = omap_readl(OTG_INTERFSEL);
+	l |= ULPI_12PIN;
+	omap_writel(l, OTG_INTERFSEL);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
-			OTG_REVISION_REG, OTG_SYSCONFIG_REG, OTG_SYSSTATUS_REG,
-			OTG_INTERFSEL_REG, OTG_SIMENABLE_REG);
+			omap_readl(OTG_REVISION), omap_readl(OTG_SYSCONFIG),
+			omap_readl(OTG_SYSSTATUS), omap_readl(OTG_INTERFSEL),
+			omap_readl(OTG_SIMENABLE));
 
 	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
 
@@ -254,12 +260,19 @@ int __init musb_platform_init(struct musb *musb)
 
 int musb_platform_suspend(struct musb *musb)
 {
+	u32 l;
+
 	if (!musb->clock)
 		return 0;
 
 	/* in any role */
-	OTG_FORCESTDBY_REG |= ENABLEFORCE;	/* enable MSTANDBY */
-	OTG_SYSCONFIG_REG |= ENABLEWAKEUP;	/* enable wakeup */
+	l = omap_readl(OTG_FORCESTDBY);
+	l |= ENABLEFORCE;	/* enable MSTANDBY */
+	omap_writel(l, OTG_FORCESTDBY);
+
+	l = omap_readl(OTG_SYSCONFIG);
+	l |= ENABLEWAKEUP;	/* enable wakeup */
+	omap_writel(l, OTG_SYSCONFIG);
 
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 1);
@@ -274,6 +287,8 @@ int musb_platform_suspend(struct musb *musb)
 
 int musb_platform_resume(struct musb *musb)
 {
+	u32 l;
+
 	if (!musb->clock)
 		return 0;
 
@@ -285,8 +300,13 @@ int musb_platform_resume(struct musb *musb)
 	else
 		clk_enable(musb->clock);
 
-	OTG_SYSCONFIG_REG &= ~ENABLEWAKEUP;	/* disable wakeup */
-	OTG_FORCESTDBY_REG &= ~ENABLEFORCE;	/* disable MSTANDBY */
+	l = omap_readl(OTG_SYSCONFIG);
+	l &= ~ENABLEWAKEUP;	/* disable wakeup */
+	omap_writel(l, OTG_SYSCONFIG);
+
+	l = omap_readl(OTG_FORCESTDBY);
+	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
+	omap_writel(l, OTG_FORCESTDBY);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/omap2430.h b/drivers/usb/musb/omap2430.h
index d036382..786a620 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -24,9 +24,9 @@
 #elif	defined(CONFIG_ARCH_OMAP3430)
 #define	OMAP_HSOTG_BASE		(OMAP34XX_HSUSB_OTG_BASE)
 #endif
-#define OMAP_HSOTG(offset)	__REG32(OMAP_HSOTG_BASE + 0x400 + (offset))
-#define OTG_REVISION_REG	OMAP_HSOTG(0x0)
-#define OTG_SYSCONFIG_REG	OMAP_HSOTG(0x4)
+#define OMAP_HSOTG(offset)	(OMAP_HSOTG_BASE + 0x400 + (offset))
+#define OTG_REVISION		OMAP_HSOTG(0x0)
+#define OTG_SYSCONFIG		OMAP_HSOTG(0x4)
 #	define	MIDLEMODE	12	/* bit position */
 #	define	FORCESTDBY		(0 << MIDLEMODE)
 #	define	NOSTDBY			(1 << MIDLEMODE)
@@ -38,17 +38,17 @@
 #	define	ENABLEWAKEUP		(1 << 2)
 #	define	SOFTRST			(1 << 1)
 #	define	AUTOIDLE		(1 << 0)
-#define OTG_SYSSTATUS_REG	OMAP_HSOTG(0x8)
+#define OTG_SYSSTATUS		OMAP_HSOTG(0x8)
 #	define	RESETDONE		(1 << 0)
-#define OTG_INTERFSEL_REG	OMAP_HSOTG(0xc)
+#define OTG_INTERFSEL		OMAP_HSOTG(0xc)
 #	define	EXTCP			(1 << 2)
 #	define	PHYSEL		0	/* bit position */
 #	define	UTMI_8BIT		(0 << PHYSEL)
 #	define	ULPI_12PIN		(1 << PHYSEL)
 #	define	ULPI_8PIN		(2 << PHYSEL)
-#define OTG_SIMENABLE_REG	OMAP_HSOTG(0x10)
+#define OTG_SIMENABLE		OMAP_HSOTG(0x10)
 #	define	TM1			(1 << 0)
-#define OTG_FORCESTDBY_REG	OMAP_HSOTG(0x14)
+#define OTG_FORCESTDBY		OMAP_HSOTG(0x14)
 #	define	ENABLEFORCE		(1 << 0)
 
 #endif	/* CONFIG_ARCH_OMAP2430 */
-- 
1.5.3.6

