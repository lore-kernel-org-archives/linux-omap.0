From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] Fix remaining sparse warnings in arch/arm/mach-omap2
Date: Wed, 07 May 2008 11:52:02 -0600
Message-ID: <20080507175202.17732.89931.stgit@localhost.localdomain>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47802 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbYEGTuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 15:50:44 -0400
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix remaining sparse warnings in arch/arm/mach-omap2/.	These fixes
mostly consist of:

- tagging appropriate integer<->pointer casts with __force

- marking private structures and functions as static; adding function
  prototypes in .h files for public functions

- assigning NULL to pointers, not 0

- adding prototypes for *_init() functions in the appropriate header
  files, and getting rid of the corresponding open-coded extern
  prototypes in other C files


Also clean up checkpatch issues - this mostly involves converting some
asm/ includes to linux/ includes.

While here, shrink some bitfields in struct omap_pwm_led_platform_data
down to the smallest possible type.
---

 arch/arm/mach-omap2/devices.c             |   10 +++++-----
 arch/arm/mach-omap2/id.c                  |    9 ++++-----
 arch/arm/mach-omap2/io.c                  |    3 ---
 arch/arm/mach-omap2/mux.c                 |   14 ++++++--------
 arch/arm/mach-omap2/serial.c              |   21 ++++++++++++---------
 arch/arm/mach-omap2/usb-ehci.c            |    2 +-
 include/asm-arm/arch-omap/board-3430sdp.h |    1 +
 include/asm-arm/arch-omap/board.h         |    6 +++---
 include/asm-arm/arch-omap/cpu.h           |    6 +++++-
 include/asm-arm/arch-omap/mmc.h           |    4 ++++
 include/asm-arm/arch-omap/omapfb.h        |    1 +
 include/asm-arm/arch-omap/system.h        |    4 ++--
 include/asm-arm/arch-omap/timex.h         |    2 ++
 include/asm-arm/arch-omap/usb.h           |    3 +++
 14 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4041fe5..d02e9e5 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <asm/hardware.h>
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
@@ -149,7 +149,7 @@ static struct resource omap2_mcspi1_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi1 = {
+static struct platform_device omap2_mcspi1 = {
 	.name		= "omap2_mcspi",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi1_resources),
@@ -171,7 +171,7 @@ static struct resource omap2_mcspi2_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi2 = {
+static struct platform_device omap2_mcspi2 = {
 	.name		= "omap2_mcspi",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi2_resources),
@@ -194,7 +194,7 @@ static struct resource omap2_mcspi3_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi3 = {
+static struct platform_device omap2_mcspi3 = {
 	.name		= "omap2_mcspi",
 	.id		= 3,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi3_resources),
@@ -218,7 +218,7 @@ static struct resource omap2_mcspi4_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi4 = {
+static struct platform_device omap2_mcspi4 = {
 	.name		= "omap2_mcspi",
 	.id		= 4,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi4_resources),
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index dff4b16..835452b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -14,18 +14,17 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <asm/arch/control.h>
 #include <asm/arch/cpu.h>
 
 #if defined(CONFIG_ARCH_OMAP2420)
-#define TAP_BASE	io_p2v(0x48014000)
+#define TAP_BASE	(__force void __iomem *)io_p2v(0x48014000)
 #elif defined(CONFIG_ARCH_OMAP2430)
-#define TAP_BASE	io_p2v(0x4900A000)
+#define TAP_BASE	(__force void __iomem *)io_p2v(0x4900A000)
 #elif defined(CONFIG_ARCH_OMAP34XX)
-#define TAP_BASE	io_p2v(0x4830A000)
+#define TAP_BASE	(__force void __iomem *)io_p2v(0x4830A000)
 #endif
 
 #define OMAP_TAP_IDCODE		0x0204
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2bb808e..2af0cdc 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -38,9 +38,6 @@
 #include <asm/arch/clockdomain.h>
 #include "clockdomains.h"
 
-extern void omap2_check_revision(void);
-extern void omapfb_reserve_sdram(void);
-
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fb639f5..7d56516 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <asm/system.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/spinlock.h>
 
 #include <asm/arch/control.h>
@@ -365,7 +365,7 @@ MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
 #endif	/* CONFIG_ARCH_OMAP34XX */
 
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
-void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 reg)
+static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 reg)
 {
 	u16 orig;
 	u8 warn = 0, debug = 0;
@@ -409,11 +409,11 @@ int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	return 0;
 }
 #else
-#define omap24xx_cfg_reg	0
+#define omap24xx_cfg_reg	NULL
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
-int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
+static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	unsigned long flags;
@@ -428,7 +428,7 @@ int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 	return 0;
 }
 #else
-#define omap34xx_cfg_reg	0
+#define omap34xx_cfg_reg	NULL
 #endif
 
 int __init omap2_mux_init(void)
@@ -437,9 +437,7 @@ int __init omap2_mux_init(void)
 		arch_mux_cfg.pins	= omap24xx_pins;
 		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
-	}
-
-	if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx()) {
 		arch_mux_cfg.pins	= omap34xx_pins;
 		arch_mux_cfg.size	= OMAP34XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap34xx_cfg_reg;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index bb79f43..c953c85 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,7 +28,7 @@ static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= (char *)IO_ADDRESS(OMAP_UART1_BASE),
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= (unsigned long)OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -36,7 +36,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= (unsigned long)OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -44,7 +44,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= (unsigned long)OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -67,7 +67,7 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 				    int value)
 {
 	offset <<= p->regshift;
-	__raw_writeb(value, (unsigned long)(p->membase + offset));
+	__raw_writeb(value, p->membase + offset);
 }
 
 /*
@@ -87,12 +87,15 @@ void omap_serial_enable_clocks(int enable)
 {
 	int i;
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		if (uart_ick[i])
-			enable ? clk_enable(uart_ick[i]) :
+		if (uart_ick[i] && uart_fck[i]) {
+			if (enable) {
+				clk_enable(uart_ick[i]);
+				clk_enable(uart_fck[i]);
+			} else {
 				clk_disable(uart_ick[i]);
-		if (uart_fck[i])
-			enable ? clk_enable(uart_fck[i]) :
 				clk_disable(uart_fck[i]);
+			}
+		}
 	}
 }
 
@@ -117,7 +120,7 @@ void __init omap_serial_init(void)
 		struct plat_serial8250_port *p = serial_platform_data + i;
 
 		if (!(info->enabled_uarts & (1 << i))) {
-			p->membase = 0;
+			p->membase = NULL;
 			p->mapbase = 0;
 			continue;
 		}
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index e48e773..e178a0d 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -48,7 +48,7 @@ static struct platform_device ehci_device = {
 	.dev = {
 		.dma_mask               = &ehci_dmamask,
 		.coherent_dma_mask      = 0xffffffff,
-		.platform_data          = 0x0,
+		.platform_data          = NULL,
 	},
 	.num_resources  = ARRAY_SIZE(ehci_resources),
 	.resource       = ehci_resources,
diff --git a/include/asm-arm/arch-omap/board-3430sdp.h b/include/asm-arm/arch-omap/board-3430sdp.h
index 8c166c2..d583008 100644
--- a/include/asm-arm/arch-omap/board-3430sdp.h
+++ b/include/asm-arm/arch-omap/board-3430sdp.h
@@ -30,6 +30,7 @@
 #define __ASM_ARCH_OMAP_3430SDP_H
 
 extern void sdp3430_usb_init(void);
+extern void sdp3430_flash_init(void);
 
 #define DEBUG_BASE			0x08000000  /* debug board */
 
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
index 3763f3e..0783e60 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -128,9 +128,9 @@ struct omap_pwm_led_platform_data {
 struct omap_gpio_switch_config {
 	char name[12];
 	u16 gpio;
-	int flags:4;
-	int type:4;
-	int key_code:24; /* Linux key code */
+	u8 flags:4;
+	u8 type:4;
+	unsigned int key_code:24; /* Linux key code */
 };
 
 struct omap_uart_config {
diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
index 2626fbd..0f1cf78 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -26,6 +26,8 @@
 #ifndef __ASM_ARCH_OMAP_CPU_H
 #define __ASM_ARCH_OMAP_CPU_H
 
+#include <linux/init.h>
+
 struct omap_chip_id {
 	u8 oc;
 };
@@ -395,6 +397,8 @@ int omap_chip_is(struct omap_chip_id oci);
 #define is_device_type_gp()	(get_device_type() == DEVICE_TYPE_GP)
 #define is_device_type_bad()	(get_device_type() == DEVICE_TYPE_BAD)
 
-#endif
+void __init omap2_check_revision(void);
+
+#endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */
 
 #endif
diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
index 6dff38e..55eb955 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -71,4 +71,8 @@ extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *inf
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
 
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void __init hsmmc_init(void);
+#endif
+
 #endif
diff --git a/include/asm-arm/arch-omap/omapfb.h b/include/asm-arm/arch-omap/omapfb.h
index 55132ad..722eeec 100644
--- a/include/asm-arm/arch-omap/omapfb.h
+++ b/include/asm-arm/arch-omap/omapfb.h
@@ -376,6 +376,7 @@ extern struct lcd_ctrl omap1_lcd_ctrl;
 extern struct lcd_ctrl omap2_disp_ctrl;
 #endif
 
+extern void omapfb_reserve_sdram(void);
 extern void omapfb_register_panel(struct lcd_panel *panel);
 extern void omapfb_write_first_pixel(struct omapfb_device *fbdev, u16 pixval);
 extern void omapfb_notify_clients(struct omapfb_device *fbdev,
diff --git a/include/asm-arm/arch-omap/system.h b/include/asm-arm/arch-omap/system.h
index 5bdac69..4faeb9f 100644
--- a/include/asm-arm/arch-omap/system.h
+++ b/include/asm-arm/arch-omap/system.h
@@ -9,12 +9,12 @@
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
 
+#include <asm/arch/prcm.h>
+
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
 #endif
 
-extern void omap_prcm_arch_reset(char mode);
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
diff --git a/include/asm-arm/arch-omap/timex.h b/include/asm-arm/arch-omap/timex.h
index 21f2e36..f1808cd 100644
--- a/include/asm-arm/arch-omap/timex.h
+++ b/include/asm-arm/arch-omap/timex.h
@@ -38,4 +38,6 @@
 #define CLOCK_TICK_RATE		(HZ * 100000UL)
 #endif
 
+extern struct sys_timer omap_timer;
+
 #endif /* __ASM_ARCH_OMAP_TIMEX_H */
diff --git a/include/asm-arm/arch-omap/usb.h b/include/asm-arm/arch-omap/usb.h
index 2147d18..580a718 100644
--- a/include/asm-arm/arch-omap/usb.h
+++ b/include/asm-arm/arch-omap/usb.h
@@ -27,6 +27,9 @@
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
+void __init usb_musb_init(void);
+void __init usb_ehci_init(void);
+
 #endif
 
 /*-------------------------------------------------------------------------*/


