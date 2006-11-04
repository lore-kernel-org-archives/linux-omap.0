From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in ads7846
Date: Sat, 04 Nov 2006 16:50:17 +0100
Message-ID: <454CB6B9.4090307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090201080502060901040301"
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
--------------090201080502060901040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix various warnings

warning: ignoring return value of 'device_create_file',
declared with attribute warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------090201080502060901040301
Content-Type: text/plain;
 name="ads7846_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ads7846_warning_patch.txt"

Index: linux-osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/ads7846.c
+++ linux-osk/drivers/input/touchscreen/ads7846.c
@@ -916,36 +916,54 @@ static int __devinit ads7846_probe(struc
 	 * use the other ADC lines a bit differently too
 	 */
 	if (ts->model == 7846) {
-		device_create_file(&spi->dev, &dev_attr_temp0);
-		device_create_file(&spi->dev, &dev_attr_temp1);
+		err = device_create_file(&spi->dev, &dev_attr_temp0);
+		if (err)
+			goto err_remove_attr7;
+		err = device_create_file(&spi->dev, &dev_attr_temp1);
+		if (err)
+			goto err_remove_attr6;
 	}
 	/* in1 == vBAT (7846), or a non-scaled ADC input */
-	if (ts->model != 7845)
-		device_create_file(&spi->dev, &dev_attr_in1_input);
+	if (ts->model != 7845) {
+		err = device_create_file(&spi->dev, &dev_attr_in1_input);
+		if (err)
+			goto err_remove_attr5;
+	}
 	/* in0 == a non-scaled ADC input */
-	device_create_file(&spi->dev, &dev_attr_in0_input);
+	err = device_create_file(&spi->dev, &dev_attr_in0_input);
+	if (err)
+		goto err_remove_attr4;
 
 	/* non-hwmon device attributes */
-	device_create_file(&spi->dev, &dev_attr_pen_down);
-	device_create_file(&spi->dev, &dev_attr_disable);
+	err = device_create_file(&spi->dev, &dev_attr_pen_down);
+	if (err)
+		goto err_remove_attr3;
+	err = device_create_file(&spi->dev, &dev_attr_disable);
+	if (err)
+		goto err_remove_attr2;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr;
+		goto err_remove_attr1;
 
 	return 0;
 
- err_remove_attr:
+ err_remove_attr1:
 	device_remove_file(&spi->dev, &dev_attr_disable);
+ err_remove_attr2:
 	device_remove_file(&spi->dev, &dev_attr_pen_down);
+ err_remove_attr3:
+	device_remove_file(&spi->dev, &dev_attr_in0_input);
+ err_remove_attr4:
+	if (ts->model != 7845)
+		device_remove_file(&spi->dev, &dev_attr_in1_input);
+ err_remove_attr5:
 	if (ts->model == 7846) {
 		device_remove_file(&spi->dev, &dev_attr_temp1);
+ err_remove_attr6:
 		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
-	if (ts->model != 7845)
-		device_remove_file(&spi->dev, &dev_attr_in1_input);
-	device_remove_file(&spi->dev, &dev_attr_in0_input);
-
+ err_remove_attr7:
 	free_irq(spi->irq, ts);
  err_cleanup_filter:
 	if (ts->filter_cleanup)


--------------090201080502060901040301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090201080502060901040301--
