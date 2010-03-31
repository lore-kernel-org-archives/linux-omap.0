From: Charulatha V <charu@ti.com>
Subject: [PATCH 1/8] OMAP:GPIO:Move architecture specific macros to specific header
Date: Wed, 31 Mar 2010 17:53:52 +0530
Message-ID: <1270038239-1090-2-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44997 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790Ab0CaMT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:29 -0400
In-Reply-To: <1270038239-1090-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch moves architecture specific defines to the
corresponding architecture specific header files.

In gpio.c, #ifdef's CONFIG_ARCH_OMAPX are added to
avoid compilation errors due to movement of macros to
mach-omap layer. These architecture specific codes
is only temporary as they will be removed at the end
of this patch series when plat-omap/gpio.c handles
only common APIs.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/include/mach/gpio.h |   88 ++++++++++++
 arch/arm/mach-omap2/include/mach/gpio.h |   99 +++++++++++++
 arch/arm/plat-omap/gpio.c               |  238 ++++---------------------------
 arch/arm/plat-omap/include/plat/gpio.h  |  159 ++++++++++++++++-----
 4 files changed, 339 insertions(+), 245 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
index e737706..c4945d7 100644
--- a/arch/arm/mach-omap1/include/mach/gpio.h
+++ b/arch/arm/mach-omap1/include/mach/gpio.h
@@ -3,3 +3,91 @@
  */
 
 #include <plat/gpio.h>
+
+/*
+ * OMAP1510 GPIO registers
+ */
+#define OMAP1510_GPIO_BASE		0xfffce000
+#define OMAP1510_GPIO_DATA_INPUT	0x00
+#define OMAP1510_GPIO_DATA_OUTPUT	0x04
+#define OMAP1510_GPIO_DIR_CONTROL	0x08
+#define OMAP1510_GPIO_INT_CONTROL	0x0c
+#define OMAP1510_GPIO_INT_MASK		0x10
+#define OMAP1510_GPIO_INT_STATUS	0x14
+#define OMAP1510_GPIO_PIN_CONTROL	0x18
+
+#define OMAP1510_IH_GPIO_BASE		64
+
+/*
+ * OMAP1610 specific GPIO registers
+ */
+#define OMAP1610_GPIO1_BASE		0xfffbe400
+#define OMAP1610_GPIO2_BASE		0xfffbec00
+#define OMAP1610_GPIO3_BASE		0xfffbb400
+#define OMAP1610_GPIO4_BASE		0xfffbbc00
+#define OMAP1610_GPIO_REVISION		0x0000
+#define OMAP1610_GPIO_SYSCONFIG		0x0010
+#define OMAP1610_GPIO_SYSSTATUS		0x0014
+#define OMAP1610_GPIO_IRQSTATUS1	0x0018
+#define OMAP1610_GPIO_IRQENABLE1	0x001c
+#define OMAP1610_GPIO_WAKEUPENABLE	0x0028
+#define OMAP1610_GPIO_DATAIN		0x002c
+#define OMAP1610_GPIO_DATAOUT		0x0030
+#define OMAP1610_GPIO_DIRECTION		0x0034
+#define OMAP1610_GPIO_EDGE_CTRL1	0x0038
+#define OMAP1610_GPIO_EDGE_CTRL2	0x003c
+#define OMAP1610_GPIO_CLEAR_IRQENABLE1	0x009c
+#define OMAP1610_GPIO_CLEAR_WAKEUPENA	0x00a8
+#define OMAP1610_GPIO_CLEAR_DATAOUT	0x00b0
+#define OMAP1610_GPIO_SET_IRQENABLE1	0x00dc
+#define OMAP1610_GPIO_SET_WAKEUPENA	0x00e8
+#define OMAP1610_GPIO_SET_DATAOUT	0x00f0
+
+/*
+ * OMAP7XX specific GPIO registers
+ */
+#define OMAP7XX_GPIO1_BASE		0xfffbc000
+#define OMAP7XX_GPIO2_BASE		0xfffbc800
+#define OMAP7XX_GPIO3_BASE		0xfffbd000
+#define OMAP7XX_GPIO4_BASE		0xfffbd800
+#define OMAP7XX_GPIO5_BASE		0xfffbe000
+#define OMAP7XX_GPIO6_BASE		0xfffbe800
+#define OMAP7XX_GPIO_DATA_INPUT		0x00
+#define OMAP7XX_GPIO_DATA_OUTPUT	0x04
+#define OMAP7XX_GPIO_DIR_CONTROL	0x08
+#define OMAP7XX_GPIO_INT_CONTROL	0x0c
+#define OMAP7XX_GPIO_INT_MASK		0x10
+#define OMAP7XX_GPIO_INT_STATUS		0x14
+
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
+#define OMAP1_MPUIO_BASE		0xfffb5000
+
+#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
+#define OMAP_MPUIO_INPUT_LATCH		0x00
+#define OMAP_MPUIO_OUTPUT		0x02
+#define OMAP_MPUIO_IO_CNTL		0x04
+#define OMAP_MPUIO_KBR_LATCH		0x08
+#define OMAP_MPUIO_KBC			0x0a
+#define OMAP_MPUIO_GPIO_EVENT_MODE	0x0c
+#define OMAP_MPUIO_GPIO_INT_EDGE	0x0e
+#define OMAP_MPUIO_KBD_INT		0x10
+#define OMAP_MPUIO_GPIO_INT		0x12
+#define OMAP_MPUIO_KBD_MASKIT		0x14
+#define OMAP_MPUIO_GPIO_MASKIT		0x16
+#define OMAP_MPUIO_GPIO_DEBOUNCING	0x18
+#define OMAP_MPUIO_LATCH		0x1a
+#else
+#define OMAP_MPUIO_INPUT_LATCH		0x00
+#define OMAP_MPUIO_OUTPUT		0x04
+#define OMAP_MPUIO_IO_CNTL		0x08
+#define OMAP_MPUIO_KBR_LATCH		0x10
+#define OMAP_MPUIO_KBC			0x14
+#define OMAP_MPUIO_GPIO_EVENT_MODE	0x18
+#define OMAP_MPUIO_GPIO_INT_EDGE	0x1c
+#define OMAP_MPUIO_KBD_INT		0x20
+#define OMAP_MPUIO_GPIO_INT		0x24
+#define OMAP_MPUIO_KBD_MASKIT		0x28
+#define OMAP_MPUIO_GPIO_MASKIT		0x2c
+#define OMAP_MPUIO_GPIO_DEBOUNCING	0x30
+#define OMAP_MPUIO_LATCH		0x34
+#endif
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
index be4d290..0b90a72 100644
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -3,3 +3,102 @@
  */
 
 #include <plat/gpio.h>
+
+/*
+ * omap24xx specific GPIO registers
+ */
+#define OMAP242X_GPIO1_BASE		0x48018000
+#define OMAP242X_GPIO2_BASE		0x4801a000
+#define OMAP242X_GPIO3_BASE		0x4801c000
+#define OMAP242X_GPIO4_BASE		0x4801e000
+
+#define OMAP243X_GPIO1_BASE		0x4900C000
+#define OMAP243X_GPIO2_BASE		0x4900E000
+#define OMAP243X_GPIO3_BASE		0x49010000
+#define OMAP243X_GPIO4_BASE		0x49012000
+#define OMAP243X_GPIO5_BASE		0x480B6000
+
+/*
+ * omap34xx specific GPIO registers
+ */
+#define OMAP34XX_GPIO1_BASE		0x48310000
+#define OMAP34XX_GPIO2_BASE		0x49050000
+#define OMAP34XX_GPIO3_BASE		0x49052000
+#define OMAP34XX_GPIO4_BASE		0x49054000
+#define OMAP34XX_GPIO5_BASE		0x49056000
+#define OMAP34XX_GPIO6_BASE		0x49058000
+
+#define OMAP34XX_NR_GPIOS		6
+
+/*
+ * OMAP44XX  specific GPIO registers
+ */
+#define OMAP44XX_GPIO1_BASE             0x4a310000
+#define OMAP44XX_GPIO2_BASE             0x48055000
+#define OMAP44XX_GPIO3_BASE             0x48057000
+#define OMAP44XX_GPIO4_BASE             0x48059000
+#define OMAP44XX_GPIO5_BASE             0x4805B000
+#define OMAP44XX_GPIO6_BASE             0x4805D000
+
+/*
+ * GPIO register offsets
+ */
+#define OMAP24XX_GPIO_REVISION		0x0000
+#define OMAP24XX_GPIO_SYSCONFIG		0x0010
+#define OMAP24XX_GPIO_SYSSTATUS		0x0014
+#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
+#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
+#define OMAP24XX_GPIO_IRQENABLE2	0x002c
+#define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
+#define OMAP24XX_GPIO_CTRL		0x0030
+#define OMAP24XX_GPIO_OE		0x0034
+#define OMAP24XX_GPIO_DATAIN		0x0038
+#define OMAP24XX_GPIO_DATAOUT		0x003c
+#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
+#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
+#define OMAP24XX_GPIO_RISINGDETECT	0x0048
+#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
+#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
+#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
+#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
+#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
+#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
+#define OMAP24XX_GPIO_SETWKUENA		0x0084
+#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
+#define OMAP24XX_GPIO_SETDATAOUT	0x0094
+
+#define OMAP4_GPIO_REVISION		0x0000
+#define OMAP4_GPIO_SYSCONFIG		0x0010
+#define OMAP4_GPIO_EOI			0x0020
+#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
+#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
+#define OMAP4_GPIO_IRQSTATUS0		0x002c
+#define OMAP4_GPIO_IRQSTATUS1		0x0030
+#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
+#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
+#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
+#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
+#define OMAP4_GPIO_IRQWAKEN0		0x0044
+#define OMAP4_GPIO_IRQWAKEN1		0x0048
+#define OMAP4_GPIO_SYSSTATUS		0x0114
+#define OMAP4_GPIO_SYSSTATUS		0x0114
+#define OMAP4_GPIO_IRQENABLE1		0x011c
+#define OMAP4_GPIO_WAKE_EN		0x0120
+#define OMAP4_GPIO_IRQSTATUS2		0x0128
+#define OMAP4_GPIO_CTRL			0x0130
+#define OMAP4_GPIO_OE			0x0134
+#define OMAP4_GPIO_DATAIN		0x0138
+#define OMAP4_GPIO_DATAOUT		0x013c
+#define OMAP4_GPIO_LEVELDETECT0		0x0140
+#define OMAP4_GPIO_LEVELDETECT1		0x0144
+#define OMAP4_GPIO_RISINGDETECT		0x0148
+#define OMAP4_GPIO_FALLINGDETECT	0x014c
+#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
+#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
+#define OMAP4_GPIO_CLEARIRQENABLE1	0x0160
+#define OMAP4_GPIO_SETIRQENABLE1	0x0164
+#define OMAP4_GPIO_CLEARWKUENA		0x0180
+#define OMAP4_GPIO_SETWKUENA		0x0184
+#define OMAP4_GPIO_CLEARDATAOUT		0x0190
+#define OMAP4_GPIO_SETDATAOUT		0x0194
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 76a347b..069dd66 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -14,195 +14,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/sysdev.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <mach/irqs.h>
-#include <mach/gpio.h>
-#include <asm/mach/irq.h>
-
-/*
- * OMAP1510 GPIO registers
- */
-#define OMAP1510_GPIO_BASE		0xfffce000
-#define OMAP1510_GPIO_DATA_INPUT	0x00
-#define OMAP1510_GPIO_DATA_OUTPUT	0x04
-#define OMAP1510_GPIO_DIR_CONTROL	0x08
-#define OMAP1510_GPIO_INT_CONTROL	0x0c
-#define OMAP1510_GPIO_INT_MASK		0x10
-#define OMAP1510_GPIO_INT_STATUS	0x14
-#define OMAP1510_GPIO_PIN_CONTROL	0x18
-
-#define OMAP1510_IH_GPIO_BASE		64
-
-/*
- * OMAP1610 specific GPIO registers
- */
-#define OMAP1610_GPIO1_BASE		0xfffbe400
-#define OMAP1610_GPIO2_BASE		0xfffbec00
-#define OMAP1610_GPIO3_BASE		0xfffbb400
-#define OMAP1610_GPIO4_BASE		0xfffbbc00
-#define OMAP1610_GPIO_REVISION		0x0000
-#define OMAP1610_GPIO_SYSCONFIG		0x0010
-#define OMAP1610_GPIO_SYSSTATUS		0x0014
-#define OMAP1610_GPIO_IRQSTATUS1	0x0018
-#define OMAP1610_GPIO_IRQENABLE1	0x001c
-#define OMAP1610_GPIO_WAKEUPENABLE	0x0028
-#define OMAP1610_GPIO_DATAIN		0x002c
-#define OMAP1610_GPIO_DATAOUT		0x0030
-#define OMAP1610_GPIO_DIRECTION		0x0034
-#define OMAP1610_GPIO_EDGE_CTRL1	0x0038
-#define OMAP1610_GPIO_EDGE_CTRL2	0x003c
-#define OMAP1610_GPIO_CLEAR_IRQENABLE1	0x009c
-#define OMAP1610_GPIO_CLEAR_WAKEUPENA	0x00a8
-#define OMAP1610_GPIO_CLEAR_DATAOUT	0x00b0
-#define OMAP1610_GPIO_SET_IRQENABLE1	0x00dc
-#define OMAP1610_GPIO_SET_WAKEUPENA	0x00e8
-#define OMAP1610_GPIO_SET_DATAOUT	0x00f0
-
-/*
- * OMAP7XX specific GPIO registers
- */
-#define OMAP7XX_GPIO1_BASE		0xfffbc000
-#define OMAP7XX_GPIO2_BASE		0xfffbc800
-#define OMAP7XX_GPIO3_BASE		0xfffbd000
-#define OMAP7XX_GPIO4_BASE		0xfffbd800
-#define OMAP7XX_GPIO5_BASE		0xfffbe000
-#define OMAP7XX_GPIO6_BASE		0xfffbe800
-#define OMAP7XX_GPIO_DATA_INPUT		0x00
-#define OMAP7XX_GPIO_DATA_OUTPUT	0x04
-#define OMAP7XX_GPIO_DIR_CONTROL	0x08
-#define OMAP7XX_GPIO_INT_CONTROL	0x0c
-#define OMAP7XX_GPIO_INT_MASK		0x10
-#define OMAP7XX_GPIO_INT_STATUS		0x14
-
-#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
-
-/*
- * omap24xx specific GPIO registers
- */
-#define OMAP242X_GPIO1_BASE		0x48018000
-#define OMAP242X_GPIO2_BASE		0x4801a000
-#define OMAP242X_GPIO3_BASE		0x4801c000
-#define OMAP242X_GPIO4_BASE		0x4801e000
-
-#define OMAP243X_GPIO1_BASE		0x4900C000
-#define OMAP243X_GPIO2_BASE		0x4900E000
-#define OMAP243X_GPIO3_BASE		0x49010000
-#define OMAP243X_GPIO4_BASE		0x49012000
-#define OMAP243X_GPIO5_BASE		0x480B6000
-
-#define OMAP24XX_GPIO_REVISION		0x0000
-#define OMAP24XX_GPIO_SYSCONFIG		0x0010
-#define OMAP24XX_GPIO_SYSSTATUS		0x0014
-#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
-#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
-#define OMAP24XX_GPIO_IRQENABLE2	0x002c
-#define OMAP24XX_GPIO_IRQENABLE1	0x001c
-#define OMAP24XX_GPIO_WAKE_EN		0x0020
-#define OMAP24XX_GPIO_CTRL		0x0030
-#define OMAP24XX_GPIO_OE		0x0034
-#define OMAP24XX_GPIO_DATAIN		0x0038
-#define OMAP24XX_GPIO_DATAOUT		0x003c
-#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
-#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
-#define OMAP24XX_GPIO_RISINGDETECT	0x0048
-#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
-#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
-#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
-#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
-#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
-#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
-#define OMAP24XX_GPIO_SETWKUENA		0x0084
-#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
-#define OMAP24XX_GPIO_SETDATAOUT	0x0094
-
-#define OMAP4_GPIO_REVISION		0x0000
-#define OMAP4_GPIO_SYSCONFIG		0x0010
-#define OMAP4_GPIO_EOI			0x0020
-#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
-#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
-#define OMAP4_GPIO_IRQSTATUS0		0x002c
-#define OMAP4_GPIO_IRQSTATUS1		0x0030
-#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
-#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
-#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
-#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
-#define OMAP4_GPIO_IRQWAKEN0		0x0044
-#define OMAP4_GPIO_IRQWAKEN1		0x0048
-#define OMAP4_GPIO_SYSSTATUS		0x0104
-#define OMAP4_GPIO_CTRL			0x0130
-#define OMAP4_GPIO_OE			0x0134
-#define OMAP4_GPIO_DATAIN		0x0138
-#define OMAP4_GPIO_DATAOUT		0x013c
-#define OMAP4_GPIO_LEVELDETECT0		0x0140
-#define OMAP4_GPIO_LEVELDETECT1		0x0144
-#define OMAP4_GPIO_RISINGDETECT		0x0148
-#define OMAP4_GPIO_FALLINGDETECT	0x014c
-#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
-#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
-#define OMAP4_GPIO_CLEARDATAOUT		0x0190
-#define OMAP4_GPIO_SETDATAOUT		0x0194
-/*
- * omap34xx specific GPIO registers
- */
-
-#define OMAP34XX_GPIO1_BASE		0x48310000
-#define OMAP34XX_GPIO2_BASE		0x49050000
-#define OMAP34XX_GPIO3_BASE		0x49052000
-#define OMAP34XX_GPIO4_BASE		0x49054000
-#define OMAP34XX_GPIO5_BASE		0x49056000
-#define OMAP34XX_GPIO6_BASE		0x49058000
-
-/*
- * OMAP44XX  specific GPIO registers
- */
-#define OMAP44XX_GPIO1_BASE             0x4a310000
-#define OMAP44XX_GPIO2_BASE             0x48055000
-#define OMAP44XX_GPIO3_BASE             0x48057000
-#define OMAP44XX_GPIO4_BASE             0x48059000
-#define OMAP44XX_GPIO5_BASE             0x4805B000
-#define OMAP44XX_GPIO6_BASE             0x4805D000
-
-struct gpio_bank {
-	unsigned long pbase;
-	void __iomem *base;
-	u16 irq;
-	u16 virtual_irq_start;
-	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	u32 suspend_wakeup;
-	u32 saved_wakeup;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	u32 non_wakeup_gpios;
-	u32 enabled_non_wakeup_gpios;
-
-	u32 saved_datain;
-	u32 saved_fallingdetect;
-	u32 saved_risingdetect;
-#endif
-	u32 level_mask;
-	u32 toggle_mask;
-	spinlock_t lock;
-	struct gpio_chip chip;
-	struct clk *dbck;
-	u32 mod_usage;
-};
-
-#define METHOD_MPUIO		0
-#define METHOD_GPIO_1510	1
-#define METHOD_GPIO_1610	2
-#define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	5
-#define METHOD_GPIO_44XX	6
+#include <plat/gpio.h>
 
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
@@ -291,23 +103,7 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 		METHOD_GPIO_24XX },
 };
 
-struct omap3_gpio_regs {
-	u32 sysconfig;
-	u32 irqenable1;
-	u32 irqenable2;
-	u32 wake_en;
-	u32 ctrl;
-	u32 oe;
-	u32 leveldetect0;
-	u32 leveldetect1;
-	u32 risingdetect;
-	u32 fallingdetect;
-	u32 dataout;
-	u32 setwkuena;
-	u32 setdataout;
-};
-
-static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
+static struct omap_gpio_reg_val gpio_context[OMAP34XX_NR_GPIOS];
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -625,10 +421,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	if (cpu_is_omap44xx())
 		reg += OMAP4_GPIO_DEBOUNCENABLE;
 	else
 		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+#endif
 
 	if (!(bank->mod_usage & l)) {
 		printk(KERN_ERR "GPIO %d not requested\n", gpio);
@@ -676,10 +474,12 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 
 	enc_time &= 0xff;
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	if (cpu_is_omap44xx())
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
 	else
 		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
+#endif
 
 	__raw_writel(enc_time, reg);
 }
@@ -953,6 +753,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	}
 	__raw_writel(gpio_mask, reg);
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
@@ -962,9 +763,12 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		__raw_writel(gpio_mask, reg);
 
-	/* Flush posted write for the irq status to avoid spurious interrupts */
-	__raw_readl(reg);
+		/* Flush posted write for the irq status to
+		 * avoid spurious interrupts
+		 */
+		__raw_readl(reg);
 	}
+#endif
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -1198,6 +1002,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	if (!cpu_class_is_omap1()) {
 		if (!bank->mod_usage) {
 			u32 ctrl;
@@ -1208,6 +1013,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		}
 		bank->mod_usage |= 1 << offset;
 	}
+#endif
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1233,7 +1039,6 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 		__raw_writel(1 << offset, reg);
 	}
-#endif
 	if (!cpu_class_is_omap1()) {
 		bank->mod_usage &= ~(1 << offset);
 		if (!bank->mod_usage) {
@@ -1244,6 +1049,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
 		}
 	}
+#endif
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
@@ -1557,6 +1363,7 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 	void __iomem *reg = bank->base;
 
 	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_IO_CNTL;
 		break;
@@ -1569,10 +1376,13 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 	case METHOD_GPIO_7XX:
 		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
 	case METHOD_GPIO_44XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
+#endif
 	}
 	return __raw_readl(reg) & mask;
 }
@@ -1651,14 +1461,20 @@ static void __init omap_gpio_show_rev(void)
 {
 	u32 rev;
 
+#ifdef CONFIG_ARCH_OMAP1
 	if (cpu_is_omap16xx())
 		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
-	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	else
+		return;
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
 	else if (cpu_is_omap44xx())
 		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
 	else
 		return;
+#endif
 
 	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
 		(rev >> 4) & 0x0f, rev & 0x0f);
@@ -1791,6 +1607,7 @@ static int __init _omap_gpio_init(void)
 			continue;
 		}
 
+#ifdef CONFIG_ARCH_OMAP1
 		if (bank_is_mpuio(bank))
 			__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
 		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
@@ -1808,6 +1625,7 @@ static int __init _omap_gpio_init(void)
 
 			gpio_count = 32; /* 7xx has 32-bit GPIOs */
 		}
+#endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		if ((bank->method == METHOD_GPIO_24XX) ||
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de7c547..d154897 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -26,51 +26,140 @@
 #ifndef __ASM_ARCH_OMAP_GPIO_H
 #define __ASM_ARCH_OMAP_GPIO_H
 
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sysdev.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 #include <linux/io.h>
-#include <mach/irqs.h>
 
-#define OMAP1_MPUIO_BASE			0xfffb5000
-
-#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
-
-#define OMAP_MPUIO_INPUT_LATCH		0x00
-#define OMAP_MPUIO_OUTPUT		0x02
-#define OMAP_MPUIO_IO_CNTL		0x04
-#define OMAP_MPUIO_KBR_LATCH		0x08
-#define OMAP_MPUIO_KBC			0x0a
-#define OMAP_MPUIO_GPIO_EVENT_MODE	0x0c
-#define OMAP_MPUIO_GPIO_INT_EDGE	0x0e
-#define OMAP_MPUIO_KBD_INT		0x10
-#define OMAP_MPUIO_GPIO_INT		0x12
-#define OMAP_MPUIO_KBD_MASKIT		0x14
-#define OMAP_MPUIO_GPIO_MASKIT		0x16
-#define OMAP_MPUIO_GPIO_DEBOUNCING	0x18
-#define OMAP_MPUIO_LATCH		0x1a
-#else
-#define OMAP_MPUIO_INPUT_LATCH		0x00
-#define OMAP_MPUIO_OUTPUT		0x04
-#define OMAP_MPUIO_IO_CNTL		0x08
-#define OMAP_MPUIO_KBR_LATCH		0x10
-#define OMAP_MPUIO_KBC			0x14
-#define OMAP_MPUIO_GPIO_EVENT_MODE	0x18
-#define OMAP_MPUIO_GPIO_INT_EDGE	0x1c
-#define OMAP_MPUIO_KBD_INT		0x20
-#define OMAP_MPUIO_GPIO_INT		0x24
-#define OMAP_MPUIO_KBD_MASKIT		0x28
-#define OMAP_MPUIO_GPIO_MASKIT		0x2c
-#define OMAP_MPUIO_GPIO_DEBOUNCING	0x30
-#define OMAP_MPUIO_LATCH		0x34
-#endif
+#include <asm/irq.h>
+#include <asm-generic/gpio.h>
+#include <asm/mach/irq.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/gpio.h>
+#include <plat/cpu.h>
 
-#define OMAP34XX_NR_GPIOS		6
+#define METHOD_MPUIO		0
+#define METHOD_GPIO_1510	1
+#define METHOD_GPIO_1610	2
+#define METHOD_GPIO_7XX		3
+#define METHOD_GPIO_24XX	4
+#define METHOD_GPIO_44XX	5
 
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
-
 #define OMAP_GPIO_IRQ(nr)	(OMAP_GPIO_IS_MPUIO(nr) ? \
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int method;
+	char ick_name[11];
+	char fck_name[11];
+	char dbck_name[11];
+};
+
+struct gpio_reg_offset {
+	u32 data_in;
+	u32 data_out;
+	u32 data_out_set;
+	u32 data_out_clear;
+	u32 dir_ctrl;
+	u32 irq_status0;
+	u32 irq_status1;
+	u32 irq_mask;
+	u32 irq_ena2;
+	u32 irq_set;
+	u32 irq_clear;
+	u32 irq_mask_bits;
+	u32 irq_inv;
+	u32 wkup_enable;
+	u32 wkup_clear;
+	u32 wkup_set;
+	u32 debounce_ena;
+	u32 debounce_val;
+	u32 syscfg;
+	u32 leveldetect0;
+	u32 leveldetect1;
+	u32 rise_detect;
+	u32 fall_detect;
+	u32 ctrl;
+	u32 rev_reg;
+};
+
+struct mpu_gpio_reg_off {
+	u32 mpu_io_ctrl;
+	u32 mpu_data_out;
+	u32 mpu_data_in;
+	u32 mpu_isr;
+	u32 mpu_irq_mask;
+	u32 mpu_irq_mask_bits;
+	u32 mpu_irq_inv;
+};
+
+struct gpio_bank {
+	unsigned long pbase;
+	void __iomem *base;
+	u16 irq;
+	u16 virtual_irq_start;
+	int method;
+	u32 suspend_wakeup;
+	u32 saved_wakeup;
+	u32 non_wakeup_gpios;
+	u32 enabled_non_wakeup_gpios;
+	u32 saved_datain;
+	u32 saved_fallingdetect;
+	u32 saved_risingdetect;
+	u32 level_mask;
+	u32 toggle_mask;
+	u32 mod_usage;
+	u8 initialized;
+	spinlock_t lock; /*spinlock for gpio module */
+	struct gpio_chip chip;
+	struct clk *dbck;
+	struct clk *fck;
+	struct clk *ick;
+};
+
+struct omap_gpio_reg_val {
+	u32 sysconfig;
+	u32 irqenable1;
+	u32 irqenable2;
+	u32 wake_en;
+	u32 ctrl;
+	u32 oe;
+	u32 leveldetect0;
+	u32 leveldetect1;
+	u32 risingdetect;
+	u32 fallingdetect;
+	u32 dataout;
+	u32 setwkuena;
+	u32 setdataout;
+};
+
+struct omap_gpio_info {
+	struct	gpio_reg_offset *reg_off;	/* reg offsets */
+	struct	mpu_gpio_reg_off *mpu_reg;	/* mpu bank reg offsets */
+	struct	gpio_bank *gpio_bank;
+	u32	index_mask; /* mask value to get gpio index */
+	u32	no_of_gpio; /* total no of gpios */
+	u16	bank_count; /* total no of banks */
+	u16	bank_bits;  /* no of gpios in each bank */
+	int	(*set_gpio_triggering)(struct gpio_bank *bank, int gpio,
+				int trigger);
+	void	(*toggle_edge_triggering)(struct gpio_bank *bank,
+				int gpio);
+	struct	gpio_bank *(*get_gpio_bank)(int gpio,
+				struct gpio_bank *gpio_bank);
+	void	(*gpio_mod_init) (struct gpio_bank *bank, int i);
+};
+
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
-- 
1.6.3.3

