From: stefano babic <stefano.babic@babic.homelinux.org>
Subject: [PATCH] OMAP Backlight driver
Date: Wed, 16 May 2007 17:28:08 +0200
Message-ID: <200705161728.09017.stefano.babic@babic.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Hi all,

in the actual repository the video backlight API is already updated to the new 
one in kernel 2.6.22-rc1 (include/linux/backlight.h).
Some drivers are updated,too.
However, the backlight driver for Omap (drivers/video/backlight/omap_bl.c) ist 
not yet updated to the new API and for this reason cannot be compiled.

I changed the file according to the new interface :

diff --git a/drivers/video/backlight/omap_bl.c 
b/drivers/video/backlight/omap_bl.c
index 3b57b27..a9532fd 100644
--- a/drivers/video/backlight/omap_bl.c
+++ b/drivers/video/backlight/omap_bl.c
@@ -109,34 +109,34 @@ static int omapbl_update_status(struct b
 {
 	struct omap_backlight *bl = class_get_devdata(&dev->class_dev);
 
-	if (bl->current_intensity != dev->props->brightness) {
-		if (dev->props->brightness < 0)
+	if (bl->current_intensity != dev->props.brightness) {
+		if (dev->props.brightness < 0)
 			return -EPERM;	/* Leave current_intensity untouched */
 
 		if (bl->powermode == FB_BLANK_UNBLANK)
-			omapbl_send_intensity(dev->props->brightness);
-		bl->current_intensity = dev->props->brightness;
+			omapbl_send_intensity(dev->props.brightness);
+		bl->current_intensity = dev->props.brightness;
 	}
 
-	if (dev->props->fb_blank != bl->powermode)
-		omapbl_set_power(dev, dev->props->fb_blank);
+	if (dev->props.fb_blank != bl->powermode)
+		omapbl_set_power(dev, dev->props.fb_blank);
 
 	return 0;
 }
 
+
 static int omapbl_get_intensity(struct backlight_device *dev)
 {
 	struct omap_backlight *bl = class_get_devdata(&dev->class_dev);
 	return bl->current_intensity;
 }
 
-static struct backlight_properties omapbl_data = {
-	.owner		= THIS_MODULE,
-	.get_brightness	= omapbl_get_intensity,
-	.update_status	= omapbl_update_status,
-	.max_brightness = OMAPBL_MAX_INTENSITY,
+static struct backlight_ops omapbl_ops = {
+	.get_brightness = omapbl_get_intensity,
+	.update_status  = omapbl_update_status,
 };
 
+
 static int omapbl_probe(struct platform_device *pdev)
 {
 	struct backlight_device *dev;
@@ -146,14 +146,14 @@ static int omapbl_probe(struct platform_
 	if (!pdata)
 		return -ENXIO;
 
-	omapbl_data.check_fb = pdata->check_fb;
+	omapbl_ops.check_fb = pdata->check_fb;
 
 	bl = kzalloc(sizeof(struct omap_backlight), GFP_KERNEL);
 	if (unlikely(!bl))
 		return -ENOMEM;
 
 	dev = backlight_device_register("omap-bl", &pdev->dev,
-			bl, &omapbl_data);
+			bl, &omapbl_ops);
 	if (IS_ERR(dev)) {
 		kfree(bl);
 		return PTR_ERR(dev);
@@ -169,8 +169,8 @@ static int omapbl_probe(struct platform_
 
 	omap_cfg_reg(PWL);	/* Conflicts with UART3 */
 
-	omapbl_data.fb_blank = FB_BLANK_UNBLANK;
-	omapbl_data.brightness = pdata->default_intensity;
+	dev->props.fb_blank = FB_BLANK_UNBLANK;
+	dev->props.brightness = pdata->default_intensity;
 	omapbl_update_status(dev);
 
 	printk(KERN_INFO "OMAP LCD backlight initialised\n");

Regards,
stefano b.

-- 
stefano <stefano.babic@babic.homelinux.org>
GPG Key: 0x55814DDE 
Fingerprint 4E85 2A66 4CBA 497A 2A7B D3BF 5973 F216 5581 4DDE
