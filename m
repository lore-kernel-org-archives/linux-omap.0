From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: RFC: moving twl4030-gpio.c to gpiolib
Date: Thu, 20 Mar 2008 08:48:04 -0500
Message-ID: <2ac93e945a89055f387be8de57db8fc1@felipebalbi.com>
References: <34018b312a8887d22398822222184197@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42034 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbYCTNsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 09:48:06 -0400
In-Reply-To: <34018b312a8887d22398822222184197@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux omap <linux-omap@vger.kernel.org>, david-b@pacbell.net


After the patch from Kevin Hilman, I had to rebase my gpiolib patch

Here an updated version of it.

====== CUT HERE ======

diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c
b/arch/arm/mach-omap2/board-sdp-hsmmc.c
index 3ae5b20..df24be6 100644
--- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
+++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/gpio.h>
 #include <asm/hardware.h>
 #include <asm/arch/mmc.h>
 #include <asm/arch/board.h>
@@ -36,8 +37,9 @@
 #define MMC2_CD_IRQ		1
 
 static int sdp_mmc_card_detect(int irq)
+
 {
-	return twl4030_get_gpio_datain(irq - IH_TWL4030_GPIO_BASE);
+	return gpio_get_value(irq - IH_TWL4030_GPIO_BASE);
 }
 
 /*
@@ -50,11 +52,11 @@ static int sdp_mmc_late_init(struct device *dev)
 	/*
 	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
 	 */
-	ret = twl4030_request_gpio(MMC1_CD_IRQ);
+	ret = gpio_request(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ), "mmc1_cd_irq");
 	if (ret != 0)
 		goto err;
 
-	ret = twl4030_set_gpio_edge_ctrl(MMC1_CD_IRQ,
+	ret = twl4030_set_gpio_edge_ctrl(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
 			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
 	if (ret != 0)
 		goto err;
@@ -64,7 +66,8 @@ static int sdp_mmc_late_init(struct device *dev)
 	if (ret != 0)
 		goto err;
 
-	ret = twl4030_set_gpio_debounce(MMC1_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
+	ret = twl4030_set_gpio_debounce(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
+			TWL4030_GPIO_IS_ENABLE);
 	if (ret != 0)
 		goto err;
 
@@ -77,11 +80,7 @@ err:
 
 static void sdp_mmc_cleanup(struct device *dev)
 {
-	int ret = 0;
-
-	ret = twl4030_free_gpio(MMC1_CD_IRQ);
-	if (ret != 0)
-		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+	gpio_free(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bbd2834..c340333 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -61,6 +61,12 @@ config GPIO_PCF857X
 	  This driver provides an in-kernel interface to those GPIOs using
 	  platform-neutral GPIO calls.
 
+config GPIO_TWL4030
+	bool "TWL4030 GPIO Driver"
+	depends on I2C && TWL4030_CORE
+	help
+	  Say yes here to provide support for twl4030 gpio submodule.
+
 comment "SPI GPIO expanders:"
 
 config GPIO_MCP23S08
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdde992..346187e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
+obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
new file mode 100644
index 0000000..81ab4ce
--- /dev/null
+++ b/drivers/gpio/twl4030-gpio.c
@@ -0,0 +1,510 @@
+/*
+ * drivers/gpio/tlw4030-gpio.c - driver for TWL4030 GPIO MODULE
+ *
+ * Copyright (C) 2006-2007 Texas Instruments, Inc.
+ * Copyright (C) 2006 MontaVista Software, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Moved to gpiolib by:
+ *	Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * Code re-arranged and cleaned up by:
+ *	Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * Initial Code:
+ *	Andy Lowe / Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
+#include <asm/gpio.h>
+#include <asm/hardware.h>
+
+#define gpio_to_twl(x)	container_of((x), struct twl4030_gpio, chip)
+#define DATA_BANK_MAX	8
+#define GET_GPIO_DATA_BANK(x)	((x)/DATA_BANK_MAX)
+#define GET_GPIO_DATA_OFF(x)	((x)%DATA_BANK_MAX)
+
+/*
+ * GPIO Block Register definitions
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
+/* BitField Definitions */
+
+/* Data banks : 3 banks for 8 gpios each */
+#define DATA_BANK_MAX				8
+#define GET_GPIO_DATA_BANK(x)			((x)/DATA_BANK_MAX)
+#define GET_GPIO_DATA_OFF(x)			((x)%DATA_BANK_MAX)
+
+/* GPIODATADIR Fields each block 0-7 */
+#define BIT_GPIODATADIR_GPIOxDIR(x)		(x)
+#define MASK_GPIODATADIR_GPIOxDIR(x)		(0x01 << (x))
+
+/* GPIODATAIN Fields each block 0-7 */
+#define BIT_GPIODATAIN_GPIOxIN(x)		(x)
+#define MASK_GPIODATAIN_GPIOxIN(x)		(0x01 << (x))
+
+/* GPIODATAOUT Fields each block 0-7 */
+#define BIT_GPIODATAOUT_GPIOxOUT(x)		(x)
+#define MASK_GPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
+
+/* CLEARGPIODATAOUT Fields */
+#define BIT_CLEARGPIODATAOUT_GPIOxOUT(x)	(x)
+#define MASK_CLEARGPIODATAOUT_GPIOxOUT(x)	(0x01 << (x))
+
+/* SETGPIODATAOUT Fields */
+#define BIT_SETGPIODATAOUT_GPIOxOUT(x)		(x)
+#define MASK_SETGPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
+
+/* GPIO_DEBEN Fields */
+#define BIT_GPIO_DEBEN_GPIOxDEB(x)		(x)
+#define MASK_GPIO_DEBEN_GPIOxDEB(x)		(0x01 << (x))
+
+/* GPIO_ISR1A Fields */
+#define BIT_GPIO_ISR_GPIOxISR(x)		(x)
+#define MASK_GPIO_ISR_GPIOxISR(x)		(0x01 << (x))
+
+/* GPIO_IMR1A Fields */
+#define BIT_GPIO_IMR1A_GPIOxIMR(x)		(x)
+#define MASK_GPIO_IMR1A_GPIOxIMR(x)		(0x01 << (x))
+
+/* GPIO_SIR1 Fields */
+#define BIT_GPIO_SIR1_GPIOxSIR(x)		(x)
+#define MASK_GPIO_SIR1_GPIO0SIR			(0x01 << (x))
+
+
+/* Control banks : 5 banks for 4 gpios each */
+#define DATA_CTL_MAX			4
+#define GET_GPIO_CTL_BANK(x)		((x)/DATA_CTL_MAX)
+#define GET_GPIO_CTL_OFF(x)		((x)%DATA_CTL_MAX)
+#define GPIO_BANK_MAX			GET_GPIO_CTL_BANK(TWL4030_GPIO_MAX)
+
+/* GPIOPUPDCTRx Fields 5 banks of 4 gpios each */
+#define BIT_GPIOPUPDCTR1_GPIOxPD(x)	(2 *(x))
+#define MASK_GPIOPUPDCTR1_GPIOxPD(x)	(0x01 << (2*(x)))
+#define BIT_GPIOPUPDCTR1_GPIOxPU(x)	((x) + 1)
+#define MASK_GPIOPUPDCTR1_GPIOxPU(x)	(0x01 << (((2*(x)) + 1)))
+
+/* GPIO_EDR1 Fields */
+#define BIT_GPIO_EDR1_GPIOxFALLING(x)	(2 *(x))
+#define MASK_GPIO_EDR1_GPIOxFALLING(x)	(0x01 << (2*(x)))
+#define BIT_GPIO_EDR1_GPIOxRISING(x)	((x) + 1)
+#define MASK_GPIO_EDR1_GPIOxRISING(x)	(0x01 << (((2*(x)) + 1)))
+
+/* GPIO_SIH_CTRL Fields */
+#define BIT_GPIO_SIH_CTRL_EXCLEN	(0x000)
+#define MASK_GPIO_SIH_CTRL_EXCLEN	(0x00000001)
+#define BIT_GPIO_SIH_CTRL_PENDDIS	(0x001)
+#define MASK_GPIO_SIH_CTRL_PENDDIS	(0x00000002)
+#define BIT_GPIO_SIH_CTRL_COR		(0x002)
+#define MASK_GPIO_SIH_CTRL_COR		(0x00000004)
+
+/* GPIO_CTRL Fields */
+#define BIT_GPIO_CTRL_GPIO0CD1		(0x000)
+#define MASK_GPIO_CTRL_GPIO0CD1		(0x00000001)
+#define BIT_GPIO_CTRL_GPIO1CD2		(0x001)
+#define MASK_GPIO_CTRL_GPIO1CD2		(0x00000002)
+#define BIT_GPIO_CTRL_GPIO_ON		(0x002)
+#define MASK_GPIO_CTRL_GPIO_ON		(0x00000004)
+
+/* Mask for GPIO registers when aggregated into a 32-bit integer */
+#define GPIO_32_MASK			0x0003ffff
+
+struct twl4030_gpio {
+	struct gpio_chip	chip;
+	unsigned		out;		/* software latch */
+	struct mutex		mutex;
+};
+
+struct twl4030_gpio *the_gpio;
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * To configure TWL4030 GPIO module registers
+ */
+static inline int gpio_twl4030_write(u8 address, u8 data)
+{
+	int ret = 0;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
+	return ret;
+}
+
+/*
+ * To read a TWL4030 GPIO module register
+ */
+static inline int gpio_twl4030_read(u8 address)
+{
+	u8 data;
+	int ret = 0;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
+	if (ret >= 0)
+		ret = data;
+	return ret;
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* MMC Card Detect feature */
+int twl4030_set_gpio_mmc_card_detect(int gpio, int enable)
+{
+	int	ret;
+	u8	reg;
+	u8	msk = (1 << gpio);
+	u8	data;
+
+	/* Only GPIOs 0 and 1 can be used for Card Detect */
+	if (unlikely(/*(gpio >= TWL4030_GPIO_MAX) ||*/ gpio > 1))
+		return -EPERM;
+
+	mutex_lock(&the_gpio->mutex);
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, REG_GPIO_CTRL);
+	if (ret)
+		goto err;
+
+	if (enable)
+		reg = (data | msk);
+	else
+		reg = (data & ~msk);
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, REG_GPIO_CTRL);
+	if (ret)
+		goto err;
+	mutex_unlock(&the_gpio->mutex);
+
+	return 0;
+err:
+	printk(KERN_ERR "twl4030-gpio: %s failed with err %d\n", __FUNCTION__,
ret);
+	mutex_unlock(&the_gpio->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(twl4030_set_gpio_mmc_card_detect);
+
+/*-------------------------------------------------------------------------*/
+
+/* We need a little math here due to twl4030 i2c transfers.
+ *
+ * TWL4030 doesn't support smbus transfers so we need to manually guess
the register
+ * address based on the offset and after that reduce offset to a range
between 0-7
+ */
+static int twl4030_gpio_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct twl4030_gpio	*gpio = gpio_to_twl(chip);
+	u8			regaddr;
+
+	if (offset >= 0 && offset < 8)
+		regaddr = REG_GPIODATADIR1;
+	else if (offset >= 9 && offset < 15) {
+		regaddr = REG_GPIODATADIR2;
+		offset -= 8;
+	} else {
+		regaddr = REG_GPIODATADIR3;
+		offset -= 17;
+	}
+
+	gpio->out = (1 << offset);
+
+	return twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, gpio->out,
REG_GPIO_CTRL);
+}
+
+static int twl4030_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	int			ret;
+	u8			value;
+	u8			regaddr;
+
+	if (offset >= 0 && offset < 8)
+		regaddr = REG_GPIODATADIR1;
+	else if (offset >= 9 && offset < 15) {
+		regaddr = REG_GPIODATADIR2;
+		offset -= 8;
+	} else {
+		regaddr = REG_GPIODATADIR3;
+		offset -= 17;
+	}
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &value, REG_GPIO_CTRL);
+
+	return (ret < 0) ? 0 : (value & (1 << offset));
+}
+
+static int twl4030_gpio_output(struct gpio_chip *chip, unsigned offset,
int value)
+{
+	struct twl4030_gpio	*gpio = gpio_to_twl(chip);
+	u8			regaddr;
+
+	if (offset >= 0 && offset < 8)
+		regaddr = REG_GPIODATADIR1;
+	else if (offset >= 9 && offset < 15) {
+		regaddr = REG_GPIODATADIR2;
+		offset -= 8;
+	} else {
+		regaddr = REG_GPIODATADIR3;
+		offset -= 17;
+	}
+
+	gpio->out &= ~(1 << offset);
+
+	return twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, gpio->out,
REG_GPIO_CTRL);
+}
+
+static void twl4030_gpio_set(struct gpio_chip *chip, unsigned offset, int
value)
+{
+	twl4030_gpio_output(chip, offset, value);
+}
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Configure PULL type for a GPIO pin on TWL4030
+ */
+int twl4030_set_gpio_pull(int gpio, int pull_dircn)
+{
+	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
+	u8 c_off = GET_GPIO_CTL_OFF(gpio);
+	u8 c_msk = 0;
+	u8 reg = 0;
+	u8 base = 0;
+	int ret = 0;
+
+	if (unlikely(gpio >= TWL4030_GPIO_MAX))
+		return -EPERM;
+
+	base = REG_GPIOPUPDCTR1 + c_bnk;
+	if (pull_dircn == TWL4030_GPIO_PULL_DOWN)
+		c_msk = MASK_GPIOPUPDCTR1_GPIOxPD(c_off);
+	else if (pull_dircn == TWL4030_GPIO_PULL_UP)
+		c_msk = MASK_GPIOPUPDCTR1_GPIOxPU(c_off);
+
+	mutex_lock(&the_gpio->mutex);
+	ret = gpio_twl4030_read(base);
+	if (ret >= 0) {
+		/* clear the previous up/down values */
+		reg = (u8) (ret);
+		reg &= ~(MASK_GPIOPUPDCTR1_GPIOxPU(c_off) |
+			MASK_GPIOPUPDCTR1_GPIOxPD(c_off));
+		reg |= c_msk;
+		ret = gpio_twl4030_write(base, reg);
+	}
+	mutex_unlock(&the_gpio->mutex);
+	return ret;
+}
+EXPORT_SYMBOL(twl4030_set_gpio_pull);
+
+/*
+ * Configure Edge control for a GPIO pin on TWL4030
+ */
+int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
+{
+	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
+	u8 c_off = GET_GPIO_CTL_OFF(gpio);
+	u8 c_msk = 0;
+	u8 reg = 0;
+	u8 base = 0;
+	int ret = 0;
+
+	base = REG_GPIO_EDR1 + c_bnk;
+
+	if (edge & TWL4030_GPIO_EDGE_RISING)
+		c_msk |= MASK_GPIO_EDR1_GPIOxRISING(c_off);
+
+	if (edge & TWL4030_GPIO_EDGE_FALLING)
+		c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
+
+	mutex_lock(&the_gpio->mutex);
+	ret = gpio_twl4030_read(base);
+	if (ret >= 0) {
+		/* clear the previous rising/falling values */
+		reg =
+		(u8) (ret &
+			~(MASK_GPIO_EDR1_GPIOxFALLING(c_off) |
+			MASK_GPIO_EDR1_GPIOxRISING(c_off)));
+		reg |= c_msk;
+		ret = gpio_twl4030_write(base, reg);
+	}
+	mutex_unlock(&the_gpio->mutex);
+	return ret;
+}
+EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
+
+/*
+ * Configure debounce timing value for a GPIO pin on TWL4030
+ */
+int twl4030_set_gpio_debounce(int gpio, int enable)
+{
+	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
+	u8 d_msk = MASK_GPIO_DEBEN_GPIOxDEB(GET_GPIO_DATA_OFF(gpio));
+	u8 reg = 0;
+	u8 base = 0;
+	int ret = 0;
+
+	base = REG_GPIO_DEBEN1 + d_bnk;
+	mutex_lock(&the_gpio->mutex);
+	ret = gpio_twl4030_read(base);
+	if (ret >= 0) {
+		if (enable)
+			reg = (u8) ((ret) | (d_msk));
+		else
+			reg = (u8) ((ret) & ~(d_msk));
+
+		ret = gpio_twl4030_write(base, reg);
+	}
+	mutex_unlock(&the_gpio->mutex);
+	return ret;
+}
+EXPORT_SYMBOL(twl4030_set_gpio_debounce);
+
+/*
+ * Configure Card detect for GPIO pin on TWL4030
+ */
+int twl4030_set_gpio_card_detect(int gpio, int enable)
+{
+	u8 reg = 0;
+	u8 msk = (1 << gpio);
+	int ret = 0;
+
+	/* Only GPIO 0 or 1 can be used for CD feature.. */
+	if (unlikely((gpio >= TWL4030_GPIO_MAX)
+		|| (gpio >= TWL4030_GPIO_MAX_CD))) {
+		return -EPERM;
+	}
+
+	mutex_lock(&the_gpio->mutex);
+	ret = gpio_twl4030_read(REG_GPIO_CTRL);
+	if (ret >= 0) {
+		if (enable)
+			reg = (u8) (ret | msk);
+		else
+			reg = (u8) (ret & ~msk);
+
+		ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
+	}
+	mutex_unlock(&the_gpio->mutex);
+	return (ret);
+}
+EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
+
+/*-------------------------------------------------------------------------*/
+
+static int __init twl4030_gpio_init(void)
+{
+	struct twl4030_gpio	*gpio;
+	int			status = 0;
+
+	/* Allocate, initialize, and register this gpio_chip. */
+	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->chip.base = IH_TWL4030_BASE;
+	gpio->chip.can_sleep = 0;
+	gpio->chip.ngpio = 18;
+	gpio->chip.direction_input = twl4030_gpio_input;
+	gpio->chip.direction_output = twl4030_gpio_output;
+	gpio->chip.get = twl4030_gpio_get;
+	gpio->chip.set = twl4030_gpio_set;
+	gpio->chip.label = "twl4030-gpio",
+
+	the_gpio = gpio;
+
+	status = gpiochip_add(&gpio->chip);
+	if (status < 0)
+		goto fail;
+
+	/* Init gpio mutex */
+	mutex_init(&gpio->mutex);
+
+	printk(KERN_INFO "added gpios %d..%d on a %s\n",
+			gpio->chip.base,
+			gpio->chip.base + gpio->chip.ngpio - 1,
+			gpio->chip.label);
+
+	return 0;
+
+fail:
+	printk(KERN_ERR "twl4030-gpio: probe error %d\n", status);
+	kfree(gpio);
+	return status;
+}
+module_init(twl4030_gpio_init);
+
+static void __exit twl4030_gpio_exit(void)
+{
+	struct twl4030_gpio	*gpio = the_gpio;
+	int			status = 0;
+
+	status = gpiochip_remove(&gpio->chip);
+	if (status == 0) {
+		kfree(gpio);
+		the_gpio = NULL;
+	} else
+		printk(KERN_ERR "twl4030-gpio: %s --> %d\n", "remove", status);
+}
+module_exit(twl4030_gpio_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Texas Instruments, Inc., Nokia Corporation");
+
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bfab098..9b938a9 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -124,10 +124,6 @@ config TWL4030_CORE
 	help
 	  Say yes here if you have TWL4030 chip on your board
 
-config TWL4030_GPIO
-	bool "TWL4030 GPIO Driver"
-	depends on TWL4030_CORE
-
 config TWL4030_USB
 	bool "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 255fbb1..ca3c668 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
-obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
diff --git a/drivers/i2c/chips/twl4030-gpio.c
b/drivers/i2c/chips/twl4030-gpio.c
deleted file mode 100644
index a9f3b1d..0000000
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ /dev/null
@@ -1,836 +0,0 @@
-/*
- * linux/drivers/i2c/chips/twl4030_gpio.c
- *
- * Copyright (C) 2006-2007 Texas Instruments, Inc.
- * Copyright (C) 2006 MontaVista Software, Inc.
- *
- * Code re-arranged and cleaned up by:
- *	Syed Mohammed Khasim <x0khasim@ti.com>
- *
- * Initial Code:
- *	Andy Lowe / Nishanth Menon
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel_stat.h>
-#include <linux/init.h>
-#include <linux/time.h>
-#include <linux/interrupt.h>
-#include <linux/random.h>
-#include <linux/syscalls.h>
-#include <linux/kthread.h>
-
-#include <linux/i2c.h>
-#include <linux/i2c/twl4030.h>
-#include <linux/slab.h>
-
-#include <asm/arch/irqs.h>
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mux.h>
-
-#include <linux/device.h>
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
-/* BitField Definitions */
-
-/* Data banks : 3 banks for 8 gpios each */
-#define DATA_BANK_MAX				8
-#define GET_GPIO_DATA_BANK(x)			((x)/DATA_BANK_MAX)
-#define GET_GPIO_DATA_OFF(x)			((x)%DATA_BANK_MAX)
-
-/* GPIODATADIR Fields each block 0-7 */
-#define BIT_GPIODATADIR_GPIOxDIR(x)		(x)
-#define MASK_GPIODATADIR_GPIOxDIR(x)		(0x01 << (x))
-
-/* GPIODATAIN Fields each block 0-7 */
-#define BIT_GPIODATAIN_GPIOxIN(x)		(x)
-#define MASK_GPIODATAIN_GPIOxIN(x)		(0x01 << (x))
-
-/* GPIODATAOUT Fields each block 0-7 */
-#define BIT_GPIODATAOUT_GPIOxOUT(x)		(x)
-#define MASK_GPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
-
-/* CLEARGPIODATAOUT Fields */
-#define BIT_CLEARGPIODATAOUT_GPIOxOUT(x)	(x)
-#define MASK_CLEARGPIODATAOUT_GPIOxOUT(x)	(0x01 << (x))
-
-/* SETGPIODATAOUT Fields */
-#define BIT_SETGPIODATAOUT_GPIOxOUT(x)		(x)
-#define MASK_SETGPIODATAOUT_GPIOxOUT(x)		(0x01 << (x))
-
-/* GPIO_DEBEN Fields */
-#define BIT_GPIO_DEBEN_GPIOxDEB(x)		(x)
-#define MASK_GPIO_DEBEN_GPIOxDEB(x)		(0x01 << (x))
-
-/* GPIO_ISR1A Fields */
-#define BIT_GPIO_ISR_GPIOxISR(x)		(x)
-#define MASK_GPIO_ISR_GPIOxISR(x)		(0x01 << (x))
-
-/* GPIO_IMR1A Fields */
-#define BIT_GPIO_IMR1A_GPIOxIMR(x)		(x)
-#define MASK_GPIO_IMR1A_GPIOxIMR(x)		(0x01 << (x))
-
-/* GPIO_SIR1 Fields */
-#define BIT_GPIO_SIR1_GPIOxSIR(x)		(x)
-#define MASK_GPIO_SIR1_GPIO0SIR			(0x01 << (x))
-
-
-/* Control banks : 5 banks for 4 gpios each */
-#define DATA_CTL_MAX			4
-#define GET_GPIO_CTL_BANK(x)		((x)/DATA_CTL_MAX)
-#define GET_GPIO_CTL_OFF(x)		((x)%DATA_CTL_MAX)
-#define GPIO_BANK_MAX			GET_GPIO_CTL_BANK(TWL4030_GPIO_MAX)
-
-/* GPIOPUPDCTRx Fields 5 banks of 4 gpios each */
-#define BIT_GPIOPUPDCTR1_GPIOxPD(x)	(2 *(x))
-#define MASK_GPIOPUPDCTR1_GPIOxPD(x)	(0x01 << (2*(x)))
-#define BIT_GPIOPUPDCTR1_GPIOxPU(x)	((x) + 1)
-#define MASK_GPIOPUPDCTR1_GPIOxPU(x)	(0x01 << (((2*(x)) + 1)))
-
-/* GPIO_EDR1 Fields */
-#define BIT_GPIO_EDR1_GPIOxFALLING(x)	(2 *(x))
-#define MASK_GPIO_EDR1_GPIOxFALLING(x)	(0x01 << (2*(x)))
-#define BIT_GPIO_EDR1_GPIOxRISING(x)	((x) + 1)
-#define MASK_GPIO_EDR1_GPIOxRISING(x)	(0x01 << (((2*(x)) + 1)))
-
-/* GPIO_SIH_CTRL Fields */
-#define BIT_GPIO_SIH_CTRL_EXCLEN	(0x000)
-#define MASK_GPIO_SIH_CTRL_EXCLEN	(0x00000001)
-#define BIT_GPIO_SIH_CTRL_PENDDIS	(0x001)
-#define MASK_GPIO_SIH_CTRL_PENDDIS	(0x00000002)
-#define BIT_GPIO_SIH_CTRL_COR		(0x002)
-#define MASK_GPIO_SIH_CTRL_COR		(0x00000004)
-
-/* GPIO_CTRL Fields */
-#define BIT_GPIO_CTRL_GPIO0CD1		(0x000)
-#define MASK_GPIO_CTRL_GPIO0CD1		(0x00000001)
-#define BIT_GPIO_CTRL_GPIO1CD2		(0x001)
-#define MASK_GPIO_CTRL_GPIO1CD2		(0x00000002)
-#define BIT_GPIO_CTRL_GPIO_ON		(0x002)
-#define MASK_GPIO_CTRL_GPIO_ON		(0x00000004)
-
-/* Mask for GPIO registers when aggregated into a 32-bit integer */
-#define GPIO_32_MASK			0x0003ffff
-
-/* Data structures */
-static struct semaphore gpio_sem;
-
-/* store usage of each GPIO. - each bit represents one GPIO */
-static unsigned int gpio_usage_count;
-
-/* shadow the imr register */
-static unsigned int gpio_imr_shadow;
-
-/* bitmask of pending requests to unmask gpio interrupts */
-static unsigned int gpio_pending_unmask;
-
-/* pointer to gpio unmask thread struct */
-static struct task_struct *gpio_unmask_thread;
-
-static inline int gpio_twl4030_read(u8 address);
-static inline int gpio_twl4030_write(u8 address, u8 data);
-
-/*
- * Helper functions to read and write the GPIO ISR and IMR registers as
- * 32-bit integers. Functions return 0 on success, non-zero otherwise.
- * The caller must hold a lock on gpio_sem.
- */
-
-static int gpio_read_isr(unsigned int *isr)
-{
-	int ret;
-
-	*isr = 0;
-	ret = twl4030_i2c_read(TWL4030_MODULE_GPIO, (u8 *) isr,
-			REG_GPIO_ISR1A, 3);
-	le32_to_cpup(isr);
-	*isr &= GPIO_32_MASK;
-
-	return ret;
-}
-
-static int gpio_write_isr(unsigned int isr)
-{
-	isr &= GPIO_32_MASK;
-	/*
-	 * The buffer passed to the twl4030_i2c_write() routine must have an
-	 * extra byte at the beginning reserved for its internal use.
-	 */
-	isr <<= 8;
-	isr = cpu_to_le32(isr);
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, (u8 *) &isr,
-				REG_GPIO_ISR1A, 3);
-}
-
-static int gpio_write_imr(unsigned int imr)
-{
-	imr &= GPIO_32_MASK;
-	/*
-	 * The buffer passed to the twl4030_i2c_write() routine must have an
-	 * extra byte at the beginning reserved for its internal use.
-	 */
-	imr <<= 8;
-	imr = cpu_to_le32(imr);
-	return twl4030_i2c_write(TWL4030_MODULE_GPIO, (u8 *) &imr,
-				REG_GPIO_IMR1A, 3);
-}
-
-/*
- * These routines are analagous to the irqchip methods, but they are
designed
- * to be called from thread context with cpu interrupts enabled and with
no
- * locked spinlocks.  We call these routines from our custom IRQ handler
- * instead of the usual irqchip methods.
- */
-static void twl4030_gpio_mask_and_ack(unsigned int irq)
-{
-	int gpio = irq - IH_TWL4030_GPIO_BASE;
-
-	down(&gpio_sem);
-	/* mask */
-	gpio_imr_shadow |= (1 << gpio);
-	gpio_write_imr(gpio_imr_shadow);
-	/* ack */
-	gpio_write_isr(1 << gpio);
-	up(&gpio_sem);
-}
-
-static void twl4030_gpio_unmask(unsigned int irq)
-{
-	int gpio = irq - IH_TWL4030_GPIO_BASE;
-
-	down(&gpio_sem);
-	gpio_imr_shadow &= ~(1 << gpio);
-	gpio_write_imr(gpio_imr_shadow);
-	up(&gpio_sem);
-}
-
-/*
- * These are the irqchip methods for the TWL4030 GPIO interrupts.
- * Our IRQ handle method doesn't call these, but they will be called by
- * other routines such as setup_irq() and enable_irq().  They are called
- * with cpu interrupts disabled and with a lock on the irq_controller_lock
- * spinlock.  This complicates matters, because accessing the TWL4030 GPIO
- * interrupt controller requires I2C bus transactions that can't be
initiated
- * in this context.  Our solution is to defer accessing the interrupt
- * controller to a kernel thread.  We only need to support the unmask
method.
- */
-
-static void twl4030_gpio_mask_and_ack_irqchip(unsigned int irq) {}
-static void twl4030_gpio_mask_irqchip(unsigned int irq) {}
-
-static void twl4030_gpio_unmask_irqchip(unsigned int irq)
-{
-	int gpio = irq - IH_TWL4030_GPIO_BASE;
-
-	gpio_pending_unmask |= (1 << gpio);
-	if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
-		wake_up_process(gpio_unmask_thread);
-}
-
-static struct irq_chip twl4030_gpio_irq_chip = {
-	.name	= "twl4030-gpio",
-	.ack	= twl4030_gpio_mask_and_ack_irqchip,
-	.mask	= twl4030_gpio_mask_irqchip,
-	.unmask	= twl4030_gpio_unmask_irqchip,
-};
-
-/*
- * These are the irqchip methods for the TWL4030 PIH GPIO module
interrupt.
- * The PIH module doesn't have interrupt masking capability, so these
- * methods are NULL.
- */
-static void twl4030_gpio_module_ack(unsigned int irq) {}
-static void twl4030_gpio_module_mask(unsigned int irq) {}
-static void twl4030_gpio_module_unmask(unsigned int irq) {}
-static struct irq_chip twl4030_gpio_module_irq_chip = {
-	.ack	= twl4030_gpio_module_ack,
-	.mask	= twl4030_gpio_module_mask,
-	.unmask	= twl4030_gpio_module_unmask,
-};
-
-/*
- * twl4030 GPIO request function
- */
-int twl4030_request_gpio(int gpio)
-{
-	int ret = 0;
-
-	if (unlikely(gpio >= TWL4030_GPIO_MAX))
-		return -EPERM;
-
-	down(&gpio_sem);
-	if (gpio_usage_count & (0x1 << gpio))
-		ret = -EBUSY;
-	else {
-		u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
-		/* First time usage? - switch on GPIO module */
-		if (!gpio_usage_count) {
-			ret =
-			gpio_twl4030_write(REG_GPIO_CTRL,
-					MASK_GPIO_CTRL_GPIO_ON);
-			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
-		}
-		if (!ret)
-			gpio_usage_count |= (0x1 << gpio);
-
-		ret =
-		twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
-				REG_GPIOPUPDCTR1, 5);
-	}
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * TWL4030 GPIO free module
- */
-int twl4030_free_gpio(int gpio)
-{
-	int ret = 0;
-
-	if (unlikely(gpio >= TWL4030_GPIO_MAX))
-		return -EPERM;
-
-	down(&gpio_sem);
-
-	if ((gpio_usage_count & (0x1 << gpio)) == 0)
-		ret = -EPERM;
-	else
-		gpio_usage_count &= ~(0x1 << gpio);
-
-	/* Last time usage? - switch off GPIO module */
-	if (!gpio_usage_count)
-		ret = gpio_twl4030_write(REG_GPIO_CTRL, 0x0);
-
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * Set direction for TWL4030 GPIO
- */
-int twl4030_set_gpio_direction(int gpio, int is_input)
-{
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIODATADIR_GPIOxDIR(GET_GPIO_DATA_OFF(gpio));
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIODATADIR1 + d_bnk;
-
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		if (is_input)
-			reg = (u8) ((ret) & ~(d_msk));
-		else
-			reg = (u8) ((ret) | (d_msk));
-
-		ret = gpio_twl4030_write(base, reg);
-	}
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * To enable/disable GPIO pin on TWL4030
- */
-int twl4030_set_gpio_dataout(int gpio, int enable)
-{
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIODATAOUT_GPIOxOUT(GET_GPIO_DATA_OFF(gpio));
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	if (enable)
-		base = REG_SETGPIODATAOUT1 + d_bnk;
-	else
-		base = REG_CLEARGPIODATAOUT1 + d_bnk;
-
-	down(&gpio_sem);
-	ret = gpio_twl4030_write(base, d_msk);
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * To get the status of a GPIO pin on TWL4030
- */
-int twl4030_get_gpio_datain(int gpio)
-{
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_off = BIT_GPIODATAIN_GPIOxIN(GET_GPIO_DATA_OFF(gpio));
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIODATAIN1 + d_bnk;
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(base);
-	up(&gpio_sem);
-	if (ret > 0)
-		ret = (ret >> d_off) & 0x1;
-
-	return ret;
-}
-
-/*
- * Configure PULL type for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_pull(int gpio, int pull_dircn)
-{
-	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
-	u8 c_off = GET_GPIO_CTL_OFF(gpio);
-	u8 c_msk = 0;
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)	||
-		!(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIOPUPDCTR1 + c_bnk;
-	if (pull_dircn == TWL4030_GPIO_PULL_DOWN)
-		c_msk = MASK_GPIOPUPDCTR1_GPIOxPD(c_off);
-	else if (pull_dircn == TWL4030_GPIO_PULL_UP)
-		c_msk = MASK_GPIOPUPDCTR1_GPIOxPU(c_off);
-
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		/* clear the previous up/down values */
-		reg = (u8) (ret);
-		reg &= ~(MASK_GPIOPUPDCTR1_GPIOxPU(c_off) |
-			MASK_GPIOPUPDCTR1_GPIOxPD(c_off));
-		reg |= c_msk;
-		ret = gpio_twl4030_write(base, reg);
-	}
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * Configure Edge control for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
-{
-	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
-	u8 c_off = GET_GPIO_CTL_OFF(gpio);
-	u8 c_msk = 0;
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIO_EDR1 + c_bnk;
-
-	if (edge & TWL4030_GPIO_EDGE_RISING)
-		c_msk |= MASK_GPIO_EDR1_GPIOxRISING(c_off);
-
-	if (edge & TWL4030_GPIO_EDGE_FALLING)
-		c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
-
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		/* clear the previous rising/falling values */
-		reg =
-		(u8) (ret &
-			~(MASK_GPIO_EDR1_GPIOxFALLING(c_off) |
-			MASK_GPIO_EDR1_GPIOxRISING(c_off)));
-		reg |= c_msk;
-		ret = gpio_twl4030_write(base, reg);
-	}
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * Configure debounce timing value for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_debounce(int gpio, int enable)
-{
-	u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
-	u8 d_msk = MASK_GPIO_DEBEN_GPIOxDEB(GET_GPIO_DATA_OFF(gpio));
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIO_DEBEN1 + d_bnk;
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		if (enable)
-			reg = (u8) ((ret) | (d_msk));
-		else
-			reg = (u8) ((ret) & ~(d_msk));
-
-		ret = gpio_twl4030_write(base, reg);
-	}
-	up(&gpio_sem);
-	return ret;
-}
-
-/*
- * Configure Card detect for GPIO pin on TWL4030
- */
-int twl4030_set_gpio_card_detect(int gpio, int enable)
-{
-	u8 reg = 0;
-	u8 msk = (1 << gpio);
-	int ret = 0;
-
-	/* Only GPIO 0 or 1 can be used for CD feature.. */
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & (0x1 << gpio))
-		|| (gpio >= TWL4030_GPIO_MAX_CD))) {
-		return -EPERM;
-	}
-
-	down(&gpio_sem);
-	ret = gpio_twl4030_read(REG_GPIO_CTRL);
-	if (ret >= 0) {
-		if (enable)
-			reg = (u8) (ret | msk);
-		else
-			reg = (u8) (ret & ~msk);
-
-		ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
-	}
-	up(&gpio_sem);
-	return (ret);
-}
-
-/* MODULE FUNCTIONS */
-
-/*
- * To configure TWL4030 GPIO module registers
- */
-static inline int gpio_twl4030_write(u8 address, u8 data)
-{
-	int ret = 0;
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
-	return ret;
-}
-
-/*
- * To read a TWL4030 GPIO module register
- */
-static inline int gpio_twl4030_read(u8 address)
-{
-	u8 data;
-	int ret = 0;
-
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
-	if (ret >= 0)
-		ret = data;
-	return ret;
-}
-
-/*
- * gpio_unmask_thread() runs as a kernel thread.  It is awakened by the
unmask
- * method for the GPIO interrupts.  It unmasks all of the GPIO interrupts
- * specified in the gpio_pending_unmask bitmask.  We have to do the
unmasking
- * in a kernel thread rather than directly in the unmask method because of
the
- * need to access the TWL4030 via the I2C bus.  Note that we don't need to
be
- * concerned about race conditions where the request to unmask a GPIO
interrupt
- * has already been cancelled before this thread does the unmasking.  If a
GPIO
- * interrupt is improperly unmasked, then the IRQ handler for it will mask
it
- * when an interrupt occurs.
- */
-static int twl4030_gpio_unmask_thread(void *data)
-{
-	current->flags |= PF_NOFREEZE;
-
-	while (!kthread_should_stop()) {
-		int irq;
-		unsigned int gpio_unmask;
-
-		local_irq_disable();
-		gpio_unmask = gpio_pending_unmask;
-		gpio_pending_unmask = 0;
-		local_irq_enable();
-
-		for (irq = IH_TWL4030_GPIO_BASE; 0 != gpio_unmask;
-				gpio_unmask >>= 1, irq++) {
-			if (gpio_unmask & 0x1)
-				twl4030_gpio_unmask(irq);
-		}
-
-		local_irq_disable();
-		if (!gpio_pending_unmask)
-			set_current_state(TASK_INTERRUPTIBLE);
-		local_irq_enable();
-
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	return 0;
-}
-
-/*
- * do_twl4030_gpio_irq() is the desc->handle method for each of the
twl4030
- * gpio interrupts.  It executes in kernel thread context.
- * On entry, cpu interrupts are enabled.
- */
-static void do_twl4030_gpio_irq(unsigned int irq, irq_desc_t *desc)
-{
-	struct irqaction *action;
-	const unsigned int cpu = smp_processor_id();
-
-	desc->status |= IRQ_LEVEL;
-
-	/*
-	 * Acknowledge, clear _AND_ disable the interrupt.
-	 */
-	twl4030_gpio_mask_and_ack(irq);
-
-	if (!desc->depth) {
-		kstat_cpu(cpu).irqs[irq]++;
-
-		action = desc->action;
-		if (action) {
-			int ret;
-			int status = 0;
-			int retval = 0;
-			do {
-				/* Call the ISR with cpu interrupts enabled. */
-				ret = action->handler(irq, action->dev_id);
-				if (ret == IRQ_HANDLED)
-					status |= action->flags;
-				retval |= ret;
-				action = action->next;
-			} while (action);
-
-			if (retval != IRQ_HANDLED)
-				printk(KERN_ERR "ISR for TWL4030 GPIO"
-					" irq %d can't handle interrupt\n",
-					irq);
-
-			if (!desc->depth)
-				twl4030_gpio_unmask(irq);
-		}
-	}
-}
-
-/*
- * do_twl4030_gpio_module_irq() is the desc->handle method for the twl4030
gpio
- * module interrupt.  It executes in kernel thread context.
- * This is a chained interrupt, so there is no desc->action method for it.
- * We query the gpio module interrupt controller in the twl4030 to
determine
- * which gpio lines are generating interrupt requests, and then call the
- * desc->handle method for each gpio that needs service.
- * On entry, cpu interrupts are disabled.
- */
-static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
-{
-	const unsigned int cpu = smp_processor_id();
-
-	desc->status |= IRQ_LEVEL;
-	/*
-	* The desc->handle method would normally call the desc->chip->ack
-	* method here, but we won't bother since our ack method is NULL.
-	*/
-	if (!desc->depth) {
-		int gpio_irq;
-		unsigned int gpio_isr;
-
-		kstat_cpu(cpu).irqs[irq]++;
-		local_irq_enable();
-
-		down(&gpio_sem);
-		if (gpio_read_isr(&gpio_isr))
-			gpio_isr = 0;
-		up(&gpio_sem);
-
-		for (gpio_irq = IH_TWL4030_GPIO_BASE; 0 != gpio_isr;
-			gpio_isr >>= 1, gpio_irq++) {
-			if (gpio_isr & 0x1) {
-				irq_desc_t *d = irq_desc + gpio_irq;
-				d->handle_irq(gpio_irq, d);
-			}
-		}
-
-		local_irq_disable();
-		/*
-		 * Here is where we should call the unmask method, but again we
-		 * won't bother since it is NULL.
-		 */
-	}
-}
-
-/* TWL4030 Initialization module */
-static int __init gpio_twl4030_init(void)
-{
-	int ret;
-	int irq = 0;
-
-	/* init the global locking sem */
-	sema_init(&gpio_sem, 1);
-
-	/* All GPIO interrupts are initially masked */
-	gpio_pending_unmask = 0;
-	gpio_imr_shadow = GPIO_32_MASK;
-	ret = gpio_write_imr(gpio_imr_shadow);
-	if (!ret) {
-		/*
-		 * Create a kernel thread to handle deferred unmasking of gpio
-		 * interrupts.
-		 */
-		gpio_unmask_thread = kthread_create(twl4030_gpio_unmask_thread,
-			NULL, "twl4030 gpio");
-		if (!gpio_unmask_thread) {
-			printk(KERN_ERR
-				"%s: could not create twl4030 gpio unmask thread!\n",
-				__FUNCTION__);
-			ret = -ENOMEM;
-		}
-	}
-
-	if (!ret) {
-		/* install an irq handler for each of the gpio interrupts */
-		for (irq = IH_TWL4030_GPIO_BASE; irq < IH_TWL4030_GPIO_END;
-			irq++) {
-			set_irq_chip(irq, &twl4030_gpio_irq_chip);
-			set_irq_handler(irq, do_twl4030_gpio_irq);
-			set_irq_flags(irq, IRQF_VALID);
-		}
-
-		/*
-		 * Install an irq handler to demultiplex the gpio module
-		 * interrupt.
-		 */
-		set_irq_chip(TWL4030_MODIRQ_GPIO,
-			&twl4030_gpio_module_irq_chip);
-		set_irq_chained_handler(TWL4030_MODIRQ_GPIO,
-			do_twl4030_gpio_module_irq);
-	}
-
-	printk(KERN_INFO "TWL4030 GPIO Demux: IRQ Range %d to %d,"
-		" Initialization %s\n", IH_TWL4030_GPIO_BASE,
-		IH_TWL4030_GPIO_END, (ret) ? "Failed" : "Success");
-	return ret;
-}
-
-/* TWL GPIO exit module */
-static void __exit gpio_twl4030_exit(void)
-{
-	int irq;
-
-	/* uninstall the gpio demultiplexing interrupt handler */
-	set_irq_handler(TWL4030_MODIRQ_GPIO, NULL);
-	set_irq_flags(TWL4030_MODIRQ_GPIO, 0);
-
-	/* uninstall the irq handler for each of the gpio interrupts */
-	for (irq = IH_TWL4030_GPIO_BASE; irq < IH_TWL4030_GPIO_END; irq++) {
-		set_irq_handler(irq, NULL);
-		set_irq_flags(irq, 0);
-	}
-
-	/* stop the gpio unmask kernel thread */
-	if (gpio_unmask_thread) {
-		kthread_stop(gpio_unmask_thread);
-		gpio_unmask_thread = NULL;
-	}
-}
-
-module_init(gpio_twl4030_init);
-module_exit(gpio_twl4030_exit);
-
-EXPORT_SYMBOL(twl4030_request_gpio);
-EXPORT_SYMBOL(twl4030_free_gpio);
-EXPORT_SYMBOL(twl4030_set_gpio_direction);
-EXPORT_SYMBOL(twl4030_set_gpio_dataout);
-EXPORT_SYMBOL(twl4030_get_gpio_datain);
-EXPORT_SYMBOL(twl4030_set_gpio_pull);
-EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
-EXPORT_SYMBOL(twl4030_set_gpio_debounce);
-EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
-
-MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("GPIO interface for TWL4030");
-MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-omap/board-3430sdp.h
b/include/asm-arm/arch-omap/board-3430sdp.h
index 06379cf..801e21b 100644
--- a/include/asm-arm/arch-omap/board-3430sdp.h
+++ b/include/asm-arm/arch-omap/board-3430sdp.h
@@ -67,23 +67,17 @@ extern void sdp_mmc_init(void);
 #define FLASH_SIZE_SDPV1	SZ_64M
 #define FLASH_SIZE_SDPV2	SZ_128M
 
-#ifdef CONFIG_TWL4030_CORE
-
 #define TWL4030_IRQNUM INT_34XX_SYS_NIRQ
 
 /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
 #define	IH_TWL4030_BASE		IH_BOARD_BASE
 #define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
 
-#ifdef CONFIG_TWL4030_GPIO
-
 /* TWL4030 GPIO Interrupts */
 #define IH_TWL4030_GPIO_BASE	(IH_TWL4030_END)
 #define IH_TWL4030_GPIO_END	(IH_TWL4030_BASE+18)
 #define NR_IRQS			(IH_TWL4030_GPIO_END)
-#else
-#define NR_IRQS			(IH_TWL4030_END)
-#endif /* CONFIG_I2C_TWL4030_GPIO */
-#endif /* End of support for TWL4030 */
+#define ARCH_NR_GPIOS		NR_IRQS
+
 #endif /*  __ASM_ARCH_OMAP_3430SDP_H */
 
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 7f9b90d..97e8228 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -109,8 +109,6 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8
num_bytes);
 /*
  * Exported TWL4030 GPIO APIs
  */
-int twl4030_get_gpio_datain(int gpio);
-int twl4030_request_gpio(int gpio);
 int twl4030_set_gpio_edge_ctrl(int gpio, int edge);
 int twl4030_set_gpio_debounce(int gpio, int enable);
 int twl4030_free_gpio(int gpio);


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

