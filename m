From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Remove unused platform init code and headers
Date: Sat, 7 Dec 2013 15:49:11 -0800
Message-ID: <20131207234911.GT26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45933 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753229Ab3LGXtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 18:49:15 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

After converting mach-omap2 to boot with device tree only,
we can now remove some more unused platform init code and
headers:

- omap4-keypad related functions are no longer needed with
  with device tree

- board-rx51.h and hsmmc.h are now unused, and board-rx51.c
  has some unneded headers

- serial.h is no longer needed

- i2c_dev_attr is now set in the driver based on the
  compatible flag, and fifo_depth is unused

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This depends on all the previously posted patches to make mach-omap2
to boot in device tree mode only.

diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index c88d8df7..9a1e826 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -5,8 +5,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/kernel.h>
-#include <linux/reboot.h>
 
 #include "common.h"
 #include "prm-regbits-33xx.h"
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index aead77a..fed5783 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/stddef.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
@@ -26,13 +25,9 @@
 #include <linux/mfd/menelaus.h>
 #include <sound/tlv320aic3x.h>
 
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
 #include "common.h"
 #include "mmc.h"
 #include "soc.h"
-#include "gpmc-onenand.h"
 
 #define TUSB6010_ASYNC_CS	1
 #define TUSB6010_SYNC_CS	4
diff --git a/arch/arm/mach-omap2/board-rx51.h b/arch/arm/mach-omap2/board-rx51.h
deleted file mode 100644
index b76f49e..0000000
--- a/arch/arm/mach-omap2/board-rx51.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * Defines for rx51 boards
- */
-
-#ifndef _OMAP_BOARD_RX51_H
-#define _OMAP_BOARD_RX51_H
-
-extern void __init rx51_peripherals_init(void);
-extern void __init rx51_video_mem_init(void);
-
-#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index a3040a4..d211edd 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -28,18 +28,12 @@
 
 #include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 #include <linux/i2c-omap.h>
 #include <linux/reboot.h>
 
 #include <asm/proc-fns.h>
 
-#include "i2c.h"
-#include "serial.h"
-
-#include "usb.h"
-
 #define OMAP_INTC_START		NR_IRQS
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP2)
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8e85fa0..3d22e8a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/platform_data/omap4-keypad.h>
 #include <linux/platform_data/mailbox-omap.h>
 
 #include <asm/mach-types.h>
@@ -29,7 +28,6 @@
 #include "iomap.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
-#include "omap4-keypad.h"
 
 #include "soc.h"
 #include "common.h"
@@ -251,36 +249,6 @@ static inline void omap_init_camera(void)
 #endif
 }
 
-int __init omap4_keyboard_init(struct omap4_keypad_platform_data
-			*sdp4430_keypad_data, struct omap_board_data *bdata)
-{
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	struct omap4_keypad_platform_data *keypad_data;
-	unsigned int id = -1;
-	char *oh_name = "kbd";
-	char *name = "omap4-keypad";
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return -ENODEV;
-	}
-
-	keypad_data = sdp4430_keypad_data;
-
-	pdev = omap_device_build(name, id, oh, keypad_data,
-				 sizeof(struct omap4_keypad_platform_data));
-
-	if (IS_ERR(pdev)) {
-		WARN(1, "Can't build omap_device for %s:%s.\n",
-						name, oh->name);
-		return PTR_ERR(pdev);
-	}
-
-	return 0;
-}
-
 #if defined(CONFIG_OMAP2PLUS_MBOX) || defined(CONFIG_OMAP2PLUS_MBOX_MODULE)
 static inline void __init omap_init_mbox(void)
 {
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
deleted file mode 100644
index 7f2e790..0000000
--- a/arch/arm/mach-omap2/hsmmc.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * MMC definitions for OMAP2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-struct mmc_card;
-
-struct omap2_hsmmc_info {
-	u8	mmc;		/* controller 1/2/3 */
-	u32	caps;		/* 4/8 wires and any additional host
-				 * capabilities OR'd (ref. linux/mmc/host.h) */
-	u32	pm_caps;	/* PM capabilities */
-	bool	transceiver;	/* MMC-2 option */
-	bool	ext_clock;	/* use external pin for input clock */
-	bool	cover_only;	/* No card detect - just cover switch */
-	bool	nonremovable;	/* Nonremovable e.g. eMMC */
-	bool	power_saving;	/* Try to sleep or power off when possible */
-	bool	no_off;		/* power_saving and power is not to go off */
-	bool	no_off_init;	/* no power off when not in MMC sleep state */
-	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
-	bool	deferred;	/* mmc needs a deferred probe */
-	int	gpio_cd;	/* or -EINVAL */
-	int	gpio_wp;	/* or -EINVAL */
-	char	*name;		/* or NULL for default */
-	struct platform_device *pdev;	/* mmc controller instance */
-	int	ocr_mask;	/* temporary HACK */
-	int	max_freq;	/* maximum clock, if constrained by external
-				 * circuitry, or 0 for default */
-	/* Remux (pad configuration) when powering on/off */
-	void (*remux)(struct device *dev, int slot, int power_on);
-	/* init some special card */
-	void (*init_card)(struct mmc_card *card);
-};
-
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
-void omap_hsmmc_init(struct omap2_hsmmc_info *);
-void omap_hsmmc_late_init(struct omap2_hsmmc_info *);
-
-#else
-
-static inline void omap_hsmmc_init(struct omap2_hsmmc_info *info)
-{
-}
-
-static inline void omap_hsmmc_late_init(struct omap2_hsmmc_info *info)
-{
-}
-
-#endif
diff --git a/arch/arm/mach-omap2/i2c.h b/arch/arm/mach-omap2/i2c.h
index 42b6f2e..f76ff79 100644
--- a/arch/arm/mach-omap2/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -24,19 +24,6 @@
 #ifndef __MACH_OMAP2_I2C_H
 #define __MACH_OMAP2_I2C_H
 
-/**
- * i2c_dev_attr - OMAP I2C controller device attributes for omap_hwmod
- * @fifo_depth: total controller FIFO size (in bytes)
- * @flags: differences in hardware support capability
- *
- * @fifo_depth represents what exists on the hardware, not what is
- * actually configured at runtime by the device driver.
- */
-struct omap_i2c_dev_attr {
-	u8	fifo_depth;
-	u32	flags;
-};
-
 int omap_i2c_reset(struct omap_hwmod *oh);
 
 #endif	/* __MACH_OMAP2_I2C_H */
diff --git a/arch/arm/mach-omap2/include/mach/serial.h b/arch/arm/mach-omap2/include/mach/serial.h
deleted file mode 100644
index 7ca1fcf..0000000
--- a/arch/arm/mach-omap2/include/mach/serial.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-/* OMAP2 serial ports */
-#define OMAP2_UART1_BASE	0x4806a000
-#define OMAP2_UART2_BASE	0x4806c000
-#define OMAP2_UART3_BASE	0x4806e000
-
-/* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP3_UART3_BASE	0x49020000
-#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
-#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
-
-/* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP4_UART3_BASE	0x48020000
-#define OMAP4_UART4_BASE	0x4806e000
-
-/* TI81XX serial ports */
-#define TI81XX_UART1_BASE	0x48020000
-#define TI81XX_UART2_BASE	0x48022000
-#define TI81XX_UART3_BASE	0x48024000
-
-/* AM3505/3517 UART4 */
-#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
-
-/* AM33XX serial port */
-#define AM33XX_UART1_BASE	0x44E09000
-
-/* OMAP5 serial ports */
-#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
-#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
-#define OMAP5_UART5_BASE	0x48066000
-#define OMAP5_UART6_BASE	0x48068000
-
-/* External port on Zoom2/3 */
-#define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfa400000
-
-#define OMAP_PORT_SHIFT		2
-#define ZOOM_PORT_SHIFT		1
-
-#define OMAP24XX_BASE_BAUD	(48000000/16)
-
-#ifndef __ASSEMBLER__
-
-struct omap_board_data;
-struct omap_uart_port_info;
-
-extern void omap_serial_init(void);
-extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
-extern void omap_serial_init_port(struct omap_board_data *bdata,
-		struct omap_uart_port_info *platform_data);
-#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 88b1d5d..aec3153 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -41,7 +41,6 @@
 #include "omap-pm.h"
 #include "sdrc.h"
 #include "control.h"
-#include "serial.h"
 #include "sram.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/omap4-keypad.h b/arch/arm/mach-omap2/omap4-keypad.h
deleted file mode 100644
index 20de0d5..0000000
--- a/arch/arm/mach-omap2/omap4-keypad.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
-#define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
-
-struct omap_board_data;
-
-extern int omap4_keyboard_init(struct omap4_keypad_platform_data *,
-				struct omap_board_data *);
-#endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2f15979..a49c88d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -29,7 +29,6 @@
 #include "prm-regbits-24xx.h"
 #include "i2c.h"
 #include "mmc.h"
-#include "serial.h"
 #include "wd_timer.h"
 
 /*
@@ -98,13 +97,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags		= OMAP_I2C_FLAG_NO_FIFO |
-			  OMAP_I2C_FLAG_SIMPLE_CLOCK |
-			  OMAP_I2C_FLAG_16BIT_DATA_REG |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 /* I2C1 */
 static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -119,7 +111,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 	/*
 	 * From mach-omap2/pm24xx.c: "Putting MPU into the WFI state
 	 * while a transfer is active seems to cause the I2C block to
@@ -142,7 +133,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 	.flags		= HWMOD_16BIT_REG,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 6d1b609..f068bb5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -76,12 +76,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2 |
-			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
-};
-
 /* I2C1 */
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -105,7 +99,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* I2C2 */
@@ -123,7 +116,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* gpio5 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 656861c..e2a46b7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -16,7 +16,6 @@
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
-#include "serial.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 0f17862..7165836 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -695,10 +695,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 struct omap_hwmod am33xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -711,7 +707,6 @@ struct omap_hwmod am33xx_i2c1_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c1 */
@@ -726,7 +721,6 @@ struct omap_hwmod am33xx_i2c2_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -741,7 +735,6 @@ struct omap_hwmod am33xx_i2c3_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9fbc3c1..0477131 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -39,7 +39,6 @@
 #include "i2c.h"
 #include "mmc.h"
 #include "wd_timer.h"
-#include "serial.h"
 
 /*
  * OMAP3xxx hardware module integration data
@@ -742,11 +741,6 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 };
 
 /* I2C1 */
-static struct omap_i2c_dev_attr i2c1_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -761,15 +755,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c1_dev_attr,
 };
 
 /* I2C2 */
-static struct omap_i2c_dev_attr i2c2_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -784,17 +772,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c2_dev_attr,
 };
 
 /* I2C3 */
-static struct omap_i2c_dev_attr i2c3_dev_attr = {
-	.fifo_depth	= 64, /* bytes */
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
-
-
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -809,7 +789,6 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c3_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1e5b12c..ddbf696 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1327,10 +1327,6 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.reset	= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -1345,7 +1341,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -1362,7 +1357,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -1379,7 +1373,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -1396,7 +1389,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 9e08d69..5027611 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -615,11 +615,6 @@ static struct omap_hwmod_class omap54xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
-/* i2c dev_attr */
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod omap54xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -634,7 +629,6 @@ static struct omap_hwmod omap54xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -651,7 +645,6 @@ static struct omap_hwmod omap54xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -668,7 +661,6 @@ static struct omap_hwmod omap54xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -685,7 +677,6 @@ static struct omap_hwmod omap54xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c5 */
@@ -702,7 +693,6 @@ static struct omap_hwmod omap54xx_i2c5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index db32d53..9b9d9d5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -848,11 +848,6 @@ static struct omap_hwmod_class dra7xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
-/* i2c dev_attr */
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod dra7xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -867,7 +862,6 @@ static struct omap_hwmod dra7xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -884,7 +878,6 @@ static struct omap_hwmod dra7xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -901,7 +894,6 @@ static struct omap_hwmod dra7xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -918,7 +910,6 @@ static struct omap_hwmod dra7xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c5 */
@@ -935,7 +926,6 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/serial.h b/arch/arm/mach-omap2/serial.h
deleted file mode 100644
index c4014f0..0000000
--- a/arch/arm/mach-omap2/serial.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <mach/serial.h>
