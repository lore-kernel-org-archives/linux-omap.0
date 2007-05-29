From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] musb_hdrc: Implement workaround for tusb3.0 wbus bug rev2
Date: Tue, 29 May 2007 15:02:33 +0300
Message-ID: <11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Without this workaround tusb3.0 will wake-up spontaneously
on USB suspend.

Patch also moves revision functions to the top of the file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/musb/tusb6010.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/tusb6010.c	2007-05-25 14:12:31.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/tusb6010.c	2007-05-25 14:12:34.000000000 +0300
@@ -25,6 +25,67 @@
 
 #include "musbdefs.h"
 
+/*
+ * Checks the revision. We need to use the DMA register as 3.0 does not
+ * have correct versions for TUSB_PRCM_REV or TUSB_INT_CTRL_REV.
+ */
+static u8 tusb_get_revision(struct musb *musb)
+{
+	void __iomem	*base = musb->ctrl_base;
+
+	return musb_readl(base, TUSB_DMA_CTRL_REV) & 0xff;
+}
+
+#define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
+#define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
+
+static int __init tusb_print_revision(struct musb *musb)
+{
+	void __iomem	*base = musb->ctrl_base;
+
+	pr_info("tusb: Revisions: %s%i.%i %s%i.%i %s%i.%i %s%i.%i\n",
+		"prcm",
+		TUSB_REV_MAJOR(musb_readl(base, TUSB_PRCM_REV)),
+		TUSB_REV_MINOR(musb_readl(base, TUSB_PRCM_REV)),
+		"int",
+		TUSB_REV_MAJOR(musb_readl(base, TUSB_INT_CTRL_REV)),
+		TUSB_REV_MINOR(musb_readl(base, TUSB_INT_CTRL_REV)),
+		"gpio",
+		TUSB_REV_MAJOR(musb_readl(base, TUSB_GPIO_REV)),
+		TUSB_REV_MINOR(musb_readl(base, TUSB_GPIO_REV)),
+		"dma",
+		TUSB_REV_MAJOR(musb_readl(base, TUSB_DMA_CTRL_REV)),
+		TUSB_REV_MINOR(musb_readl(base, TUSB_DMA_CTRL_REV)));
+
+	return TUSB_REV_MAJOR(musb_readl(base, TUSB_INT_CTRL_REV));
+}
+
+static void tusb_wbus_quirk(struct musb *musb, int enabled)
+{
+	void __iomem	*base = musb->ctrl_base;
+	static u32	phy_otg_ctrl = 0;
+
+	if (enabled) {
+		DBG(2, "Enabling tusb wbus quirk\n");
+		musb_writel(base, TUSB_PHY_OTG_CTRL_ENABLE,
+				TUSB_PHY_OTG_CTRL_WRPROTECT |
+				TUSB_PHY_OTG_CTRL_TESTM2 |
+				TUSB_PHY_OTG_CTRL_TESTM1 |
+				TUSB_PHY_OTG_CTRL_TESTM0);
+		phy_otg_ctrl = musb_readl(base, TUSB_PHY_OTG_CTRL);
+		musb_writel(base, TUSB_PHY_OTG_CTRL,
+				TUSB_PHY_OTG_CTRL_WRPROTECT |
+				TUSB_PHY_OTG_CTRL_TESTM2);
+	} else if (musb_readl(base, TUSB_PHY_OTG_CTRL_ENABLE)
+			& TUSB_PHY_OTG_CTRL_TESTM2) {
+		DBG(3, "Disabling tusb wbus quirk\n");
+		musb_writel(base, TUSB_PHY_OTG_CTRL,
+			TUSB_PHY_OTG_CTRL_WRPROTECT | phy_otg_ctrl);
+		musb_writel(base, TUSB_PHY_OTG_CTRL_ENABLE,
+			TUSB_PHY_OTG_CTRL_WRPROTECT);
+		phy_otg_ctrl = 0;
+	}
+}
 
 /*
  * TUSB 6010 may use a parallel bus that doesn't support byte ops;
@@ -253,6 +314,11 @@
 	void __iomem	*base = musb->ctrl_base;
 	u32		reg;
 
+	if ((wakeup_enables & TUSB_PRCM_WBUS)
+			&& musb_platform_get_vbus_status(musb)
+			&& (tusb_get_revision(musb) == TUSB_REV_30))
+		tusb_wbus_quirk(musb, 1);
+
 	tusb_set_clock_source(musb, 0);
 
 	wakeup_enables |= TUSB_PRCM_WNORCS;
@@ -302,7 +368,7 @@
 		musb_writel(base, TUSB_PRCM_MNGMT, prcm_mngmt);
 	}
 
-	if (otg_stat & TUSB_DEV_OTG_STAT_VBUS_SENSE)
+	if (otg_stat & TUSB_DEV_OTG_STAT_VBUS_VALID)
 		ret = 1;
 
 	return ret;
@@ -651,6 +717,9 @@
 		u32	reg;
 		u32	i;
 
+		if (tusb_get_revision(musb) == TUSB_REV_30)
+			tusb_wbus_quirk(musb, 0);
+
 		/* there are issues re-locking the PLL on wakeup ... */
 
 		/* work around issue 8 */
@@ -829,30 +898,6 @@
 	musb_writel(base, TUSB_WAIT_COUNT, 1);
 }
 
-#define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
-#define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
-
-static int __init tusb_print_revision(struct musb *musb)
-{
-	void __iomem	*base = musb->ctrl_base;
-
-	pr_info("tusb: Revisions: %s%i.%i %s%i.%i %s%i.%i %s%i.%i\n",
-		"prcm",
-		TUSB_REV_MAJOR(musb_readl(base, TUSB_PRCM_REV)),
-		TUSB_REV_MINOR(musb_readl(base, TUSB_PRCM_REV)),
-		"int",
-		TUSB_REV_MAJOR(musb_readl(base, TUSB_INT_CTRL_REV)),
-		TUSB_REV_MINOR(musb_readl(base, TUSB_INT_CTRL_REV)),
-		"gpio",
-		TUSB_REV_MAJOR(musb_readl(base, TUSB_GPIO_REV)),
-		TUSB_REV_MINOR(musb_readl(base, TUSB_GPIO_REV)),
-		"dma",
-		TUSB_REV_MAJOR(musb_readl(base, TUSB_DMA_CTRL_REV)),
-		TUSB_REV_MINOR(musb_readl(base, TUSB_DMA_CTRL_REV)));
-
-	return TUSB_REV_MAJOR(musb_readl(base, TUSB_INT_CTRL_REV));
-}
-
 static int __init tusb_start(struct musb *musb)
 {
 	void __iomem	*base = musb->ctrl_base;
Index: linux-omap-2.6/drivers/usb/musb/tusb6010.h
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/tusb6010.h	2007-05-25 14:12:31.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/tusb6010.h	2007-05-25 14:12:34.000000000 +0300
@@ -216,6 +216,10 @@
 #define TUSB_PROD_TEST_RESET_VAL		0xa596
 #define TUSB_EP_FIFO(ep)			(TUSB_FIFO_BASE + (ep) * 0x20)
 
+#define TUSB_REV_1	0x10
+#define TUSB_REV_2	0x20
+#define TUSB_REV_30	0x30
+
 /*----------------------------------------------------------------------------*/
 
 #ifdef CONFIG_USB_TUSB6010
