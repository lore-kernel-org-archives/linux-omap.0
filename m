From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: move OMAP USB platform data to <linux/platform_data/omap-usb.h>
Date: Fri, 28 Sep 2012 10:02:28 +0300
Message-ID: <1348815748-30072-1-git-send-email-balbi@ti.com>
References: <20120927202615.GS4840@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:52644 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753406Ab2I1HHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 03:07:32 -0400
Received: by lagh6 with SMTP id h6so877975lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 00:07:29 -0700 (PDT)
In-Reply-To: <20120927202615.GS4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>, jon-hunter@ti.com, Omar Ramirez Luna <omar.luna@linaro.org>, Felipe Balbi <balbi@ti.com>

In order to make single zImage work for ARM architecture,
we need to make sure we don't depend on private headers.

Move USB platform_data to <linux/platform_data/omap-usb.h>
and keep only internal functions in <plat/usb.h>.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Compile tested only.

 arch/arm/mach-omap2/usb-host.c                     |   1 +
 arch/arm/mach-omap2/usb-musb.c                     |   1 +
 arch/arm/mach-omap2/usb-tusb6010.c                 |   1 +
 arch/arm/plat-omap/include/plat/usb.h              | 126 +--------------------
 drivers/mfd/omap-usb-host.c                        |   2 +-
 drivers/usb/musb/am35x.c                           |   3 +-
 drivers/usb/musb/musb_dsps.c                       |   3 +-
 drivers/usb/musb/omap2430.h                        |   2 +-
 .../linux/platform_data/omap-usb.h                 |  76 +++++--------
 9 files changed, 37 insertions(+), 178 deletions(-)
 copy arch/arm/plat-omap/include/plat/usb.h => include/linux/platform_data/omap-usb.h (72%)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index dde8a11..9a85460 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_data/omap-usb.h>
 
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index c4a5768..809e2d7 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/platform_data/omap-usb.h>
 
 #include <linux/usb/musb.h>
 
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 805bea6..bc6c225 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/export.h>
+#include <linux/platform_data/omap-usb.h>
 
 #include <linux/usb/musb.h>
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 548a4c8..6173467 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,82 +3,11 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
-#include <linux/io.h>
-#include <linux/usb/musb.h>
 #include <plat/board.h>
-
-#define OMAP3_HS_USB_PORTS	3
-
-enum usbhs_omap_port_mode {
-	OMAP_USBHS_PORT_MODE_UNUSED,
-	OMAP_EHCI_PORT_MODE_PHY,
-	OMAP_EHCI_PORT_MODE_TLL,
-	OMAP_EHCI_PORT_MODE_HSIC,
-	OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM,
-	OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM,
-	OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM,
-	OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM,
-	OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0,
-	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
-};
-
-struct usbhs_omap_board_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-
-	/* have to be valid if phy_reset is true and portx is in phy mode */
-	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
-
-	/* Set this to true for ES2.x silicon */
-	unsigned			es2_compatibility:1;
-
-	unsigned			phy_reset:1;
-
-	/*
-	 * Regulators for USB PHYs.
-	 * Each PHY can have a separate regulator.
-	 */
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
-};
+#include <linux/platform_data/omap-usb.h>
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-struct ehci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
-	unsigned			phy_reset:1;
-};
-
-struct ohci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			es2_compatibility:1;
-};
-
-struct usbhs_omap_platform_data {
-	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
-
-	struct ehci_hcd_omap_platform_data	*ehci_data;
-	struct ohci_hcd_omap_platform_data	*ohci_data;
-};
-/*-------------------------------------------------------------------------*/
-
-struct omap_musb_board_data {
-	u8	interface_type;
-	u8	mode;
-	u16	power;
-	unsigned extvbus:1;
-	void	(*set_phy_power)(u8 on);
-	void	(*clear_irq)(void);
-	void	(*set_mode)(u8 mode);
-	void	(*reset)(void);
-};
-
-enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
-
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
 extern void usbhs_init(const struct usbhs_omap_board_data *pdata);
@@ -97,59 +26,6 @@ extern void am35x_musb_clear_irq(void);
 extern void am35x_set_mode(u8 musb_mode);
 extern void ti81xx_musb_phy_power(u8 on);
 
-/* AM35x */
-/* USB 2.0 PHY Control */
-#define CONF2_PHY_GPIOMODE	(1 << 23)
-#define CONF2_OTGMODE		(3 << 14)
-#define CONF2_NO_OVERRIDE	(0 << 14)
-#define CONF2_FORCE_HOST	(1 << 14)
-#define CONF2_FORCE_DEVICE	(2 << 14)
-#define CONF2_FORCE_HOST_VBUS_LOW (3 << 14)
-#define CONF2_SESENDEN		(1 << 13)
-#define CONF2_VBDTCTEN		(1 << 12)
-#define CONF2_REFFREQ_24MHZ	(2 << 8)
-#define CONF2_REFFREQ_26MHZ	(7 << 8)
-#define CONF2_REFFREQ_13MHZ	(6 << 8)
-#define CONF2_REFFREQ		(0xf << 8)
-#define CONF2_PHYCLKGD		(1 << 7)
-#define CONF2_VBUSSENSE		(1 << 6)
-#define CONF2_PHY_PLLON		(1 << 5)
-#define CONF2_RESET		(1 << 4)
-#define CONF2_PHYPWRDN		(1 << 3)
-#define CONF2_OTGPWRDN		(1 << 2)
-#define CONF2_DATPOL		(1 << 1)
-
-/* TI81XX specific definitions */
-#define USBCTRL0	0x620
-#define USBSTAT0	0x624
-
-/* TI816X PHY controls bits */
-#define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
-#define TI816X_USBPHY_REFCLK_OSC	(1 << 8)
-
-/* TI814X PHY controls bits */
-#define USBPHY_CM_PWRDN		(1 << 0)
-#define USBPHY_OTG_PWRDN	(1 << 1)
-#define USBPHY_CHGDET_DIS	(1 << 2)
-#define USBPHY_CHGDET_RSTRT	(1 << 3)
-#define USBPHY_SRCONDM		(1 << 4)
-#define USBPHY_SINKONDP		(1 << 5)
-#define USBPHY_CHGISINK_EN	(1 << 6)
-#define USBPHY_CHGVSRC_EN	(1 << 7)
-#define USBPHY_DMPULLUP		(1 << 8)
-#define USBPHY_DPPULLUP		(1 << 9)
-#define USBPHY_CDET_EXTCTL	(1 << 10)
-#define USBPHY_GPIO_MODE	(1 << 12)
-#define USBPHY_DPOPBUFCTL	(1 << 13)
-#define USBPHY_DMOPBUFCTL	(1 << 14)
-#define USBPHY_DPINPUT		(1 << 15)
-#define USBPHY_DMINPUT		(1 << 16)
-#define USBPHY_DPGPIO_PD	(1 << 17)
-#define USBPHY_DMGPIO_PD	(1 << 18)
-#define USBPHY_OTGVDET_EN	(1 << 19)
-#define USBPHY_OTGSESSEND_EN	(1 << 20)
-#define USBPHY_DATA_POLARITY	(1 << 23)
-
 #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
 u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
 u32 omap1_usb1_init(unsigned nwires);
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 41088ec..2faeee4 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <plat/cpu.h>
-#include <plat/usb.h>
+#include <linux/platform_data/usb.h>
 #include <linux/pm_runtime.h>
 
 #define USBHS_DRIVER_NAME	"usbhs_omap"
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 7a95ab8..9fdb8d0 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -33,8 +33,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-
-#include <plat/usb.h>
+#include <linux/platform_data/omap-usb.h>
 
 #include "musb_core.h"
 
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 494772f..18b2eb6 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -36,13 +36,12 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
+#include <linux/platform_data/omap-usb.h>
 
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 
-#include <plat/usb.h>
-
 #include "musb_core.h"
 
 /**
diff --git a/drivers/usb/musb/omap2430.h b/drivers/usb/musb/omap2430.h
index 40b3c02..5b78417 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -10,7 +10,7 @@
 #ifndef __MUSB_OMAP243X_H__
 #define __MUSB_OMAP243X_H__
 
-#include <plat/usb.h>
+#include <linux/platform_data/omap-usb.h>
 
 /*
  * OMAP2430-specific definitions
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/include/linux/platform_data/omap-usb.h
similarity index 72%
copy from arch/arm/plat-omap/include/plat/usb.h
copy to include/linux/platform_data/omap-usb.h
index 548a4c8..d16d835 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/include/linux/platform_data/omap-usb.h
@@ -1,11 +1,29 @@
-// include/asm-arm/mach-omap/usb.h
-
-#ifndef	__ASM_ARCH_OMAP_USB_H
-#define	__ASM_ARCH_OMAP_USB_H
+/*
+ * omap-usb.h - Platform data for the various OMAP USB IPs
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * This software is distributed under the terms of the GNU General Public
+ * License ("GPL") version 2, as published by the Free Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_OMAP_USB_H
+#define __LINUX_PLATFORM_DATA_OMAP_USB_H
 
 #include <linux/io.h>
 #include <linux/usb/musb.h>
-#include <plat/board.h>
 
 #define OMAP3_HS_USB_PORTS	3
 
@@ -44,8 +62,6 @@ struct usbhs_omap_board_data {
 	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 };
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
 struct ehci_hcd_omap_platform_data {
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
@@ -64,6 +80,7 @@ struct usbhs_omap_platform_data {
 	struct ehci_hcd_omap_platform_data	*ehci_data;
 	struct ohci_hcd_omap_platform_data	*ohci_data;
 };
+
 /*-------------------------------------------------------------------------*/
 
 struct omap_musb_board_data {
@@ -77,25 +94,10 @@ struct omap_musb_board_data {
 	void	(*reset)(void);
 };
 
-enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
-
-extern void usb_musb_init(struct omap_musb_board_data *board_data);
-
-extern void usbhs_init(const struct usbhs_omap_board_data *pdata);
-
-extern int omap4430_phy_power(struct device *dev, int ID, int on);
-extern int omap4430_phy_set_clk(struct device *dev, int on);
-extern int omap4430_phy_init(struct device *dev);
-extern int omap4430_phy_exit(struct device *dev);
-extern int omap4430_phy_suspend(struct device *dev, int suspend);
-
-#endif
-
-extern void am35x_musb_reset(void);
-extern void am35x_musb_phy_power(u8 on);
-extern void am35x_musb_clear_irq(void);
-extern void am35x_set_mode(u8 musb_mode);
-extern void ti81xx_musb_phy_power(u8 on);
+enum musb_interface {
+	MUSB_INTERFACE_ULPI,
+	MUSB_INTERFACE_UTMI
+};
 
 /* AM35x */
 /* USB 2.0 PHY Control */
@@ -150,24 +152,4 @@ extern void ti81xx_musb_phy_power(u8 on);
 #define USBPHY_OTGSESSEND_EN	(1 << 20)
 #define USBPHY_DATA_POLARITY	(1 << 23)
 
-#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
-u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
-u32 omap1_usb1_init(unsigned nwires);
-u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup);
-#else
-static inline u32 omap1_usb0_init(unsigned nwires, unsigned is_device)
-{
-	return 0;
-}
-static inline u32 omap1_usb1_init(unsigned nwires)
-{
-	return 0;
-
-}
-static inline u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
-{
-	return 0;
-}
-#endif
-
-#endif	/* __ASM_ARCH_OMAP_USB_H */
+#endif	/* __LINUX_PLATFORM_DATA_OMAP_USB_H */
-- 
1.7.12

