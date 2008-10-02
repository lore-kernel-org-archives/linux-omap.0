From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7-omap1-git 2/2] twl4030-gpio.h removal
Date: Wed, 1 Oct 2008 19:48:21 -0700
Message-ID: <200810011948.21792.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:47871 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750948AbYJBC7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 22:59:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

The <linux/i2c/...> directory has too many headers for twl4030
support.  Start simplifying that by moving twl430-gpio.h into
the main twl4030.h and also:

 - Providing comments to summarize the { module, offset } logical
   addressing vs the { i2c_client, register } physical addressing.

 - Moving the { module, offset } based I/O calls next to the place
   those modules are defined, with slightly improved descriptions.

 - Adding some section markers internal to twl4030.h so unrelated
   things can be visually separated.

 - Move TWL4030_GPIO_MAX adjacent to the other GPIO symbols.

 - Remove two more now-obsolete symbols (for GPIO pullup/pulldown).

 - Have global definitions of the three SIH_CTRL register bits,
   following the pattern of twl4030-core.c (and fixing a minor
   fault handling bug in reading the clear-on-read bit).

To keep things simple, the only blocks with register declarations
in this file should be ones with registers that (cleanly) get
shared between components ... modules with SIH registers (for
IRQ handling) being the obvious candidates.

No functional changes.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c      |    6 -
 drivers/mfd/twl4030-core.c       |   12 ++-
 include/linux/i2c/twl4030-gpio.h |   76 ---------------------
 include/linux/i2c/twl4030.h      |  130 ++++++++++++++++++++++++++++++-------
 4 files changed, 115 insertions(+), 109 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-gpio.h>
 
 
 /*
@@ -79,11 +78,6 @@ static int twl4030_gpio_irq_end;
 #define is_module()	false
 #endif
 
-/* GPIO_SIH_CTRL Fields */
-#define MASK_GPIO_SIH_CTRL_EXCLEN	BIT(0)
-#define MASK_GPIO_SIH_CTRL_PENDDIS	BIT(1)
-#define MASK_GPIO_SIH_CTRL_COR		BIT(2)
-
 /* GPIO_CTRL Fields */
 #define MASK_GPIO_CTRL_GPIO0CD1		BIT(0)
 #define MASK_GPIO_CTRL_GPIO1CD2		BIT(1)
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -39,7 +39,6 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-gpio.h>
 #include <linux/i2c/twl4030-madc.h>
 #include <linux/i2c/twl4030-pwrirq.h>
 
@@ -183,7 +182,6 @@ static inline void activate_irq(int irq)
 #define TWL4030_MADC_MADC_SIH_CTRL	0x67
 #define TWL4030_KEYPAD_KEYP_SIH_CTRL	0x17
 
-#define TWL4030_SIH_CTRL_COR_MASK	(1 << 2)
 
 /**
  * struct twl4030_mod_iregs - TWL module IMR/ISR regs to mask/clear at init
@@ -341,12 +339,20 @@ struct twl4030mapping {
 
 /* mapping the module id to slave id and base address */
 static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
+	/*
+	 * NOTE:  don't change this table without updating the
+	 * <linux/i2c/twl4030.h> defines for TWL4030_MODULE_*
+	 * so they continue to match the order in this table.
+	 */
+
 	{ TWL4030_SLAVENUM_NUM0, TWL4030_BASEADD_USB },
+
 	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_AUDIO_VOICE },
 	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_GPIO },
 	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_INTBR },
 	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_PIH },
 	{ TWL4030_SLAVENUM_NUM1, TWL4030_BASEADD_TEST },
+
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_KEYPAD },
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_MADC },
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_INTERRUPTS },
@@ -357,6 +363,7 @@ static struct twl4030mapping twl4030_map
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWM1 },
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWMA },
 	{ TWL4030_SLAVENUM_NUM2, TWL4030_BASEADD_PWMB },
+
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_BACKUP },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_INT },
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_PM_MASTER },
@@ -1080,7 +1087,6 @@ static void __init twl4030_mask_clear_in
 
 		/* Are ISRs cleared by reads or writes? */
 		cor = twl4030_read_cor_bit(tmr.mod_no, tmr.sih_ctrl);
-		WARN_ON(cor < 0);
 
 		for (j = 0; j < tmr.reg_cnt; j++) {
 
--- a/include/linux/i2c/twl4030-gpio.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * twl4030-gpio.h - header for TWL4030 GPIO module
- *
- * Copyright (C) 2005-2006, 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
- *
- * Based on tlv320aic23.c:
- * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#ifndef __TWL4030_GPIO_H_
-#define __TWL4030_GPIO_H_
-
-/*
- * GPIO Block Register definitions
- */
-
-#define REG_GPIODATAIN1			0x0
-#define REG_GPIODATAIN2			0x1
-#define REG_GPIODATAIN3			0x2
-#define REG_GPIODATADIR1		0x3
-#define REG_GPIODATADIR2		0x4
-#define REG_GPIODATADIR3		0x5
-#define REG_GPIODATAOUT1		0x6
-#define REG_GPIODATAOUT2		0x7
-#define REG_GPIODATAOUT3		0x8
-#define REG_CLEARGPIODATAOUT1		0x9
-#define REG_CLEARGPIODATAOUT2		0xA
-#define REG_CLEARGPIODATAOUT3		0xB
-#define REG_SETGPIODATAOUT1		0xC
-#define REG_SETGPIODATAOUT2		0xD
-#define REG_SETGPIODATAOUT3		0xE
-#define REG_GPIO_DEBEN1			0xF
-#define REG_GPIO_DEBEN2			0x10
-#define REG_GPIO_DEBEN3			0x11
-#define REG_GPIO_CTRL			0x12
-#define REG_GPIOPUPDCTR1		0x13
-#define REG_GPIOPUPDCTR2		0x14
-#define REG_GPIOPUPDCTR3		0x15
-#define REG_GPIOPUPDCTR4		0x16
-#define REG_GPIOPUPDCTR5		0x17
-#define REG_GPIO_ISR1A			0x19
-#define REG_GPIO_ISR2A			0x1A
-#define REG_GPIO_ISR3A			0x1B
-#define REG_GPIO_IMR1A			0x1C
-#define REG_GPIO_IMR2A			0x1D
-#define REG_GPIO_IMR3A			0x1E
-#define REG_GPIO_ISR1B			0x1F
-#define REG_GPIO_ISR2B			0x20
-#define REG_GPIO_ISR3B			0x21
-#define REG_GPIO_IMR1B			0x22
-#define REG_GPIO_IMR2B			0x23
-#define REG_GPIO_IMR3B			0x24
-#define REG_GPIO_EDR1			0x28
-#define REG_GPIO_EDR2			0x29
-#define REG_GPIO_EDR3			0x2A
-#define REG_GPIO_EDR4			0x2B
-#define REG_GPIO_EDR5			0x2C
-#define REG_GPIO_SIH_CTRL		0x2D
-
-#endif /* End of __TWL4030_GPIO_H */
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -25,15 +25,28 @@
 #ifndef __TWL4030_H_
 #define __TWL4030_H_
 
-/* USB ID */
+/*
+ * Using the twl4030 core we address registers using a pair
+ *	{ module id, relative register offset }
+ * which that core then maps to the relevant
+ *	{ i2c slave, absolute register address }
+ *
+ * The module IDs are meaningful only to the twl4030 core code,
+ * which uses them as array indices to look up the first register
+ * address each module uses within a given i2c slave.
+ */
+
+/* Slave 0 (i2c address 0x48) */
 #define TWL4030_MODULE_USB		0x00
-/* AUD ID */
+
+/* Slave 1 (i2c address 0x49) */
 #define TWL4030_MODULE_AUDIO_VOICE	0x01
 #define TWL4030_MODULE_GPIO		0x02
 #define TWL4030_MODULE_INTBR		0x03
 #define TWL4030_MODULE_PIH		0x04
 #define TWL4030_MODULE_TEST		0x05
-/* AUX ID */
+
+/* Slave 2 (i2c address 0x4a) */
 #define TWL4030_MODULE_KEYPAD		0x06
 #define TWL4030_MODULE_MADC		0x07
 #define TWL4030_MODULE_INTERRUPTS	0x08
@@ -44,7 +57,8 @@
 #define TWL4030_MODULE_PWM1		0x0D
 #define TWL4030_MODULE_PWMA		0x0E
 #define TWL4030_MODULE_PWMB		0x0F
-/* POWER ID */
+
+/* Slave 3 (i2c address 0x4b) */
 #define TWL4030_MODULE_BACKUP		0x10
 #define TWL4030_MODULE_INT		0x11
 #define TWL4030_MODULE_PM_MASTER	0x12
@@ -52,6 +66,92 @@
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
 
+/*
+ * Read and write single 8-bit registers
+ */
+int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
+int twl4030_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
+
+/*
+ * Read and write several 8-bit registers at once.
+ *
+ * IMPORTANT:  For twl4030_i2c_write(), allocate num_bytes + 1
+ * for the value, and populate your data starting at offset 1.
+ */
+int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
+int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * NOTE:  at up to 1024 registers, this is a big chip.
+ *
+ * Avoid putting register declarations in this file, instead of into
+ * a driver-private file, unless some of the registers in a block
+ * need to be shared with other drivers.  One example is blocks that
+ * have Secondary IRQ Handler (SIH) registers.
+ */
+
+#define TWL4030_SIH_CTRL_EXCLEN_MASK	BIT(0)
+#define TWL4030_SIH_CTRL_PENDDIS_MASK	BIT(1)
+#define TWL4030_SIH_CTRL_COR_MASK	BIT(2)
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * GPIO Block Register offsets (use TWL4030_MODULE_GPIO)
+ */
+
+#define REG_GPIODATAIN1			0x0
+#define REG_GPIODATAIN2			0x1
+#define REG_GPIODATAIN3			0x2
+#define REG_GPIODATADIR1		0x3
+#define REG_GPIODATADIR2		0x4
+#define REG_GPIODATADIR3		0x5
+#define REG_GPIODATAOUT1		0x6
+#define REG_GPIODATAOUT2		0x7
+#define REG_GPIODATAOUT3		0x8
+#define REG_CLEARGPIODATAOUT1		0x9
+#define REG_CLEARGPIODATAOUT2		0xA
+#define REG_CLEARGPIODATAOUT3		0xB
+#define REG_SETGPIODATAOUT1		0xC
+#define REG_SETGPIODATAOUT2		0xD
+#define REG_SETGPIODATAOUT3		0xE
+#define REG_GPIO_DEBEN1			0xF
+#define REG_GPIO_DEBEN2			0x10
+#define REG_GPIO_DEBEN3			0x11
+#define REG_GPIO_CTRL			0x12
+#define REG_GPIOPUPDCTR1		0x13
+#define REG_GPIOPUPDCTR2		0x14
+#define REG_GPIOPUPDCTR3		0x15
+#define REG_GPIOPUPDCTR4		0x16
+#define REG_GPIOPUPDCTR5		0x17
+#define REG_GPIO_ISR1A			0x19
+#define REG_GPIO_ISR2A			0x1A
+#define REG_GPIO_ISR3A			0x1B
+#define REG_GPIO_IMR1A			0x1C
+#define REG_GPIO_IMR2A			0x1D
+#define REG_GPIO_IMR3A			0x1E
+#define REG_GPIO_ISR1B			0x1F
+#define REG_GPIO_ISR2B			0x20
+#define REG_GPIO_ISR3B			0x21
+#define REG_GPIO_IMR1B			0x22
+#define REG_GPIO_IMR2B			0x23
+#define REG_GPIO_IMR3B			0x24
+#define REG_GPIO_EDR1			0x28
+#define REG_GPIO_EDR2			0x29
+#define REG_GPIO_EDR3			0x2A
+#define REG_GPIO_EDR4			0x2B
+#define REG_GPIO_EDR5			0x2C
+#define REG_GPIO_SIH_CTRL		0x2D
+
+/* Up to 18 signals are available as GPIOs, when their
+ * pins are not assigned to another use (such as ULPI/USB).
+ */
+#define TWL4030_GPIO_MAX		18
+
+/*----------------------------------------------------------------------*/
+
 struct twl4030_bci_platform_data {
 	int *battery_tmp_tbl;
 	unsigned int tblsize;
@@ -109,6 +209,8 @@ struct twl4030_platform_data {
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
 
+/*----------------------------------------------------------------------*/
+
 /*
  * FIXME completely stop using TWL4030_IRQ_BASE ... instead, pass the
  * IRQ data to subsidiary devices using platform device resources.
@@ -148,28 +250,8 @@ struct twl4030_platform_data {
 
 /* TWL4030 GPIO interrupt definitions */
 
-#define TWL4030_GPIO_MAX		18
 #define TWL4030_GPIO_IRQ_NO(n)		(TWL4030_GPIO_IRQ_BASE + (n))
 #define TWL4030_GPIO_IS_ENABLE		1
-#define TWL4030_GPIO_PULL_UP		0
-#define TWL4030_GPIO_PULL_DOWN		1
-
-/* Functions to read and write from TWL4030 */
-
-/*
- * IMP NOTE:
- * The base address of the module will be added by the triton driver
- * It is the caller's responsibility to ensure sane values
- */
-int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
-int twl4030_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
-
- /*
-  * i2c_write: IMPORTANT - Allocate value num_bytes+1 and valid data starts at
-  *		Offset 1.
-  */
-int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
-int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
 
 /*
  * Exported TWL4030 GPIO APIs
