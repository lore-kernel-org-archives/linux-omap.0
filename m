From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-omap-git] osk+mistral backlight, power
Date: Wed, 06 Dec 2006 22:46:57 -0800
Message-ID: <20061207064657.CC5D31E7779@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Mistral-specific:
 
  - Add PWL-driven LCD backlight device

  - Apply power to the board even when the LCD isn't configured; things
    like EEPROM, temperature sensor, and wakeup switch depend on it.

Generic backlight driver updates:

  - Don't oops on misconfigured platform device

  - Writing to /sys/class/backlight/omap-bl/brightness now works

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk2/arch/arm/mach-omap1/board-osk.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/board-osk.c	2006-12-06 12:58:14.000000000 -0800
+++ osk2/arch/arm/mach-omap1/board-osk.c	2006-12-06 22:26:42.000000000 -0800
@@ -292,6 +292,18 @@ static struct platform_device osk5912_kp
 	.resource	= osk5912_kp_resources,
 };
 
+static struct omap_backlight_config mistral_bl_data = {
+	.default_intensity	= 0xa0,
+};
+
+static struct platform_device mistral_bl_device = {
+	.name		= "omap-bl",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &mistral_bl_data,
+	},
+};
+
 static struct platform_device osk5912_lcd_device = {
 	.name		= "lcd_osk",
 	.id		= -1,
@@ -299,6 +311,7 @@ static struct platform_device osk5912_lc
 
 static struct platform_device *mistral_devices[] __initdata = {
 	&osk5912_kp_device,
+	&mistral_bl_device,
 	&osk5912_lcd_device,
 };
 
@@ -404,6 +417,15 @@ static void __init osk_mistral_init(void
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
 
+	/* LCD:  backlight, and power; power controls other devices on the
+	 * board, like the touchscreen, EEPROM, and wakeup (!) switch.
+	 */
+	omap_cfg_reg(PWL);
+	if (omap_request_gpio(2) == 0) {
+		omap_set_gpio_direction(2, 0 /* out */);
+		omap_set_gpio_dataout(2, 1 /* on */);
+	}
+
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
Index: osk2/drivers/video/backlight/omap_bl.c
===================================================================
--- osk2.orig/drivers/video/backlight/omap_bl.c	2006-09-29 07:12:43.000000000 -0700
+++ osk2/drivers/video/backlight/omap_bl.c	2006-12-06 21:58:34.000000000 -0800
@@ -110,8 +110,7 @@ static int omapbl_update_status(struct b
 	struct omap_backlight *bl = class_get_devdata(&dev->class_dev);
 
 	if (bl->current_intensity != dev->props->brightness) {
-		if (dev->props->brightness > OMAPBL_MAX_INTENSITY ||
-				dev->props->brightness < 0)
+		if (dev->props->brightness < 0)
 			return -EPERM;	/* Leave current_intensity untouched */
 
 		if (bl->powermode == FB_BLANK_UNBLANK)
@@ -135,6 +134,7 @@ static struct backlight_properties omapb
 	.owner		= THIS_MODULE,
 	.get_brightness	= omapbl_get_intensity,
 	.update_status	= omapbl_update_status,
+	.max_brightness = OMAPBL_MAX_INTENSITY,
 };
 
 static int omapbl_probe(struct platform_device *pdev)
@@ -143,12 +143,20 @@ static int omapbl_probe(struct platform_
 	struct omap_backlight *bl;
 	struct omap_backlight_config *pdata = pdev->dev.platform_data;
 
+	if (!pdata)
+		return -ENXIO;
+
 	omapbl_data.check_fb = pdata->check_fb;
 
 	bl = kzalloc(sizeof(struct omap_backlight), GFP_KERNEL);
 	if (unlikely(!bl))
 		return -ENOMEM;
 
+	/* REVISIT backlight API glitch:  we can't associate the
+	 * class device with "pdev" ... probably pass &pdev->dev
+	 * instead of a string.
+	 */
+
 	dev = backlight_device_register("omap-bl", bl, &omapbl_data);
 	if (IS_ERR(dev)) {
 		kfree(bl);
