From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: [PATCH] Fix scheduling while atomic bug in tsc210x
Date: Fri, 17 Aug 2007 09:06:56 +0900
Message-ID: <002901c7e062$87e88d50$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Fix scheduling while atomic bug

BUG: scheduling while atomic: swapper/0x00000002/1
[<c00281ec>] (dump_stack+0x0/0x14) from [<c0047f9c>]
(__schedule_bug+0x34/0x3c)
[<c0047f68>] (__schedule_bug+0x0/0x3c) from [<c024d434>]
(schedule+0x74/0x384)
[<c024d3c0>] (schedule+0x0/0x384) from [<c024d8d0>]
(wait_for_completion+0xc8/0)
[<c024d808>] (wait_for_completion+0x0/0x148) from [<c005f0ac>]
(call_usermodehe)
 r8:c072bce0 r7:00000000 r6:00000000 r5:c02fd2d4 r4:c07536e0
[<c005f004>] (call_usermodehelper_exec+0x0/0x100) from [<c015b214>]
(kobject_ue)
 r8:00000008 r7:c7c060ad r6:c7cccda0 r5:c074a9e0 r4:00000000
[<c015ade4>] (kobject_uevent_env+0x0/0x498) from [<c015b290>]
(kobject_uevent+0)
[<c015b27c>] (kobject_uevent+0x0/0x18) from [<c0199fe4>]
(device_add+0x374/0x61)
[<c0199c70>] (device_add+0x0/0x618) from [<c019e7a0>]
(platform_device_add+0xe8)
[<c019e6b8>] (platform_device_add+0x0/0x164) from [<c019e840>]
(platform_device)
 r7:c076a800 r6:c0752400 r5:c076a8a4 r4:c02f0958
[<c019e81c>] (platform_device_register+0x0/0x28) from [<c01b367c>]
(tsc210x_pro)
 r4:00000004
[<c01b326c>] (tsc210x_probe+0x0/0x54c) from [<c01b37cc>]
(tsc2101_probe+0x14/0x)
[<c01b37b8>] (tsc2101_probe+0x0/0x18) from [<c01b0478>]
(spi_drv_probe+0x24/0x2)
[<c01b0454>] (spi_drv_probe+0x0/0x28) from [<c019c8b0>]
(driver_probe_device+0x)
[<c019c7d4>] (driver_probe_device+0x0/0x180) from [<c019cabc>]
(__driver_attach)
 r8:c072a000 r7:c02f0648 r6:c02f0648 r5:c076a800 r4:c076a8c0
[<c019ca20>] (__driver_attach+0x0/0xf8) from [<c019b800>]
(bus_for_each_dev+0x4)
 r6:c019ca20 r5:c072bed8 r4:00000000
[<c019b7b4>] (bus_for_each_dev+0x0/0x84) from [<c019cb3c>]
(driver_attach+0x24/)
 r7:c02f01e8 r6:c02f0650 r5:c02f0648 r4:00000000
[<c019cb18>] (driver_attach+0x0/0x2c) from [<c019c02c>]
(bus_add_driver+0x7c/0x)
[<c019bfb0>] (bus_add_driver+0x0/0x1d4) from [<c019d040>]
(driver_register+0x84)
[<c019cfbc>] (driver_register+0x0/0x8c) from [<c01b051c>]
(spi_register_driver+)
 r4:00000000
[<c01b04cc>] (spi_register_driver+0x0/0x64) from [<c0017a10>]
(tsc210x_init+0x3)
[<c00179dc>] (tsc210x_init+0x0/0x74) from [<c0008a5c>]
(kernel_init+0xe0/0x290)
 r5:00000000 r4:00000000
[<c000897c>] (kernel_init+0x0/0x290) from [<c004ff8c>] (do_exit+0x0/0x878)

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

diff --git a/drivers/spi/tsc210x.c b/drivers/spi/tsc210x.c
index 8a2b406..df8bcf9 100644
--- a/drivers/spi/tsc210x.c
+++ b/drivers/spi/tsc210x.c
@@ -26,7 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/autoconf.h>
@@ -107,7 +107,7 @@ struct tsc210x_dev {
 	struct workqueue_struct *queue;
 	struct delayed_work ts_worker;		/* Poll-wait for PEN UP */
 	struct delayed_work sensor_worker;	/* Scan the ADC inputs */
-	spinlock_t queue_lock;
+	struct mutex queue_lock;
 	struct completion data_avail;
 
 	tsc210x_touch_t touch_cb;
@@ -523,10 +523,10 @@ static void tsc210x_input_scan(struct work_struct
*work)
 
 	tsc210x_touchscreen_mode(dev);
 
-	spin_lock(&dev->queue_lock);
+	mutex_lock(&dev->queue_lock);
 	if (!dev->flushing)
 		tsc210x_queue_scan(dev);
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 }
 
 /* ADC has finished a new conversion for us.  */
@@ -927,10 +927,10 @@ tsc210x_suspend(struct spi_device *spi, pm_message_t
state)
 		return -ENODEV;
 
 	/* Stop the inputs scan loop */
-	spin_lock(&dev->queue_lock);
+	mutex_lock(&dev->queue_lock);
 	dev->flushing = 1;
 	cancel_delayed_work(&dev->sensor_worker);
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 	flush_workqueue(dev->queue);
 
 	/* Wait until pen-up happens */
@@ -955,11 +955,11 @@ static int tsc210x_resume(struct spi_device *spi)
 	if (!dev)
 		return 0;
 
-	spin_lock(&dev->queue_lock);
+	mutex_lock(&dev->queue_lock);
 	err = tsc210x_configure(dev);
 
 	dev->flushing = 0;
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 
 	return err;
 }
@@ -1020,7 +1020,7 @@ static int tsc210x_probe(struct spi_device *spi, enum
tsc_type type)
 		goto err_queue;
 	}
 
-	spin_lock_init(&dev->queue_lock);
+	mutex_init(&dev->queue_lock);
 	init_completion(&dev->data_avail);
 
 	/* Allocate enough struct spi_transfer's for all requests */
@@ -1099,7 +1099,7 @@ static int tsc210x_probe(struct spi_device *spi, enum
tsc_type type)
 		goto err_spi;
 
 	/* We want no interrupts before configuration succeeds.  */
-	spin_lock(&dev->queue_lock);
+	mutex_lock(&dev->queue_lock);
 	dev->flushing = 1;
 
 	if (request_irq(spi->irq, tsc210x_handler, IRQF_SAMPLE_RANDOM |
@@ -1130,7 +1130,7 @@ static int tsc210x_probe(struct spi_device *spi, enum
tsc_type type)
 		goto err_alsa;
 
 	dev->flushing = 0;
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 	return 0;
 
 err_alsa:
@@ -1138,7 +1138,7 @@ err_alsa:
 err_hwmon:
 	platform_device_unregister(&tsc210x_ts_device);
 err_irq:
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 err_spi:
 	dev_set_drvdata(&spi->dev, NULL);
 	clk_disable(dev->bclk_ck);
@@ -1167,10 +1167,10 @@ static int tsc210x_remove(struct spi_device *spi)
 	struct tsc210x_dev *dev = dev_get_drvdata(&spi->dev);
 
 	/* Stop the inputs scan loop */
-	spin_lock(&dev->queue_lock);
+	mutex_lock(&dev->queue_lock);
 	dev->flushing = 1;
 	cancel_delayed_work(&dev->sensor_worker);
-	spin_unlock(&dev->queue_lock);
+	mutex_unlock(&dev->queue_lock);
 	flush_workqueue(dev->queue);
 
 	/* Wait for pen-up */
