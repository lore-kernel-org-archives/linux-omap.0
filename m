From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/8] omap: musb: ti81xx: Add phy power function
Date: Tue, 11 Oct 2011 16:56:03 +0530
Message-ID: <1318332369-9732-3-git-send-email-ajay.gupta@ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318332369-9732-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding ti81xx_musb_phy_power() which will be used by musb driver through
its function pointer in board_data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
---
Changes from v3:
	- Added ioremap and inumap for SCM register access instead of using
	  omap_ctrl_read/write.

 arch/arm/mach-omap2/omap_phy_internal.c |   35 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h   |   32 ++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 58775e3..4c90477 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -260,3 +260,38 @@ void am35x_set_mode(u8 musb_mode)
 
 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
+
+void ti81xx_musb_phy_power(u8 on)
+{
+	void __iomem *scm_base = NULL;
+	u32 usbphycfg;
+
+	scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
+	if (!scm_base) {
+		pr_err("system control module ioremap failed\n");
+		return;
+	}
+
+	usbphycfg = __raw_readl(scm_base + USBCTRL0);
+
+	if (on) {
+		if (cpu_is_ti816x()) {
+			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
+			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
+		} else if (cpu_is_ti814x()) {
+			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
+				| USBPHY_DPINPUT | USBPHY_DMINPUT);
+			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
+				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
+		}
+	} else {
+		if (cpu_is_ti816x())
+			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
+		else if (cpu_is_ti814x())
+			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
+
+	}
+	__raw_writel(usbphycfg, scm_base + USBCTRL0);
+
+	iounmap(scm_base);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
