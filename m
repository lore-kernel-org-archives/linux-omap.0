From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 2/8] AI TB: Board file of Always Innovating OMAP3-based
 Touch Book
Date: Wed, 18 Nov 2009 18:57:39 -0800
Message-ID: <1258599459.8001.33.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-26zuJmkY0Q3fn5cLM2aC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57673 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970AbZKSC5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 21:57:37 -0500
Received: by gxk26 with SMTP id 26so1677303gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 18:57:42 -0800 (PST)
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


--=-26zuJmkY0Q3fn5cLM2aC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
arch/arm/mach-omap2/board-omap3touchbook.c |  683
++++++++++++++++++++++++++++
1 files changed, 683 insertions(+), 0 deletions(-)
create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c
b/arch/arm/mach-omap2/board-omap3touchbook.c
new file mode 100644
index 0000000..ad3ef6e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -0,0 +1,683 @@
+/*
+ * linux/arch/arm/mach-omap2/board-omap3touchbook.c
+ *
+ * Copyright (C) 2009 Always Innovating
+ *
+ * Modified from mach-omap2/board-omap3beagleboard.c
+ *
+ * Initial code: Grégoire Gentil, Tim Yamin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
+#include <plat/mcspi.h>
+#include <linux/spi/spi.h>
+
+#include <linux/spi/ads7846.h>
+#include <linux/mma7455l.h>
+
+#include <plat/dmtimer.h>
+#include <linux/backlight.h>
+
+#include <linux/regulator/machine.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/timer-gp.h>
+
+#include "mmc-twl4030.h"
+
+#include <asm/setup.h>
+
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+#define NAND_BLOCK_SIZE SZ_128K
+
+#define OMAP3_AC_GPIO 136
+#define OMAP3_TS_GPIO 162
+#define TB_BL_PWM_TIMER 9
+#define TB_KILL_POWER_GPIO 168
+
+unsigned long touchbook_revision;
+
+static struct mtd_partition omap3touchbook_nand_partitions[] = {
+ /* All the partition sizes are listed in terms of NAND block size */
+ {
+ .name = "X-Loader",
+ .offset = 0,
+ .size = 4 * NAND_BLOCK_SIZE,
+ .mask_flags = MTD_WRITEABLE, /* force read-only */
+ },
+ {
+ .name = "U-Boot",
+ .offset = MTDPART_OFS_APPEND, /* Offset = 0x80000 */
+ .size = 15 * NAND_BLOCK_SIZE,
+ .mask_flags = MTD_WRITEABLE, /* force read-only */
+ },
+ {
+ .name = "U-Boot Env",
+ .offset = MTDPART_OFS_APPEND, /* Offset = 0x260000 */
+ .size = 1 * NAND_BLOCK_SIZE,
+ },
+ {
+ .name = "Kernel",
+ .offset = MTDPART_OFS_APPEND, /* Offset = 0x280000 */
+ .size = 32 * NAND_BLOCK_SIZE,
+ },
+ {
+ .name = "File System",
+ .offset = MTDPART_OFS_APPEND, /* Offset = 0x680000 */
+ .size = MTDPART_SIZ_FULL,
+ },
+};
+
+static struct omap_nand_platform_data omap3touchbook_nand_data = {
+ .options = NAND_BUSWIDTH_16,
+ .parts = omap3touchbook_nand_partitions,
+ .nr_parts = ARRAY_SIZE(omap3touchbook_nand_partitions),
+ .dma_channel = -1, /* disable DMA in OMAP NAND driver */
+ .nand_setup = NULL,
+ .dev_ready = NULL,
+};
+
+static struct resource omap3touchbook_nand_resource = {
+ .flags = IORESOURCE_MEM,
+};
+
+static struct platform_device omap3touchbook_nand_device = {
+ .name = "omap2-nand",
+ .id = -1,
+ .dev = {
+ .platform_data = &omap3touchbook_nand_data,
+ },
+ .num_resources = 1,
+ .resource = &omap3touchbook_nand_resource,
+};
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+static struct twl4030_hsmmc_info mmc[] = {
+ {
+ .mmc = 1,
+ .wires = 8,
+ .gpio_wp = 29,
+ },
+ {} /* Terminator */
+};
+
+static struct platform_device omap3_touchbook_lcd_device = {
+ .name = "omap3touchbook_lcd",
+ .id = -1,
+};
+
+static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
+ .ctrl_name = "internal",
+};
+
+static struct regulator_consumer_supply touchbook_vmmc1_supply = {
+ .supply = "vmmc",
+};
+
+static struct regulator_consumer_supply touchbook_vsim_supply = {
+ .supply = "vmmc_aux",
+};
+
+static struct gpio_led gpio_leds[];
+
+static int touchbook_twl_gpio_setup(struct device *dev,
+ unsigned gpio, unsigned ngpio)
+{
+ if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+ omap_cfg_reg(AG9_34XX_GPIO23);
+ mmc[0].gpio_wp = 23;
+ } else {
+ omap_cfg_reg(AH8_34XX_GPIO29);
+ }
+ /* gpio + 0 is "mmc0_cd" (input/IRQ) */
+ mmc[0].gpio_cd = gpio + 0;
+ twl4030_mmc_init(mmc);
+
+ /* link regulators to MMC adapters */
+ touchbook_vmmc1_supply.dev = mmc[0].dev;
+ touchbook_vsim_supply.dev = mmc[0].dev;
+
+ /* REVISIT: need ehci-omap hooks for external VBUS
+ * power switch and overcurrent detect
+ */
+
+ gpio_request(gpio + 1, "EHCI_nOC");
+ gpio_direction_input(gpio + 1);
+
+ /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+ gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
+ gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
+ /* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+ gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+ return 0;
+}
+
+static struct twl4030_gpio_platform_data touchbook_gpio_data = {
+ .gpio_base = OMAP_MAX_GPIO_LINES,
+ .irq_base = TWL4030_GPIO_IRQ_BASE,
+ .irq_end = TWL4030_GPIO_IRQ_END,
+ .use_leds = true,
+ .pullups = BIT(1),
+ .pulldowns = BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+ | BIT(15) | BIT(16) | BIT(17),
+ .setup = touchbook_twl_gpio_setup,
+};
+
+static struct regulator_consumer_supply touchbook_vdac_supply = {
+ .supply = "vdac",
+ .dev = &omap3_touchbook_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply touchbook_vdvi_supply = {
+ .supply = "vdvi",
+ .dev = &omap3_touchbook_lcd_device.dev,
+};
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max
220 mA) */
+static struct regulator_init_data touchbook_vmmc1 = {
+ .constraints = {
+ .min_uV = 1850000,
+ .max_uV = 3150000,
+ .valid_modes_mask = REGULATOR_MODE_NORMAL
+ | REGULATOR_MODE_STANDBY,
+ .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+ | REGULATOR_CHANGE_MODE
+ | REGULATOR_CHANGE_STATUS,
+ },
+ .num_consumer_supplies = 1,
+ .consumer_supplies = &touchbook_vmmc1_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data touchbook_vsim = {
+ .constraints = {
+ .min_uV = 1800000,
+ .max_uV = 3000000,
+ .valid_modes_mask = REGULATOR_MODE_NORMAL
+ | REGULATOR_MODE_STANDBY,
+ .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+ | REGULATOR_CHANGE_MODE
+ | REGULATOR_CHANGE_STATUS,
+ },
+ .num_consumer_supplies = 1,
+ .consumer_supplies = &touchbook_vsim_supply,
+};
+
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data touchbook_vdac = {
+ .constraints = {
+ .min_uV = 1800000,
+ .max_uV = 1800000,
+ .valid_modes_mask = REGULATOR_MODE_NORMAL
+ | REGULATOR_MODE_STANDBY,
+ .valid_ops_mask = REGULATOR_CHANGE_MODE
+ | REGULATOR_CHANGE_STATUS,
+ },
+ .num_consumer_supplies = 1,
+ .consumer_supplies = &touchbook_vdac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data touchbook_vpll2 = {
+ .constraints = {
+ .name = "VDVI",
+ .min_uV = 1800000,
+ .max_uV = 1800000,
+ .valid_modes_mask = REGULATOR_MODE_NORMAL
+ | REGULATOR_MODE_STANDBY,
+ .valid_ops_mask = REGULATOR_CHANGE_MODE
+ | REGULATOR_CHANGE_STATUS,
+ },
+ .num_consumer_supplies = 1,
+ .consumer_supplies = &touchbook_vdvi_supply,
+};
+
+static struct twl4030_usb_data touchbook_usb_data = {
+ .usb_mode = T2_USB_MODE_ULPI,
+};
+
+static struct twl4030_codec_audio_data touchbook_audio_data = {
+ .audio_mclk = 26000000,
+};
+
+static struct twl4030_codec_data touchbook_codec_data = {
+ .audio_mclk = 26000000,
+ .audio = &touchbook_audio_data,
+};
+
+static struct twl4030_platform_data touchbook_twldata = {
+ .irq_base = TWL4030_IRQ_BASE,
+ .irq_end = TWL4030_IRQ_END,
+
+ /* platform_data for children goes here */
+ .usb = &touchbook_usb_data,
+ .gpio = &touchbook_gpio_data,
+ .codec = &touchbook_codec_data,
+ .vmmc1 = &touchbook_vmmc1,
+ .vsim = &touchbook_vsim,
+ .vdac = &touchbook_vdac,
+ .vpll2 = &touchbook_vpll2,
+};
+
+static struct i2c_board_info __initdata touchbook_i2c_boardinfo[] = {
+ {
+ I2C_BOARD_INFO("twl4030", 0x48),
+ .flags = I2C_CLIENT_WAKE,
+ .irq = INT_34XX_SYS_NIRQ,
+ .platform_data = &touchbook_twldata,
+ },
+};
+
+static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] = {
+ {
+ I2C_BOARD_INFO("bq27200", 0x55),
+ },
+};
+
+static int __init omap3_touchbook_i2c_init(void)
+{
+ /* Standard TouchBook bus */
+ omap_register_i2c_bus(1, 2600, touchbook_i2c_boardinfo,
+ ARRAY_SIZE(touchbook_i2c_boardinfo));
+
+ /* Additional TouchBook bus */
+ omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
+ ARRAY_SIZE(touchBook_i2c_boardinfo));
+
+ return 0;
+}
+
+static void __init omap3_ads7846_init(void)
+{
+ if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
+ printk(KERN_ERR "Failed to request GPIO %d for "
+ "ads7846 pen down IRQ\n", OMAP3_TS_GPIO);
+ return;
+ }
+
+ gpio_direction_input(OMAP3_TS_GPIO);
+ omap_set_gpio_debounce(OMAP3_TS_GPIO, 1);
+ omap_set_gpio_debounce_time(OMAP3_TS_GPIO, 0xa);
+}
+
+static struct ads7846_platform_data ads7846_config = {
+ .x_min = 100,
+ .y_min = 265,
+ .x_max = 3950,
+ .y_max = 3750,
+ .x_plate_ohms = 40,
+ .pressure_max = 255,
+ .debounce_max = 10,
+ .debounce_tol = 5,
+ .debounce_rep = 1,
+ .gpio_pendown = OMAP3_TS_GPIO,
+ .keep_vref_on = 1,
+};
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+ .turbo_mode = 0,
+ .single_channel = 1, /* 0: slave, 1: master */
+};
+
+static struct spi_board_info omap3_ads7846_spi_board_info[] __initdata
= {
+ {
+ .modalias = "ads7846",
+ .bus_num = 4,
+ .chip_select = 0,
+ .max_speed_hz = 1500000,
+ .controller_data = &ads7846_mcspi_config,
+ .irq = OMAP_GPIO_IRQ(OMAP3_TS_GPIO),
+ .platform_data = &ads7846_config,
+ }
+};
+
+static struct gpio_led gpio_leds[] = {
+ {
+ .name = "touchbook::usr0",
+ .default_trigger = "heartbeat",
+ .gpio = 150,
+ },
+ {
+ .name = "touchbook::usr1",
+ .default_trigger = "mmc0",
+ .gpio = 149,
+ },
+ {
+ .name = "touchbook::pmu_stat",
+ .gpio = -EINVAL, /* gets replaced */
+ .active_low = true,
+ },
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+ .leds = gpio_leds,
+ .num_leds = ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+ .name = "leds-gpio",
+ .id = -1,
+ .dev = {
+ .platform_data = &gpio_led_info,
+ },
+};
+
+static struct gpio_keys_button gpio_buttons[] = {
+ {
+ .code = BTN_EXTRA,
+ .gpio = 7,
+ .desc = "user",
+ .wakeup = 1,
+ },
+ {
+ .code = KEY_POWER,
+ .gpio = 183,
+ .desc = "power",
+ .wakeup = 1,
+ },
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+ .buttons = gpio_buttons,
+ .nbuttons = ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device keys_gpio = {
+ .name = "gpio-keys",
+ .id = -1,
+ .dev = {
+ .platform_data = &gpio_key_info,
+ },
+};
+
+static struct omap_board_config_kernel omap3_touchbook_config[]
__initdata = {
+ { OMAP_TAG_LCD, &omap3_touchbook_lcd_config },
+};
+
+static void __init omap3_touchbook_init_irq(void)
+{
+ omap_board_config = omap3_touchbook_config;
+ omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
+ omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+      mt46h32m32lf6_sdrc_params);
+ omap_init_irq();
+#ifdef CONFIG_OMAP_32K_TIMER
+ omap2_gp_clockevent_set_gptimer(12);
+#endif
+ omap_gpio_init();
+}
+
+static struct platform_device *omap3_touchbook_devices[] __initdata = {
+ &omap3_touchbook_lcd_device,
+ &leds_gpio,
+ &keys_gpio,
+};
+
+static void __init omap3touchbook_flash_init(void)
+{
+ u8 cs = 0;
+ u8 nandcs = GPMC_CS_NUM + 1;
+
+ u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+ /* find out the chip-select on which NAND exists */
+ while (cs < GPMC_CS_NUM) {
+ u32 ret = 0;
+ ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+ if ((ret & 0xC00) == 0x800) {
+ printk(KERN_INFO "Found NAND on CS%d\n", cs);
+ if (nandcs > GPMC_CS_NUM)
+ nandcs = cs;
+ }
+ cs++;
+ }
+
+ if (nandcs > GPMC_CS_NUM) {
+ printk(KERN_INFO "NAND: Unable to find configuration "
+ "in GPMC\n ");
+ return;
+ }
+
+ if (nandcs < GPMC_CS_NUM) {
+ omap3touchbook_nand_data.cs = nandcs;
+ omap3touchbook_nand_data.gpmc_cs_baseaddr = (void *)
+ (gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+ omap3touchbook_nand_data.gpmc_baseaddr =
+ (void *) (gpmc_base_add);
+
+ printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+ if (platform_device_register(&omap3touchbook_nand_device) < 0)
+ printk(KERN_ERR "Unable to register NAND device\n");
+ }
+}
+
+static void __init omap3_mma7455l_init(void)
+{
+ int ret;
+
+ ret = gpio_request(OMAP3_AC_GPIO, "mma7455l");
+ if (ret < 0) {
+ printk(KERN_ERR "Failed to request GPIO %d for mma7455l IRQ\n",
+ OMAP3_AC_GPIO);
+ return;
+ }
+
+ gpio_direction_input(OMAP3_AC_GPIO);
+}
+
+static struct mma7455l_platform_data mma7455l_config = {
+ .calibration_x = -4,
+ .calibration_y = 28,
+ .calibration_z = -28,
+};
+
+static struct omap2_mcspi_device_config mma7455l_mcspi_config = {
+ .turbo_mode = 0,
+ .single_channel = 1, /* 0: slave, 1: master */
+};
+
+static struct spi_board_info omap3_mma7455l_spi_board_info[] __initdata
= {
+ {
+ .modalias = "mma7455l",
+ .bus_num = 3,
+ .chip_select = 0,
+ .max_speed_hz = 200000,
+ .irq = OMAP_GPIO_IRQ(OMAP3_AC_GPIO),
+ .controller_data = &mma7455l_mcspi_config,
+ .platform_data = &mma7455l_config,
+ }
+};
+
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+ .port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+ .port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+ .port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+ .phy_reset  = true,
+ .reset_gpio_port[0]  = -EINVAL,
+ .reset_gpio_port[1]  = 147,
+ .reset_gpio_port[2]  = -EINVAL
+};
+
+static int touchbook_backlight_brightness = 50;
+static struct omap_dm_timer *touchbook_backlight_pwm;
+
+static int touchbook_backlight_read(struct backlight_device *bd)
+{
+ return touchbook_backlight_brightness;
+}
+
+static int touchbook_backlight_update(struct backlight_device *bd)
+{
+ int value = bd->props.brightness;
+ touchbook_backlight_brightness = value;
+
+ /* Frequency calculation:
+    - For 200Hz PWM, you want to load -164 (=> -32768Hz / 200Hz).
+    - Minimum duty cycle for the backlight is 15%.
+    - You have (164*0.85) => ~140 levels of brightness.
+ */
+
+ /* For maximum brightness, just stop the timer... */
+ if (value != bd->props.max_brightness) {
+ /* Load the appropriate value for 200Hz PWM */
+ u32 period = clk_get_rate(omap_dm_timer_get_fclk(
+ touchbook_backlight_pwm)) / 200;
+
+ /* Minimum duty cycle is 15% */
+ u32 minimum = (period * 3) / 20;
+ u32 maximum = (period * 17) / 20;
+
+ /* Work out match value */
+ u32 match = (maximum * value) / 100;
+
+ /* Start... */
+ omap_dm_timer_set_load(touchbook_backlight_pwm,
+ 1, 0xFFFFFFFF - period - 1);
+ omap_dm_timer_set_match(touchbook_backlight_pwm,
+ 1, 0xFFFFFFFF - minimum - match);
+ omap_dm_timer_write_counter(touchbook_backlight_pwm, -1);
+ omap_dm_timer_start(touchbook_backlight_pwm);
+ } else
+ omap_dm_timer_stop(touchbook_backlight_pwm);
+
+
+ return 0;
+}
+
+static struct backlight_ops touchbook_backlight_properties = {
+ .get_brightness = touchbook_backlight_read,
+ .update_status = touchbook_backlight_update,
+};
+
+static void __init omap3_touchbook_backlight_init(void)
+{
+ static struct backlight_device *bd;
+ bd = backlight_device_register("touchbook", NULL, NULL,
+ &touchbook_backlight_properties);
+
+ if (bd) {
+ touchbook_backlight_pwm = omap_dm_timer_request_specific(
+ TB_BL_PWM_TIMER);
+ omap_dm_timer_enable(touchbook_backlight_pwm);
+ omap_dm_timer_set_source(touchbook_backlight_pwm,
+ OMAP_TIMER_SRC_SYS_CLK);
+ omap_dm_timer_set_pwm(touchbook_backlight_pwm,
+ 1, 1, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+ bd->props.max_brightness = 100;
+ bd->props.brightness = touchbook_backlight_brightness;
+ }
+
+ touchbook_backlight_update(bd);
+}
+
+static void omap3_touchbook_poweroff(void)
+{
+ int r;
+
+ r = gpio_request(TB_KILL_POWER_GPIO, "DVI reset");
+ if (r < 0) {
+ printk(KERN_ERR "Unable to get kill power GPIO\n");
+ return;
+ }
+
+ gpio_direction_output(TB_KILL_POWER_GPIO, 0);
+}
+
+static void __init early_touchbook_revision(char **p)
+{
+ if (!*p)
+ return;
+
+ strict_strtoul(*p, 10, &touchbook_revision);
+}
+__early_param("tbr=", early_touchbook_revision);
+
+static void __init omap3_touchbook_init(void)
+{
+ pm_power_off = omap3_touchbook_poweroff;
+
+ omap3_touchbook_i2c_init();
+ platform_add_devices(omap3_touchbook_devices,
+ ARRAY_SIZE(omap3_touchbook_devices));
+ omap_serial_init();
+
+ omap_cfg_reg(J25_34XX_GPIO170);
+ gpio_request(176, "DVI_nPD");
+ /* REVISIT leave DVI powered down until it's needed ... */
+ gpio_direction_output(176, true);
+
+ /* Touchscreen and accelerometer */
+ spi_register_board_info(omap3_ads7846_spi_board_info,
+ ARRAY_SIZE(omap3_ads7846_spi_board_info));
+ spi_register_board_info(omap3_mma7455l_spi_board_info,
+ ARRAY_SIZE(omap3_mma7455l_spi_board_info));
+ omap3_ads7846_init();
+ omap3_mma7455l_init();
+
+ omap3_touchbook_backlight_init();
+
+ usb_musb_init();
+ usb_ehci_init(&ehci_pdata);
+ omap3touchbook_flash_init();
+
+ /* Ensure SDRC pins are mux'd for self-refresh */
+ omap_cfg_reg(H16_34XX_SDRC_CKE0);
+ omap_cfg_reg(H17_34XX_SDRC_CKE1);
+}
+
+static void __init omap3_touchbook_map_io(void)
+{
+ omap2_set_globals_343x();
+ omap2_map_common_io();
+}
+
+MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
+ /* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
+ .phys_io = 0x48000000,
+ .io_pg_offst = ((0xd8000000) >> 18) & 0xfffc,
+ .boot_params = 0x80000100,
+ .map_io = omap3_touchbook_map_io,
+ .init_irq = omap3_touchbook_init_irq,
+ .init_machine = omap3_touchbook_init,
+ .timer = &omap_timer,
+MACHINE_END
-- 
1.6.0.4



--=-26zuJmkY0Q3fn5cLM2aC
Content-Disposition: attachment; filename*0=0002-Board-file-of-Always-Innovating-OMAP3-based-Touch-Bo.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-Board-file-of-Always-Innovating-OMAP3-based-Touch-Bo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

>From 795fb3714e9bbb3ed358fb13d282bd80da3c5f9c Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:30:39 -0800
Subject: [PATCH] Board file of Always Innovating OMAP3-based Touch Book


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |  683 ++++++++++++++++++++++++++++
 1 files changed, 683 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
new file mode 100644
index 0000000..ad3ef6e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -0,0 +1,683 @@
+/*
+ * linux/arch/arm/mach-omap2/board-omap3touchbook.c
+ *
+ * Copyright (C) 2009 Always Innovating
+ *
+ * Modified from mach-omap2/board-omap3beagleboard.c
+ *
+ * Initial code: Grégoire Gentil, Tim Yamin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
+#include <plat/mcspi.h>
+#include <linux/spi/spi.h>
+
+#include <linux/spi/ads7846.h>
+#include <linux/mma7455l.h>
+
+#include <plat/dmtimer.h>
+#include <linux/backlight.h>
+
+#include <linux/regulator/machine.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/timer-gp.h>
+
+#include "mmc-twl4030.h"
+
+#include <asm/setup.h>
+
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+#define NAND_BLOCK_SIZE		SZ_128K
+
+#define OMAP3_AC_GPIO		136
+#define OMAP3_TS_GPIO		162
+#define TB_BL_PWM_TIMER		9
+#define TB_KILL_POWER_GPIO	168
+
+unsigned long touchbook_revision;
+
+static struct mtd_partition omap3touchbook_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader",
+		.offset		= 0,
+		.size		= 4 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 15 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot Env",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
+		.size		= 1 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "Kernel",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "File System",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_nand_platform_data omap3touchbook_nand_data = {
+	.options	= NAND_BUSWIDTH_16,
+	.parts		= omap3touchbook_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(omap3touchbook_nand_partitions),
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.nand_setup	= NULL,
+	.dev_ready	= NULL,
+};
+
+static struct resource omap3touchbook_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device omap3touchbook_nand_device = {
+	.name		= "omap2-nand",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &omap3touchbook_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &omap3touchbook_nand_resource,
+};
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 8,
+		.gpio_wp	= 29,
+	},
+	{}	/* Terminator */
+};
+
+static struct platform_device omap3_touchbook_lcd_device = {
+	.name		= "omap3touchbook_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct regulator_consumer_supply touchbook_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply touchbook_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
+static struct gpio_led gpio_leds[];
+
+static int touchbook_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+		omap_cfg_reg(AG9_34XX_GPIO23);
+		mmc[0].gpio_wp = 23;
+	} else {
+		omap_cfg_reg(AH8_34XX_GPIO29);
+	}
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
+
+	/* link regulators to MMC adapters */
+	touchbook_vmmc1_supply.dev = mmc[0].dev;
+	touchbook_vsim_supply.dev = mmc[0].dev;
+
+	/* REVISIT: need ehci-omap hooks for external VBUS
+	 * power switch and overcurrent detect
+	 */
+
+	gpio_request(gpio + 1, "EHCI_nOC");
+	gpio_direction_input(gpio + 1);
+
+	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	return 0;
+}
+
+static struct twl4030_gpio_platform_data touchbook_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= true,
+	.pullups	= BIT(1),
+	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+				| BIT(15) | BIT(16) | BIT(17),
+	.setup		= touchbook_twl_gpio_setup,
+};
+
+static struct regulator_consumer_supply touchbook_vdac_supply = {
+	.supply		= "vdac",
+	.dev		= &omap3_touchbook_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply touchbook_vdvi_supply = {
+	.supply		= "vdvi",
+	.dev		= &omap3_touchbook_lcd_device.dev,
+};
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data touchbook_vmmc1 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &touchbook_vmmc1_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data touchbook_vsim = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &touchbook_vsim_supply,
+};
+
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data touchbook_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &touchbook_vdac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data touchbook_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &touchbook_vdvi_supply,
+};
+
+static struct twl4030_usb_data touchbook_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
+static struct twl4030_codec_audio_data touchbook_audio_data = {
+	.audio_mclk = 26000000,
+};
+
+static struct twl4030_codec_data touchbook_codec_data = {
+	.audio_mclk = 26000000,
+	.audio = &touchbook_audio_data,
+};
+
+static struct twl4030_platform_data touchbook_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.usb		= &touchbook_usb_data,
+	.gpio		= &touchbook_gpio_data,
+	.codec		= &touchbook_codec_data,
+	.vmmc1		= &touchbook_vmmc1,
+	.vsim		= &touchbook_vsim,
+	.vdac		= &touchbook_vdac,
+	.vpll2		= &touchbook_vpll2,
+};
+
+static struct i2c_board_info __initdata touchbook_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &touchbook_twldata,
+	},
+};
+
+static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("bq27200", 0x55),
+	},
+};
+
+static int __init omap3_touchbook_i2c_init(void)
+{
+	/* Standard TouchBook bus */
+	omap_register_i2c_bus(1, 2600, touchbook_i2c_boardinfo,
+			ARRAY_SIZE(touchbook_i2c_boardinfo));
+
+	/* Additional TouchBook bus */
+	omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
+			ARRAY_SIZE(touchBook_i2c_boardinfo));
+
+	return 0;
+}
+
+static void __init omap3_ads7846_init(void)
+{
+	if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
+		printk(KERN_ERR "Failed to request GPIO %d for "
+				"ads7846 pen down IRQ\n", OMAP3_TS_GPIO);
+		return;
+	}
+
+	gpio_direction_input(OMAP3_TS_GPIO);
+	omap_set_gpio_debounce(OMAP3_TS_GPIO, 1);
+	omap_set_gpio_debounce_time(OMAP3_TS_GPIO, 0xa);
+}
+
+static struct ads7846_platform_data ads7846_config = {
+	.x_min			= 100,
+	.y_min			= 265,
+	.x_max			= 3950,
+	.y_max			= 3750,
+	.x_plate_ohms		= 40,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 5,
+	.debounce_rep		= 1,
+	.gpio_pendown		= OMAP3_TS_GPIO,
+	.keep_vref_on		= 1,
+};
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+static struct spi_board_info omap3_ads7846_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 4,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OMAP3_TS_GPIO),
+		.platform_data		= &ads7846_config,
+	}
+};
+
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "touchbook::usr0",
+		.default_trigger	= "heartbeat",
+		.gpio			= 150,
+	},
+	{
+		.name			= "touchbook::usr1",
+		.default_trigger	= "mmc0",
+		.gpio			= 149,
+	},
+	{
+		.name			= "touchbook::pmu_stat",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
+static struct gpio_keys_button gpio_buttons[] = {
+	{
+		.code			= BTN_EXTRA,
+		.gpio			= 7,
+		.desc			= "user",
+		.wakeup			= 1,
+	},
+	{
+		.code			= KEY_POWER,
+		.gpio			= 183,
+		.desc			= "power",
+		.wakeup			= 1,
+	},
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device keys_gpio = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_key_info,
+	},
+};
+
+static struct omap_board_config_kernel omap3_touchbook_config[] __initdata = {
+	{ OMAP_TAG_LCD,		&omap3_touchbook_lcd_config },
+};
+
+static void __init omap3_touchbook_init_irq(void)
+{
+	omap_board_config = omap3_touchbook_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+#ifdef CONFIG_OMAP_32K_TIMER
+	omap2_gp_clockevent_set_gptimer(12);
+#endif
+	omap_gpio_init();
+}
+
+static struct platform_device *omap3_touchbook_devices[] __initdata = {
+	&omap3_touchbook_lcd_device,
+	&leds_gpio,
+	&keys_gpio,
+};
+
+static void __init omap3touchbook_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	/* find out the chip-select on which NAND exists */
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			printk(KERN_INFO "Found NAND on CS%d\n", cs);
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				 "in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM) {
+		omap3touchbook_nand_data.cs = nandcs;
+		omap3touchbook_nand_data.gpmc_cs_baseaddr = (void *)
+			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+		omap3touchbook_nand_data.gpmc_baseaddr =
+						(void *) (gpmc_base_add);
+
+		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+		if (platform_device_register(&omap3touchbook_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+	}
+}
+
+static void __init omap3_mma7455l_init(void)
+{
+	int ret;
+
+	ret = gpio_request(OMAP3_AC_GPIO, "mma7455l");
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to request GPIO %d for mma7455l IRQ\n",
+			OMAP3_AC_GPIO);
+		return;
+	}
+
+	gpio_direction_input(OMAP3_AC_GPIO);
+}
+
+static struct mma7455l_platform_data mma7455l_config = {
+	.calibration_x = -4,
+	.calibration_y = 28,
+	.calibration_z = -28,
+};
+
+static struct omap2_mcspi_device_config mma7455l_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+static struct spi_board_info omap3_mma7455l_spi_board_info[] __initdata = {
+	{
+		.modalias		= "mma7455l",
+		.bus_num		= 3,
+		.chip_select		= 0,
+		.max_speed_hz		= 200000,
+		.irq			= OMAP_GPIO_IRQ(OMAP3_AC_GPIO),
+		.controller_data	= &mma7455l_mcspi_config,
+		.platform_data		= &mma7455l_config,
+	}
+};
+
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 147,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static int touchbook_backlight_brightness = 50;
+static struct omap_dm_timer *touchbook_backlight_pwm;
+
+static int touchbook_backlight_read(struct backlight_device *bd)
+{
+	return touchbook_backlight_brightness;
+}
+
+static int touchbook_backlight_update(struct backlight_device *bd)
+{
+	int value = bd->props.brightness;
+	touchbook_backlight_brightness = value;
+
+	/* Frequency calculation:
+	   - For 200Hz PWM, you want to load -164 (=> -32768Hz / 200Hz).
+	   - Minimum duty cycle for the backlight is 15%.
+	   - You have (164*0.85) => ~140 levels of brightness.
+	*/
+
+	/* For maximum brightness, just stop the timer... */
+	if (value != bd->props.max_brightness) {
+		/* Load the appropriate value for 200Hz PWM */
+		u32 period = clk_get_rate(omap_dm_timer_get_fclk(
+					touchbook_backlight_pwm)) / 200;
+
+		/* Minimum duty cycle is 15% */
+		u32 minimum = (period * 3) / 20;
+		u32 maximum = (period * 17) / 20;
+
+		/* Work out match value */
+		u32 match = (maximum * value) / 100;
+
+		/* Start... */
+		omap_dm_timer_set_load(touchbook_backlight_pwm,
+					1, 0xFFFFFFFF - period - 1);
+		omap_dm_timer_set_match(touchbook_backlight_pwm,
+					1, 0xFFFFFFFF - minimum - match);
+		omap_dm_timer_write_counter(touchbook_backlight_pwm, -1);
+		omap_dm_timer_start(touchbook_backlight_pwm);
+	} else
+		omap_dm_timer_stop(touchbook_backlight_pwm);
+
+
+	return 0;
+}
+
+static struct backlight_ops touchbook_backlight_properties = {
+	.get_brightness = touchbook_backlight_read,
+	.update_status = touchbook_backlight_update,
+};
+
+static void __init omap3_touchbook_backlight_init(void)
+{
+	static struct backlight_device *bd;
+	bd = backlight_device_register("touchbook", NULL, NULL,
+					&touchbook_backlight_properties);
+
+	if (bd) {
+		touchbook_backlight_pwm = omap_dm_timer_request_specific(
+				TB_BL_PWM_TIMER);
+		omap_dm_timer_enable(touchbook_backlight_pwm);
+		omap_dm_timer_set_source(touchbook_backlight_pwm,
+				OMAP_TIMER_SRC_SYS_CLK);
+		omap_dm_timer_set_pwm(touchbook_backlight_pwm,
+				1, 1, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+		bd->props.max_brightness = 100;
+		bd->props.brightness = touchbook_backlight_brightness;
+	}
+
+	touchbook_backlight_update(bd);
+}
+
+static void omap3_touchbook_poweroff(void)
+{
+	int r;
+
+	r = gpio_request(TB_KILL_POWER_GPIO, "DVI reset");
+	if (r < 0) {
+		printk(KERN_ERR "Unable to get kill power GPIO\n");
+		return;
+	}
+
+	gpio_direction_output(TB_KILL_POWER_GPIO, 0);
+}
+
+static void __init early_touchbook_revision(char **p)
+{
+	if (!*p)
+		return;
+
+	strict_strtoul(*p, 10, &touchbook_revision);
+}
+__early_param("tbr=", early_touchbook_revision);
+
+static void __init omap3_touchbook_init(void)
+{
+	pm_power_off = omap3_touchbook_poweroff;
+
+	omap3_touchbook_i2c_init();
+	platform_add_devices(omap3_touchbook_devices,
+			ARRAY_SIZE(omap3_touchbook_devices));
+	omap_serial_init();
+
+	omap_cfg_reg(J25_34XX_GPIO170);
+	gpio_request(176, "DVI_nPD");
+	/* REVISIT leave DVI powered down until it's needed ... */
+	gpio_direction_output(176, true);
+
+	/* Touchscreen and accelerometer */
+	spi_register_board_info(omap3_ads7846_spi_board_info,
+				ARRAY_SIZE(omap3_ads7846_spi_board_info));
+	spi_register_board_info(omap3_mma7455l_spi_board_info,
+				ARRAY_SIZE(omap3_mma7455l_spi_board_info));
+	omap3_ads7846_init();
+	omap3_mma7455l_init();
+
+	omap3_touchbook_backlight_init();
+
+	usb_musb_init();
+	usb_ehci_init(&ehci_pdata);
+	omap3touchbook_flash_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+}
+
+static void __init omap3_touchbook_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
+	/* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_touchbook_map_io,
+	.init_irq	= omap3_touchbook_init_irq,
+	.init_machine	= omap3_touchbook_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.0.4


--=-26zuJmkY0Q3fn5cLM2aC
Content-Disposition: attachment; filename*0=0002-Board-file-of-Always-Innovating-OMAP3-based-Touch-Bo.pat; filename*1=ch.zip
Content-Type: application/zip; name*0=0002-Board-file-of-Always-Innovating-OMAP3-based-Touch-Bo.patch.z; name*1=ip
Content-Transfer-Encoding: base64

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
8xUAAAAA


--=-26zuJmkY0Q3fn5cLM2aC--

