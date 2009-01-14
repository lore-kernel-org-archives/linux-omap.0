From: Tony Lindgren <tony@atomide.com>
Subject: Re: Important changes, please read
Date: Wed, 14 Jan 2009 16:28:54 +0200
Message-ID: <20090114142851.GM29324@atomide.com>
References: <20090114134152.GJ29324@atomide.com> <Pine.LNX.4.64.0901141613130.18586@shogun.pilppa.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57797 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbZANO24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 09:28:56 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901141613130.18586@shogun.pilppa.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Laitio <lamikr@pilppa.org>
Cc: linux-omap@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Mika Laitio <lamikr@pilppa.org> [090114 16:16]:
>> - We reset arch/arm/mach-omap1 to be what's in the mainline and
>>  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
>>  to find later on. Naturally any code in that patch can be reworked
>>  so it can be integrated to the mainline kernel.
>
> What is the status of OMAP1 devices in 2.6.28-omap1 tree compared to this 
> tree that will be there? Has anybody made tests whether devices like  
> innovator are still either with this 2.6.28-omap1 or with 
> 2.6.29-rc1-omap?

Well that would mean mostly leaving out some device init code that's not
in the mainline kernel. I have not been able to boot my 1510 for a while
since the SDRAM seems to be broken on it. But at least the 16xx devices
are working, except for the MMC bug posted by Ladislav.

Below is a rough diff of the stuff that needs to be looked through for
what can be removed.

The clock changes and mailbox updates we don't want to remove, those
should go into the mainline kernel. The MMU code in the patch should
go into the dspgateway branch.

Tony

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="clean-mach-omap1.patch"

diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-h2.c ./arch/arm/mach-omap1/board-h2.c
--- a/arch/arm/mach-omap1/board-h2.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-h2.c	2009-01-14 16:21:30.000000000 +0200
@@ -20,7 +20,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -29,8 +28,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/i2c/tps65010.h>
-#include <linux/workqueue.h>
-#include <linux/clk.h>
 
 #include <mach/hardware.h>
 #include <asm/gpio.h>
@@ -40,8 +37,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/dma.h>
-#include <mach/gpio.h>
 #include <mach/gpio-switch.h>
 #include <mach/mux.h>
 #include <mach/tc.h>
@@ -411,10 +406,10 @@ static void __init h2_init(void)
 	/* Irda */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
-	if (!(gpio_request(H2_IRDA_FIRSEL_GPIO_PIN, "irda firsel"))) {
-		gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN);
-		h2_irda_data.transceiver_mode = h2_transceiver_mode;
-	}
+	if (gpio_request(H2_IRDA_FIRSEL_GPIO_PIN, "IRDA mode") < 0)
+		BUG();
+	gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+	h2_irda_data.transceiver_mode = h2_transceiver_mode;
 #endif
 
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-h3.c ./arch/arm/mach-omap1/board-h3.c
--- a/arch/arm/mach-omap1/board-h3.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-h3.c	2009-01-14 16:21:30.000000000 +0200
@@ -26,13 +26,8 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
-#include <linux/clk.h>
-
-#include <linux/i2c/tps65010.h>
-#include <linux/i2c/pcf857x.h>
-
 #include <linux/spi/spi.h>
-#include <linux/spi/tsc210x.h>
+#include <linux/i2c/tps65010.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -44,10 +39,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <media/v4l2-int-device.h>
-
-#include <mach/gpio.h>
-#include <mach/gpio-switch.h>
+#include <mach/gpioexpander.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/tc.h>
@@ -282,15 +274,29 @@ static struct platform_device h3_kp_devi
 
 /* Select between the IrDA and aGPS module
  */
-
-static int gpio_irda_enable;
-static int gpio_irda_x;
-static int gpio_irda_fir;
-
 static int h3_select_irda(struct device *dev, int state)
 {
-	gpio_set_value_cansleep(gpio_irda_enable, state & IR_SEL);
-	return 0;
+	unsigned char expa;
+	int err = 0;
+
+	if ((err = read_gpio_expa(&expa, 0x26))) {
+		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
+		return err;
+	}
+
+	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
+	if (state & IR_SEL) { /* IrDA */
+		if ((err = write_gpio_expa(expa | 0x40, 0x26))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	} else {
+		if ((err = write_gpio_expa(expa & ~0x40, 0x26))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	}
+	return err;
 }
 
 static void set_trans_mode(struct work_struct *work)
@@ -298,9 +304,24 @@ static void set_trans_mode(struct work_s
 	struct omap_irda_config *irda_config =
 		container_of(work, struct omap_irda_config, gpio_expa.work);
 	int mode = irda_config->mode;
+	unsigned char expa;
+	int err = 0;
+
+	if ((err = read_gpio_expa(&expa, 0x27)) != 0) {
+		printk(KERN_ERR "Error reading from I/O expander\n");
+	}
+
+	expa &= ~0x03;
+
+	if (mode & IR_SIRMODE) {
+		expa |= 0x01;
+	} else { /* MIR/FIR */
+		expa |= 0x03;
+	}
 
-	gpio_set_value_cansleep(gpio_irda_x, 1);
-	gpio_set_value_cansleep(gpio_irda_fir, !(mode & IR_SIRMODE));
+	if ((err = write_gpio_expa(expa, 0x27)) != 0) {
+		printk(KERN_ERR "Error writing to I/O expander\n");
+	}
 }
 
 static int h3_transceiver_mode(struct device *dev, int mode)
@@ -353,12 +374,6 @@ static struct platform_device h3_lcd_dev
 	.id		= -1,
 };
 
-static struct tsc210x_config tsc_platform_data = {
-	.use_internal		= 1,
-	.monitor		= TSC_VBAT | TSC_TEMP,
-	.mclk			= "mclk",
-};
-
 static struct spi_board_info h3_spi_board_info[] __initdata = {
 	[0] = {
 		.modalias	= "tsc2101",
@@ -366,7 +381,7 @@ static struct spi_board_info h3_spi_boar
 		.chip_select	= 0,
 		.irq		= OMAP_GPIO_IRQ(H3_TS_GPIO),
 		.max_speed_hz	= 16000000,
-		.platform_data	= &tsc_platform_data,
+		/* .platform_data	= &tsc_platform_data, */
 	},
 };
 
@@ -375,6 +390,7 @@ static struct platform_device *devices[]
 	&nand_device,
         &smc91x_device,
 	&intlat_device,
+	&h3_irda_device,
 	&h3_kp_device,
 	&h3_lcd_device,
 };
@@ -407,180 +423,36 @@ static struct omap_board_config_kernel h
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
 
-#define H3_NAND_RB_GPIO_PIN	10
-
-static int nand_dev_ready(struct omap_nand_platform_data *data)
-{
-	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
-}
-
-#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
-
-#include <../drivers/media/video/ov9640.h>
-
-/*
- * Common OV9640 register initialization for all image sizes, pixel formats,
- * and frame rates
- */
-const static struct ov9640_reg ov9640_common[] = {
-
-	{ 0x12, 0x80 }, { 0x11, 0x80 }, { 0x13, 0x88 },	/* COM7, CLKRC, COM8 */
-	{ 0x01, 0x58 }, { 0x02, 0x24 }, { 0x04, 0x00 },	/* BLUE, RED, COM1 */
-	{ 0x0E, 0x81 }, { 0x0F, 0x4F }, { 0x14, 0xcA },	/* COM5, COM6, COM9 */
-	{ 0x16, 0x02 }, { 0x1B, 0x01 }, { 0x24, 0x70 },	/* ?, PSHFT, AEW */
-	{ 0x25, 0x68 }, { 0x26, 0xD3 }, { 0x27, 0x90 },	/* AEB, VPT, BBIAS */
-	{ 0x2A, 0x00 }, { 0x2B, 0x00 }, { 0x32, 0x24 },	/* EXHCH, EXHCL, HREF */
-	{ 0x33, 0x02 }, { 0x37, 0x02 }, { 0x38, 0x13 },	/* CHLF, ADC, ACOM */
-	{ 0x39, 0xF0 }, { 0x3A, 0x00 }, { 0x3B, 0x01 },	/* OFON, TSLB, COM11 */
-	{ 0x3D, 0x90 }, { 0x3E, 0x02 }, { 0x3F, 0xF2 },	/* COM13, COM14, EDGE */
-	{ 0x41, 0x02 }, { 0x42, 0xC8 },		/* COM16, COM17 */
-	{ 0x43, 0xF0 }, { 0x44, 0x10 }, { 0x45, 0x6C },	/* ?, ?, ? */
-	{ 0x46, 0x6C }, { 0x47, 0x44 }, { 0x48, 0x44 },	/* ?, ?, ? */
-	{ 0x49, 0x03 }, { 0x59, 0x49 }, { 0x5A, 0x94 },	/* ?, ?, ? */
-	{ 0x5B, 0x46 }, { 0x5C, 0x84 }, { 0x5D, 0x5C },	/* ?, ?, ? */
-	{ 0x5E, 0x08 }, { 0x5F, 0x00 }, { 0x60, 0x14 },	/* ?, ?, ? */
-	{ 0x61, 0xCE },					/* ? */
-	{ 0x62, 0x70 }, { 0x63, 0x00 }, { 0x64, 0x04 },	/* LCC1, LCC2, LCC3 */
-	{ 0x65, 0x00 }, { 0x66, 0x00 },			/* LCC4, LCC5 */
-	{ 0x69, 0x00 }, { 0x6A, 0x3E }, { 0x6B, 0x3F },	/* HV, MBD, DBLV */
-	{ 0x6C, 0x40 }, { 0x6D, 0x30 }, { 0x6E, 0x4B },	/* GSP1, GSP2, GSP3 */
-	{ 0x6F, 0x60 }, { 0x70, 0x70 }, { 0x71, 0x70 },	/* GSP4, GSP5, GSP6 */
-	{ 0x72, 0x70 }, { 0x73, 0x70 }, { 0x74, 0x60 },	/* GSP7, GSP8, GSP9 */
-	{ 0x75, 0x60 }, { 0x76, 0x50 }, { 0x77, 0x48 },	/* GSP10,GSP11,GSP12 */
-	{ 0x78, 0x3A }, { 0x79, 0x2E }, { 0x7A, 0x28 },	/* GSP13,GSP14,GSP15 */
-	{ 0x7B, 0x22 }, { 0x7C, 0x04 }, { 0x7D, 0x07 },	/* GSP16,GST1, GST2 */
-	{ 0x7E, 0x10 }, { 0x7F, 0x28 }, { 0x80, 0x36 },	/* GST3, GST4, GST5 */
-	{ 0x81, 0x44 }, { 0x82, 0x52 }, { 0x83, 0x60 },	/* GST6, GST7, GST8 */
-	{ 0x84, 0x6C }, { 0x85, 0x78 }, { 0x86, 0x8C },	/* GST9, GST10,GST11 */
-	{ 0x87, 0x9E }, { 0x88, 0xBB }, { 0x89, 0xD2 },	/* GST12,GST13,GST14 */
-	{ 0x8A, 0xE6 }, { 0x13, 0xaF }, { 0x15, 0x02 },	/* GST15, COM8 */
-	{ 0x22, 0x8a }, /* GROS */
-	{ OV9640_REG_TERM, OV9640_VAL_TERM }
-};
-
-static int ov9640_sensor_power_set(int power)
-{
-	unsigned char expa;
-	int err;
-
-	/* read current state of GPIO EXPA outputs */
-	err = read_gpio_expa(&expa, 0x27);
-	if (err) {
-		printk(KERN_ERR "Error reading GPIO EXPA\n");
-		return err;
-	}
-	/* Clear GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up/down sensor */
-	if (power)
-		expa |= 0x08;
-	else
-		expa &= ~0x08;
-
-	err = write_gpio_expa(expa, 0x27);
-	if (err) {
-		printk(KERN_ERR "Error writing to GPIO EXPA\n");
-		return err;
-	}
-
-	return err;
-}
-
-static struct v4l2_ifparm ifparm = {
-	.if_type = V4L2_IF_TYPE_BT656,
-	.u = {
-		.bt656 = {
-			 .frame_start_on_rising_vs = 1,
-			 .nobt_vs_inv = 1,
-			 .mode = V4L2_IF_TYPE_BT656_MODE_NOBT_8BIT,
-			 .clock_min = OV9640_XCLK_MIN,
-			 .clock_max = OV9640_XCLK_MAX,
-		 },
-	},
-};
-
-static int ov9640_ifparm(struct v4l2_ifparm *p)
-{
-	*p = ifparm;
-
-	return 0;
-}
-
-static struct ov9640_platform_data h3_ov9640_platform_data = {
-	.power_set	= ov9640_sensor_power_set,
-	.default_regs	= ov9640_common,
-	.ifparm		= ov9640_ifparm,
-};
-#endif
-
-static int h3_pcf_setup(struct i2c_client *client, int gpio,
-		unsigned ngpio, void *context)
-{
-	int	status;
-
-	/* REVISIT someone with schematics should look up the rest
-	 * of these signals, and configure them appropriately ...
-	 * camera and audio seem to be involved, too.
-	 */
-
-	/* P0 - ? */
-	gpio_irda_x = gpio + 0;
-	status = gpio_request(gpio_irda_x, "irda_x");
-	if (status < 0)
-		goto done;
-	status = gpio_direction_output(gpio_irda_x, 0);
-	if (status < 0)
-		goto done;
-
-	/* P1 - set if MIR/FIR */
-	gpio_irda_fir = gpio + 1;
-	status = gpio_request(gpio_irda_fir, "irda_fir");
-	if (status < 0)
-		goto done;
-	status = gpio_direction_output(gpio_irda_fir, 0);
-	if (status < 0)
-		goto done;
-
-	/* 'P6' enable/disable IRDA_TX and IRDA_RX ... default, off */
-	gpio_irda_enable = gpio + 6;
-	status = gpio_request(gpio_irda_enable, "irda_enable");
-	if (status < 0)
-		goto done;
-	status = gpio_direction_output(gpio_irda_enable, 0);
-	if (status < 0)
-		goto done;
-
-	/* register the IRDA device now that it can be operated */
-	status = platform_device_register(&h3_irda_device);
-
-done:
-	return status;
-}
-
-static struct pcf857x_platform_data h3_pcf_data = {
-	/* assign these GPIO numbers right after the MPUIO lines */
-	.gpio_base	= OMAP_MAX_GPIO_LINES + 16,
-	.setup		= h3_pcf_setup,
-};
-
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        {
-		I2C_BOARD_INFO("pcf8574", 0x27),
-		.platform_data = &h3_pcf_data,
-       }, {
 		I2C_BOARD_INFO("tps65013", 0x48),
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
-#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
-	{
-		I2C_BOARD_INFO("ov9640", 0x30),
-		.platform_data = &h3_ov9640_platform_data,
-	},
-#endif
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
 		.irq		= OMAP_GPIO_IRQ(14),
 	},
 };
 
+static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
+	{
+		.name			= "mmc_slot",
+		.gpio                   = OMAP_MPUIO(1),
+		.type                   = OMAP_GPIO_SWITCH_TYPE_COVER,
+		.debounce_rising        = 100,
+		.debounce_falling       = 0,
+		.notify                 = h3_mmc_slot_cover_handler,
+		.notify_data            = NULL,
+	},
+};
+
+#define H3_NAND_RB_GPIO_PIN	10
+
+static int nand_dev_ready(struct omap_nand_platform_data *data)
+{
+	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
+}
+
 static void __init h3_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
@@ -604,12 +476,6 @@ static void __init h3_init(void)
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
 	omap_cfg_reg(V2_1710_GPIO10);
 
-	/* TSC2101 */
-	omap_cfg_reg(W19_1610_GPIO48);
-	gpio_request(H3_TS_GPIO, "tsc_irq");
-	gpio_direction_input(H3_TS_GPIO);
-	omap_cfg_reg(N14_1610_UWIRE_CS0);
-
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	spi_register_board_info(h3_spi_board_info,
 				ARRAY_SIZE(h3_spi_board_info));
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c ./arch/arm/mach-omap1/board-nokia770.c
--- a/arch/arm/mach-omap1/board-nokia770.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-nokia770.c	2009-01-14 16:21:30.000000000 +0200
@@ -32,8 +32,8 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 #include <mach/dsp_common.h>
+#include <mach/aic23.h>
 #include <mach/omapfb.h>
-#include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
 
@@ -163,47 +163,6 @@ static struct spi_board_info nokia770_sp
 	},
 };
 
-static struct {
-	struct clk *sys_ck;
-} hwa742;
-
-static int hwa742_get_clocks(void)
-{
-	hwa742.sys_ck = clk_get(NULL, "bclk");
-	if (IS_ERR(hwa742.sys_ck)) {
-		printk(KERN_ERR "can't get HWA742 clock\n");
-		return PTR_ERR(hwa742.sys_ck);
-	}
-	return 0;
-}
-
-static unsigned long hwa742_get_clock_rate(struct device *dev)
-{
-	return clk_get_rate(hwa742.sys_ck);
-}
-
-static void hwa742_power_up(struct device *dev)
-{
-	clk_enable(hwa742.sys_ck);
-}
-
-static void hwa742_power_down(struct device *dev)
-{
-	clk_disable(hwa742.sys_ck);
-}
-
-static struct hwa742_platform_data nokia770_hwa742_platform_data = {
-	.get_clock_rate	= hwa742_get_clock_rate,
-	.power_up	= hwa742_power_up,
-	.power_down	= hwa742_power_down,
-	.te_connected	= 1,
-};
-
-static void hwa742_dev_init(void)
-{
-	hwa742_get_clocks();
-	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
-}
 
 /* assume no Mini-AB port */
 
@@ -424,7 +383,6 @@ static void __init omap_nokia770_init(vo
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_dsp_init();
-	hwa742_dev_init();
 	ads7846_dev_init();
 	mipid_dev_init();
 	nokia770_mmc_init();
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-osk.c ./arch/arm/mach-omap1/board-osk.c
--- a/arch/arm/mach-omap1/board-osk.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-osk.c	2009-01-14 16:21:30.000000000 +0200
@@ -223,6 +223,9 @@ static struct i2c_board_info __initdata 
 	{
 		I2C_BOARD_INFO("tlv320aic23", 0x1B),
 	},
+	/* TODO when driver support is ready:
+	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
+	 */
 };
 
 static void __init osk_init_smc91x(void)
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-palmte.c ./arch/arm/mach-omap1/board-palmte.c
--- a/arch/arm/mach-omap1/board-palmte.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-palmte.c	2009-01-14 16:21:30.000000000 +0200
@@ -42,7 +42,6 @@
 #include <mach/irda.h>
 #include <mach/keypad.h>
 #include <mach/common.h>
-#include <mach/gpio-switch.h>
 
 static void __init omap_palmte_init_irq(void)
 {
@@ -315,37 +314,6 @@ static void palmte_headphones_detect(voi
 	}
 }
 
-static struct omap_gpio_switch palmte_switches[] __initdata = {
-	/* Speaker-enable pin is an output */
-	{
-		.name	= "speaker-enable",
-		.gpio	= PALMTE_SPEAKER_GPIO,
-		.type	= OMAP_GPIO_SWITCH_TYPE_ACTIVITY,
-		.flags	= OMAP_GPIO_SWITCH_FLAG_OUTPUT |
-			OMAP_GPIO_SWITCH_FLAG_INVERTED,
-	},
-	/* Indicates whether power is from DC-IN or battery */
-	{
-		.name	= "dc-in",
-		.gpio	= PALMTE_DC_GPIO,
-		.type	= OMAP_GPIO_SWITCH_TYPE_CONNECTION,
-		.flags	= OMAP_GPIO_SWITCH_FLAG_INVERTED,
-	},
-	/* Indicates whether a USB host is on the other end of the cable */
-	{
-		.name	= "usb",
-		.gpio	= PALMTE_USBDETECT_GPIO,
-		.type	= OMAP_GPIO_SWITCH_TYPE_CONNECTION,
-	},
-	/* High when headphones jack is plugged in */
-	{
-		.name	= "headphones",
-		.gpio	= PALMTE_HEADPHONES_GPIO,
-		.type	= OMAP_GPIO_SWITCH_TYPE_CONNECTION,
-		.notify	= palmte_headphones_detect,
-	},
-};
-
 static void __init palmte_misc_gpio_setup(void)
 {
 	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
@@ -371,10 +339,6 @@ static void __init omap_palmte_init(void
 	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
-
-	omap_register_gpio_switches(palmte_switches,
-			ARRAY_SIZE(palmte_switches));
-
 	palmte_misc_gpio_setup();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/board-sx1.c ./arch/arm/mach-omap1/board-sx1.c
--- a/arch/arm/mach-omap1/board-sx1.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/board-sx1.c	2009-01-14 16:21:30.000000000 +0200
@@ -33,7 +33,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <mach/gpio-switch.h>
 #include <mach/mux.h>
 #include <mach/irda.h>
 #include <mach/usb.h>
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/clock.c ./arch/arm/mach-omap1/clock.c
--- a/arch/arm/mach-omap1/clock.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/clock.c	2009-01-14 16:21:30.000000000 +0200
@@ -34,50 +34,27 @@ __u32 arm_idlect1_mask;
  * Omap1 specific clock functions
  *-------------------------------------------------------------------------*/
 
-static void omap1_watchdog_recalc(struct clk *clk, unsigned long parent_rate,
-				  u8 rate_storage)
+static void omap1_watchdog_recalc(struct clk * clk)
 {
-	unsigned long new_rate;
-
-	new_rate = parent_rate / 14;
-
-	if (rate_storage == CURRENT_RATE)
-		clk->rate = new_rate;
-	else if (rate_storage == TEMP_RATE)
-		clk->temp_rate = new_rate;
+	clk->rate = clk->parent->rate / 14;
 }
 
-static void omap1_uart_recalc(struct clk *clk, unsigned long parent_rate,
-			      u8 rate_storage)
+static void omap1_uart_recalc(struct clk * clk)
 {
-	unsigned long new_rate;
-	unsigned int val = __raw_readl(clk->enable_reg);
-
+	unsigned int val = omap_readl(clk->enable_reg);
 	if (val & clk->enable_bit)
-		new_rate = 48000000;
+		clk->rate = 48000000;
 	else
-		new_rate = 12000000;
-
-	if (rate_storage == CURRENT_RATE)
-		clk->rate = new_rate;
-	else if (rate_storage == TEMP_RATE)
-		clk->temp_rate = new_rate;
+		clk->rate = 12000000;
 }
 
-static void omap1_sossi_recalc(struct clk *clk, unsigned long parent_rate,
-			       u8 rate_storage)
+static void omap1_sossi_recalc(struct clk *clk)
 {
-	unsigned long new_rate;
 	u32 div = omap_readl(MOD_CONF_CTRL_1);
 
 	div = (div >> 17) & 0x7;
 	div++;
-	new_rate = clk->parent->rate / div;
-
-	if (rate_storage == CURRENT_RATE)
-		clk->rate = new_rate;
-	else if (rate_storage == TEMP_RATE)
-		clk->temp_rate = new_rate;
+	clk->rate = clk->parent->rate / div;
 }
 
 static int omap1_clk_enable_dsp_domain(struct clk *clk)
@@ -238,32 +215,24 @@ static int calc_dsor_exp(struct clk *clk
 	return dsor_exp;
 }
 
-static void omap1_ckctl_recalc(struct clk *clk, unsigned long parent_rate,
-			       u8 rate_storage)
+static void omap1_ckctl_recalc(struct clk * clk)
 {
 	int dsor;
-	unsigned long new_rate;
 
 	/* Calculate divisor encoded as 2-bit exponent */
 	dsor = 1 << (3 & (omap_readw(ARM_CKCTL) >> clk->rate_offset));
 
-	new_rate = parent_rate / dsor;
-
-	if (unlikely(clk->rate == new_rate))
+	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
+	clk->rate = clk->parent->rate / dsor;
 
-	if (rate_storage == CURRENT_RATE)
-		clk->rate = new_rate;
-	else if (rate_storage == TEMP_RATE)
-		clk->temp_rate = new_rate;
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 }
 
-static void omap1_ckctl_recalc_dsp_domain(struct clk *clk,
-					  unsigned long parent_rate,
-					  u8 rate_storage)
+static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
 {
 	int dsor;
-	unsigned long new_rate;
 
 	/* Calculate divisor encoded as 2-bit exponent
 	 *
@@ -276,15 +245,12 @@ static void omap1_ckctl_recalc_dsp_domai
 	dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
 	omap1_clk_disable(&api_ck.clk);
 
-	new_rate = parent_rate / dsor;
-
-	if (unlikely(clk->rate == new_rate))
+	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
+	clk->rate = clk->parent->rate / dsor;
 
-	if (rate_storage == CURRENT_RATE)
-		clk->rate = new_rate;
-	else if (rate_storage == TEMP_RATE)
-		clk->temp_rate = new_rate;
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 }
 
 /* MPU virtual clock functions */
@@ -323,7 +289,7 @@ static int omap1_select_table_rate(struc
 		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
 
 	ck_dpll1.rate = ptr->pll_rate;
-	propagate_rate(&ck_dpll1, CURRENT_RATE);
+	propagate_rate(&ck_dpll1);
 	return 0;
 }
 
@@ -348,6 +314,9 @@ static int omap1_clk_set_rate_dsp_domain
 		ret = 0;
 	}
 
+	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
+		propagate_rate(clk);
+
 	return ret;
 }
 
@@ -403,14 +372,14 @@ static int omap1_set_uart_rate(struct cl
 {
 	unsigned int val;
 
-	val = __raw_readl(clk->enable_reg);
+	val = omap_readl(clk->enable_reg);
 	if (rate == 12000000)
 		val &= ~(1 << clk->enable_bit);
 	else if (rate == 48000000)
 		val |= (1 << clk->enable_bit);
 	else
 		return -EINVAL;
-	__raw_writel(val, clk->enable_reg);
+	omap_writel(val, clk->enable_reg);
 	clk->rate = rate;
 
 	return 0;
@@ -429,8 +398,8 @@ static int omap1_set_ext_clk_rate(struct
 	else
 		ratio_bits = (dsor - 2) << 2;
 
-	ratio_bits |= __raw_readw(clk->enable_reg) & ~0xfd;
-	__raw_writew(ratio_bits, clk->enable_reg);
+	ratio_bits |= omap_readw(clk->enable_reg) & ~0xfd;
+	omap_writew(ratio_bits, clk->enable_reg);
 
 	return 0;
 }
@@ -454,6 +423,8 @@ static int omap1_set_sossi_rate(struct c
 	omap_writel(l, MOD_CONF_CTRL_1);
 
 	clk->rate = p_rate / (div + 1);
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 
 	return 0;
 }
@@ -469,8 +440,8 @@ static void omap1_init_ext_clk(struct cl
 	__u16 ratio_bits;
 
 	/* Determine current rate and ensure clock is based on 96MHz APLL */
-	ratio_bits = __raw_readw(clk->enable_reg) & ~1;
-	__raw_writew(ratio_bits, clk->enable_reg);
+	ratio_bits = omap_readw(clk->enable_reg) & ~1;
+	omap_writew(ratio_bits, clk->enable_reg);
 
 	ratio_bits = (ratio_bits & 0xfc) >> 2;
 	if (ratio_bits > 6)
@@ -535,13 +506,25 @@ static int omap1_clk_enable_generic(stru
 	}
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		regval32 = __raw_readl(clk->enable_reg);
-		regval32 |= (1 << clk->enable_bit);
-		__raw_writel(regval32, clk->enable_reg);
+		if (clk->flags & VIRTUAL_IO_ADDRESS) {
+			regval32 = __raw_readl(clk->enable_reg);
+			regval32 |= (1 << clk->enable_bit);
+			__raw_writel(regval32, clk->enable_reg);
+		} else {
+			regval32 = omap_readl(clk->enable_reg);
+			regval32 |= (1 << clk->enable_bit);
+			omap_writel(regval32, clk->enable_reg);
+		}
 	} else {
-		regval16 = __raw_readw(clk->enable_reg);
-		regval16 |= (1 << clk->enable_bit);
-		__raw_writew(regval16, clk->enable_reg);
+		if (clk->flags & VIRTUAL_IO_ADDRESS) {
+			regval16 = __raw_readw(clk->enable_reg);
+			regval16 |= (1 << clk->enable_bit);
+			__raw_writew(regval16, clk->enable_reg);
+		} else {
+			regval16 = omap_readw(clk->enable_reg);
+			regval16 |= (1 << clk->enable_bit);
+			omap_writew(regval16, clk->enable_reg);
+		}
 	}
 
 	return 0;
@@ -556,13 +539,25 @@ static void omap1_clk_disable_generic(st
 		return;
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		regval32 = __raw_readl(clk->enable_reg);
-		regval32 &= ~(1 << clk->enable_bit);
-		__raw_writel(regval32, clk->enable_reg);
+		if (clk->flags & VIRTUAL_IO_ADDRESS) {
+			regval32 = __raw_readl(clk->enable_reg);
+			regval32 &= ~(1 << clk->enable_bit);
+			__raw_writel(regval32, clk->enable_reg);
+		} else {
+			regval32 = omap_readl(clk->enable_reg);
+			regval32 &= ~(1 << clk->enable_bit);
+			omap_writel(regval32, clk->enable_reg);
+		}
 	} else {
-		regval16 = __raw_readw(clk->enable_reg);
-		regval16 &= ~(1 << clk->enable_bit);
-		__raw_writew(regval16, clk->enable_reg);
+		if (clk->flags & VIRTUAL_IO_ADDRESS) {
+			regval16 = __raw_readw(clk->enable_reg);
+			regval16 &= ~(1 << clk->enable_bit);
+			__raw_writew(regval16, clk->enable_reg);
+		} else {
+			regval16 = omap_readw(clk->enable_reg);
+			regval16 &= ~(1 << clk->enable_bit);
+			omap_writew(regval16, clk->enable_reg);
+		}
 	}
 }
 
@@ -570,6 +565,9 @@ static long omap1_clk_round_rate(struct 
 {
 	int dsor_exp;
 
+	if (clk->flags & RATE_FIXED)
+		return clk->rate;
+
 	if (clk->flags & RATE_CKCTL) {
 		dsor_exp = calc_dsor_exp(clk, rate);
 		if (dsor_exp < 0)
@@ -609,6 +607,9 @@ static int omap1_clk_set_rate(struct clk
 		ret = 0;
 	}
 
+	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
+		propagate_rate(clk);
+
 	return ret;
 }
 
@@ -631,10 +632,17 @@ static void __init omap1_clk_disable_unu
 	}
 
 	/* Is the clock already disabled? */
-	if (clk->flags & ENABLE_REG_32BIT)
-		regval32 = __raw_readl(clk->enable_reg);
-	else
-		regval32 = __raw_readw(clk->enable_reg);
+	if (clk->flags & ENABLE_REG_32BIT) {
+		if (clk->flags & VIRTUAL_IO_ADDRESS)
+			regval32 = __raw_readl(clk->enable_reg);
+			else
+				regval32 = omap_readl(clk->enable_reg);
+	} else {
+		if (clk->flags & VIRTUAL_IO_ADDRESS)
+			regval32 = __raw_readw(clk->enable_reg);
+		else
+			regval32 = omap_readw(clk->enable_reg);
+	}
 
 	if ((regval32 & (1 << clk->enable_bit)) == 0)
 		return;
@@ -761,7 +769,7 @@ int __init omap1_clk_init(void)
 			}
 		}
 	}
-	propagate_rate(&ck_dpll1, CURRENT_RATE);
+	propagate_rate(&ck_dpll1);
 #else
 	/* Find the highest supported frequency and enable it */
 	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
@@ -770,11 +778,11 @@ int __init omap1_clk_init(void)
 		omap_writew(0x2290, DPLL_CTL);
 		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
 		ck_dpll1.rate = 60000000;
-		propagate_rate(&ck_dpll1, CURRENT_RATE);
+		propagate_rate(&ck_dpll1);
 	}
 #endif
 	/* Cache rates for clocks connected to ck_ref (not dpll1) */
-	propagate_rate(&ck_ref, CURRENT_RATE);
+	propagate_rate(&ck_ref);
 	printk(KERN_INFO "Clocking rate (xtal/DPLL1/MPU): "
 		"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
 	       ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/clock.h ./arch/arm/mach-omap1/clock.h
--- a/arch/arm/mach-omap1/clock.h	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/clock.h	2009-01-14 16:21:30.000000000 +0200
@@ -15,22 +15,16 @@
 
 static int omap1_clk_enable_generic(struct clk * clk);
 static void omap1_clk_disable_generic(struct clk * clk);
-static void omap1_ckctl_recalc(struct clk *clk, unsigned long parent_rate,
-			       u8 rate_storage);
-static void omap1_watchdog_recalc(struct clk *clk, unsigned long parent_rate,
-				  u8 rate_storage);
+static void omap1_ckctl_recalc(struct clk * clk);
+static void omap1_watchdog_recalc(struct clk * clk);
 static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
-static void omap1_sossi_recalc(struct clk *clk, unsigned long parent_rate,
-			       u8 rate_storage);
-static void omap1_ckctl_recalc_dsp_domain(struct clk *clk,
-					  unsigned long parent_rate,
-					  u8 rate_storage);
+static void omap1_sossi_recalc(struct clk *clk);
+static void omap1_ckctl_recalc_dsp_domain(struct clk * clk);
 static int omap1_clk_enable_dsp_domain(struct clk * clk);
 static int omap1_clk_set_rate_dsp_domain(struct clk * clk, unsigned long rate);
 static void omap1_clk_disable_dsp_domain(struct clk * clk);
 static int omap1_set_uart_rate(struct clk * clk, unsigned long rate);
-static void omap1_uart_recalc(struct clk *clk, unsigned long parent_rate,
-			      u8 rate_storage);
+static void omap1_uart_recalc(struct clk * clk);
 static int omap1_clk_enable_uart_functional(struct clk * clk);
 static void omap1_clk_disable_uart_functional(struct clk * clk);
 static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate);
@@ -169,7 +163,7 @@ static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -179,8 +173,8 @@ static struct arm_idlect1_clk ck_dpll1ou
 		.name		= "ck_dpll1out",
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
-				  ENABLE_REG_32BIT,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+				  ENABLE_REG_32BIT | RATE_PROPAGATES,
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -194,7 +188,7 @@ static struct clk sossi_ck = {
 	.parent		= &ck_dpll1out.clk,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
 			  ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_1,
 	.enable_bit	= 16,
 	.recalc		= &omap1_sossi_recalc,
 	.set_rate	= &omap1_set_sossi_rate,
@@ -206,7 +200,8 @@ static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_CKCTL | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
+			  ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -220,7 +215,7 @@ static struct arm_idlect1_clk armper_ck 
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | RATE_CKCTL |
 				  CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -234,7 +229,7 @@ static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -247,7 +242,7 @@ static struct arm_idlect1_clk armxor_ck 
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -262,7 +257,7 @@ static struct arm_idlect1_clk armtim_ck 
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -277,7 +272,7 @@ static struct arm_idlect1_clk armwdt_ck 
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -305,7 +300,7 @@ static struct clk dsp_ck = {
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
+	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -328,8 +323,8 @@ static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL,
-	.enable_reg	= IOMEM(DSP_IDLECT2),
+			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
+	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc_dsp_domain,
@@ -341,8 +336,9 @@ static struct clk dspper_ck = {
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
-	.enable_reg	= IOMEM(DSP_IDLECT2),
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+			  VIRTUAL_IO_ADDRESS,
+	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_dsp_domain,
@@ -352,8 +348,9 @@ static struct clk dspxor_ck = {
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
-	.enable_reg	= IOMEM(DSP_IDLECT2),
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+			  VIRTUAL_IO_ADDRESS,
+	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_dsp_domain,
@@ -367,7 +364,7 @@ static struct arm_idlect1_clk tc_ck = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
-				  RATE_CKCTL |
+				  RATE_CKCTL | RATE_PROPAGATES |
 				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -407,7 +404,7 @@ static struct clk l3_ocpi_ck = {
 	.name		= "l3_ocpi_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -418,7 +415,7 @@ static struct clk tc1_ck = {
 	.name		= "tc1_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -429,7 +426,7 @@ static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -462,7 +459,7 @@ static struct arm_idlect1_clk api_ck = {
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -477,7 +474,7 @@ static struct arm_idlect1_clk lb_ck = {
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -508,7 +505,7 @@ static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -522,7 +519,7 @@ static struct arm_idlect1_clk lcd_ck_151
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -540,7 +537,7 @@ static struct clk uart1_1510 = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -554,9 +551,9 @@ static struct uart_clk uart1_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
+				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 29,
 		.enable		= &omap1_clk_enable_uart_functional,
 		.disable	= &omap1_clk_disable_uart_functional,
@@ -572,7 +569,7 @@ static struct clk uart2_ck = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
 			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -588,7 +585,7 @@ static struct clk uart3_1510 = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -602,9 +599,9 @@ static struct uart_clk uart3_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
+				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 31,
 		.enable		= &omap1_clk_enable_uart_functional,
 		.disable	= &omap1_clk_disable_uart_functional,
@@ -617,8 +614,8 @@ static struct clk usb_clko = {	/* 6 MHz 
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
+			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -629,8 +626,8 @@ static struct clk usb_hhc_ck1510 = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+			  RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -641,8 +638,9 @@ static struct clk usb_hhc_ck16xx = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-	.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
+	.flags		= CLOCK_IN_OMAP16XX |
+			  RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
 	.enable_bit	= 8 /* UHOST_EN */,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -652,8 +650,8 @@ static struct clk usb_dc_ck = {
 	.name		= "usb_dc_ck",
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
+	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
 	.enable_bit	= 4,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -663,9 +661,9 @@ static struct clk mclk_1510 = {
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 6,
+ 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
+ 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
+ 	.enable_bit	= 6,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -674,7 +672,7 @@ static struct clk mclk_16xx = {
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
+	.enable_reg	= (void __iomem *)COM_CLK_DIV_CTRL_SEL,
 	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -687,7 +685,7 @@ static struct clk bclk_1510 = {
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -696,7 +694,7 @@ static struct clk bclk_16xx = {
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
+	.enable_reg	= (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
 	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -711,9 +709,9 @@ static struct clk mmc1_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
+			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -725,9 +723,9 @@ static struct clk mmc2_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
-			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.flags		= CLOCK_IN_OMAP16XX |
+			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 20,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -736,7 +734,7 @@ static struct clk mmc2_ck = {
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
@@ -751,7 +749,8 @@ static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_NO_IDLE_PARENT | ALWAYS_ENABLED,
+			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
+			  ALWAYS_ENABLED,
 	.parent		= &armxor_ck.clk,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -761,7 +760,8 @@ static struct clk i2c_fck = {
 static struct clk i2c_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
+	.flags		= CLOCK_IN_OMAP16XX |
+			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
 			  ALWAYS_ENABLED,
 	.parent		= &armper_ck.clk,
 	.recalc		= &followparent_recalc,
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/devices.c ./arch/arm/mach-omap1/devices.c
--- a/arch/arm/mach-omap1/devices.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/devices.c	2009-01-14 16:21:30.000000000 +0200
@@ -86,7 +86,7 @@ static struct resource mbox_resources[] 
 };
 
 static struct platform_device mbox_device = {
-	.name		= "omap1-mailbox",
+	.name		= "mailbox",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mbox_resources),
 	.resource	= mbox_resources,
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/Kconfig ./arch/arm/mach-omap1/Kconfig
--- a/arch/arm/mach-omap1/Kconfig	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/Kconfig	2009-01-14 16:21:30.000000000 +0200
@@ -4,16 +4,19 @@ comment "OMAP Core Type"
 config ARCH_OMAP730
 	depends on ARCH_OMAP1
 	bool "OMAP730 Based System"
+	select CPU_ARM926T
 	select ARCH_OMAP_OTG
 
 config ARCH_OMAP15XX
 	depends on ARCH_OMAP1
 	default y
 	bool "OMAP15xx Based System"
+	select CPU_ARM925T
 
 config ARCH_OMAP16XX
 	depends on ARCH_OMAP1
 	bool "OMAP16xx Based System"
+	select CPU_ARM926T
 	select ARCH_OMAP_OTG
 
 comment "OMAP Board Type"
@@ -38,6 +41,7 @@ config MACH_OMAP_H2
 config MACH_OMAP_H3
 	bool "TI H3 Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
+#	select GPIOEXPANDER_OMAP
     	help
 	  TI OMAP 1710 H3 board support. Say Y here if you have such
 	  a board.
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/mailbox.c ./arch/arm/mach-omap1/mailbox.c
--- a/arch/arm/mach-omap1/mailbox.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/mailbox.c	2009-01-12 15:32:15.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Mailbox reservation modules for DSP
  *
- * Copyright (C) 2006-2008 Nokia Corporation
+ * Copyright (C) 2006 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -17,8 +17,6 @@
 #include <mach/mailbox.h>
 #include <mach/irqs.h>
 
-#define DRV_NAME "omap1-mailbox"
-
 #define MAILBOX_ARM2DSP1		0x00
 #define MAILBOX_ARM2DSP1b		0x04
 #define MAILBOX_DSP2ARM1		0x08
@@ -29,7 +27,7 @@
 #define MAILBOX_DSP2ARM1_Flag		0x1c
 #define MAILBOX_DSP2ARM2_Flag		0x20
 
-static void __iomem *mbox_base;
+unsigned long mbox_base;
 
 struct omap_mbox1_fifo {
 	unsigned long cmd;
@@ -42,14 +40,14 @@ struct omap_mbox1_priv {
 	struct omap_mbox1_fifo rx_fifo;
 };
 
-static inline int mbox_read_reg(size_t ofs)
+static inline int mbox_read_reg(unsigned int reg)
 {
-	return __raw_readw(mbox_base + ofs);
+	return __raw_readw(mbox_base + reg);
 }
 
-static inline void mbox_write_reg(u32 val, size_t ofs)
+static inline void mbox_write_reg(unsigned int val, unsigned int reg)
 {
-	__raw_writew(val, mbox_base + ofs);
+	__raw_writew(val, mbox_base + reg);
 }
 
 /* msg */
@@ -145,7 +143,7 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
-static int __devinit omap1_mbox_probe(struct platform_device *pdev)
+static int __init omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret = 0;
@@ -172,10 +170,12 @@ static int __devinit omap1_mbox_probe(st
 	}
 	mbox_dsp_info.irq = res->start;
 
-	return omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	ret = omap_mbox_register(&mbox_dsp_info);
+
+	return ret;
 }
 
-static int __devexit omap1_mbox_remove(struct platform_device *pdev)
+static int omap1_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister(&mbox_dsp_info);
 
@@ -184,9 +184,9 @@ static int __devexit omap1_mbox_remove(s
 
 static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
-	.remove	= __devexit_p(omap1_mbox_remove),
+	.remove	= omap1_mbox_remove,
 	.driver	= {
-		.name	= DRV_NAME,
+		.name	= "mailbox",
 	},
 };
 
@@ -203,7 +203,4 @@ static void __exit omap1_mbox_exit(void)
 module_init(omap1_mbox_init);
 module_exit(omap1_mbox_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
-MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
-MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_LICENSE("GPL");
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/Makefile ./arch/arm/mach-omap1/Makefile
--- a/arch/arm/mach-omap1/Makefile	2008-12-29 10:42:09.000000000 +0200
+++ b/arch/arm/mach-omap1/Makefile	2008-10-30 21:57:21.000000000 +0200
@@ -13,12 +13,6 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
-# DSP
-obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
-obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
-mailbox_mach-objs		:= mailbox.o
-mmu_mach-objs			:= mmu.o
-
 led-y := leds.o
 
 # Specific board support
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/mcbsp.c ./arch/arm/mach-omap1/mcbsp.c
--- a/arch/arm/mach-omap1/mcbsp.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/mcbsp.c	2009-01-14 16:21:30.000000000 +0200
@@ -17,7 +17,9 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <mach/irqs.h>
 #include <mach/dma.h>
+#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/mmu.c ./arch/arm/mach-omap1/mmu.c
--- a/arch/arm/mach-omap1/mmu.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/mmu.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,351 +0,0 @@
-/*
- * linux/arch/arm/mach-omap1/mmu.c
- *
- * Support for non-MPU OMAP1 MMUs.
- *
- * Copyright (C) 2002-2005 Nokia Corporation
- *
- * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *        and Paul Mundt <paul.mundt@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/rwsem.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include "mmu.h"
-#include <asm/tlbflush.h>
-#include <mach/dsp_common.h>
-
-static void *dspvect_page;
-#define DSP_INIT_PAGE	0xfff000
-
-#define MMUFAULT_MASK (OMAP_MMU_FAULT_ST_PERM |\
-		       OMAP_MMU_FAULT_ST_TLB_MISS |\
-		       OMAP_MMU_FAULT_ST_TRANS)
-
-static unsigned int get_cam_l_va_mask(u16 pgsz)
-{
-	switch (pgsz) {
-	case OMAP_MMU_CAM_PAGESIZE_1MB:
-		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
-		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1MB;
-	case OMAP_MMU_CAM_PAGESIZE_64KB:
-		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
-		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_64KB;
-	case OMAP_MMU_CAM_PAGESIZE_4KB:
-		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
-		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_4KB;
-	case OMAP_MMU_CAM_PAGESIZE_1KB:
-		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
-		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1KB;
-	}
-	return 0;
-}
-
-#define get_cam_va_mask(pgsz) \
-	((u32)OMAP_MMU_CAM_H_VA_TAG_H_MASK << 22 | \
-	 (u32)get_cam_l_va_mask(pgsz) << 6)
-
-static int intmem_usecount;
-
-/* for safety */
-void dsp_mem_usecount_clear(void)
-{
-	if (intmem_usecount != 0) {
-		printk(KERN_WARNING
-		       "MMU: unbalanced memory request/release detected.\n"
-		       "         intmem_usecount is not zero at where "
-		       "it should be! ... fixed to be zero.\n");
-		intmem_usecount = 0;
-		omap_dsp_release_mem();
-	}
-}
-EXPORT_SYMBOL_GPL(dsp_mem_usecount_clear);
-
-void omap_mmu_itack(struct omap_mmu *mmu)
-{
-	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
-}
-EXPORT_SYMBOL(omap_mmu_itack);
-
-static int omap1_mmu_mem_enable(struct omap_mmu *mmu, void *addr)
-{
-	int ret = 0;
-
-	if (omap_mmu_internal_memory(mmu, addr)) {
-		if (intmem_usecount++ == 0)
-			ret = omap_dsp_request_mem();
-	}
-
-	return ret;
-}
-
-static int omap1_mmu_mem_disable(struct omap_mmu *mmu, void *addr)
-{
-	int ret = 0;
-
-	if (omap_mmu_internal_memory(mmu, addr)) {
-		if (--intmem_usecount == 0)
-			omap_dsp_release_mem();
-	} else
-		ret = -EIO;
-
-	return ret;
-}
-
-static inline void
-omap1_mmu_read_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
-{
-	/* read a TLB entry */
-	omap_mmu_write_reg(mmu, OMAP_MMU_LD_TLB_RD, OMAP_MMU_LD_TLB);
-
-	cr->cam_h = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM_H);
-	cr->cam_l = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM_L);
-	cr->ram_h = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM_H);
-	cr->ram_l = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM_L);
-}
-
-static inline void
-omap1_mmu_load_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
-{
-	/* Set the CAM and RAM entries */
-	omap_mmu_write_reg(mmu, cr->cam_h, OMAP_MMU_CAM_H);
-	omap_mmu_write_reg(mmu, cr->cam_l, OMAP_MMU_CAM_L);
-	omap_mmu_write_reg(mmu, cr->ram_h, OMAP_MMU_RAM_H);
-	omap_mmu_write_reg(mmu, cr->ram_l, OMAP_MMU_RAM_L);
-}
-
-static ssize_t omap1_mmu_show(struct omap_mmu *mmu, char *buf,
-			      struct omap_mmu_tlb_lock *tlb_lock)
-{
-	int i, len;
-
-	len = sprintf(buf, "P: preserved, V: valid\n"
-			   "ety P V size   cam_va     ram_pa ap\n");
-			 /* 00: P V  4KB 0x300000 0x10171800 FA */
-
-	for (i = 0; i < mmu->nr_tlb_entries; i++) {
-		struct omap_mmu_tlb_entry ent;
-		struct cam_ram_regset cr;
-		struct omap_mmu_tlb_lock entry_lock;
-		char *pgsz_str, *ap_str;
-
-		/* read a TLB entry */
-		entry_lock.base   = tlb_lock->base;
-		entry_lock.victim = i;
-		omap_mmu_read_tlb(mmu, &entry_lock, &cr);
-
-		ent.pgsz  = cr.cam_l & OMAP_MMU_CAM_PAGESIZE_MASK;
-		ent.prsvd = cr.cam_l & OMAP_MMU_CAM_P;
-		ent.valid = cr.cam_l & OMAP_MMU_CAM_V;
-		ent.ap    = cr.ram_l & OMAP_MMU_RAM_L_AP_MASK;
-		ent.va = (u32)(cr.cam_h & OMAP_MMU_CAM_H_VA_TAG_H_MASK) << 22 |
-			 (u32)(cr.cam_l & get_cam_l_va_mask(ent.pgsz)) << 6;
-		ent.pa = (unsigned long)cr.ram_h << 16 |
-			 (cr.ram_l & OMAP_MMU_RAM_L_RAM_LSB_MASK);
-
-		pgsz_str = (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_1MB)  ? " 1MB":
-			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_64KB) ? "64KB":
-			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_4KB)  ? " 4KB":
-			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_1KB)  ? " 1KB":
-								     " ???";
-		ap_str = (ent.ap == OMAP_MMU_RAM_L_AP_RO) ? "RO":
-			 (ent.ap == OMAP_MMU_RAM_L_AP_FA) ? "FA":
-			 (ent.ap == OMAP_MMU_RAM_L_AP_NA) ? "NA":
-							   "??";
-
-		if (i == tlb_lock->base)
-			len += sprintf(buf + len, "lock base = %d\n",
-				       tlb_lock->base);
-		if (i == tlb_lock->victim)
-			len += sprintf(buf + len, "victim    = %d\n",
-				       tlb_lock->victim);
-		len += sprintf(buf + len,
-			       /* 00: P V  4KB 0x300000 0x10171800 FA */
-			       "%02d: %c %c %s 0x%06lx 0x%08lx %s\n",
-			       i,
-			       ent.prsvd ? 'P' : ' ',
-			       ent.valid ? 'V' : ' ',
-			       pgsz_str, ent.va, ent.pa, ap_str);
-	}
-
-	return len;
-}
-
-static int exmap_setup_preserved_entries(struct omap_mmu *mmu)
-{
-	int n = 0;
-
-	exmap_setup_preserved_mem_page(mmu, dspvect_page, DSP_INIT_PAGE, n++);
-
-	return n;
-}
-
-static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
-{
-	exmap_clear_mem_page(mmu, DSP_INIT_PAGE);
-}
-
-static int omap1_mmu_startup(struct omap_mmu *mmu)
-{
-	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
-	if (dspvect_page == NULL) {
-		dev_err(mmu->dev, "MMU %s: failed to allocate memory "
-			"for vector table\n", mmu->name);
-		return -ENOMEM;
-	}
-
-	mmu->nr_exmap_preserved = exmap_setup_preserved_entries(mmu);
-
-	return 0;
-}
-
-static void omap1_mmu_shutdown(struct omap_mmu *mmu)
-{
-	exmap_clear_preserved_entries(mmu);
-
-	if (dspvect_page != NULL) {
-		unsigned long virt;
-
-		down_read(&mmu->exmap_sem);
-
-		virt = (unsigned long)omap_mmu_to_virt(mmu, DSP_INIT_PAGE);
-		flush_tlb_kernel_range(virt, virt + PAGE_SIZE);
-		free_page((unsigned long)dspvect_page);
-		dspvect_page = NULL;
-
-		up_read(&mmu->exmap_sem);
-	}
-}
-
-static inline unsigned long omap1_mmu_cam_va(struct cam_ram_regset *cr)
-{
-	unsigned int page_size = cr->cam_l & OMAP_MMU_CAM_PAGESIZE_MASK;
-
-	return (u32)(cr->cam_h & OMAP_MMU_CAM_H_VA_TAG_H_MASK)  << 22 |
-	       (u32)(cr->cam_l & get_cam_l_va_mask(page_size)) << 6;
-}
-
-static struct cam_ram_regset *
-omap1_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
-{
-	struct cam_ram_regset *cr;
-
-	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		dev_err(mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
-			" an aligned boundary\n", mmu->name, entry->va);
-		return ERR_PTR(-EINVAL);
-	}
-
-	cr = kmalloc(sizeof(struct cam_ram_regset), GFP_KERNEL);
-
-	cr->cam_h = entry->va >> 22;
-	cr->cam_l = (entry->va >> 6 & get_cam_l_va_mask(entry->pgsz)) |
-		   entry->prsvd | entry->pgsz;
-	cr->ram_h = entry->pa >> 16;
-	cr->ram_l = (entry->pa & OMAP_MMU_RAM_L_RAM_LSB_MASK) | entry->ap;
-
-	return cr;
-}
-
-static inline int omap1_mmu_cam_ram_valid(struct cam_ram_regset *cr)
-{
-	return cr->cam_l & OMAP_MMU_CAM_V;
-}
-
-static void omap1_mmu_interrupt(struct omap_mmu *mmu)
-{
-	unsigned long status;
-	unsigned long adh, adl;
-	unsigned long dp;
-	unsigned long va;
-
-	status = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_ST);
-	adh = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_H);
-	adl = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_L);
-	dp = adh & OMAP_MMU_FAULT_AD_H_DP;
-	va = (((adh & OMAP_MMU_FAULT_AD_H_ADR_MASK) << 16) | adl);
-
-	/* if the fault is masked, nothing to do */
-	if ((status & MMUFAULT_MASK) == 0) {
-		pr_debug("MMU interrupt, but ignoring.\n");
-		/*
-		 * note: in OMAP1710,
-		 * when CACHE + DMA domain gets out of idle in DSP,
-		 * MMU interrupt occurs but MMU_FAULT_ST is not set.
-		 * in this case, we just ignore the interrupt.
-		 */
-		if (status) {
-			pr_debug("%s%s%s%s\n",
-				 (status & OMAP_MMU_FAULT_ST_PREF)?
-				 "  (prefetch err)" : "",
-				 (status & OMAP_MMU_FAULT_ST_PERM)?
-				 "  (permission fault)" : "",
-				 (status & OMAP_MMU_FAULT_ST_TLB_MISS)?
-				 "  (TLB miss)" : "",
-				 (status & OMAP_MMU_FAULT_ST_TRANS) ?
-				 "  (translation fault)": "");
-			pr_debug("fault address = %#08lx\n", va);
-		}
-		enable_irq(mmu->irq);
-		return;
-	}
-
-	pr_info("%s%s%s%s\n",
-		(status & OMAP_MMU_FAULT_ST_PREF)?
-		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PREF)?
-		"  prefetch err":
-		"  (prefetch err)":
-		"",
-		(status & OMAP_MMU_FAULT_ST_PERM)?
-		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PERM)?
-		"  permission fault":
-		"  (permission fault)":
-		"",
-		(status & OMAP_MMU_FAULT_ST_TLB_MISS)?
-		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TLB_MISS)?
-		"  TLB miss":
-		"  (TLB miss)":
-		"",
-		(status & OMAP_MMU_FAULT_ST_TRANS)?
-		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TRANS)?
-		"  translation fault":
-		"  (translation fault)":
-		"");
-	pr_info("fault address = %#08lx\n", va);
-
-	mmu->fault_address = va;
-	schedule_work(&mmu->irq_work);
-}
-
-static pgprot_t omap1_mmu_pte_get_attr(struct omap_mmu_tlb_entry *entry)
-{
-	/* 4KB AP position as default */
-	u32 attr = entry->ap >> 4;
-	attr <<= ((entry->pgsz == OMAP_MMU_CAM_PAGESIZE_1MB) ? 6:0);
-	return attr;
-}
-
-struct omap_mmu_ops omap1_mmu_ops = {
-	.startup	= omap1_mmu_startup,
-	.shutdown	= omap1_mmu_shutdown,
-	.mem_enable	= omap1_mmu_mem_enable,
-	.mem_disable	= omap1_mmu_mem_disable,
-	.read_tlb	= omap1_mmu_read_tlb,
-	.load_tlb	= omap1_mmu_load_tlb,
-	.show		= omap1_mmu_show,
-	.cam_va		= omap1_mmu_cam_va,
-	.cam_ram_alloc	= omap1_mmu_cam_ram_alloc,
-	.cam_ram_valid	= omap1_mmu_cam_ram_valid,
-	.interrupt	= omap1_mmu_interrupt,
-	.pte_get_attr	= omap1_mmu_pte_get_attr,
-};
-EXPORT_SYMBOL_GPL(omap1_mmu_ops);
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/mmu.h ./arch/arm/mach-omap1/mmu.h
--- a/arch/arm/mach-omap1/mmu.h	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/mmu.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,119 +0,0 @@
-#ifndef __MACH_OMAP1_MMU_H
-#define __MACH_OMAP1_MMU_H
-
-#include <linux/io.h>
-#include <mach/mmu.h>
-
-#define MMU_LOCK_BASE_MASK		(0x3f << 10)
-#define MMU_LOCK_VICTIM_MASK		(0x3f << 4)
-
-#define OMAP_MMU_PREFETCH		0x00
-#define OMAP_MMU_WALKING_ST		0x04
-#define OMAP_MMU_CNTL			0x08
-#define OMAP_MMU_FAULT_AD_H		0x0c
-#define OMAP_MMU_FAULT_AD_L		0x10
-#define OMAP_MMU_FAULT_ST		0x14
-#define OMAP_MMU_IT_ACK			0x18
-#define OMAP_MMU_TTB_H			0x1c
-#define OMAP_MMU_TTB_L			0x20
-#define OMAP_MMU_LOCK			0x24
-#define OMAP_MMU_LD_TLB			0x28
-#define OMAP_MMU_CAM_H			0x2c
-#define OMAP_MMU_CAM_L			0x30
-#define OMAP_MMU_RAM_H			0x34
-#define OMAP_MMU_RAM_L			0x38
-#define OMAP_MMU_GFLUSH			0x3c
-#define OMAP_MMU_FLUSH_ENTRY		0x40
-#define OMAP_MMU_READ_CAM_H		0x44
-#define OMAP_MMU_READ_CAM_L		0x48
-#define OMAP_MMU_READ_RAM_H		0x4c
-#define OMAP_MMU_READ_RAM_L		0x50
-
-#define OMAP_MMU_CNTL_BURST_16MNGT_EN	0x0020
-#define OMAP_MMU_CNTL_WTL_EN		0x0004
-#define OMAP_MMU_CNTL_MMU_EN		0x0002
-#define OMAP_MMU_CNTL_RESET_SW		0x0001
-
-#define OMAP_MMU_FAULT_AD_H_DP		0x0100
-#define OMAP_MMU_FAULT_AD_H_ADR_MASK	0x00ff
-
-#define OMAP_MMU_FAULT_ST_PREF		0x0008
-#define OMAP_MMU_FAULT_ST_PERM		0x0004
-#define OMAP_MMU_FAULT_ST_TLB_MISS	0x0002
-#define OMAP_MMU_FAULT_ST_TRANS		0x0001
-
-#define OMAP_MMU_IT_ACK_IT_ACK		0x0001
-
-#define OMAP_MMU_CAM_H_VA_TAG_H_MASK		0x0003
-
-#define OMAP_MMU_CAM_L_VA_TAG_L1_MASK		0xc000
-#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1MB	0x0000
-#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_64KB	0x3c00
-#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_4KB	0x3fc0
-#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1KB	0x3ff0
-#define OMAP_MMU_CAM_L_P			0x0008
-#define OMAP_MMU_CAM_L_V			0x0004
-#define OMAP_MMU_CAM_L_PAGESIZE_MASK		0x0003
-#define OMAP_MMU_CAM_L_PAGESIZE_1MB		0x0000
-#define OMAP_MMU_CAM_L_PAGESIZE_64KB		0x0001
-#define OMAP_MMU_CAM_L_PAGESIZE_4KB		0x0002
-#define OMAP_MMU_CAM_L_PAGESIZE_1KB		0x0003
-
-#define OMAP_MMU_CAM_P			OMAP_MMU_CAM_L_P
-#define OMAP_MMU_CAM_V			OMAP_MMU_CAM_L_V
-#define OMAP_MMU_CAM_PAGESIZE_MASK	OMAP_MMU_CAM_L_PAGESIZE_MASK
-#define OMAP_MMU_CAM_PAGESIZE_1MB	OMAP_MMU_CAM_L_PAGESIZE_1MB
-#define OMAP_MMU_CAM_PAGESIZE_64KB	OMAP_MMU_CAM_L_PAGESIZE_64KB
-#define OMAP_MMU_CAM_PAGESIZE_4KB	OMAP_MMU_CAM_L_PAGESIZE_4KB
-#define OMAP_MMU_CAM_PAGESIZE_1KB	OMAP_MMU_CAM_L_PAGESIZE_1KB
-#define OMAP_MMU_CAM_PAGESIZE_16MB	-1 /* unused in omap1 */
-
-#define OMAP_MMU_RAM_L_RAM_LSB_MASK	0xfc00
-#define OMAP_MMU_RAM_L_AP_MASK		0x0300
-#define OMAP_MMU_RAM_L_AP_NA		0x0000
-#define OMAP_MMU_RAM_L_AP_RO		0x0200
-#define OMAP_MMU_RAM_L_AP_FA		0x0300
-
-#define OMAP_MMU_LD_TLB_RD		0x0002
-
-#define INIT_TLB_ENTRY(ent, v, p, ps)			\
-do {							\
-	(ent)->va	= (v);				\
-	(ent)->pa	= (p);				\
-	(ent)->pgsz	= (ps);				\
-	(ent)->prsvd	= 0;				\
-	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
-	(ent)->tlb	= 1;				\
-} while (0)
-
-#define INIT_TLB_ENTRY_4KB_PRESERVED(ent, v, p)	\
-do {							\
-	(ent)->va	= (v);				\
-	(ent)->pa	= (p);				\
-	(ent)->pgsz	= OMAP_MMU_CAM_PAGESIZE_4KB;	\
-	(ent)->prsvd	= OMAP_MMU_CAM_P;		\
-	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
-} while (0)
-
-struct omap_mmu_tlb_entry {
-	unsigned long va;
-	unsigned long pa;
-	unsigned int pgsz, prsvd, valid;
-
-	u16 ap;
-	unsigned int tlb;
-};
-
-static inline unsigned short
-omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
-{
-	return __raw_readw(mmu->base + reg);
-}
-
-static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
-			       unsigned short val, unsigned long reg)
-{
-	__raw_writew(val, mmu->base + reg);
-}
-
-#endif /* __MACH_OMAP1_MMU_H */
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/time.c ./arch/arm/mach-omap1/time.c
--- a/arch/arm/mach-omap1/time.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/time.c	2009-01-14 16:21:30.000000000 +0200
@@ -173,7 +173,7 @@ static __init void omap_init_mpu_timer(u
 	clockevent_mpu_timer1.min_delta_ns =
 		clockevent_delta2ns(1, &clockevent_mpu_timer1);
 
-	clockevent_mpu_timer1.cpumask = cpumask_of_cpu(0);
+	clockevent_mpu_timer1.cpumask = cpumask_of(0);
 	clockevents_register_device(&clockevent_mpu_timer1);
 }
 
diff -Nrup --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-omap-2.6/arch/arm/mach-omap1/timer32k.c ./arch/arm/mach-omap1/timer32k.c
--- a/arch/arm/mach-omap1/timer32k.c	2009-01-14 12:41:48.000000000 +0200
+++ b/arch/arm/mach-omap1/timer32k.c	2009-01-14 16:21:30.000000000 +0200
@@ -187,7 +187,7 @@ static __init void omap_init_32k_timer(v
 	clockevent_32k_timer.min_delta_ns =
 		clockevent_delta2ns(1, &clockevent_32k_timer);
 
-	clockevent_32k_timer.cpumask = cpumask_of_cpu(0);
+	clockevent_32k_timer.cpumask = cpumask_of(0);
 	clockevents_register_device(&clockevent_32k_timer);
 }
 

--huq684BweRXVnRxX--
