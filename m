From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in leds-omap-pwm.c
Date: Sat, 20 Jan 2007 08:07:32 +0100
Message-ID: <45B1BFB4.5000503@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050003020102070108020702"
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

This is a multi-part message in MIME format.
--------------050003020102070108020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warnings in leds-omap-pwm.c:

drivers/leds/leds-omap-pwm.c: In function 'omap_pwm_led_probe':
drivers/leds/leds-omap-pwm.c:260: warning: ignoring return
value of 'class_device_create_file', declared with attribute
warn_unused_result
drivers/leds/leds-omap-pwm.c:262: warning: ignoring return
value of 'class_device_create_file', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------050003020102070108020702
Content-Type: text/plain;
 name="leds_omap_pwm_warning_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="leds_omap_pwm_warning_fix"

Index: linux-osk/drivers/leds/leds-omap-pwm.c
===================================================================
--- linux-osk.orig/drivers/leds/leds-omap-pwm.c
+++ linux-osk/drivers/leds/leds-omap-pwm.c
@@ -253,19 +253,30 @@ static int omap_pwm_led_probe(struct pla
 		if (led->blink_timer == NULL) {
 			dev_err(&pdev->dev, "failed to request blinking pwm timer\n");
 			ret = -ENODEV;
-			goto error_blink;
+			goto error_blink1;
 		}
 		omap_dm_timer_disable(led->blink_timer);
 
-		class_device_create_file(led->cdev.class_dev,
-					 &class_device_attr_on_period);
-		class_device_create_file(led->cdev.class_dev,
-					 &class_device_attr_off_period);
+		ret = class_device_create_file(led->cdev.class_dev,
+					       &class_device_attr_on_period);
+		if(ret)
+			goto error_blink2;
+
+		ret = class_device_create_file(led->cdev.class_dev,
+					        &class_device_attr_off_period);
+		if(ret)
+			goto error_blink3;
+
 	}
 
 	return 0;
 
-error_blink:
+error_blink3:
+	class_device_remove_file(led->cdev.class_dev,
+				 &class_device_attr_on_period);
+error_blink2:
+	dev_err(&pdev->dev, "failed to create device file(s)\n");
+error_blink1:
 	omap_dm_timer_free(led->intensity_timer);
 error_intensity:
 	led_classdev_unregister(&led->cdev);


--------------050003020102070108020702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050003020102070108020702--
