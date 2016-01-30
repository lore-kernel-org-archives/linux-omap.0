From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Sat, 30 Jan 2016 23:15:09 +0100
Message-ID: <20160130221509.GA28644@amd>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160130201452.GC30429@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > > ffdffe8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200072
> > > > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > > > 
> > > > cm_idlest1_core changes periodicall often, to 00218072. The rest seems
> > > > constant.
> > > 
> > > For cm_idlest1_core 42 is the answer.. Here you have bits 4 and 5
> > > blocking which is for OTG and it's PHY. That's a known issue with
> > > musb and setting pm_runtime_irq_safe() on the MUSB parent.
> > > 
> > > If you do rmmod omap2430 and phy-twl4030usb chances are the LEDs will
> > > start going off assuming the McSPI bit goes low with WLAN idling.
> > 
> > Ok, so I tried to compile kernel without omap2430/phy-twl4030usb
> > . That did not help. So I thought, ok, maybe rmmod is needed to
> > trigger some powersaving? But that is not exactly easy to do:
> > 
> > pavel@n900:/my/tui/ofone$ sudo insmod /my/modules/omap2430.ko
> > pavel@n900:/my/tui/ofone$ sudo insmod /my/modules/phy-twl4030-usb.ko
> > pavel@n900:/my/tui/ofone$ sudo rmmod phy-twl4030-usb.ko
> > Error: Module phy_twl4030_usb is in use
> > pavel@n900:/my/tui/ofone$
> > 
> > Any ideas what jumps to use the modules? Charger code?
> 
> I tried a kernel without charger code, and no luck, rmmod fails the
> same way. dmesg says:
> [  111.093078] wlan0: authenticated
> [  111.097442] wlan0: associate with 06:27:22:f9:10:6a (try 1/3)
> [  111.104553] wlan0: RX AssocResp from 06:27:22:f9:10:6a (capab=0x421
> status=0 aid=2)
> [  111.104705] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 2),
> will use 2
> [  111.104736] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 3),
> will use 2
> [  111.256652] wlan0: associated
> [  184.681427] HS USB OTG: no transceiver configured
> [  184.681488] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
> with status -517
> [  184.681976] HS USB OTG: no transceiver configured
> [  184.682006] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
> with status -517
> [  187.690338] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> Initialized TWL4030 USB module
> [  187.698303] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
> combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [  187.698333] musb-hdrc: MHDRC RTL version 1.400
> [  187.698333] musb-hdrc: setup fifo_mode 4
> [  187.698394] musb-hdrc: 28/31 max ep, 16384/16384 memory
> pavel@n900:/my/tui/ofone$

I added following hack to phy-twl4030-usb.c so that I could avoid
modules and module unloading problem. But still could not get it to
sleep :-(.

									Pavel
									
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 3a707dd..ac3761b 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -532,6 +532,43 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,
 }
 static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
 
+static ssize_t twl4030_test_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&twl->lock);
+	ret = sprintf(buf, "%s\n", "hello, world");
+	mutex_unlock(&twl->lock);
+
+	return ret;
+}
+
+static int twl4030_shutdown(struct twl4030_usb *twl);
+
+static ssize_t twl4030_test_store(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long tmp;
+
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+
+	mutex_lock(&twl->lock);
+	sscanf(buf, "%lX", &tmp);
+	printk("TWL HACK: tmp = 0x%lX\n", tmp);
+	mutex_unlock(&twl->lock);
+
+	if (tmp == 0xdead) {
+		printk("TWL HACK: killing hardware\n");
+		printk("TWL HACK: killing hardware = %d\n", twl4030_shutdown(twl));
+	}
+	
+	return strnlen(buf, count);
+}
+
+static DEVICE_ATTR(test, 0664, twl4030_test_show, twl4030_test_store);
+
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
@@ -710,6 +747,9 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
+	if (device_create_file(&pdev->dev, &dev_attr_test))
+		dev_warn(&pdev->dev, "could not create sysfs file #2\n");
+	
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
 
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -745,14 +785,12 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int twl4030_usb_remove(struct platform_device *pdev)
+static int twl4030_shutdown(struct twl4030_usb *twl)
 {
-	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
 	pm_runtime_get_sync(twl->dev);
 	cancel_delayed_work(&twl->id_workaround_work);
-	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
@@ -779,6 +817,17 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+
+static int twl4030_usb_remove(struct platform_device *pdev)
+{
+	struct twl4030_usb *twl = platform_get_drvdata(pdev);
+
+	device_remove_file(twl->dev, &dev_attr_vbus);
+	device_remove_file(twl->dev, &dev_attr_test);
+	
+	return twl4030_shutdown(twl);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id twl4030_usb_id_table[] = {
 	{ .compatible = "ti,twl4030-usb" },

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
