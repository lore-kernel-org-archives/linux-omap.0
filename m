From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.17-rc3-omap] Mistral board updates (spi, ...)
Date: Mon, 1 May 2006 13:55:50 -0700
Message-ID: <200605011355.51097.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XXnVE9NsEzyRwU7"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_XXnVE9NsEzyRwU7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Declares the ads7846 device, etc


--Boundary-00=_XXnVE9NsEzyRwU7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="omap-osk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-osk.patch"

This adds the OSK/Mistral specific glue for the omap_uwire driver and
its ADS 7846 touchscreen.  It also moves the lcd and keypad setup so
it's grouped with the other Mistral-specific setup code, and provides
comments about which switch maps to which reported key. 

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/arch/arm/mach-omap1/board-osk.c
===================================================================
--- osk.orig/arch/arm/mach-omap1/board-osk.c	2006-05-01 11:37:16.000000000 -0700
+++ osk/arch/arm/mach-omap1/board-osk.c	2006-05-01 12:09:12.000000000 -0700
@@ -33,7 +33,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/input.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -45,25 +44,10 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
-#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
 
-static int osk_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 3, KEY_UP),
-	KEY(1, 1, KEY_LEFTCTRL),
-	KEY(1, 2, KEY_LEFT),
-	KEY(2, 0, KEY_SPACE),
-	KEY(2, 1, KEY_ESC),
-	KEY(2, 2, KEY_DOWN),
-	KEY(3, 2, KEY_ENTER),
-	KEY(3, 3, KEY_RIGHT),
-	0
-};
-
-
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -181,48 +165,17 @@ static struct omap_alsa_codec_config als
 
 static struct platform_device osk5912_mcbsp1_device = {
 	.name	= "omap_alsa_mcbsp",
- 	.id	= 1,
+	.id	= 1,
 	.dev = {
 		.platform_data	= &alsa_config,
 	},
 };
 
-static struct resource osk5912_kp_resources[] = {
-	[0] = {
-		.start	= INT_KEYBOARD,
-		.end	= INT_KEYBOARD,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct omap_kp_platform_data osk_kp_data = {
-	.rows	= 8,
-	.cols	= 8,
-	.keymap = osk_keymap,
-};
-
-static struct platform_device osk5912_kp_device = {
-	.name		= "omap-keypad",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &osk_kp_data,
-	},
-	.num_resources	= ARRAY_SIZE(osk5912_kp_resources),
-	.resource	= osk5912_kp_resources,
-};
-
-static struct platform_device osk5912_lcd_device = {
-	.name		= "lcd_osk",
-	.id		= -1,
-};
-
 static struct platform_device *osk5912_devices[] __initdata = {
 	&osk5912_flash_device,
 	&osk5912_smc91x_device,
 	&osk5912_cf_device,
 	&osk5912_mcbsp1_device,
-	&osk5912_kp_device,
-	&osk5912_lcd_device,
 };
 
 static void __init osk_init_smc91x(void)
@@ -276,18 +229,95 @@ static struct omap_uart_config osk_uart_
 	.enabled_uarts = (1 << 0),
 };
 
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
 static struct omap_lcd_config osk_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
+#endif
 
 static struct omap_board_config_kernel osk_config[] = {
 	{ OMAP_TAG_USB,           &osk_usb_config },
 	{ OMAP_TAG_UART,		&osk_uart_config },
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
 	{ OMAP_TAG_LCD,			&osk_lcd_config },
+#endif
 };
 
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+#include <asm/arch/keypad.h>
+
+static const int osk_keymap[] = {
+	/* KEY(col, row, code) */
+	KEY(0, 0, KEY_F1),		/* SW4 */
+	KEY(0, 3, KEY_UP),		/* (sw2/up) */
+	KEY(1, 1, KEY_LEFTCTRL),	/* SW5 */
+	KEY(1, 2, KEY_LEFT),		/* (sw2/left) */
+	KEY(2, 0, KEY_SPACE),		/* SW3 */
+	KEY(2, 1, KEY_ESC),		/* SW6 */
+	KEY(2, 2, KEY_DOWN),		/* (sw2/down) */
+	KEY(3, 2, KEY_ENTER),		/* (sw2/select) */
+	KEY(3, 3, KEY_RIGHT),		/* (sw2/right) */
+	0
+};
+
+static struct omap_kp_platform_data osk_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = (int *) osk_keymap,
+};
+
+static struct resource osk5912_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device osk5912_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &osk_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(osk5912_kp_resources),
+	.resource	= osk5912_kp_resources,
+};
+
+static struct platform_device osk5912_lcd_device = {
+	.name		= "lcd_osk",
+	.id		= -1,
+};
+
+static struct platform_device *mistral_devices[] __initdata = {
+	&osk5912_kp_device,
+	&osk5912_lcd_device,
+};
+
+static const struct ads7846_platform_data mistral_ts_info = {
+	.model			= 7846,
+	.vref_delay_usecs	= 100,	/* internal, no capacitor */
+	.x_plate_ohms		= 419,
+	.y_plate_ohms		= 486,
+	// .{x,y,pressure}_{min,max}
+};
+
+static struct spi_board_info __initdata mistral_boardinfo[] = { {
+	/* MicroWire (bus 2) CS0 has an ads7846e */
+	.modalias		= "ads7846",
+	.platform_data		= &mistral_ts_info,
+	.irq			= OMAP_GPIO_IRQ(4),
+	.max_speed_hz		= 120000 /* max sample rate at 3V */
+					* 26 /* command + data + overhead */,
+	.bus_num		= 2,
+	.chip_select		= 0,
+} };
+
 #ifdef	CONFIG_PM
 static irqreturn_t
 osk_mistral_wake_interrupt(int irq, void *ignored, struct pt_regs *regs)
@@ -298,14 +328,18 @@ osk_mistral_wake_interrupt(int irq, void
 
 static void __init osk_mistral_init(void)
 {
-	/* FIXME here's where to feed in framebuffer, touchpad, and
-	 * keyboard setup ...  not in the drivers for those devices!
-	 *
-	 * NOTE:  we could actually tell if there's a Mistral board
+	/* NOTE:  we could actually tell if there's a Mistral board
 	 * attached, e.g. by trying to read something from the ads7846.
-	 * But this is too early for that...
+	 * But this arch_init() code is too early for that, since we
+	 * can't talk to the ads or even the i2c eeprom.
 	 */
 
+	// omap_cfg_reg(P19_1610_GPIO6);	// BUSY
+	omap_cfg_reg(P20_1610_GPIO4);	// PENIRQ
+	set_irq_type(OMAP_GPIO_IRQ(4), IRQT_FALLING);
+	spi_register_board_info(mistral_boardinfo,
+			ARRAY_SIZE(mistral_boardinfo));
+
 	/* the sideways button (SW1) is for use as a "wakeup" button */
 	omap_cfg_reg(N15_1610_MPUIO2);
 	if (omap_request_gpio(OMAP_MPUIO(2)) == 0) {
@@ -329,6 +363,8 @@ static void __init osk_mistral_init(void
 #endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
+
+	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
 static void __init osk_mistral_init(void) { }

--Boundary-00=_XXnVE9NsEzyRwU7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_XXnVE9NsEzyRwU7--
