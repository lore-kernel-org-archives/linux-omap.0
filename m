From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] CBUS: various cleanups
Date: Thu, 9 Mar 2006 08:28:12 -0800 (PST)
Message-ID: <20060309162812.32791.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-161633621-1141921692=:32516"
Content-Transfer-Encoding: 8bit
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
Cc: david.weinehall@nokia.com
List-Id: linux-omap@vger.kernel.org

--0-161633621-1141921692=:32516
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony/Juha/Amit,

Attached patch is a first attempt to cleanup files under drivers/cbus
directory with

o kmalloc + memset(0) -> kzalloc
o device_driver to platform_driver conversion madness :)

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

And few doubts after reading the code...!!!. Changes builds for N770.
But unable to test it as *not* having access to n770.

cbus/retu-wdt.c
---------------

static int retu_modify_counter(unsigned int new)
{
        int ret = 0;

        if (new < RETU_WDT_MIN_TIMER || new > RETU_WDT_MAX_TIMER)
                return -EINVAL;

Why checking for < 0, for 'unsigned int new' ?

cbus/tahvo-usb.c
----------------
Please check the changes I made in this file, as I got confused, and
may be done in-correct platform_driver related modifications.

static int omap_otg_remove(struct platform_device *pdev)
{
        tahvo_otg_dev = NULL;
        free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);

Will free_irq will work with NULL tahvo_otg_dev?

tahvo_usb_probe function is not deleting sysfs files if
otg_set_transceiver fails. Please check.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-161633621-1141921692=:32516
Content-Type: text/x-patch; name="cbus-cleanup.patch"
Content-Description: 4097957857-cbus-cleanup.patch
Content-Disposition: inline; filename="cbus-cleanup.patch"

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index eff38be..081c647 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -222,12 +222,10 @@ int __init cbus_bus_init(void)
 	struct cbus_host *chost;
 	int ret;
 
-	chost = kmalloc(sizeof (*chost), GFP_KERNEL);
+	chost = kzalloc(sizeof (*chost), GFP_KERNEL);
 	if (chost == NULL)
 		return -ENOMEM;
 
-	memset(chost, 0, sizeof (*chost));
-
 	spin_lock_init(&chost->lock);
 
 	cbus_config = omap_get_config(OMAP_TAG_CBUS, struct omap_cbus_config);
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index da8c14c..55ac190 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -69,6 +69,8 @@ static void retubutton_irq(unsigned long
 	mod_timer(&pwrbtn_timer, jiffies + msecs_to_jiffies(PWRBTN_DELAY));
 }
 
+static char banner[] __initdata = KERN_INFO "Retu power button driver initialized\n";
+
 /**
  * Init function.
  * Allocates interrupt for power button and registers itself to input layer.
@@ -77,7 +79,7 @@ static int __init retubutton_init(void)
 {
 	int irq;
 
-	printk(KERN_INFO "Retu power button driver initialized\n");
+	printk(banner);
 	irq = RETU_INT_PWR;
 
 	init_timer(&pwrbtn_timer);
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 6471e7e..663a008 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -302,7 +302,7 @@ static ssize_t retu_rtc_cal_store(struct
 static DEVICE_ATTR(cal, S_IRUGO | S_IWUSR, retu_rtc_cal_show,
 		   retu_rtc_cal_store);
 
-static struct device_driver retu_rtc_driver;
+static struct platform_driver retu_rtc_driver;
 
 static void retu_rtca_disable(void)
 {
@@ -315,7 +315,7 @@ static void retu_rtca_disable(void)
 static void retu_rtca_expired(void *data)
 {
 	retu_rtca_disable();
-	kobject_uevent(&retu_rtc_driver.kobj, KOBJ_CHANGE);
+	kobject_uevent(&retu_rtc_driver.driver.kobj, KOBJ_CHANGE);
 }
 
 DECLARE_WORK(retu_rtca_work, retu_rtca_expired, NULL);
@@ -360,7 +360,7 @@ static int retu_rtc_init_irq(void)
 }
 
 
-static int __devinit retu_rtc_probe(struct device *dev)
+static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
 	int r;
 
@@ -379,48 +379,49 @@ static int __devinit retu_rtc_probe(stru
 	else
 		retu_rtc_do_reset();
 
-	if ((r = device_create_file(dev, &dev_attr_time)) != 0)
+	if ((r = device_create_file(&pdev->dev, &dev_attr_time)) != 0)
 		return r;
-	else if ((r = device_create_file(dev, &dev_attr_reset)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_reset)) != 0)
 		goto err_unregister_time;
-	else if ((r = device_create_file(dev, &dev_attr_alarm)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_alarm)) != 0)
 		goto err_unregister_reset;
-	else if ((r = device_create_file(dev, &dev_attr_alarm_expired)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_alarm_expired)) != 0)
 		goto err_unregister_alarm;
-	else if ((r = device_create_file(dev, &dev_attr_cal)) != 0)
+	else if ((r = device_create_file(&pdev->dev, &dev_attr_cal)) != 0)
 		goto err_unregister_alarm_expired;
 	else
 		return r;
 
 err_unregister_alarm_expired:
-	device_remove_file(dev, &dev_attr_alarm_expired);
+	device_remove_file(&pdev->dev, &dev_attr_alarm_expired);
 err_unregister_alarm:
-	device_remove_file(dev, &dev_attr_alarm);
+	device_remove_file(&pdev->dev, &dev_attr_alarm);
 err_unregister_reset:
-	device_remove_file(dev, &dev_attr_reset);
+	device_remove_file(&pdev->dev, &dev_attr_reset);
 err_unregister_time:
-	device_remove_file(dev, &dev_attr_time);
+	device_remove_file(&pdev->dev, &dev_attr_time);
 	return r;
 }
 
-static int __devexit retu_rtc_remove(struct device *dev)
+static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 	retu_disable_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCA);
-	device_remove_file(dev, &dev_attr_cal);
-	device_remove_file(dev, &dev_attr_alarm_expired);
-	device_remove_file(dev, &dev_attr_alarm);
-	device_remove_file(dev, &dev_attr_reset);
-	device_remove_file(dev, &dev_attr_time);
+	device_remove_file(&pdev->dev, &dev_attr_cal);
+	device_remove_file(&pdev->dev, &dev_attr_alarm_expired);
+	device_remove_file(&pdev->dev, &dev_attr_alarm);
+	device_remove_file(&pdev->dev, &dev_attr_reset);
+	device_remove_file(&pdev->dev, &dev_attr_time);
 	return 0;
 }
 
-static struct device_driver retu_rtc_driver = {
-	.name		= "retu-rtc",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_rtc_driver = {
 	.probe		= retu_rtc_probe,
 	.remove		= __devexit_p(retu_rtc_remove),
+	.driver		= {
+		.name	= "retu-rtc",
+	},
 };
 
 static struct platform_device retu_rtc_device = {
@@ -447,7 +448,7 @@ static int __init retu_rtc_init(void)
 
 	init_completion(&retu_rtc_exited);
 
-	if ((ret = driver_register(&retu_rtc_driver)) != 0)
+	if ((ret = platform_driver_register(&retu_rtc_driver)) != 0)
 		return ret;
 
 	if ((ret = platform_device_register(&retu_rtc_device)) != 0)
@@ -456,14 +457,14 @@ static int __init retu_rtc_init(void)
 	return 0;
 
 err_unregister_driver:
-	driver_unregister(&retu_rtc_driver);
+	platform_driver_unregister(&retu_rtc_driver);
 	return ret;
 }
 
 static void __exit retu_rtc_exit(void)
 {
 	platform_device_unregister(&retu_rtc_device);
-	driver_unregister(&retu_rtc_driver);
+	platform_driver_unregister(&retu_rtc_driver);
 
 	wait_for_completion(&retu_rtc_exited);
 }
diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 69d1be9..9454760 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -372,12 +372,11 @@ int retu_user_init(void)
 	struct retu_irq *irq;
 	int res, i;
 
-	irq = kmalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
+	irq = kzalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
 	if (irq == NULL) {
-		printk(KERN_ERR PFX "kmalloc failed\n");
+		printk(KERN_ERR PFX "kzalloc failed\n");
 		return -ENOMEM;
 	}
-	memset(irq, 0, sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN);
 	for (i = 0; i < RETU_MAX_IRQ_BUF_LEN; i++)
 		list_add(&irq[i].node, &retu_irqs_reserve);
 
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 9739907..629affc 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -103,29 +103,29 @@ static DEVICE_ATTR(period, S_IRUGO | S_I
                    retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
 
-static int __devinit retu_wdt_probe(struct device *dev)
+static int __devinit retu_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = device_create_file(dev, &dev_attr_period);
+	ret = device_create_file(&pdev->dev, &dev_attr_period);
 	if (ret) {
 		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: period\n");
 		return ret;
 	}
 
-	ret = device_create_file(dev, &dev_attr_counter);
+	ret = device_create_file(&pdev->dev, &dev_attr_counter);
 	if (ret) {
-		device_remove_file(dev, &dev_attr_period);
+		device_remove_file(&pdev->dev, &dev_attr_period);
 		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: counter\n");
 	}
 
 	return ret;
 }
 
-static int __devexit retu_wdt_remove(struct device *dev)
+static int __devexit retu_wdt_remove(struct platform_device *pdev)
 {
-	device_remove_file(dev, &dev_attr_period);
-	device_remove_file(dev, &dev_attr_counter);
+	device_remove_file(&pdev->dev, &dev_attr_period);
+	device_remove_file(&pdev->dev, &dev_attr_counter);
 	return 0;
 }
 
@@ -142,20 +142,23 @@ static struct platform_device retu_wdt_d
 	},
 };
 
-static struct device_driver retu_wdt_driver = {
-	.name = "retu-watchdog",
-	.bus = &platform_bus_type,
-	.probe = retu_wdt_probe,
-	.remove = __devexit_p(retu_wdt_remove),
+static struct platform_driver retu_wdt_driver = {
+	.probe 		= retu_wdt_probe,
+	.remove 	= __devexit_p(retu_wdt_remove),
+	.driver 	= {
+		.name = "retu-watchdog",
+	},
 };
 
+static char banner[] __initdata = KERN_INFO "Retu watchdog driver initialized\n";
+
 static int __init retu_wdt_init(void)
 {
 	int ret;
 
 	init_completion(&retu_wdt_completion);
 
-	ret = driver_register(&retu_wdt_driver);
+	ret = platform_driver_register(&retu_wdt_driver);
 	if (ret)
 		return ret;
 
@@ -170,12 +173,12 @@ static int __init retu_wdt_init(void)
 		printk(KERN_INFO
 		       "retu_wdt_init: Intializing to default value\n");
 	}
-
-	printk(KERN_INFO "Retu watchdog driver initialized\n");
+	
+	printk(banner);
 	return ret;
 
 exit1:
-	driver_unregister(&retu_wdt_driver);
+	platform_driver_unregister(&retu_wdt_driver);
 	wait_for_completion(&retu_wdt_completion);
 
 	return ret;
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 87ab216..9c93f4e 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -293,7 +293,7 @@ static void retu_power_off(void)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit retu_probe(struct device *dev)
+static int __devinit retu_probe(struct platform_driver *pdev)
 {
 	const struct omap_em_asic_bb5_config * em_asic_config;
 	int rev, ret;
@@ -358,7 +358,7 @@ static int __devinit retu_probe(struct d
 	return 0;
 }
 
-static int retu_remove(struct device *dev)
+static int retu_remove(struct platform_driver *pdev)
 {
 #ifdef CONFIG_CBUS_RETU_USER
 	retu_user_cleanup();
@@ -377,11 +377,12 @@ static void retu_device_release(struct d
 	complete(&device_release);
 }
 
-static struct device_driver retu_driver = {
-	.name		= "retu",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_driver = {
 	.probe		= retu_probe,
 	.remove		= retu_remove,
+	.driver		= {
+		.name	= "retu",
+	},
 };
 
 static struct platform_device retu_device = {
@@ -392,6 +393,8 @@ static struct platform_device retu_devic
 	}
 };
 
+static char banner[] __initdata = KERN_INFO "Retu/Vilma driver initialising\n";
+
 /**
  * retu_init - initialise Retu driver
  *
@@ -401,15 +404,15 @@ static int __init retu_init(void)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "Retu/Vilma driver initialising\n");
-
+	printk(banner);
+	
 	init_completion(&device_release);
 
-	if ((ret = driver_register(&retu_driver)) < 0)
+	if ((ret = platform_driver_register(&retu_driver)) < 0)
 		return ret;
 
 	if ((ret = platform_device_register(&retu_device)) < 0) {
-		driver_unregister(&retu_driver);
+		platform_driver_unregister(&retu_driver);
 		return ret;
 	}
 	return 0;
@@ -421,7 +424,7 @@ static int __init retu_init(void)
 static void __exit retu_exit(void)
 {
 	platform_device_unregister(&retu_device);
-	driver_unregister(&retu_driver);
+	platform_driver_unregister(&retu_driver);
 	wait_for_completion(&device_release);
 }
 
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index a002fb7..eb443ed 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -175,11 +175,11 @@ static int omap_otg_init(void)
 	return 0;
 }
 
-static int omap_otg_probe(struct device *dev)
+static int omap_otg_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	tahvo_otg_dev = to_platform_device(dev);
+	tahvo_otg_dev = pdev;
 	ret = omap_otg_init();
 	if (ret != 0) {
 		printk(KERN_ERR "tahvo-usb: omap_otg_init failed\n");
@@ -191,18 +191,19 @@ static int omap_otg_probe(struct device 
 			   &tahvo_usb_device);
 }
 
-static int omap_otg_remove(struct device *dev)
+static int omap_otg_remove(struct platform_device *pdev)
 {
 	tahvo_otg_dev = NULL;
 	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
 	return 0;
 }
 
-struct device_driver omap_otg_driver = {
-	.name		= "omap_otg",
-	.bus		= &platform_bus_type,
+struct platform_driver omap_otg_driver = {
 	.probe		= omap_otg_probe,
 	.remove		= omap_otg_remove,
+	.driver		= {
+		.name	= "omap_otg",
+	}
 };
 
 /*
@@ -546,17 +547,16 @@ static ssize_t otg_mode_store(struct dev
 static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
 #endif
 
-static int tahvo_usb_probe(struct device *dev)
+static int tahvo_usb_probe(struct platform_device *pdev)
 {
 	struct tahvo_usb *tu;
 	int ret;
 
 	/* Create driver data */
-	tu = kmalloc(sizeof(*tu), GFP_KERNEL);
+	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
 	if (!tu)
 		return -ENOMEM;
-	memset(tu, 0, sizeof(*tu));
-	tu->pt_dev = container_of(dev, struct platform_device, dev);
+	tu->pt_dev = pdev;
 #ifdef CONFIG_USB_OTG
 	/* Default mode */
 #ifdef CONFIG_CBUS_TAHVO_USB_HOST_BY_DEFAULT
@@ -583,9 +583,9 @@ static int tahvo_usb_probe(struct device
 	}
 
 	/* Attributes */
-	device_create_file(dev, &dev_attr_vbus_state);
+	device_create_file(&pdev->dev, &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-	device_create_file(dev, &dev_attr_otg_mode);
+	device_create_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
 
 	/* Create OTG interface */
@@ -607,7 +607,7 @@ static int tahvo_usb_probe(struct device
 		return ret;
 	}
 
-	dev->driver_data = tu;
+	platform_set_drvdata(pdev, tu);
 
 	/* Act upon current vbus state once at startup. A vbus state irq may or
 	 * may not be generated in addition to this. */
@@ -615,23 +615,24 @@ static int tahvo_usb_probe(struct device
 	return 0;
 }
 
-static int tahvo_usb_remove(struct device *dev)
+static int tahvo_usb_remove(struct platform_device *pdev)
 {
 	tahvo_free_irq(TAHVO_INT_VBUSON);
 	flush_scheduled_work();
 	otg_set_transceiver(0);
-	device_remove_file(dev, &dev_attr_vbus_state);
+	device_remove_file(&pdev->dev, &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-	device_remove_file(dev, &dev_attr_otg_mode);
+	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
 	return 0;
 }
 
-static struct device_driver tahvo_usb_driver = {
-	.name		= "tahvo-usb",
-	.bus		= &platform_bus_type,
+static struct platform_driver tahvo_usb_driver = {
 	.probe		= tahvo_usb_probe,
 	.remove		= tahvo_usb_remove,
+	.driver		= {
+		.name	= "tahvo-usb",
+	}
 };
 
 static struct platform_device tahvo_usb_device = {
@@ -639,23 +640,25 @@ static struct platform_device tahvo_usb_
 	.id		= -1,
 };
 
+static char banner[] __initdata = KERN_INFO "Tahvo USB transceiver driver initializing\n";
+
 static int __init tahvo_usb_init(void)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "Tahvo USB transceiver driver initializing\n");
-	ret = driver_register(&tahvo_usb_driver);
+	printk(banner);
+	ret = platform_driver_register(&tahvo_usb_driver);
 	if (ret)
 		return ret;
 	ret = platform_device_register(&tahvo_usb_device);
 	if (ret < 0) {
-		driver_unregister(&tahvo_usb_driver);
+		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
-	ret = driver_register(&omap_otg_driver);
+	ret = platform_driver_register(&omap_otg_driver);
 	if (ret) {
 		platform_device_unregister(&tahvo_usb_device);
-		driver_unregister(&tahvo_usb_driver);
+		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
 	return 0;
@@ -665,9 +668,9 @@ subsys_initcall(tahvo_usb_init);
 
 static void __exit tahvo_usb_exit(void)
 {
-	driver_unregister(&omap_otg_driver);
+	platform_driver_unregister(&omap_otg_driver);
 	platform_device_unregister(&tahvo_usb_device);
-	driver_unregister(&tahvo_usb_driver);
+	platform_driver_unregister(&tahvo_usb_driver);
 }
 module_exit(tahvo_usb_exit);
 
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index 7e6f770..86c0145 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -353,12 +353,11 @@ int tahvo_user_init(void)
 	struct tahvo_irq *irq;
 	int res, i;
 
-	irq = kmalloc(sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN, GFP_KERNEL);
+	irq = kzalloc(sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN, GFP_KERNEL);
 	if (irq == NULL) {
-		printk(KERN_ERR PFX "kmalloc failed\n");
+		printk(KERN_ERR PFX "kzalloc failed\n");
 		return -ENOMEM;
 	}
-	memset(irq, 0, sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN);
 	for (i = 0; i < TAHVO_MAX_IRQ_BUF_LEN; i++)
 		list_add(&irq[i].node, &tahvo_irqs_reserve);
 
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 6693a74..9a98c68 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -266,7 +266,7 @@ void tahvo_free_irq(int id)
  * Probe for the Tahvo ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit tahvo_probe(struct device *dev)
+static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	const struct omap_em_asic_bb5_config * em_asic_config;
 	int rev, id, ret;
@@ -335,7 +335,7 @@ static int __devinit tahvo_probe(struct 
 	return 0;
 }
 
-static int tahvo_remove(struct device *dev)
+static int tahvo_remove(struct platform_device *pdev)
 {
 #ifdef CONFIG_CBUS_TAHVO_USER
 	tahvo_user_cleanup();
@@ -354,11 +354,12 @@ static void tahvo_device_release(struct 
 	complete(&device_release);
 }
 
-static struct device_driver tahvo_driver = {
-	.name		= "tahvo",
-	.bus		= &platform_bus_type,
+static struct platform_driver tahvo_driver = {
 	.probe		= tahvo_probe,
 	.remove		= tahvo_remove,
+	.driver		= {
+		.name	= "tahvo",
+	},
 };
 
 static struct platform_device tahvo_device = {
@@ -382,11 +383,11 @@ static int __init tahvo_init(void)
 
 	init_completion(&device_release);
 
-	if ((ret = driver_register(&tahvo_driver)) < 0)
+	if ((ret = platform_driver_register(&tahvo_driver)) < 0)
 		return ret;
 
 	if ((ret = platform_device_register(&tahvo_device)) < 0) {
-		driver_unregister(&tahvo_driver);
+		platform_driver_unregister(&tahvo_driver);
 		return ret;
 	}
 	return 0;
@@ -398,7 +399,7 @@ static int __init tahvo_init(void)
 static void __exit tahvo_exit(void)
 {
 	platform_device_unregister(&tahvo_device);
-	driver_unregister(&tahvo_driver);
+	platform_driver_unregister(&tahvo_driver);
 	wait_for_completion(&device_release);
 }
 
diff --git a/drivers/cbus/user_retu_tahvo.h b/drivers/cbus/user_retu_tahvo.h

--0-161633621-1141921692=:32516
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-161633621-1141921692=:32516--
