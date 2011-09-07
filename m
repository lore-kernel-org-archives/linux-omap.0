From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/6 v2] omap: musb: ti81xx: Add phy power function
Date: Wed, 7 Sep 2011 22:32:22 +0530
Message-ID: <1315414945-19829-4-git-send-email-ajay.gupta@ti.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52126 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab1IGRCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 13:02:34 -0400
In-Reply-To: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Ravi Babu <ravibabu@ti.com>

Adding ti81xx_musb_phy_power() which will be used by musb driver through
its function pointer in board_data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   24 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h   |   32 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 58775e3..352b6af 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -260,3 +260,27 @@ void am35x_set_mode(u8 musb_mode)
 
 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
+
+void ti81xx_musb_phy_power(u8 on)
+{
+	u32 usbphycfg = omap_ctrl_readl(USBCTRL0);
+
+	if (on) {
+		if (cpu_is_ti816x()) {
+			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
+			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
+		} else if (cpu_is_ti814x()) {
+			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
+				| USBPHY_DPINPUT | USBPHY_DMINPUT);
+			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
+				| USBPHY_DPOPBUFCTL | USBPHY_DPOPBUFCTL);
+		}
+	} else {
+		if (cpu_is_ti816x())
+			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
+		else if (cpu_is_ti814x())
+			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
+
+	}
+	omap_ctrl_writel(usbphycfg, USBCTRL0);
+}
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 17d3c93..c616385 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -114,6 +114,7 @@ extern void am35x_musb_reset(void);
 extern void am35x_musb_phy_power(u8 on);
 extern void am35x_musb_clear_irq(void);
 extern void am35x_set_mode(u8 musb_mode);
+extern void ti81xx_musb_phy_power(u8 on);
 
 /*
  * FIXME correct answer depends on hmc_mode,
@@ -273,6 +274,37 @@ static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
 #define CONF2_OTGPWRDN		(1 << 2)
 #define CONF2_DATPOL		(1 << 1)
 
+/* TI81XX specific definitions */
+#define USBCTRL0	0x620
+#define USBSTAT0	0x624
+
+/* TI816X PHY controls bits */
+#define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
+#define TI816X_USBPHY_REFCLK_OSC	(1 << 8)
+
+/* TI814X PHY controls bits */
+#define USBPHY_CM_PWRDN		(1 << 0)
+#define USBPHY_OTG_PWRDN	(1 << 1)
+#define USBPHY_CHGDET_DIS	(1 << 2)
+#define USBPHY_CHGDET_RSTRT	(1 << 3)
+#define USBPHY_SRCONDM		(1 << 4)
+#define USBPHY_SINKONDP		(1 << 5)
+#define USBPHY_CHGISINK_EN	(1 << 6)
+#define USBPHY_CHGVSRC_EN	(1 << 7)
+#define USBPHY_DMPULLUP		(1 << 8)
+#define USBPHY_DPPULLUP		(1 << 9)
+#define USBPHY_CDET_EXTCTL	(1 << 10)
+#define USBPHY_GPIO_MODE	(1 << 12)
+#define USBPHY_DPOPBUFCTL	(1 << 13)
+#define USBPHY_DMOPBUFCTL	(1 << 14)
+#define USBPHY_DPINPUT		(1 << 15)
+#define USBPHY_DMINPUT		(1 << 16)
+#define USBPHY_DPGPIO_PD	(1 << 17)
+#define USBPHY_DMGPIO_PD	(1 << 18)
+#define USBPHY_OTGVDET_EN	(1 << 19)
+#define USBPHY_OTGSESSEND_EN	(1 << 20)
+#define USBPHY_DATA_POLARITY	(1 << 23)
+
 #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
 u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
 u32 omap1_usb1_init(unsigned nwires);
-- 
1.6.2.4

