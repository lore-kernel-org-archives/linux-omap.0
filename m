From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Clean-up MMC device init (Was:
	[PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data)
Date: Tue, 16 Sep 2008 18:52:05 -0700
Message-ID: <20080917015204.GE25885@atomide.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com> <20080911181312.GC4986@flint.arm.linux.org.uk> <20080912004848.GO21163@atomide.com> <20080913095946.GA24437@flint.arm.linux.org.uk> <20080913171134.GB27348@atomide.com> <20080916231356.GB25885@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54070 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYIQBwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 21:52:14 -0400
Content-Disposition: inline
In-Reply-To: <20080916231356.GB25885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080916 16:14]:
> * Tony Lindgren <tony@atomide.com> [080913 10:12]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080913 03:00]:
> > > On Thu, Sep 11, 2008 at 05:48:49PM -0700, Tony Lindgren wrote:
> 
> <snip>
> 
> > > Maybe these functions should also be taking note of info->nr_slots?
> > > Though I don't particularly like the way 'info' is shared between both
> > > controllers.  It's more usual to pass a data structure to drivers
> > > describing just the data for _this_ instance of the device.
> > 
> > Let's see if that can be sorted out too. Some implementations multiplex
> > the slot over I2C.
> > 
> > > Now, when you come across a device with three controllers, you're not
> > > modifying arch/arm/plat-omap/devices.c to add that third controller -
> > > you're just creating the omapN_init_mmc() function with another
> > > omap_mmc_add() line.
> > > 
> > > As an added bonus, notice the lack of nasty #ifdef's scattered in there
> > > as well.
> > 
> > Yeah that's good.
> > 
> > > Oh, and I see little reason for checking for NULL data in these functions -
> > > they clearly don't take NULL data, and if someone passes NULL data, they
> > > deserve to oops - and hopefully they'll fix their code.
> > 
> > OK
> 
> Here's the patch updated. If necessary, the patch could be broken into
> several parts.
> 
> Turns out that the omap1 MMC support has been pretty badly broken for
> a while now. I ended up removing all the obviously broken MMC
> configurations, and only try to revive the ones that seem like
> they should work. I also removed the cover switch handling that needs
> to be reimplemented using gpio chip instead.

Here's the patch with few compile and whitespace warnings fixed.

> Regards,
> 
> Tony


--JP+T4n/bALQSJXh8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-mmc-init-v3.patch"

>From abd024013c6e66805b31877492172e1b2ac07b75 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 16 Sep 2008 18:51:25 -0700
Subject: [PATCH] ARM: OMAP: Clean-up MMC device init

Clean-up MMC device init:

- Initialize devices in mach-omap1/devices.c and mach-omap2/devices.c
  instead of plat-omap/devices.c

- Allocate MMC devices dynamically as suggested by Russell King

- Remove old struct omap_mmc_config, use struct omap_mmc_platform_data instead

- Fix omap1 mmc clock instance number

- Remove obviously broken MMC configurations. Those can be patched back
  in later on when they work

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index ab9ee58..e6ab560 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -12,90 +12,55 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/platform_device.h>
+
+#include <linux/i2c/tps65010.h>
+
 #include <mach/mmc.h>
 #include <mach/gpio.h>
 
-#ifdef CONFIG_MMC_OMAP
-static int slot_cover_open;
-static struct device *mmc_device;
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
-static int h2_mmc_set_power(struct device *dev, int slot, int power_on,
+static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
-		power_on ? "on" : "off", vdd);
-#endif
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int h2_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
-{
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
-		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
-#endif
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
+	if (power_on)
+		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 1);
+	else
+		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
 
 	return 0;
 }
 
-static int h2_mmc_get_cover_state(struct device *dev, int slot)
-{
-	BUG_ON(slot != 0);
-
-	return slot_cover_open;
-}
-
-void h2_mmc_slot_cover_handler(void *arg, int state)
-{
-	if (mmc_device == NULL)
-		return;
-
-	slot_cover_open = state;
-	omap_mmc_notify_cover_event(mmc_device, 0, state);
-}
-
-static int h2_mmc_late_init(struct device *dev)
-{
-	int ret = 0;
-
-	mmc_device = dev;
-
-	return ret;
-}
-
-static void h2_mmc_cleanup(struct device *dev)
-{
-}
-
-static struct omap_mmc_platform_data h2_mmc_data = {
+/*
+ * H2 could use the following functions tested:
+ * - mmc_get_cover_state that uses OMAP_MPUIO(1)
+ * - mmc_get_wp that uses OMAP_MPUIO(3)
+ */
+static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
-	.switch_slot                    = NULL,
-	.init                           = h2_mmc_late_init,
-	.cleanup                        = h2_mmc_cleanup,
+	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
-		.set_power              = h2_mmc_set_power,
-		.set_bus_mode           = h2_mmc_set_bus_mode,
-		.get_ro                 = NULL,
-		.get_cover_state        = h2_mmc_get_cover_state,
+		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   = "mmcblk",
 	},
 };
 
+static struct omap_mmc_platform_data *mmc_data[OMAP16XX_NR_MMC];
+
 void __init h2_mmc_init(void)
 {
-	omap_set_mmc_info(1, &h2_mmc_data);
+	int ret;
+
+	ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	if (ret < 0)
+		return;
+	gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
+
+	mmc_data[0] = &mmc1_data;
+	omap1_init_mmc(mmc_data, OMAP16XX_NR_MMC);
 }
 
 #else
@@ -104,7 +69,4 @@ void __init h2_mmc_init(void)
 {
 }
 
-void h2_mmc_slot_cover_handler(void *arg, int state)
-{
-}
 #endif
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 3b65914..9e106eb 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -348,10 +348,25 @@ static void __init h2_init_smc91x(void)
 	}
 }
 
+static int h2_tps_setup(struct i2c_client *client, void *context)
+{
+	tps65010_config_vregs1(TPS_LDO2_ENABLE | TPS_VLDO2_3_0V |
+				TPS_LDO1_ENABLE | TPS_VLDO1_3_0V);
+
+	return 0;
+}
+
+static struct tps65010_board tps_board = {
+	.base		= H2_TPS_GPIO_BASE,
+	.outmask	= 0x0f,
+	.setup		= h2_tps_setup,
+};
+
 static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
 		.irq            = OMAP_GPIO_IRQ(58),
+		.platform_data	= &tps_board,
 	}, {
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
 		.irq		= OMAP_GPIO_IRQ(2),
@@ -381,15 +396,6 @@ static struct omap_usb_config h2_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h2_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-	},
-};
-
-extern struct omap_mmc_platform_data h2_mmc_data;
-
 static struct omap_uart_config h2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -400,7 +406,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h2_usb_config },
-	{ OMAP_TAG_MMC,		&h2_mmc_config },
 	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 3608581..fdfe793 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -12,94 +12,55 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/platform_device.h>
+
+#include <linux/i2c/tps65010.h>
+
 #include <mach/mmc.h>
 #include <mach/gpio.h>
 
-#ifdef CONFIG_MMC_OMAP
-static int slot_cover_open;
-static struct device *mmc_device;
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
-static int h3_mmc_set_power(struct device *dev, int slot, int power_on,
+static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
-		power_on ? "on" : "off", vdd);
-#endif
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
+	if (power_on)
+		gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 1);
+	else
+		gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 0);
 
 	return 0;
 }
 
-static int h3_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
-{
-	int ret = 0;
-
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
-		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
-#endif
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
-
-	/* Treated on upper level */
-
-	return bus_mode;
-}
-
-static int h3_mmc_get_cover_state(struct device *dev, int slot)
-{
-	BUG_ON(slot != 0);
-
-	return slot_cover_open;
-}
-
-void h3_mmc_slot_cover_handler(void *arg, int state)
-{
-	if (mmc_device == NULL)
-		return;
-
-	slot_cover_open = state;
-	omap_mmc_notify_cover_event(mmc_device, 0, state);
-}
-
-static int h3_mmc_late_init(struct device *dev)
-{
-	int ret = 0;
-
-	mmc_device = dev;
-
-	return ret;
-}
-
-static void h3_mmc_cleanup(struct device *dev)
-{
-}
-
-static struct omap_mmc_platform_data h3_mmc_data = {
+/*
+ * H3 could use the following functions tested:
+ * - mmc_get_cover_state that uses OMAP_MPUIO(1)
+ * - mmc_get_wp that maybe uses OMAP_MPUIO(3)
+ */
+static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
-	.switch_slot                    = NULL,
-	.init                           = h3_mmc_late_init,
-	.cleanup                        = h3_mmc_cleanup,
+	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
-		.set_power              = h3_mmc_set_power,
-		.set_bus_mode           = h3_mmc_set_bus_mode,
-		.get_ro                 = NULL,
-		.get_cover_state        = h3_mmc_get_cover_state,
+		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   = "mmcblk",
 	},
 };
 
+static struct omap_mmc_platform_data *mmc_data[OMAP16XX_NR_MMC];
+
 void __init h3_mmc_init(void)
 {
-	omap_set_mmc_info(1, &h3_mmc_data);
+	int ret;
+
+	ret = gpio_request(H3_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	if (ret < 0)
+		return;
+	gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 0);
+
+	mmc_data[0] = &mmc1_data;
+	omap1_init_mmc(mmc_data, OMAP16XX_NR_MMC);
 }
 
 #else
@@ -108,7 +69,4 @@ void __init h3_mmc_init(void)
 {
 }
 
-void h3_mmc_slot_cover_handler(void *arg, int state)
-{
-}
 #endif
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 2ced6d9..ff9bbe2 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -447,15 +447,6 @@ static struct omap_usb_config h3_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h3_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-       },
-};
-
-extern struct omap_mmc_platform_data h3_mmc_data;
-
 static struct omap_uart_config h3_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -466,7 +457,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h3_usb_config },
-	{ OMAP_TAG_MMC,		&h3_mmc_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cbc11be..7a97f6b 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -39,6 +39,7 @@
 #include <mach/common.h>
 #include <mach/mcbsp.h>
 #include <mach/omap-alsa.h>
+#include <mach/mmc.h>
 
 static int innovator_keymap[] = {
 	KEY(0, 0, KEY_F1),
@@ -360,16 +361,49 @@ static struct omap_lcd_config innovator1610_lcd_config __initdata = {
 };
 #endif
 
-static struct omap_mmc_config innovator_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 1,
-		.wp_pin		= OMAP_MPUIO(3),
-		.power_pin	= -1,	/* FPGA F3 UIO42 */
-		.switch_pin	= -1,	/* FPGA F4 UIO43 */
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+
+static int mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	if (power_on)
+		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
+				OMAP1510_FPGA_POWER);
+	else
+		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
+				OMAP1510_FPGA_POWER);
+
+	return 0;
+}
+
+/*
+ * Innovator could use the following functions tested:
+ * - mmc_get_wp that uses OMAP_MPUIO(3)
+ * - mmc_get_cover_state that uses FPGA F4 UIO43
+ */
+static struct omap_mmc_platform_data mmc1_data = {
+	.nr_slots                       = 1,
+	.slots[0]       = {
+		.set_power		= mmc_set_power,
+		.wire4			= 1,
+		.name                   = "mmcblk",
 	},
 };
 
+static struct omap_mmc_platform_data *mmc_data[OMAP16XX_NR_MMC];
+
+void __init innovator_mmc_init(void)
+{
+	mmc_data[0] = &mmc1_data;
+	omap1_init_mmc(mmc_data, OMAP15XX_NR_MMC);
+}
+
+#else
+static inline void innovator_mmc_init(void)
+{
+}
+#endif
+
 static struct omap_uart_config innovator_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -377,7 +411,6 @@ static struct omap_uart_config innovator_uart_config __initdata = {
 static struct omap_board_config_kernel innovator_config[] = {
 	{ OMAP_TAG_USB,         NULL },
 	{ OMAP_TAG_LCD,		NULL },
-	{ OMAP_TAG_MMC,		&innovator_mmc_config },
 	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
 
@@ -412,6 +445,7 @@ static void __init innovator_init(void)
 	omap_board_config_size = ARRAY_SIZE(innovator_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	innovator_mmc_init();
 }
 
 static void __init innovator_map_io(void)
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 38d9783..c008ed8 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -35,6 +35,7 @@
 #include <mach/aic23.h>
 #include <mach/omapfb.h>
 #include <mach/lcd_mipid.h>
+#include <mach/mmc.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
@@ -173,26 +174,68 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.pins[0]	= 6,
 };
 
-static struct omap_mmc_config nokia770_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-	.mmc[1] = {
-		.enabled	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
+if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+
+#define NOKIA770_GPIO_MMC_POWER		41
+#define NOKIA770_GPIO_MMC_SWITCH	23
+
+static int nokia770_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	if (power_on)
+		gpio_set_value(NOKIA770_GPIO_MMC_POWER, 1);
+	else
+		gpio_set_value(NOKIA770_GPIO_MMC_POWER, 0);
+
+	return 0;
+}
+
+static int nokia770_mmc_get_cover_state(struct device *dev, int slot)
+{
+	return gpio_get_value(NOKIA770_GPIO_MMC_SWITCH);
+}
+
+static struct omap_mmc_platform_data nokia770_mmc2_data = {
+	.nr_slots                       = 1,
+	.dma_mask			= 0xffffffff,
+	.slots[0]       = {
+		.set_power		= nokia770_mmc_set_power,
+		.get_cover_state	= nokia770_mmc_get_cover_state,
+		.name                   = "mmcblk",
 	},
 };
 
+static struct omap_mmc_platform_data *nokia770_mmc_data[OMAP16XX_NR_MMC];
+
+static void __init nokia770_mmc_init(void)
+{
+	int ret;
+
+	ret = gpio_request(NOKIA770_GPIO_MMC_POWER, "MMC power");
+	if (ret < 0)
+		return;
+	gpio_direction_output(NOKIA770_GPIO_MMC_POWER, 0);
+
+	ret = gpio_request(NOKIA770_GPIO_MMC_SWITCH, "MMC cover");
+	if (ret < 0) {
+		gpio_free(NOKIA770_GPIO_MMC_POWER);
+		return;
+	}
+	gpio_direction_input(NOKIA770_GPIO_MMC_SWITCH);
+
+	/* Only the second MMC controller is used */
+	nokia770_mmc_data[1] = &nokia770_mmc2_data;
+	omap1_init_mmc(nokia770_mmc_data, OMAP16XX_NR_MMC);
+}
+
+#else
+static inline void nokia770_mmc_init(void)
+{
+}
+#endif
+
 static struct omap_board_config_kernel nokia770_config[] __initdata = {
 	{ OMAP_TAG_USB,		NULL },
-	{ OMAP_TAG_MMC,		&nokia770_mmc_config },
 };
 
 #if	defined(CONFIG_OMAP_DSP)
@@ -335,6 +378,7 @@ static void __init omap_nokia770_init(void)
 	omap_dsp_init();
 	ads7846_dev_init();
 	mipid_dev_init();
+	nokia770_mmc_init();
 }
 
 static void __init omap_nokia770_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index b580436..86e927b 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -195,15 +195,6 @@ static struct omap_usb_config palmte_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_mmc_config palmte_mmc_config __initdata = {
-	.mmc[0]		= {
-		.enabled 	= 1,
-		.wp_pin		= PALMTE_MMC_WP_GPIO,
-		.power_pin	= PALMTE_MMC_POWER_GPIO,
-		.switch_pin	= PALMTE_MMC_SWITCH_GPIO,
-	},
-};
-
 static struct omap_lcd_config palmte_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -316,7 +307,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_USB,		&palmte_usb_config },
-	{ OMAP_TAG_MMC,		&palmte_mmc_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
 	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e719294..e8116c5 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -267,16 +267,6 @@ static struct omap_usb_config palmz71_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_mmc_config palmz71_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 0,
-		.wp_pin		= PALMZ71_MMC_WP_GPIO,
-		.power_pin	= -1,
-		.switch_pin	= PALMZ71_MMC_IN_GPIO,
-	},
-};
-
 static struct omap_lcd_config palmz71_lcd_config __initdata = {
 	.ctrl_name = "internal",
 };
@@ -287,7 +277,6 @@ static struct omap_uart_config palmz71_uart_config __initdata = {
 
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
 	{OMAP_TAG_USB,	&palmz71_usb_config},
-	{OMAP_TAG_MMC,	&palmz71_mmc_config},
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
 	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 0be4eba..66a4d7d 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -12,30 +12,20 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/platform_device.h>
+
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/gpio.h>
 
-#ifdef CONFIG_MMC_OMAP
-static int slot_cover_open;
-static struct device *mmc_device;
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
-static int sx1_mmc_set_power(struct device *dev, int slot, int power_on,
+static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
 	int err;
 	u8 dat = 0;
 
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
-		power_on ? "on" : "off", vdd);
-#endif
-
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
-
 	err = sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
 	if (err < 0)
 		return err;
@@ -48,68 +38,23 @@ static int sx1_mmc_set_power(struct device *dev, int slot, int power_on,
 	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
 
-static int sx1_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
-{
-#ifdef CONFIG_MMC_DEBUG
-	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
-		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
-#endif
-	if (slot != 0) {
-		dev_err(dev, "No such slot %d\n", slot + 1);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int sx1_mmc_get_cover_state(struct device *dev, int slot)
-{
-	BUG_ON(slot != 0);
-
-	return slot_cover_open;
-}
-
-void sx1_mmc_slot_cover_handler(void *arg, int state)
-{
-	if (mmc_device == NULL)
-		return;
-
-	slot_cover_open = state;
-	omap_mmc_notify_cover_event(mmc_device, 0, state);
-}
-
-static int sx1_mmc_late_init(struct device *dev)
-{
-	int ret = 0;
-
-	mmc_device = dev;
-
-	return ret;
-}
-
-static void sx1_mmc_cleanup(struct device *dev)
-{
-}
-
-static struct omap_mmc_platform_data sx1_mmc_data = {
+/* Cover switch is at OMAP_MPUIO(3) */
+static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
-	.switch_slot                    = NULL,
-	.init                           = sx1_mmc_late_init,
-	.cleanup                        = sx1_mmc_cleanup,
 	.slots[0]       = {
-		.set_power              = sx1_mmc_set_power,
-		.set_bus_mode           = sx1_mmc_set_bus_mode,
-		.get_ro                 = NULL,
-		.get_cover_state        = sx1_mmc_get_cover_state,
+		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
 					  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   = "mmcblk",
 	},
 };
 
+static struct omap_mmc_platform_data *mmc_data[OMAP15XX_NR_MMC];
+
 void __init sx1_mmc_init(void)
 {
-	omap_set_mmc_info(1, &sx1_mmc_data);
+	mmc_data[0] = &mmc1_data;
+	omap1_init_mmc(mmc_data, OMAP15XX_NR_MMC);
 }
 
 #else
@@ -118,7 +63,4 @@ void __init sx1_mmc_init(void)
 {
 }
 
-void sx1_mmc_slot_cover_handler(void *arg, int state)
-{
-}
 #endif
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 130bcc6..f915839 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -378,15 +378,6 @@ static struct omap_usb_config sx1_usb_config __initdata = {
 	.pins[2]	= 0,
 };
 
-/*----------- MMC -------------------------*/
-
-static struct omap_mmc_config sx1_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled	= 1,
-		.wire4		= 0,
-	},
-};
-
 /*----------- LCD -------------------------*/
 
 static struct platform_device sx1_lcd_device = {
@@ -414,7 +405,6 @@ static struct omap_uart_config sx1_uart_config __initdata = {
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_USB,	&sx1_usb_config },
-	{ OMAP_TAG_MMC,	&sx1_mmc_config },
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
@@ -443,7 +433,6 @@ static void __init omap_sx1_init(void)
 	omap_set_gpio_dataout(1, 1);/*A_IRDA_OFF = 1 */
 	omap_set_gpio_dataout(11, 0);/*A_SWITCH = 0 */
 	omap_set_gpio_dataout(15, 0);/*A_USB_ON = 0 */
-
 }
 /*----------------------------------------*/
 static void __init omap_sx1_init_irq(void)
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 213b487..2b1631b 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -139,21 +139,12 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_mmc_config voiceblue_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.power_pin	= 2,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_uart_config voiceblue_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel voiceblue_config[] = {
 	{ OMAP_TAG_USB,  &voiceblue_usb_config },
-	{ OMAP_TAG_MMC,  &voiceblue_mmc_config },
 	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 5635b51..c1dcdf1 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -705,7 +705,6 @@ static struct clk bclk_16xx = {
 
 static struct clk mmc1_ck = {
 	.name		= "mmc_ck",
-	.id		= 1,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
@@ -720,7 +719,7 @@ static struct clk mmc1_ck = {
 
 static struct clk mmc2_ck = {
 	.name		= "mmc_ck",
-	.id		= 2,
+	.id		= 1,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 99982d3..4801513 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -22,6 +22,7 @@
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -99,6 +100,95 @@ static inline void omap_init_mbox(void)
 static inline void omap_init_mbox(void) { }
 #endif
 
+/*-------------------------------------------------------------------------*/
+
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+
+static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
+			int controller_nr)
+{
+	if (controller_nr == 0) {
+		omap_cfg_reg(MMC_CMD);
+		omap_cfg_reg(MMC_CLK);
+		omap_cfg_reg(MMC_DAT0);
+		if (cpu_is_omap1710()) {
+			omap_cfg_reg(M15_1710_MMC_CLKI);
+			omap_cfg_reg(P19_1710_MMC_CMDDIR);
+			omap_cfg_reg(P20_1710_MMC_DATDIR0);
+		}
+		if (mmc_controller->slots[0].wire4) {
+			omap_cfg_reg(MMC_DAT1);
+			/* NOTE: DAT2 can be on W10 (here) or M15 */
+			if (!mmc_controller->slots[0].nomux)
+				omap_cfg_reg(MMC_DAT2);
+			omap_cfg_reg(MMC_DAT3);
+		}
+	}
+
+	/* Block 2 is on newer chips, and has many pinout options */
+	if (cpu_is_omap16xx() && controller_nr == 1) {
+		if (!mmc_controller->slots[1].nomux) {
+			omap_cfg_reg(Y8_1610_MMC2_CMD);
+			omap_cfg_reg(Y10_1610_MMC2_CLK);
+			omap_cfg_reg(R18_1610_MMC2_CLKIN);
+			omap_cfg_reg(W8_1610_MMC2_DAT0);
+			if (mmc_controller->slots[1].wire4) {
+				omap_cfg_reg(V8_1610_MMC2_DAT1);
+				omap_cfg_reg(W15_1610_MMC2_DAT2);
+				omap_cfg_reg(R10_1610_MMC2_DAT3);
+			}
+
+			/* These are needed for the level shifter */
+			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
+			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
+			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
+		}
+
+		/* Feedback clock must be set on OMAP-1710 MMC2 */
+		if (cpu_is_omap1710())
+			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
+					MOD_CONF_CTRL_1);
+	}
+}
+
+void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
+			int nr_controllers)
+{
+	int i;
+
+	for (i = 0; i < nr_controllers; i++) {
+		unsigned long base, size;
+		unsigned int irq = 0;
+
+		if (!mmc_data[i])
+			continue;
+
+		omap1_mmc_mux(mmc_data[i], i);
+
+		switch (i) {
+		case 0:
+			base = OMAP1_MMC1_BASE;
+			irq = INT_MMC;
+			break;
+		case 1:
+			if (!cpu_is_omap16xx())
+				return;
+			base = OMAP1_MMC2_BASE;
+			irq = INT_1610_MMC2;
+			break;
+		default:
+			continue;
+		}
+		size = OMAP1_MMC_SIZE;
+
+		omap_mmc_add(i, base, size, irq, mmc_data[i]);
+	};
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_OMAP_STI)
 
 #define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 989ad15..eec2fea 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -261,16 +261,6 @@ static struct omap_uart_config apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
 
-static struct omap_mmc_config apollon_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 1,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_usb_config apollon_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
@@ -284,7 +274,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 
 static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
-	{ OMAP_TAG_MMC,		&apollon_mmc_config },
 	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 9ba0978..3b34c20 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -41,19 +41,8 @@ static struct omap_uart_config generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_mmc_config generic_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_board_config_kernel generic_config[] = {
 	{ OMAP_TAG_UART,	&generic_uart_config },
-	{ OMAP_TAG_MMC,		&generic_mmc_config },
 };
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index d4e3b6f..9f01681 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -371,23 +371,12 @@ static struct omap_uart_config h4_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_mmc_config h4_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_lcd_config h4_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
-	{ OMAP_TAG_MMC,		&h4_mmc_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2ee954a..3bbb76b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,10 +19,12 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
+#include <mach/control.h>
 #include <mach/tc.h>
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
@@ -203,6 +205,86 @@ static inline void omap_init_mcspi(void) {}
 
 /*-------------------------------------------------------------------------*/
 
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
+static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
+			int controller_nr)
+{
+	if (cpu_is_omap2420() && controller_nr == 0) {
+		omap_cfg_reg(H18_24XX_MMC_CMD);
+		omap_cfg_reg(H15_24XX_MMC_CLKI);
+		omap_cfg_reg(G19_24XX_MMC_CLKO);
+		omap_cfg_reg(F20_24XX_MMC_DAT0);
+		omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
+		omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+		if (mmc_controller->slots[0].wire4) {
+			omap_cfg_reg(H14_24XX_MMC_DAT1);
+			omap_cfg_reg(E19_24XX_MMC_DAT2);
+			omap_cfg_reg(D19_24XX_MMC_DAT3);
+			omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
+			omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
+			omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+		}
+
+		/*
+		 * Use internal loop-back in MMC/SDIO Module Input Clock
+		 * selection
+		 */
+		if (mmc_controller->slots[0].internal_clock) {
+			u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+			v |= (1 << 24);
+			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+		}
+	}
+}
+
+void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
+			int nr_controllers)
+{
+	int i;
+
+	for (i = 0; i < nr_controllers; i++) {
+		unsigned long base, size;
+		unsigned int irq = 0;
+
+		if (!mmc_data[i])
+			continue;
+
+		omap2_mmc_mux(mmc_data[i], i);
+
+		switch (i) {
+		case 0:
+			base = OMAP2_MMC1_BASE;
+			irq = INT_24XX_MMC_IRQ;
+			break;
+		case 1:
+			base = OMAP2_MMC2_BASE;
+			irq = INT_24XX_MMC2_IRQ;
+			break;
+		case 2:
+			if (!cpu_is_omap34xx())
+				return;
+			base = OMAP3_MMC3_BASE;
+			irq = INT_34XX_MMC3_IRQ;
+			break;
+		default:
+			continue;
+		}
+
+		if (cpu_is_omap2420())
+			size = OMAP2420_MMC_SIZE;
+		else
+			size = HSMMC_SIZE;
+
+		omap_mmc_add(i, base, size, irq, mmc_data[i]);
+	};
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 static int __init omap2_init_devices(void)
 {
 	/* please keep these calls, and their implementations above,
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index b38410f..85f2b2b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -198,212 +198,45 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-#define	OMAP_MMC1_BASE		0x4809c000
-#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x1fc)
-#define	OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+#define OMAP_MMC_NR_RES		2
 
-#define	OMAP_MMC2_BASE		0x480b4000
-#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x1fc)
-#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
-
-#else
-
-#define	OMAP_MMC1_BASE		0xfffb7800
-#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x7f)
-#define OMAP_MMC1_INT		INT_MMC
-
-#define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
-#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x7f)
-#define	OMAP_MMC2_INT		INT_1610_MMC2
-
-#endif
-
-static struct omap_mmc_platform_data mmc1_data;
-
-static u64 mmc1_dmamask = 0xffffffff;
-
-static struct resource mmc1_resources[] = {
-	{
-		.start		= OMAP_MMC1_BASE,
-		.end		= OMAP_MMC1_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP_MMC1_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mmc_omap_device1 = {
-	.name		= "mmci-omap",
-	.id		= 1,
-	.dev = {
-		.dma_mask	= &mmc1_dmamask,
-		.platform_data	= &mmc1_data,
-	},
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
-	.resource	= mmc1_resources,
-};
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-
-static struct omap_mmc_platform_data mmc2_data;
-
-static u64 mmc2_dmamask = 0xffffffff;
-
-static struct resource mmc2_resources[] = {
-	{
-		.start		= OMAP_MMC2_BASE,
-		.end		= OMAP_MMC2_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP_MMC2_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mmc_omap_device2 = {
-	.name		= "mmci-omap",
-	.id		= 2,
-	.dev = {
-		.dma_mask	= &mmc2_dmamask,
-		.platform_data	= &mmc2_data,
-	},
-	.num_resources	= ARRAY_SIZE(mmc2_resources),
-	.resource	= mmc2_resources,
-};
-#endif
-
-static inline void omap_init_mmc_conf(const struct omap_mmc_config *mmc_conf)
-{
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
-		return;
-
-	if (mmc_conf->mmc[0].enabled) {
-		if (cpu_is_omap24xx()) {
-			omap_cfg_reg(H18_24XX_MMC_CMD);
-			omap_cfg_reg(H15_24XX_MMC_CLKI);
-			omap_cfg_reg(G19_24XX_MMC_CLKO);
-			omap_cfg_reg(F20_24XX_MMC_DAT0);
-			omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
-			omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
-		} else {
-			omap_cfg_reg(MMC_CMD);
-			omap_cfg_reg(MMC_CLK);
-			omap_cfg_reg(MMC_DAT0);
-			if (cpu_is_omap1710()) {
-				omap_cfg_reg(M15_1710_MMC_CLKI);
-				omap_cfg_reg(P19_1710_MMC_CMDDIR);
-				omap_cfg_reg(P20_1710_MMC_DATDIR0);
-			}
-		}
-		if (mmc_conf->mmc[0].wire4) {
-			if (cpu_is_omap24xx()) {
-				omap_cfg_reg(H14_24XX_MMC_DAT1);
-				omap_cfg_reg(E19_24XX_MMC_DAT2);
-				omap_cfg_reg(D19_24XX_MMC_DAT3);
-				omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
-				omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
-				omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
-			} else {
-				omap_cfg_reg(MMC_DAT1);
-				/* NOTE:  DAT2 can be on W10 (here) or M15 */
-				if (!mmc_conf->mmc[0].nomux)
-					omap_cfg_reg(MMC_DAT2);
-				omap_cfg_reg(MMC_DAT3);
-			}
-		}
-#if defined(CONFIG_ARCH_OMAP2420)
-		if (mmc_conf->mmc[0].internal_clock) {
-			/*
-			 * Use internal loop-back in MMC/SDIO
-			 * Module Input Clock selection
-			 */
-			if (cpu_is_omap24xx()) {
-				u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-				v |= (1 << 24); /* not used in 243x */
-				omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-			}
-		}
-#endif
-	}
-
-#ifdef	CONFIG_ARCH_OMAP16XX
-	/* block 2 is on newer chips, and has many pinout options */
-	if (mmc_conf->mmc[1].enabled) {
-		if (!mmc_conf->mmc[1].nomux) {
-			omap_cfg_reg(Y8_1610_MMC2_CMD);
-			omap_cfg_reg(Y10_1610_MMC2_CLK);
-			omap_cfg_reg(R18_1610_MMC2_CLKIN);
-			omap_cfg_reg(W8_1610_MMC2_DAT0);
-			if (mmc_conf->mmc[1].wire4) {
-				omap_cfg_reg(V8_1610_MMC2_DAT1);
-				omap_cfg_reg(W15_1610_MMC2_DAT2);
-				omap_cfg_reg(R10_1610_MMC2_DAT3);
-			}
-
-			/* These are needed for the level shifter */
-			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
-			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
-			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
-		}
-
-		/* Feedback clock must be set on OMAP-1710 MMC2 */
-		if (cpu_is_omap1710())
-			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
-				     MOD_CONF_CTRL_1);
-	}
-#endif
-}
-
-static void __init omap_init_mmc(void)
+/*
+ * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
+ */
+int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
+		unsigned int irq, struct omap_mmc_platform_data *data)
 {
-	const struct omap_mmc_config	*mmc_conf;
-
-	/* NOTE:  assumes MMC was never (wrongly) enabled */
-	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
-	if (!mmc_conf)
-		return;
-
-	omap_init_mmc_conf(mmc_conf);
-
-	if (mmc_conf->mmc[0].enabled) {
-		mmc1_data.conf = mmc_conf->mmc[0];
-		(void) platform_device_register(&mmc_omap_device1);
-	}
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-	if (mmc_conf->mmc[1].enabled) {
-		mmc2_data.conf = mmc_conf->mmc[1];
-		(void) platform_device_register(&mmc_omap_device2);
-	}
-#endif
-}
+	struct platform_device *pdev;
+	struct resource res[OMAP_MMC_NR_RES];
+	int ret;
+
+	pdev = platform_device_alloc("mmci-omap", id);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
+	res[0].start = base;
+	res[0].end = base + size - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = res[1].end = irq;
+	res[1].flags = IORESOURCE_IRQ;
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret == 0)
+		ret = platform_device_add_data(pdev, data, sizeof(*data));
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto fail;
+	return 0;
 
-void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
-{
-	switch (host) {
-	case 1:
-		mmc1_data = *info;
-		break;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-	case 2:
-		mmc2_data = *info;
-		break;
-#endif
-	default:
-		BUG();
-	}
+fail:
+	platform_device_put(pdev);
+	return ret;
 }
 
-#else
-static inline void omap_init_mmc(void) {}
-void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -547,7 +380,6 @@ static int __init omap_init_devices(void)
 	 */
 	omap_init_dsp();
 	omap_init_kp();
-	omap_init_mmc();
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
diff --git a/arch/arm/plat-omap/include/mach/board-h2.h b/arch/arm/plat-omap/include/mach/board-h2.h
index 2a050e9..15531c8 100644
--- a/arch/arm/plat-omap/include/mach/board-h2.h
+++ b/arch/arm/plat-omap/include/mach/board-h2.h
@@ -29,13 +29,13 @@
 #ifndef __ASM_ARCH_OMAP_H2_H
 #define __ASM_ARCH_OMAP_H2_H
 
-/* Placeholder for H2 specific defines */
-
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define OMAP1610_ETHR_START		0x04000300
 
+#define H2_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
+#	define H2_TPS_GPIO_MMC_PWR_EN	(H2_TPS_GPIO_BASE + 3)
+
 extern void h2_mmc_init(void);
-extern void h2_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /*  __ASM_ARCH_OMAP_H2_H */
 
diff --git a/arch/arm/plat-omap/include/mach/board-h3.h b/arch/arm/plat-omap/include/mach/board-h3.h
index 14909dc..1888326 100644
--- a/arch/arm/plat-omap/include/mach/board-h3.h
+++ b/arch/arm/plat-omap/include/mach/board-h3.h
@@ -30,7 +30,9 @@
 /* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
 #define OMAP1710_ETHR_START		0x04000300
 
+#define H3_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
+#	define H3_TPS_GPIO_MMC_PWR_EN	(H3_TPS_GPIO_BASE + 4)
+
 extern void h3_mmc_init(void);
-extern void h3_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /*  __ASM_ARCH_OMAP_H3_H */
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 5444564..9466772 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -16,7 +16,6 @@
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_MMC		0x4f02
 #define OMAP_TAG_SERIAL_CONSOLE 0x4f03
 #define OMAP_TAG_USB		0x4f04
 #define OMAP_TAG_LCD		0x4f05
@@ -35,25 +34,6 @@ struct omap_clock_config {
 	u8 system_clock_type;
 };
 
-struct omap_mmc_conf {
-	unsigned enabled:1;
-	/* nomux means "standard" muxing is wrong on this board, and that
-	 * board-specific code handled it before common init logic.
-	 */
-	unsigned nomux:1;
-	/* switch pin can be for card detect (default) or card cover */
-	unsigned cover:1;
-	/* 4 wire signaling is optional, and is only used for SD/SDIO */
-	unsigned wire4:1;
-	s16 power_pin;
-	s16 switch_pin;
-	s16 wp_pin;
-};
-
-struct omap_mmc_config {
-	struct omap_mmc_conf mmc[2];
-};
-
 struct omap_serial_console_config {
 	u8 console_uart;
 	u32 console_speed;
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 62aa7df..57414c4 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -279,6 +279,7 @@
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
 
 #define	INT_34XX_BENCH_MPU_EMUL	3
 
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index fc15d13..d1c80c3 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -17,12 +17,25 @@
 
 #include <mach/board.h>
 
+#define OMAP15XX_NR_MMC		1
+#define OMAP16XX_NR_MMC		2
+#define OMAP1_MMC_SIZE		0x080
+#define	OMAP1_MMC1_BASE		0xfffb7800
+#define	OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+
+#define OMAP24XX_NR_MMC		2
+#define OMAP34XX_NR_MMC		3
+#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
+#define HSMMC_SIZE		0x200
+#define	OMAP2_MMC1_BASE		0x4809c000
+#define	OMAP2_MMC2_BASE		0x480b4000
+#define OMAP3_MMC3_BASE		0x480ad000
+
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
-	struct omap_mmc_conf	conf;
 
-	/* number of slots on board */
+	/* number of slots per controller */
 	unsigned nr_slots:2;
 
 	/* set if your board has components or wiring that limits the
@@ -41,7 +54,27 @@ struct omap_mmc_platform_data {
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
 
+	u64 dma_mask;
+
 	struct omap_mmc_slot_data {
+
+		/*
+		 * nomux means "standard" muxing is wrong on this board, and
+		 * that board-specific code handled it before common init logic.
+		 */
+		unsigned nomux:1;
+
+		/* switch pin can be for card detect (default) or card cover */
+		unsigned cover:1;
+
+		/* 4 wire signaling is optional, and is only used for SD/SDIO */
+		unsigned wire4:1;
+
+		/* use the internal clock */
+		unsigned internal_clock:1;
+		s16 power_pin;
+		s16 switch_pin;
+
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);
 		int (* get_ro)(struct device *dev, int slot);
@@ -49,8 +82,8 @@ struct omap_mmc_platform_data {
 		/* return MMC cover switch state, can be NULL if not supported.
 		 *
 		 * possible return values:
-		 *   0 - open
-		 *   1 - closed
+		 *   0 - closed
+		 *   1 - open
 		 */
 		int (* get_cover_state)(struct device *dev, int slot);
 
@@ -66,9 +99,35 @@ struct omap_mmc_platform_data {
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
 
-extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info);
-
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
 
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers);
+void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers);
+int omap_mmc_add(int id, unsigned long base, unsigned long size,
+			unsigned int irq, struct omap_mmc_platform_data *data);
+#else
+static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers)
+{
+}
+static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers)
+{
+}
+static inline int omap_mmc_add(int id, unsigned long base, unsigned long size,
+		unsigned int irq, struct omap_mmc_platform_data *data)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void __init hsmmc_init(void);
+#endif
+
 #endif
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 1b9fc3c..086e6de 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1317,7 +1317,7 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	host->slots[id] = slot;
 
 	mmc->caps = 0;
-	if (host->pdata->conf.wire4)
+	if (host->pdata->slots[id].wire4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;
@@ -1451,6 +1451,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	host->use_dma = 1;
+	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch = -1;
 
 	host->irq = irq;

--JP+T4n/bALQSJXh8--
