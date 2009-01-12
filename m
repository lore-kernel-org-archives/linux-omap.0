From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 12/12] DSS: Hacked N810 support
Date: Mon, 12 Jan 2009 13:48:38 +0200
Message-ID: <20090112114838.1003.90392.stgit@tubuntu>
References: <20090112114718.1003.23643.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35822 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbZALLtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 06:49:07 -0500
In-Reply-To: <20090112114718.1003.23643.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---

 arch/arm/mach-omap2/board-n800.c    |  214 ++++++++++++++---
 drivers/video/omap2/Kconfig         |   10 +
 drivers/video/omap2/Makefile        |    3=20
 drivers/video/omap2/ctrl-blizzard.c |  279 ++++++++++++++++++++++
 drivers/video/omap2/panel-n800.c    |  437 +++++++++++++++++++++++++++=
++++++++
 5 files changed, 905 insertions(+), 38 deletions(-)
 create mode 100644 drivers/video/omap2/ctrl-blizzard.c
 create mode 100644 drivers/video/omap2/panel-n800.c

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/boa=
rd-n800.c
index b38b295..ffa5aad 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -40,6 +40,7 @@
 #include <mach/gpio-switch.h>
 #include <mach/omapfb.h>
 #include <mach/blizzard.h>
+#include <mach/display.h>
=20
 #include <../drivers/cbus/tahvo.h>
 #include <../drivers/media/video/tcm825x.h>
@@ -156,23 +157,175 @@ static struct omap_uart_config n800_uart_config =
__initdata =3D {
=20
 #include "../../../drivers/cbus/retu.h"
=20
-static struct omap_fbmem_config n800_fbmem0_config __initdata =3D {
-	.size =3D 752 * 1024,
+static struct omap_tmp105_config n800_tmp105_config __initdata =3D {
+	.tmp105_irq_pin =3D 125,
+	.set_power =3D n800_tmp105_set_power,
 };
=20
-static struct omap_fbmem_config n800_fbmem1_config __initdata =3D {
-	.size =3D 752 * 1024,
-};
=20
-static struct omap_fbmem_config n800_fbmem2_config __initdata =3D {
-	.size =3D 752 * 1024,
+
+
+/* DISPLAY */
+static struct {
+	struct clk *sys_ck;
+} blizzard;
+
+static int blizzard_get_clocks(void)
+{
+	blizzard.sys_ck =3D clk_get(0, "osc_ck");
+	if (IS_ERR(blizzard.sys_ck)) {
+		printk(KERN_ERR "can't get Blizzard clock\n");
+		return PTR_ERR(blizzard.sys_ck);
+	}
+	return 0;
+}
+
+static unsigned long blizzard_get_clock_rate(void)
+{
+	return clk_get_rate(blizzard.sys_ck);
+}
+
+static int n800_pn800_enable(struct omap_display *display)
+{
+	if (display->hw_config.panel_reset_gpio !=3D -1) {
+		printk("enabling panel gpio\n");
+		gpio_direction_output(display->hw_config.panel_reset_gpio, 1);
+	}
+
+	return 0;
+}
+
+static void n800_pn800_disable(struct omap_display *display)
+{
+	if (display->hw_config.panel_reset_gpio !=3D -1) {
+		printk("disabling panel gpio\n");
+		gpio_direction_output(display->hw_config.panel_reset_gpio, 0);
+		msleep(120);
+	}
+}
+
+static int n800_blizzard_enable(struct omap_display *display)
+{
+	printk("enabling bliz powers\n");
+
+	/* Vcore to 1.475V */
+	tahvo_set_clear_reg_bits(0x07, 0, 0xf);
+	msleep(10);
+
+	clk_enable(blizzard.sys_ck);
+
+	if (display->hw_config.ctrl_reset_gpio !=3D -1)
+		gpio_direction_output(display->hw_config.ctrl_reset_gpio, 1);
+
+	printk("osc_ck %lu\n", blizzard_get_clock_rate());
+
+	return 0;
+}
+
+static void n800_blizzard_disable(struct omap_display *display)
+{
+	printk("disabling bliz powers\n");
+
+	if (display->hw_config.ctrl_reset_gpio !=3D -1)
+		gpio_direction_output(display->hw_config.ctrl_reset_gpio, 0);
+
+	clk_disable(blizzard.sys_ck);
+
+	/* Vcore to 1.005V */
+	tahvo_set_clear_reg_bits(0x07, 0xf, 0);
+}
+
+static int n800_set_backlight_level(struct omap_display *display, int =
level)
+{
+	return 0;
+}
+
+static struct omap_display_data n800_dsi_display_data =3D {
+	.type =3D OMAP_DISPLAY_TYPE_DBI,
+	.name =3D "lcd",
+	.ctrl_name =3D "ctrl-blizzard",
+	.panel_name =3D "panel-pn800",
+	.panel_reset_gpio =3D -1,
+	.ctrl_reset_gpio =3D N800_BLIZZARD_POWERDOWN_GPIO,
+	.panel_enable =3D n800_pn800_enable,
+	.panel_disable =3D n800_pn800_disable,
+	.ctrl_enable =3D n800_blizzard_enable,
+	.ctrl_disable =3D n800_blizzard_disable,
+	.set_backlight =3D n800_set_backlight_level,
+	.u.rfbi =3D {
+		.channel =3D 0,
+		/* 8 for cmd mode, 16 for pixel data. ctrl-blizzard handles switchin=
g */
+		.data_lines =3D 8,
+	},
+	.priv =3D 0, // XXX used for panel datalines
+};
+static struct omap_dss_platform_data n800_dss_data =3D {
+	.num_displays =3D 1,
+	.displays =3D {
+		&n800_dsi_display_data,
+	},
 };
=20
-static struct omap_tmp105_config n800_tmp105_config __initdata =3D {
-	.tmp105_irq_pin =3D 125,
-	.set_power =3D n800_tmp105_set_power,
+static struct platform_device n800_dss_device =3D {
+	.name          =3D "omap-dss",
+	.id            =3D -1,
+	.dev            =3D {
+		.platform_data =3D &n800_dss_data,
+	},
 };
=20
+static void __init n800_display_init(void)
+{
+	int r;
+	const struct omap_lcd_config *conf;
+
+	conf =3D omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf !=3D NULL) {
+		n800_dsi_display_data.panel_reset_gpio =3D conf->nreset_gpio;
+		n800_dsi_display_data.priv =3D (void*)(u32)conf->data_lines; // XXX
+		//printk("\n\nTULI %d\n\n", conf->data_lines);
+	} else {
+		printk("\n\nEI TULLU MIOT=C3=84=C3=84=C3=84\n\n");
+	}
+
+	blizzard_get_clocks();
+	clk_enable(blizzard.sys_ck); // XXX always enable
+
+	//omapfb_set_ctrl_platform_data(&n800_blizzard_data);
+	//
+	if (n800_dsi_display_data.ctrl_reset_gpio !=3D -1) {
+		r =3D gpio_request(n800_dsi_display_data.ctrl_reset_gpio,
+				"Blizzard pd");
+		if (r < 0) {
+			n800_dsi_display_data.ctrl_reset_gpio =3D -1;
+			printk(KERN_ERR "Unable to get Blizzard GPIO\n");
+		} else {
+			gpio_direction_output(n800_dsi_display_data.ctrl_reset_gpio,
+					1);
+			// XXX always enable
+		}
+	}
+
+	if (n800_dsi_display_data.panel_reset_gpio !=3D -1) {
+		r =3D gpio_request(n800_dsi_display_data.panel_reset_gpio,
+				"panel reset");
+		if (r < 0) {
+			n800_dsi_display_data.panel_reset_gpio =3D -1;
+			printk(KERN_ERR "Unable to get pn800 GPIO\n");
+		} else {
+			gpio_direction_output(n800_dsi_display_data.panel_reset_gpio,
+					1);
+			// XXX always enable
+		}
+	}
+}
+
+/* DISPLAY END */
+
+
+
+
+
 static void mipid_shutdown(struct mipid_platform_data *pdata)
 {
 	if (pdata->nreset_gpio !=3D -1) {
@@ -186,6 +339,7 @@ static struct mipid_platform_data n800_mipid_platfo=
rm_data =3D {
 	.shutdown =3D mipid_shutdown,
 };
=20
+#if 0
 static void __init mipid_dev_init(void)
 {
 	const struct omap_lcd_config *conf;
@@ -196,26 +350,9 @@ static void __init mipid_dev_init(void)
 		n800_mipid_platform_data.data_lines =3D conf->data_lines;
 	}
 }
+#endif
=20
-static struct {
-	struct clk *sys_ck;
-} blizzard;
-
-static int blizzard_get_clocks(void)
-{
-	blizzard.sys_ck =3D clk_get(0, "osc_ck");
-	if (IS_ERR(blizzard.sys_ck)) {
-		printk(KERN_ERR "can't get Blizzard clock\n");
-		return PTR_ERR(blizzard.sys_ck);
-	}
-	return 0;
-}
-
-static unsigned long blizzard_get_clock_rate(struct device *dev)
-{
-	return clk_get_rate(blizzard.sys_ck);
-}
-
+#if 0
 static void blizzard_enable_clocks(int enable)
 {
 	if (enable)
@@ -260,14 +397,12 @@ static void __init blizzard_dev_init(void)
 	gpio_direction_output(N800_BLIZZARD_POWERDOWN_GPIO, 1);
=20
 	blizzard_get_clocks();
-	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
+	//omapfb_set_ctrl_platform_data(&n800_blizzard_data);
 }
+#endif
=20
 static struct omap_board_config_kernel n800_config[] __initdata =3D {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
-	{ OMAP_TAG_FBMEM,			&n800_fbmem0_config },
-	{ OMAP_TAG_FBMEM,			&n800_fbmem1_config },
-	{ OMAP_TAG_FBMEM,			&n800_fbmem2_config },
 	{ OMAP_TAG_TMP105,			&n800_tmp105_config },
 };
=20
@@ -374,7 +509,7 @@ static struct omap2_mcspi_device_config tsc2005_mcs=
pi_config =3D {
=20
 static struct spi_board_info n800_spi_board_info[] __initdata =3D {
 	{
-		.modalias	=3D "lcd_mipid",
+		.modalias	=3D "panel-n800",
 		.bus_num	=3D 1,
 		.chip_select	=3D 1,
 		.max_speed_hz	=3D 4000000,
@@ -399,7 +534,7 @@ static struct spi_board_info n800_spi_board_info[] =
__initdata =3D {
=20
 static struct spi_board_info n810_spi_board_info[] __initdata =3D {
 	{
-		.modalias	 =3D "lcd_mipid",
+		.modalias	 =3D "panel-n800",
 		.bus_num	 =3D 1,
 		.chip_select	 =3D 1,
 		.max_speed_hz	 =3D 4000000,
@@ -567,6 +702,7 @@ static struct platform_device *n800_devices[] __ini=
tdata =3D {
 #if defined(CONFIG_CBUS_RETU) && defined(CONFIG_LEDS_OMAP_PWM)
 	&n800_keypad_led_device,
 #endif
+	&n800_dss_device,
 };
=20
 #ifdef CONFIG_MENELAUS
@@ -689,9 +825,10 @@ void __init nokia_n800_common_init(void)
 	if (machine_is_nokia_n810())
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 			ARRAY_SIZE(n810_i2c_board_info_2));
-	=09
-	mipid_dev_init();
-	blizzard_dev_init();
+
+	//mipid_dev_init();
+	//blizzard_dev_init();
+	n800_display_init();
 }
=20
 static void __init nokia_n800_init(void)
@@ -712,6 +849,7 @@ void __init nokia_n800_map_io(void)
 	omap_board_config_size =3D ARRAY_SIZE(n800_config);
=20
 	omap2_set_globals_242x();
+	omap2_set_sdram_vram(800 * 480 * 2 * 3, 0);
 	omap2_map_common_io();
 }
=20
diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
index b54c955..4e9211e 100644
--- a/drivers/video/omap2/Kconfig
+++ b/drivers/video/omap2/Kconfig
@@ -49,4 +49,14 @@ config PANEL_SHARP_LS037V7DW01
         help
           LCD Panel used in TI's SDP3430 and EVM boards
=20
+config PANEL_N800
+        tristate "panel n800"
+        help
+          N800 LCD
+
+config CTRL_BLIZZARD
+        tristate "blizzard ctrl"
+        help
+          Blizzard Ctrl
+
 endmenu
diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefil=
e
index fe6858e..7727f9c 100644
--- a/drivers/video/omap2/Makefile
+++ b/drivers/video/omap2/Makefile
@@ -3,3 +3,6 @@ omapfb-y :=3D omapfb-main.o omapfb-sysfs.o omapfb-ioctl=
=2Eo
=20
 obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw01.o
+
+obj-$(CONFIG_CTRL_BLIZZARD) +=3D ctrl-blizzard.o
+obj-$(CONFIG_PANEL_N800) +=3D panel-n800.o
diff --git a/drivers/video/omap2/ctrl-blizzard.c b/drivers/video/omap2/=
ctrl-blizzard.c
new file mode 100644
index 0000000..e1e5569
--- /dev/null
+++ b/drivers/video/omap2/ctrl-blizzard.c
@@ -0,0 +1,279 @@
+
+//#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include <mach/display.h>
+#include <mach/dma.h>
+
+#ifdef DEBUG
+#define DBG(format, ...) printk(KERN_DEBUG "Blizzard: " format, ## __V=
A_ARGS__)
+#else
+#define DBG(format, ...)
+#endif
+
+#define BLIZZARD_REV_CODE			0x00
+#define BLIZZARD_CONFIG				0x02
+#define BLIZZARD_PLL_DIV			0x04
+#define BLIZZARD_PLL_LOCK_RANGE			0x06
+#define BLIZZARD_PLL_CLOCK_SYNTH_0		0x08
+#define BLIZZARD_PLL_CLOCK_SYNTH_1		0x0a
+#define BLIZZARD_PLL_MODE			0x0c
+#define BLIZZARD_CLK_SRC			0x0e
+#define BLIZZARD_MEM_BANK0_ACTIVATE		0x10
+#define BLIZZARD_MEM_BANK0_STATUS		0x14
+#define BLIZZARD_PANEL_CONFIGURATION		0x28
+#define BLIZZARD_HDISP				0x2a
+#define BLIZZARD_HNDP				0x2c
+#define BLIZZARD_VDISP0				0x2e
+#define BLIZZARD_VDISP1				0x30
+#define BLIZZARD_VNDP				0x32
+#define BLIZZARD_HSW				0x34
+#define BLIZZARD_VSW				0x38
+#define BLIZZARD_DISPLAY_MODE			0x68
+#define BLIZZARD_INPUT_WIN_X_START_0		0x6c
+#define BLIZZARD_DATA_SOURCE_SELECT		0x8e
+#define BLIZZARD_DISP_MEM_DATA_PORT		0x90
+#define BLIZZARD_DISP_MEM_READ_ADDR0		0x92
+#define BLIZZARD_POWER_SAVE			0xE6
+#define BLIZZARD_NDISP_CTRL_STATUS		0xE8
+
+/* Data source select */
+/* For S1D13745 */
+#define BLIZZARD_SRC_WRITE_LCD_BACKGROUND	0x00
+#define BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE	0x01
+#define BLIZZARD_SRC_WRITE_OVERLAY_ENABLE	0x04
+#define BLIZZARD_SRC_DISABLE_OVERLAY		0x05
+/* For S1D13744 */
+#define BLIZZARD_SRC_WRITE_LCD			0x00
+#define BLIZZARD_SRC_BLT_LCD			0x06
+
+#define BLIZZARD_COLOR_RGB565			0x01
+#define BLIZZARD_COLOR_YUV420			0x09
+
+#define BLIZZARD_VERSION_S1D13745		0x01	/* Hailstorm */
+#define BLIZZARD_VERSION_S1D13744		0x02	/* Blizzard */
+
+#define BLIZZARD_AUTO_UPDATE_TIME		(HZ / 20)
+
+
+
+static struct {
+	int			version;
+} blizzard;
+
+
+static inline void blizzard_cmd(u8 cmd)
+{
+        omap_rfbi_write_command(&cmd, 1);
+}
+
+static inline void blizzard_write(u8 cmd, const u8 *buf, int len)
+{
+        omap_rfbi_write_command(&cmd, 1);
+        omap_rfbi_write_data(buf, len);
+}
+
+static inline void blizzard_read(u8 cmd, u8 *buf, int len)
+{
+        omap_rfbi_write_command(&cmd, 1);
+        omap_rfbi_read_data(buf, len);
+}
+
+static u8 blizzard_read_reg(u8 cmd)
+{
+	u8 data;
+	blizzard_read(cmd, &data, 1);
+	return data;
+}
+
+static int blizzard_ctrl_init(struct omap_display *display)
+{
+	DBG("blizzard_ctrl_init\n");
+
+	return 0;
+}
+
+
+static int blizzard_ctrl_enable(struct omap_display *display)
+{
+	int r =3D 0;
+	u8 rev, conf;
+
+	DBG("blizzard_ctrl_enable\n");
+
+	if (display->hw_config.ctrl_enable) {
+		r =3D display->hw_config.ctrl_enable(display);
+		if (r)
+			return r;
+	}
+
+	msleep(100);
+
+	rev =3D blizzard_read_reg(BLIZZARD_CLK_SRC);
+	printk("CLK_SRC %x\n", rev);
+
+	rev =3D blizzard_read_reg(BLIZZARD_PLL_DIV);
+	printk("PLLDIV %x\n", rev);
+
+	rev =3D blizzard_read_reg(BLIZZARD_REV_CODE);
+	conf =3D blizzard_read_reg(BLIZZARD_CONFIG);
+
+	printk("rev %x, conf %x\n", rev, conf);
+
+	switch (rev & 0xfc) {
+	case 0x9c:
+		blizzard.version =3D BLIZZARD_VERSION_S1D13744;
+		pr_info("omapfb: s1d13744 LCD controller rev %d "
+			"initialized (CNF pins %x)\n", rev & 0x03, conf & 0x07);
+		break;
+	case 0xa4:
+		blizzard.version =3D BLIZZARD_VERSION_S1D13745;
+		pr_info("omapfb: s1d13745 LCD controller rev %d "
+			"initialized (CNF pins %x)\n", rev & 0x03, conf & 0x07);
+		break;
+	default:
+		printk("invalid s1d1374x revision %02x\n",
+			rev);
+		r =3D -ENODEV;
+	}
+
+	return r;
+}
+
+static void blizzard_ctrl_disable(struct omap_display *display)
+{
+	DBG("blizzard_ctrl_disable\n");
+
+	if (display->hw_config.ctrl_disable)
+		display->hw_config.ctrl_disable(display);
+}
+
+int rfbi_configure(int rfbi_module, int bpp, int lines);
+
+static void blizzard_ctrl_setup_update(struct omap_display *display,
+				    int x, int y, int w, int h)
+{
+	u8 tmp[18];
+	int x_end, y_end;
+
+	DBG("blizzard_ctrl_setup_update\n");
+
+	x_end =3D x + w - 1;
+	y_end =3D y + h - 1;
+
+	tmp[0] =3D x;
+	tmp[1] =3D x >> 8;
+	tmp[2] =3D y;
+	tmp[3] =3D y >> 8;
+	tmp[4] =3D x_end;
+	tmp[5] =3D x_end >> 8;
+	tmp[6] =3D y_end;
+	tmp[7] =3D y_end >> 8;
+
+	/* scaling? */
+	tmp[8] =3D x;
+	tmp[9] =3D x >> 8;
+	tmp[10] =3D y;
+	tmp[11] =3D y >> 8;
+	tmp[12] =3D x_end;
+	tmp[13] =3D x_end >> 8;
+	tmp[14] =3D y_end;
+	tmp[15] =3D y_end >> 8;
+
+	tmp[16] =3D BLIZZARD_COLOR_RGB565; //color_mode;
+
+	if (blizzard.version =3D=3D BLIZZARD_VERSION_S1D13745)
+		tmp[17] =3D BLIZZARD_SRC_WRITE_LCD_BACKGROUND;
+	else
+		tmp[17] =3D blizzard.version =3D=3D BLIZZARD_VERSION_S1D13744 ?
+				BLIZZARD_SRC_WRITE_LCD :
+				BLIZZARD_SRC_WRITE_LCD_DESTRUCTIVE;
+
+	rfbi_configure(display->hw_config.u.rfbi.channel,
+		       16,
+		       8);
+
+	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
+
+	rfbi_configure(display->hw_config.u.rfbi.channel,
+		       16,
+		       16);
+}
+
+static int blizzard_ctrl_enable_te(struct omap_display *display, int e=
nable)
+{
+	return 0;
+}
+
+static int blizzard_ctrl_rotate(struct omap_display *display, int rota=
te)
+{
+	return 0;
+}
+
+static int blizzard_ctrl_mirror(struct omap_display *display, int enab=
le)
+{
+	return 0;
+}
+
+static int blizzard_run_test(struct omap_display *display, int test_nu=
m)
+{
+	return 0;
+}
+
+static struct omap_ctrl blizzard_ctrl =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "ctrl-blizzard",
+	.init =3D blizzard_ctrl_init,
+	.enable =3D blizzard_ctrl_enable,
+	.disable =3D blizzard_ctrl_disable,
+	.setup_update =3D blizzard_ctrl_setup_update,
+	.enable_te =3D blizzard_ctrl_enable_te,
+	.rotate =3D blizzard_ctrl_rotate,
+	.mirror =3D blizzard_ctrl_mirror,
+	.run_test =3D blizzard_run_test,
+	.pixel_size =3D 16,
+
+	.timings =3D {
+                .cs_on_time     =3D 0,
+
+                .we_on_time     =3D 9000,
+                .we_off_time    =3D 18000,
+                .we_cycle_time  =3D 36000,
+
+                .re_on_time     =3D 9000,
+                .re_off_time    =3D 27000,
+                .re_cycle_time  =3D 36000,
+
+                .access_time    =3D 27000,
+                .cs_off_time    =3D 36000,
+
+                .cs_pulse_width =3D 0,
+        },
+};
+
+
+static int __init blizzard_init(void)
+{
+	DBG("blizzard_init\n");
+	omap_dss_register_ctrl(&blizzard_ctrl);
+	return 0;
+}
+
+static void __exit blizzard_exit(void)
+{
+	DBG("blizzard_exit\n");
+
+	omap_dss_unregister_ctrl(&blizzard_ctrl);
+}
+
+module_init(blizzard_init);
+module_exit(blizzard_exit);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
+MODULE_DESCRIPTION("Blizzard Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/panel-n800.c b/drivers/video/omap2/pan=
el-n800.c
new file mode 100644
index 0000000..3ae0a16
--- /dev/null
+++ b/drivers/video/omap2/panel-n800.c
@@ -0,0 +1,437 @@
+
+/*#define DEBUG*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
+
+#include <mach/display.h>
+#include <mach/dma.h>
+
+#define MIPID_CMD_READ_DISP_ID		0x04
+#define MIPID_CMD_READ_RED		0x06
+#define MIPID_CMD_READ_GREEN		0x07
+#define MIPID_CMD_READ_BLUE		0x08
+#define MIPID_CMD_READ_DISP_STATUS	0x09
+#define MIPID_CMD_RDDSDR		0x0F
+#define MIPID_CMD_SLEEP_IN		0x10
+#define MIPID_CMD_SLEEP_OUT		0x11
+#define MIPID_CMD_DISP_OFF		0x28
+#define MIPID_CMD_DISP_ON		0x29
+
+#define MIPID_VER_LPH8923		3
+#define MIPID_VER_LS041Y3		4
+
+#define MIPID_ESD_CHECK_PERIOD		msecs_to_jiffies(5000)
+
+#ifdef DEBUG
+#define DBG(format, ...) printk(KERN_DEBUG "PN800: " format, ## __VA_A=
RGS__)
+#else
+#define DBG(format, ...)
+#endif
+
+struct pn800_device {
+	struct backlight_device *bl_dev;
+	int		enabled;
+	int		model;
+	int		revision;
+	u8		display_id[3];
+	unsigned int	saved_bklight_level;
+	unsigned long	hw_guard_end;		/* next value of jiffies
+						   when we can issue the
+						   next sleep in/out command */
+	unsigned long	hw_guard_wait;		/* max guard time in jiffies */
+
+	struct spi_device	*spi;
+	struct mutex		mutex;
+	struct omap_panel	panel;
+	struct omap_display	*display;
+};
+
+
+static void pn800_transfer(struct pn800_device *md, int cmd,
+			      const u8 *wbuf, int wlen, u8 *rbuf, int rlen)
+{
+	struct spi_message	m;
+	struct spi_transfer	*x, xfer[4];
+	u16			w;
+	int			r;
+
+	BUG_ON(md->spi =3D=3D NULL);
+
+	spi_message_init(&m);
+
+	memset(xfer, 0, sizeof(xfer));
+	x =3D &xfer[0];
+
+	cmd &=3D  0xff;
+	x->tx_buf =3D &cmd;
+	x->bits_per_word =3D 9;
+	x->len =3D 2;
+	spi_message_add_tail(x, &m);
+
+	if (wlen) {
+		x++;
+		x->tx_buf =3D wbuf;
+		x->len =3D wlen;
+		x->bits_per_word =3D 9;
+		spi_message_add_tail(x, &m);
+	}
+
+	if (rlen) {
+		x++;
+		x->rx_buf =3D &w;
+		x->len =3D 1;
+		spi_message_add_tail(x, &m);
+
+		if (rlen > 1) {
+			/* Arrange for the extra clock before the first
+			 * data bit.
+			 */
+			x->bits_per_word =3D 9;
+			x->len		 =3D 2;
+
+			x++;
+			x->rx_buf	 =3D &rbuf[1];
+			x->len		 =3D rlen - 1;
+			spi_message_add_tail(x, &m);
+		}
+	}
+
+	r =3D spi_sync(md->spi, &m);
+	if (r < 0)
+		dev_dbg(&md->spi->dev, "spi_sync %d\n", r);
+
+	if (rlen)
+		rbuf[0] =3D w & 0xff;
+}
+
+static inline void pn800_cmd(struct pn800_device *md, int cmd)
+{
+	pn800_transfer(md, cmd, NULL, 0, NULL, 0);
+}
+
+static inline void pn800_write(struct pn800_device *md,
+			       int reg, const u8 *buf, int len)
+{
+	pn800_transfer(md, reg, buf, len, NULL, 0);
+}
+
+static inline void pn800_read(struct pn800_device *md,
+			      int reg, u8 *buf, int len)
+{
+	pn800_transfer(md, reg, NULL, 0, buf, len);
+}
+
+static void set_data_lines(struct pn800_device *md, int data_lines)
+{
+	u16 par;
+
+	switch (data_lines) {
+	case 16:
+		par =3D 0x150;
+		break;
+	case 18:
+		par =3D 0x160;
+		break;
+	case 24:
+		par =3D 0x170;
+		break;
+	}
+	pn800_write(md, 0x3a, (u8 *)&par, 2);
+}
+
+static void send_init_string(struct pn800_device *md)
+{
+	u16 initpar[] =3D { 0x0102, 0x0100, 0x0100 };
+	int data_lines;
+
+	pn800_write(md, 0xc2, (u8 *)initpar, sizeof(initpar));
+
+	data_lines =3D (int)md->display->hw_config.priv; // XXX
+
+	set_data_lines(md, data_lines);
+}
+
+static void hw_guard_start(struct pn800_device *md, int guard_msec)
+{
+	md->hw_guard_wait =3D msecs_to_jiffies(guard_msec);
+	md->hw_guard_end =3D jiffies + md->hw_guard_wait;
+}
+
+static void hw_guard_wait(struct pn800_device *md)
+{
+	unsigned long wait =3D md->hw_guard_end - jiffies;
+
+	if ((long)wait > 0 && wait <=3D md->hw_guard_wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(wait);
+	}
+}
+
+static void set_sleep_mode(struct pn800_device *md, int on)
+{
+	int cmd, sleep_time =3D 50;
+
+	if (on)
+		cmd =3D MIPID_CMD_SLEEP_IN;
+	else
+		cmd =3D MIPID_CMD_SLEEP_OUT;
+	hw_guard_wait(md);
+	pn800_cmd(md, cmd);
+	hw_guard_start(md, 120);
+	/*
+	 * When we enable the panel, it seems we _have_ to sleep
+	 * 120 ms before sending the init string. When disabling the
+	 * panel we'll sleep for the duration of 2 frames, so that the
+	 * controller can still provide the PCLK,HS,VS signals. */
+	if (!on)
+		sleep_time =3D 120;
+	msleep(sleep_time);
+}
+
+static void set_display_state(struct pn800_device *md, int enabled)
+{
+	int cmd =3D enabled ? MIPID_CMD_DISP_ON : MIPID_CMD_DISP_OFF;
+
+	pn800_cmd(md, cmd);
+}
+
+static int panel_enabled(struct pn800_device *md)
+{
+	u32 disp_status;
+	int enabled;
+
+	pn800_read(md, MIPID_CMD_READ_DISP_STATUS, (u8 *)&disp_status, 4);
+	disp_status =3D __be32_to_cpu(disp_status);
+	enabled =3D (disp_status & (1 << 17)) && (disp_status & (1 << 10));
+	dev_dbg(&md->spi->dev,
+		"LCD panel %s enabled by bootloader (status 0x%04x)\n",
+		enabled ? "" : "not ", disp_status);
+	DBG("status %#08x\n", disp_status);
+	return enabled;
+}
+
+static int panel_detect(struct pn800_device *md)
+{
+	pn800_read(md, MIPID_CMD_READ_DISP_ID, md->display_id, 3);
+	dev_dbg(&md->spi->dev, "MIPI display ID: %02x%02x%02x\n",
+		md->display_id[0], md->display_id[1], md->display_id[2]);
+
+	switch (md->display_id[0]) {
+	case 0x45:
+		md->model =3D MIPID_VER_LPH8923;
+		md->panel.name =3D "lph8923";
+		break;
+	case 0x83:
+		md->model =3D MIPID_VER_LS041Y3;
+		md->panel.name =3D "ls041y3";
+		//md->esd_check =3D ls041y3_esd_check;
+		break;
+	default:
+		md->panel.name =3D "unknown";
+		dev_err(&md->spi->dev, "invalid display ID\n");
+		return -ENODEV;
+	}
+
+	md->revision =3D md->display_id[1];
+	pr_info("omapfb: %s rev %02x LCD detected\n",
+			md->panel.name, md->revision);
+
+	return 0;
+}
+
+
+
+static int pn800_panel_enable(struct omap_display *display)
+{
+	int r;
+	struct pn800_device *md =3D
+		(struct pn800_device *)display->panel->priv;
+
+	DBG("pn800_panel_enable\n");
+
+	mutex_lock(&md->mutex);
+
+	if (display->hw_config.panel_enable)
+		display->hw_config.panel_enable(display);
+
+	msleep(50); // wait for power up
+
+	r =3D panel_detect(md);
+	if (r) {
+		mutex_unlock(&md->mutex);
+		return r;
+	}
+
+	md->enabled =3D panel_enabled(md);
+
+	if (md->enabled) {
+		DBG("panel already enabled\n");
+		; /*pn800_esd_start_check(md);*/
+	} else {
+		; /*md->saved_bklight_level =3D pn800_get_bklight_level(panel);*/
+	}
+
+
+	if (md->enabled) {
+		mutex_unlock(&md->mutex);
+		return 0;
+	}
+
+	set_sleep_mode(md, 0);
+	md->enabled =3D 1;
+	send_init_string(md);
+	set_display_state(md, 1);
+	//mipid_set_bklight_level(panel, md->saved_bklight_level);
+	//mipid_esd_start_check(md);
+
+	mutex_unlock(&md->mutex);
+	return 0;
+}
+
+static void pn800_panel_disable(struct omap_display *display)
+{
+	struct pn800_device *md =3D
+		(struct pn800_device *)display->panel->priv;
+
+	DBG("pn800_panel_disable\n");
+
+	mutex_lock(&md->mutex);
+
+	if (!md->enabled) {
+		mutex_unlock(&md->mutex);
+		return;
+	}
+	/*md->saved_bklight_level =3D pn800_get_bklight_level(panel);*/
+	/*pn800_set_bklight_level(panel, 0);*/
+
+	set_display_state(md, 0);
+	set_sleep_mode(md, 1);
+	md->enabled =3D 0;
+
+
+	if (display->hw_config.panel_disable)
+		display->hw_config.panel_disable(display);
+
+	mutex_unlock(&md->mutex);
+}
+
+static int pn800_panel_init(struct omap_display *display)
+{
+	struct pn800_device *md =3D
+		(struct pn800_device *)display->panel->priv;
+
+	DBG("pn800_panel_init\n");
+
+	mutex_init(&md->mutex);
+	md->display =3D display;
+
+	return 0;
+}
+
+static int pn800_run_test(struct omap_display *display, int test_num)
+{
+	return 0;
+}
+
+static struct omap_panel pn800_panel =3D {
+	.owner		=3D THIS_MODULE,
+	.name		=3D "panel-pn800",
+	.init		=3D pn800_panel_init,
+	/*.remove	=3D pn800_cleanup,*/
+	.enable		=3D pn800_panel_enable,
+	.disable	=3D pn800_panel_disable,
+	//.set_mode	=3D pn800_set_mode,
+	.run_test	=3D pn800_run_test,
+
+	.timings =3D {
+		.x_res =3D 800,
+		.y_res =3D 480,
+
+		.pixel_clock	=3D 21940,
+		.hsw		=3D 50,
+		.hfp		=3D 20,
+		.hbp		=3D 15,
+
+		.vsw		=3D 2,
+		.vfp		=3D 1,
+		.vbp		=3D 3,
+	},
+	.config		=3D OMAP_DSS_LCD_TFT,
+
+	.bpp =3D 16,
+};
+
+static int pn800_spi_probe(struct spi_device *spi)
+{
+	struct pn800_device *md;
+
+	DBG("pn800_spi_probe\n");
+
+	md =3D kzalloc(sizeof(*md), GFP_KERNEL);
+	if (md =3D=3D NULL) {
+		dev_err(&spi->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	spi->mode =3D SPI_MODE_0;
+	md->spi =3D spi;
+	dev_set_drvdata(&spi->dev, md);
+	md->panel =3D pn800_panel;
+	pn800_panel.priv =3D md;
+
+	omap_dss_register_panel(&pn800_panel);
+
+	return 0;
+}
+
+static int pn800_spi_remove(struct spi_device *spi)
+{
+	struct pn800_device *md =3D dev_get_drvdata(&spi->dev);
+
+	DBG("pn800_spi_remove\n");
+
+	omap_dss_unregister_panel(&pn800_panel);
+
+	/*pn800_disable(&md->panel);*/
+	kfree(md);
+
+	return 0;
+}
+
+static struct spi_driver pn800_spi_driver =3D {
+	.driver =3D {
+		.name	=3D "panel-n800",
+		.bus	=3D &spi_bus_type,
+		.owner	=3D THIS_MODULE,
+	},
+	.probe	=3D pn800_spi_probe,
+	.remove	=3D __devexit_p(pn800_spi_remove),
+};
+
+static int __init pn800_init(void)
+{
+	DBG("pn800_init\n");
+	return spi_register_driver(&pn800_spi_driver);
+}
+
+static void __exit pn800_exit(void)
+{
+	DBG("pn800_exit\n");
+	spi_unregister_driver(&pn800_spi_driver);
+}
+
+module_init(pn800_init);
+module_exit(pn800_exit);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
+MODULE_DESCRIPTION("N800 LCD Driver");
+MODULE_LICENSE("GPL");

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
