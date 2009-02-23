From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 19/23] usb: host: ehci: ioremap all usb bases
Date: Mon, 23 Feb 2009 20:55:31 +0200
Message-ID: <1235415335-17408-20-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
 <1235415335-17408-19-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42869 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbZBWS6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:58:51 -0500
In-Reply-To: <1235415335-17408-19-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>

doing that will allow us to use standarnd __raw_read/write
calls and stop using omap_read/write ones.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
One patch from Tony ensuring register read only after clocks
where on, was melded into this one.

 arch/arm/mach-omap2/usb-ehci.c |   20 +++-
 drivers/usb/host/ehci-omap.c   |  241 +++++++++++++++++++++++-----------------
 2 files changed, 155 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 6c1a46f..7f7b844 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -29,12 +29,22 @@
 #include <mach/usb.h>
 
 static struct resource ehci_resources[] = {
-	[0] = {
-		.start   = OMAP34XX_EHCI_BASE,
-		.end     = OMAP34XX_EHCI_BASE + SZ_1K - 1,
-		.flags   = IORESOURCE_MEM,
+	{
+		.start	= OMAP34XX_EHCI_BASE,
+		.end	= OMAP34XX_EHCI_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {         /* general IRQ */
+	{
+		.start	= OMAP34XX_UHH_CONFIG_BASE,
+		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_USBTLL_BASE,
+		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{         /* general IRQ */
 		.start   = INT_34XX_EHCI_IRQ,
 		.flags   = IORESOURCE_IRQ,
 	}
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index c9305a3..48ced8f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -38,28 +38,24 @@
 #include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
 
 /*
- * OMAP USBHOST Register addresses: PHYSICAL ADDRESSES
- *	Use omap_readl()/omap_writel() functions
+ * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
+ *	Use ehci_omap_readl()/ehci_omap_writel() functions
  */
 
-/* USBHOST: TLL, UUH, OHCI, EHCI */
-#define	OMAP_USBHOST_BASE	(L4_34XX_BASE + 0x60000)
-
 /* TLL Register Set */
-#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
-#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
-#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
+#define	OMAP_USBTLL_REVISION	(0x00)
+#define	OMAP_USBTLL_SYSCONFIG	(0x10)
 	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY		(1 << 8)
 	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE		(1 << 3)
 	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP		(1 << 2)
 	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET		(1 << 1)
 	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE		(1 << 0)
-#define	OMAP_USBTLL_SYSSTATUS	(OMAP_USBHOST_TLL_BASE + 0x14)
+#define	OMAP_USBTLL_SYSSTATUS	(0x14)
 	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE		(1 << 0)
-#define	OMAP_USBTLL_IRQSTATUS	(OMAP_USBHOST_TLL_BASE + 0x18)
-#define	OMAP_USBTLL_IRQENABLE	(OMAP_USBHOST_TLL_BASE + 0x1C)
+#define	OMAP_USBTLL_IRQSTATUS	(0x18)
+#define	OMAP_USBTLL_IRQENABLE	(0x1C)
 
-#define	OMAP_TLL_SHARED_CONF	(OMAP_USBHOST_TLL_BASE + 0x30)
+#define	OMAP_TLL_SHARED_CONF	(0x30)
 	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
 	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
 	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
@@ -67,31 +63,22 @@
 	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
 
 #define	OMAP_TLL_CHANNEL_CONF(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x040 + 0x004 * num))
+			(0x040 + 0x004 * num)
 	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
 	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
 	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
 	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
 	#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
 
-#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x804 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x807 + 0x100 * num))
-#define	OMAP_TLL_ULPI_OTG_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x80A + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_EN_RISE(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x80D + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_EN_FALL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x810 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_STATUS(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x813 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_LATCH(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x814 + 0x100 * num))
-#define	OMAP_TLL_ULPI_DEBUG(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x815 + 0x100 * num))
-#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x816 + 0x100 * num))
+#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)		(0x804 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)		(0x807 + 0x100 * num)
+#define	OMAP_TLL_ULPI_OTG_CTRL(num)			(0x80A + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_EN_RISE(num)			(0x80D + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_EN_FALL(num)			(0x810 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_STATUS(num)			(0x813 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_LATCH(num)			(0x814 + 0x100 * num)
+#define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
+#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
 
 #define OMAP_TLL_CHANNEL_COUNT		3
 	#define OMAP_TLL_CHANNEL_1_EN_MASK	(1 << 1)
@@ -99,9 +86,8 @@
 	#define OMAP_TLL_CHANNEL_3_EN_MASK	(1 << 4)
 
 /* UHH Register Set */
-#define	OMAP_USBHOST_UHH_BASE	(OMAP_USBHOST_BASE + 0x4000)
-#define	OMAP_UHH_REVISION	(OMAP_USBHOST_UHH_BASE + 0x00)
-#define	OMAP_UHH_SYSCONFIG	(OMAP_USBHOST_UHH_BASE + 0x10)
+#define	OMAP_UHH_REVISION	(0x00)
+#define	OMAP_UHH_SYSCONFIG	(0x10)
 	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE	(1 << 12)
 	#define	OMAP_UHH_SYSCONFIG_CACTIVITY	(1 << 8)
 	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE	(1 << 3)
@@ -109,19 +95,18 @@
 	#define	OMAP_UHH_SYSCONFIG_SOFTRESET	(1 << 1)
 	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE	(1 << 0)
 
-#define	OMAP_UHH_SYSSTATUS	(OMAP_USBHOST_UHH_BASE + 0x14)
-#define	OMAP_UHH_HOSTCONFIG	(OMAP_USBHOST_UHH_BASE + 0x40)
+#define	OMAP_UHH_SYSSTATUS	(0x14)
+#define	OMAP_UHH_HOSTCONFIG	(0x40)
 	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS		(1 << 0)
 	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN	(1 << 2)
 	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN	(1 << 3)
 	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN	(1 << 4)
 	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN	(1 << 5)
 
-#define	OMAP_UHH_DEBUG_CSR	(OMAP_USBHOST_UHH_BASE + 0x44)
+#define	OMAP_UHH_DEBUG_CSR	(0x44)
 
 /* EHCI Register Set */
-#define	OMAP_USBHOST_EHCI_BASE	(OMAP_USBHOST_BASE + 0x4800)
-#define	EHCI_INSNREG05_ULPI		(OMAP_USBHOST_EHCI_BASE + 0xA4)
+#define	EHCI_INSNREG05_ULPI		(0xA4)
 	#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT	31
 	#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT	24
 	#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT		22
@@ -134,6 +119,28 @@
 
 /*-------------------------------------------------------------------------*/
 
+static inline void ehci_omap_writel(void __iomem *base, u32 reg, u32 val)
+{
+	__raw_writel(val, base + reg);
+}
+
+static inline u32 ehci_omap_readl(void __iomem *base, u32 reg)
+{
+	return __raw_readl(base + reg);
+}
+
+static inline void ehci_omap_writeb(void __iomem *base, u8 reg, u8 val)
+{
+	__raw_writeb(val, base + reg);
+}
+
+static inline u8 ehci_omap_readb(void __iomem *base, u8 reg)
+{
+	return __raw_readb(base + reg);
+}
+
+/*-------------------------------------------------------------------------*/
+
 struct ehci_hcd_omap {
 	struct ehci_hcd		*ehci;
 	struct device		*dev;
@@ -156,6 +163,10 @@ struct ehci_hcd_omap {
 
 	/* desired phy_mode: TLL, PHY */
 	enum ehci_hcd_omap_mode	phy_mode;
+
+	void __iomem		*uhh_base;
+	void __iomem		*tll_base;
+	void __iomem		*ehci_base;
 };
 
 /* Clock names as per clock framework: May change so keep as #defs */
@@ -173,7 +184,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	unsigned reg;
 	int i;
 
-	reg = omap_readl(OMAP_UHH_HOSTCONFIG);
+	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS
 		| OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
 		| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
@@ -181,10 +192,10 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
 	/* Use UTMI Ports of TLL */
-	omap_writel(reg, OMAP_UHH_HOSTCONFIG);
+	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 
 	/* Ensure bit is set */
-	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
+	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG)
 			& OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
 		cpu_relax();
 
@@ -197,46 +208,41 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	dev_dbg(omap->dev, "Entered UTMI MODE: success\n");
 
 	/* Program the 3 TLL channels upfront */
-
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
-		reg = omap_readl(OMAP_TLL_CHANNEL_CONF(i));
-
-		/* Disable AutoIdle */
-		reg &= ~OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE;
-		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
-
-		/* Disable BitStuffing */
-		reg &= ~OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
-		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
+		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
-		/* SDR Mode */
-		reg &= ~OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE;
-		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
+		/* Disable AutoIdle, BitStuffing and use SDR Mode */
+		reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
+				| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
+				| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+		ehci_omap_writel(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i), reg);
 	}
 
 	/* Program Common TLL register */
-	reg = omap_readl(OMAP_TLL_SHARED_CONF);
+	reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_SHARED_CONF);
 	reg |= (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
 			| OMAP_TLL_SHARED_CONF_USB_DIVRATION
 			| OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN);
 	reg &= ~OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN;
 
-	omap_writel(reg, OMAP_TLL_SHARED_CONF);
+	ehci_omap_writel(omap->tll_base, OMAP_TLL_SHARED_CONF, reg);
 
 	/* Enable channels now */
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
-		reg = omap_readl(OMAP_TLL_CHANNEL_CONF(i));
+		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Enable only the reg that is needed */
 		if (!(tll_channel_mask & 1<<i))
 			continue;
 
 		reg |= OMAP_TLL_CHANNEL_CONF_CHANEN;
-		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
+		ehci_omap_writel(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i), reg);
 
-		omap_writeb(0xbe, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
+		ehci_omap_writeb(omap->tll_base,
+				OMAP_TLL_ULPI_SCRATCH_REGISTER(i), 0xbe);
 		dev_dbg(omap->dev, "ULPI_SCRATCH_REG[ch=%d]= 0x%02x\n",
-			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
+				i+1, ehci_omap_readb(omap->tll_base,
+				OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
 	}
 }
 
@@ -319,7 +325,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 	clk_enable(omap->usbhost1_48m_fck);
 
-
 	if (omap->phy_reset) {
 		/* Refer: ISSUE1 */
 		gpio_request(omap->reset_gpio_port1, "USB1 PHY reset");
@@ -362,11 +367,11 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 
 	/* perform TLL soft reset, and wait until reset is complete */
-	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET,
-			OMAP_USBTLL_SYSCONFIG);
+	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+			OMAP_USBTLL_SYSCONFIG_SOFTRESET);
 
 	/* Wait for TLL reset to complete */
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
+	while (!(ehci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
 			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE))) {
 		cpu_relax();
 
@@ -380,24 +385,24 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	dev_dbg(omap->dev, "TLL RESET DONE\n");
 
 	/* (1<<3) = no idle mode only for initial debugging */
-	omap_writel(OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
+	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
+			OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
 			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
-			OMAP_USBTLL_SYSCONFIG_CACTIVITY,
-			OMAP_USBTLL_SYSCONFIG);
+			OMAP_USBTLL_SYSCONFIG_CACTIVITY);
 
 
 	/* Put UHH in NoIdle/NoStandby mode */
-	reg = omap_readl(OMAP_UHH_SYSCONFIG);
+	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
 	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
 			| OMAP_UHH_SYSCONFIG_SIDLEMODE
 			| OMAP_UHH_SYSCONFIG_CACTIVITY
 			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
 	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
 
-	omap_writel(reg, OMAP_UHH_SYSCONFIG);
+	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
 	if (omap->phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
-		reg = omap_readl(OMAP_UHH_HOSTCONFIG);
+		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 
 		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
 				| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
@@ -406,10 +411,10 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 				| OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN);
 
 		/* Bypass the TLL module for PHY mode operation */
-		omap_writel(reg, OMAP_UHH_HOSTCONFIG);
+		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 
 		/* Ensure that BYPASS is set */
-		while (omap_readl(OMAP_UHH_HOSTCONFIG)
+		while (ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG)
 			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
 			cpu_relax();
 
@@ -455,14 +460,18 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		/* use Port1 VBUS to charge externally Port2:
 		 *	So for PHY mode operation use Port2 only
 		 */
-		omap_writel((0xa << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
-				(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
-				(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
-				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
-				(0x26),
-				EHCI_INSNREG05_ULPI);
-
-		while (!(omap_readl(EHCI_INSNREG05_ULPI)
+		ehci_omap_writel(omap->ehci_base, EHCI_INSNREG05_ULPI,
+				/* OTG ctrl reg*/
+				(0xa << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |
+				/*   Write */
+				(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |
+				/* Port1 */
+				(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |
+				/* Start */
+				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |
+				(0x26));
+
+		while (!(ehci_omap_readl(omap->ehci_base, EHCI_INSNREG05_ULPI)
 				& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
 			cpu_relax();
 
@@ -517,8 +526,10 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
-	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0))) {
+	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
+			OMAP_UHH_SYSCONFIG_SOFTRESET);
+	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS)
+				& (1 << 0))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
@@ -527,7 +538,8 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		}
 	}
 
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1))) {
+	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS)
+				& (1 << 1))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
@@ -536,7 +548,8 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		}
 	}
 
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2))) {
+	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS)
+				& (1 << 2))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
@@ -545,10 +558,11 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		}
 	}
 	dev_dbg(omap->dev, "UHH RESET DONE OMAP_UHH_SYSSTATUS %x\n",
-			omap_readl(OMAP_UHH_SYSSTATUS));
+			ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS));
 
-	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0))) {
+	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG, (1 << 1));
+	while (!(ehci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
+				& (1 << 0))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
@@ -652,26 +666,43 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->ehci->caps	= hcd->regs;
 	omap->ehci->sbrn	= 0x20;
 
-	ret = omap_start_ehc(omap, hcd);
-	if (ret) {
-		dev_dbg(&pdev->dev, "failed to start ehci\n");
-		goto err_start;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	hcd->rsrc_start = 0;
-	hcd->rsrc_len = 0;
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
-		dev_err(&pdev->dev, "ioremap failed\n");
+		dev_err(&pdev->dev, "EHCI ioremap failed\n");
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
+	/* we know this is the memory we want, no need to ioremap again */
+	omap->ehci_base = hcd->regs;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	omap->uhh_base = ioremap(res->start, resource_size(res));
+	if (!omap->uhh_base) {
+		dev_err(&pdev->dev, "UHH ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_uhh_ioremap;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	omap->tll_base = ioremap(res->start, resource_size(res));
+	if (!omap->tll_base) {
+		dev_err(&pdev->dev, "TLL ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_tll_ioremap;
+	}
+
+	ret = omap_start_ehc(omap, hcd);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to start ehci\n");
+		goto err_start;
+	}
+
 	omap->ehci->regs = hcd->regs
 		+ HC_LENGTH(readl(&omap->ehci->caps->hc_capbase));
 
@@ -691,12 +722,18 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_hcd:
-	iounmap(hcd->regs);
-
-err_ioremap:
 	omap_stop_ehc(omap, hcd);
 
 err_start:
+	iounmap(omap->tll_base);
+
+err_tll_ioremap:
+	iounmap(omap->uhh_base);
+
+err_uhh_ioremap:
+	iounmap(hcd->regs);
+
+err_ioremap:
 	usb_put_hcd(hcd);
 
 err_create_hcd:
@@ -722,8 +759,10 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
 
 	usb_remove_hcd(hcd);
-	iounmap(hcd->regs);
 	omap_stop_ehc(omap, hcd);
+	iounmap(hcd->regs);
+	iounmap(omap->tll_base);
+	iounmap(omap->uhh_base);
 	usb_put_hcd(hcd);
 
 	return 0;
-- 
1.6.1.3

