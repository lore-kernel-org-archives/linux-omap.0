From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/7] usb: musb: get rid of omap_readl/writel
Date: Thu, 21 Jan 2010 15:33:53 +0200
Message-ID: <1264080838-9452-3-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24863 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0AUNfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 08:35:10 -0500
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

we have those addresses already ioremaped, so let's
use our __raw_readl/writel wrappers.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    4 +-
 drivers/usb/musb/musb_core.h |   12 +++++-----
 drivers/usb/musb/omap2430.c  |   48 +++++++++++++++++++++--------------------
 drivers/usb/musb/omap2430.h  |   32 ++++++++++++---------------
 4 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2c53da7..a6dc18c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2234,7 +2234,7 @@ void musb_save_context(struct musb *musb)
 
 	musb_writeb(musb_base, MUSB_INDEX, musb_context.index);
 
-	musb_platform_save_context(&musb_context);
+	musb_platform_save_context(musb, &musb_context);
 }
 
 void musb_restore_context(struct musb *musb)
@@ -2243,7 +2243,7 @@ void musb_restore_context(struct musb *musb)
 	void __iomem *musb_base = musb->mregs;
 	void __iomem *ep_target_regs;
 
-	musb_platform_restore_context(&musb_context);
+	musb_platform_restore_context(musb, &musb_context);
 
 	if (is_host_enabled(musb)) {
 		musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 3d66c3e..74a55b9 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -482,13 +482,13 @@ struct musb_context_registers {
 };
 
 #if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
-extern void musb_platform_save_context(struct musb_context_registers
-		*musb_context);
-extern void musb_platform_restore_context(struct musb_context_registers
-		*musb_context);
+extern void musb_platform_save_context(struct musb *musb,
+		struct musb_context_registers *musb_context);
+extern void musb_platform_restore_context(struct musb *musb,
+		struct musb_context_registers *musb_context);
 #else
-#define musb_platform_save_context(x)		do {} while (0)
-#define musb_platform_restore_context(x)	do {} while (0)
+#define musb_platform_save_context(m, x)	do {} while (0)
+#define musb_platform_restore_context(m, x)	do {} while (0)
 #endif
 
 #endif
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 15a3f27..3fe1686 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -220,7 +220,7 @@ int __init musb_platform_init(struct musb *musb)
 
 	musb_platform_resume(musb);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
 	l &= ~NOSTDBY;		/* remove possible nostdby */
 	l |= SMARTSTDBY;	/* enable smart standby */
@@ -233,17 +233,19 @@ int __init musb_platform_init(struct musb *musb)
 	 */
 	if (!cpu_is_omap3430())
 		l |= AUTOIDLE;		/* enable auto idle */
-	omap_writel(l, OTG_SYSCONFIG);
+	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
 
-	l = omap_readl(OTG_INTERFSEL);
+	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 	l |= ULPI_12PIN;
-	omap_writel(l, OTG_INTERFSEL);
+	musb_writel(musb->mregs, OTG_INTERFSEL, l);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
-			omap_readl(OTG_REVISION), omap_readl(OTG_SYSCONFIG),
-			omap_readl(OTG_SYSSTATUS), omap_readl(OTG_INTERFSEL),
-			omap_readl(OTG_SIMENABLE));
+			musb_readl(musb->mregs, OTG_REVISION),
+			musb_readl(musb->mregs, OTG_SYSCONFIG),
+			musb_readl(musb->mregs, OTG_SYSSTATUS),
+			musb_readl(musb->mregs, OTG_INTERFSEL),
+			musb_readl(musb->mregs, OTG_SIMENABLE));
 
 	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
 
@@ -256,18 +258,18 @@ int __init musb_platform_init(struct musb *musb)
 }
 
 #ifdef CONFIG_PM
-void musb_platform_save_context(struct musb_context_registers
-		*musb_context)
+void musb_platform_save_context(struct musb *musb,
+		struct musb_context_registers *musb_context)
 {
-	musb_context->otg_sysconfig = omap_readl(OTG_SYSCONFIG);
-	musb_context->otg_forcestandby = omap_readl(OTG_FORCESTDBY);
+	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
+	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
 }
 
-void musb_platform_restore_context(struct musb_context_registers
-		*musb_context)
+void musb_platform_restore_context(struct musb *musb,
+		struct musb_context_registers *musb_context)
 {
-	omap_writel(musb_context->otg_sysconfig, OTG_SYSCONFIG);
-	omap_writel(musb_context->otg_forcestandby, OTG_FORCESTDBY);
+	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
+	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
 }
 #endif
 
@@ -279,13 +281,13 @@ int musb_platform_suspend(struct musb *musb)
 		return 0;
 
 	/* in any role */
-	l = omap_readl(OTG_FORCESTDBY);
+	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
-	omap_writel(l, OTG_FORCESTDBY);
+	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
 	l |= ENABLEWAKEUP;	/* enable wakeup */
-	omap_writel(l, OTG_SYSCONFIG);
+	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
 
 	otg_set_suspend(musb->xceiv, 1);
 
@@ -311,13 +313,13 @@ static int musb_platform_resume(struct musb *musb)
 	else
 		clk_enable(musb->clock);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	omap_writel(l, OTG_SYSCONFIG);
+	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
 
-	l = omap_readl(OTG_FORCESTDBY);
+	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
-	omap_writel(l, OTG_FORCESTDBY);
+	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/omap2430.h b/drivers/usb/musb/omap2430.h
index fbede77..40b3c02 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -10,47 +10,43 @@
 #ifndef __MUSB_OMAP243X_H__
 #define __MUSB_OMAP243X_H__
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
-#include <mach/hardware.h>
 #include <plat/usb.h>
 
 /*
  * OMAP2430-specific definitions
  */
 
-#define MENTOR_BASE_OFFSET	0
-#if	defined(CONFIG_ARCH_OMAP2430)
-#define	OMAP_HSOTG_BASE		(OMAP243X_HS_BASE)
-#elif	defined(CONFIG_ARCH_OMAP3430)
-#define	OMAP_HSOTG_BASE		(OMAP34XX_HSUSB_OTG_BASE)
-#endif
-#define OMAP_HSOTG(offset)	(OMAP_HSOTG_BASE + 0x400 + (offset))
-#define OTG_REVISION		OMAP_HSOTG(0x0)
-#define OTG_SYSCONFIG		OMAP_HSOTG(0x4)
+#define OTG_REVISION		0x400
+
+#define OTG_SYSCONFIG		0x404
 #	define	MIDLEMODE	12	/* bit position */
 #	define	FORCESTDBY		(0 << MIDLEMODE)
 #	define	NOSTDBY			(1 << MIDLEMODE)
 #	define	SMARTSTDBY		(2 << MIDLEMODE)
+
 #	define	SIDLEMODE		3	/* bit position */
 #	define	FORCEIDLE		(0 << SIDLEMODE)
 #	define	NOIDLE			(1 << SIDLEMODE)
 #	define	SMARTIDLE		(2 << SIDLEMODE)
+
 #	define	ENABLEWAKEUP		(1 << 2)
 #	define	SOFTRST			(1 << 1)
 #	define	AUTOIDLE		(1 << 0)
-#define OTG_SYSSTATUS		OMAP_HSOTG(0x8)
+
+#define OTG_SYSSTATUS		0x408
 #	define	RESETDONE		(1 << 0)
-#define OTG_INTERFSEL		OMAP_HSOTG(0xc)
+
+#define OTG_INTERFSEL		0x40c
 #	define	EXTCP			(1 << 2)
-#	define	PHYSEL		0	/* bit position */
+#	define	PHYSEL			0	/* bit position */
 #	define	UTMI_8BIT		(0 << PHYSEL)
 #	define	ULPI_12PIN		(1 << PHYSEL)
 #	define	ULPI_8PIN		(2 << PHYSEL)
-#define OTG_SIMENABLE		OMAP_HSOTG(0x10)
+
+#define OTG_SIMENABLE		0x410
 #	define	TM1			(1 << 0)
-#define OTG_FORCESTDBY		OMAP_HSOTG(0x14)
-#	define	ENABLEFORCE		(1 << 0)
 
-#endif	/* CONFIG_ARCH_OMAP2430 */
+#define OTG_FORCESTDBY		0x414
+#	define	ENABLEFORCE		(1 << 0)
 
 #endif	/* __MUSB_OMAP243X_H__ */
-- 
1.6.6.rc0

