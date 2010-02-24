From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] AM35x: Add musb support
Date: Wed, 24 Feb 2010 18:48:15 +0530
Message-ID: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
It supports upto 500mA of power in host mode.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Created against latest l-o master branch and below patches.
[1] AM35xx: Add clock support for new modules on AM35xx
[2] OMAP2/3 clock: Extend find_idlest() to pass back idle
[3] musb: fix power field to hold all possible values
[4] musb: Add extvbus in musb_board_data 

I am posting musb driver layer platform file seperately to linux-usb list.

 arch/arm/mach-omap2/board-am3517evm.c |   10 ++++++++
 arch/arm/mach-omap2/usb-musb.c        |    4 +++
 arch/arm/plat-omap/include/plat/usb.h |   38 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index aee0a02..805c7ab 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -273,6 +273,12 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 500,
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -286,6 +292,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* USB OTG DRVVBUS offset = 0x212 */
+	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
@@ -313,6 +321,8 @@ static void __init am3517_evm_init(void)
 
 	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
 				ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	/* MUSB */
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init am3517_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 17726ac..1b08cff 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,6 +28,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/am35xx.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 
@@ -89,6 +90,9 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	if (cpu_is_omap243x()) {
 		musb_resources[0].start = OMAP243X_HS_BASE;
+	} else if (cpu_is_omap3517()) {
+		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
+		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
 	} else if (cpu_is_omap34xx()) {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index d82bf77..2df6c70 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -168,5 +168,43 @@ void omap_usb_init(struct omap_usb_config *pdata);
 #	define	USBT2TLL5PI		(1 << 17)
 #	define	USB0PUENACTLOI		(1 << 16)
 #	define	USBSTANDBYCTRL		(1 << 15)
+/* AM3517 */
+/* USB 2.0 OTG module registers */
+#define USB_REVISION_REG	0x00
+#define USB_CTRL_REG		0x04
+#define USB_STAT_REG		0x08
+#define USB_EMULATION_REG	0x0c
+/* 0x10 Reserved */
+#define USB_AUTOREQ_REG		0x14
+#define USB_SRP_FIX_TIME_REG	0x18
+#define USB_TEARDOWN_REG	0x1c
+#define EP_INTR_SRC_REG		0x20
+#define EP_INTR_SRC_SET_REG	0x24
+#define EP_INTR_SRC_CLEAR_REG	0x28
+#define EP_INTR_MASK_REG	0x2c
+#define EP_INTR_MASK_SET_REG	0x30
+#define EP_INTR_MASK_CLEAR_REG	0x34
+#define EP_INTR_SRC_MASKED_REG	0x38
+#define CORE_INTR_SRC_REG	0x40
+#define CORE_INTR_SRC_SET_REG	0x44
+#define CORE_INTR_SRC_CLEAR_REG	0x48
+#define CORE_INTR_MASK_REG	0x4c
+#define CORE_INTR_MASK_SET_REG	0x50
+#define CORE_INTR_MASK_CLEAR_REG 0x54
+#define CORE_INTR_SRC_MASKED_REG 0x58
+/* 0x5c Reserved */
+#define USB_END_OF_INTR_REG	0x60
+
+/* Control register bits */
+#define USB_SOFT_RESET_MASK	1
+
+/* USB interrupt register bits */
+#define USB_INTR_USB_SHIFT	16
+#define USB_INTR_USB_MASK	(0x1ff << USB_INTR_USB_SHIFT)
+#define USB_INTR_DRVVBUS	0x100
+#define USB_INTR_RX_SHIFT	16
+#define USB_INTR_TX_SHIFT	0
+
+#define USB_MENTOR_CORE_OFFSET	0x400
 
 #endif	/* __ASM_ARCH_OMAP_USB_H */
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
