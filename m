From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [patch] Convert cbus driver code to use platform APIs
	consistently
Date: Tue, 09 Jun 2009 18:13:23 +0100
Message-ID: <20090609181323.74811o8hdh9l2gcg@lidskialf.net>
References: <20090522193359.17514ptwyl8kdbls@lidskialf.net>
	<20090522231826.12833dwwkvi7rv0g@lidskialf.net>
	<20090523023901.33341jpwcx6nd70g@lidskialf.net>
	<20090523014717.GB9283@atomide.com>
	<20090523121108.14776dli2aeyapkw@lidskialf.net>
	<20090523123040.16971ty5wndy6mow@lidskialf.net>
	<20090523132812.14461t6dlahg2ew0@lidskialf.net>
	<20090523142542.10985fjvcwu3k9s0@lidskialf.net>
	<20090601231839.GD22956@atomide.com>
	<20090608205554.8257711w03d8isi2@lidskialf.net>
	<20090609102008.GB2617@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_1mhn56xvfayo"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:54403 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbZFIRNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 13:13:22 -0400
In-Reply-To: <20090609102008.GB2617@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

This message is in MIME format.

--=_1mhn56xvfayo
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting Tony Lindgren <tony@atomide.com>:

> * Andrew de Quincey <adq_dvb@lidskialf.net> [090608 12:56]:
>> Recent changes in the drivers/base/platform.c exposed an inconsistency
>> in the cbus drivers; they weren't matching platform_divers with
>> platform_devices, which causes all sorts of structure casting issues
>> within the base platform code since it assumes this.
>>
>> Signed-off-by: Andrew de Quincey <adq@lidskialf.net>
>
> The patch seems to be missing from the mail?

gah, FAIL.

Attached :)


--=_1mhn56xvfayo
Content-Type: text/x-patch;
	charset=UTF-8;
	name="cbus-platform-drivers-fix.patch"
Content-Disposition: attachment;
	filename="cbus-platform-drivers-fix.patch"
Content-Transfer-Encoding: quoted-printable

commit 20c2956fc541bb327f4a2df41dbe5ff50261749f
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Mon May 25 22:56:01 2009 +0100

    Fix cbus to use platform APIs

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 1ebc33b..76343f9 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -361,7 +361,7 @@ static int retu_rtc_init_irq(void)
 }
=20
=20
-static int __devinit retu_rtc_probe(struct device *dev)
+static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
 =09int r;
=20
@@ -380,48 +380,49 @@ static int __devinit retu_rtc_probe(struct device *dev=
)
 =09else
 =09=09retu_rtc_do_reset();
=20
-=09if ((r =3D device_create_file(dev, &dev_attr_time)) !=3D 0)
+=09if ((r =3D device_create_file(&(pdev->dev), &dev_attr_time)) !=3D 0)
 =09=09return r;
-=09else if ((r =3D device_create_file(dev, &dev_attr_reset)) !=3D 0)
+=09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_reset)) !=3D =
0)
 =09=09goto err_unregister_time;
-=09else if ((r =3D device_create_file(dev, &dev_attr_alarm)) !=3D 0)
+=09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_alarm)) !=3D =
0)
 =09=09goto err_unregister_reset;
-=09else if ((r =3D device_create_file(dev, &dev_attr_alarm_expired)) !=3D 0=
)
+=09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_alarm_expired=
)) !=3D 0)
 =09=09goto err_unregister_alarm;
-=09else if ((r =3D device_create_file(dev, &dev_attr_cal)) !=3D 0)
+=09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_cal)) !=3D 0)
 =09=09goto err_unregister_alarm_expired;
 =09else
 =09=09return r;
=20
 err_unregister_alarm_expired:
-=09device_remove_file(dev, &dev_attr_alarm_expired);
+=09device_remove_file(&(pdev->dev), &dev_attr_alarm_expired);
 err_unregister_alarm:
-=09device_remove_file(dev, &dev_attr_alarm);
+=09device_remove_file(&(pdev->dev), &dev_attr_alarm);
 err_unregister_reset:
-=09device_remove_file(dev, &dev_attr_reset);
+=09device_remove_file(&(pdev->dev), &dev_attr_reset);
 err_unregister_time:
-=09device_remove_file(dev, &dev_attr_time);
+=09device_remove_file(&(pdev->dev), &dev_attr_time);
 =09return r;
 }
=20
-static int __devexit retu_rtc_remove(struct device *dev)
+static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 =09retu_disable_irq(RETU_INT_RTCS);
 =09retu_free_irq(RETU_INT_RTCS);
 =09retu_free_irq(RETU_INT_RTCA);
-=09device_remove_file(dev, &dev_attr_cal);
-=09device_remove_file(dev, &dev_attr_alarm_expired);
-=09device_remove_file(dev, &dev_attr_alarm);
-=09device_remove_file(dev, &dev_attr_reset);
-=09device_remove_file(dev, &dev_attr_time);
+=09device_remove_file(&(pdev->dev), &dev_attr_cal);
+=09device_remove_file(&(pdev->dev), &dev_attr_alarm_expired);
+=09device_remove_file(&(pdev->dev), &dev_attr_alarm);
+=09device_remove_file(&(pdev->dev), &dev_attr_reset);
+=09device_remove_file(&(pdev->dev), &dev_attr_time);
 =09return 0;
 }
=20
-static struct device_driver retu_rtc_driver =3D {
-=09.name=09=09=3D "retu-rtc",
-=09.bus=09=09=3D &platform_bus_type,
+static struct platform_driver retu_rtc_driver =3D {
 =09.probe=09=09=3D retu_rtc_probe,
 =09.remove=09=09=3D __devexit_p(retu_rtc_remove),
+=09.driver=09=09=3D {
+=09=09.name=09=09=3D "retu-rtc",
+=09}
 };
=20
 static struct platform_device retu_rtc_device =3D {
@@ -448,7 +449,7 @@ static int __init retu_rtc_init(void)
=20
 =09init_completion(&retu_rtc_exited);
=20
-=09if ((ret =3D driver_register(&retu_rtc_driver)) !=3D 0)
+=09if ((ret =3D platform_driver_register(&retu_rtc_driver)) !=3D 0)
 =09=09return ret;
=20
 =09if ((ret =3D platform_device_register(&retu_rtc_device)) !=3D 0)
@@ -457,14 +458,14 @@ static int __init retu_rtc_init(void)
 =09return 0;
=20
 err_unregister_driver:
-=09driver_unregister(&retu_rtc_driver);
+=09platform_driver_unregister(&retu_rtc_driver);
 =09return ret;
 }
=20
 static void __exit retu_rtc_exit(void)
 {
 =09platform_device_unregister(&retu_rtc_device);
-=09driver_unregister(&retu_rtc_driver);
+=09platform_driver_unregister(&retu_rtc_driver);
=20
 =09wait_for_completion(&retu_rtc_exited);
 }
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index b7b20b7..1fa181e 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -104,20 +104,20 @@ static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, retu_wdt=
_period_show, \
 =09=09=09retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
=20
-static int __devinit retu_wdt_probe(struct device *dev)
+static int __devinit retu_wdt_probe(struct platform_device *pdev)
 {
 =09int ret;
=20
-=09ret =3D device_create_file(dev, &dev_attr_period);
+=09ret =3D device_create_file(&(pdev->dev), &dev_attr_period);
 =09if (ret) {
 =09=09printk(KERN_ERR "retu_wdt_probe: Error creating "
 =09=09=09=09=09"sys device file: period\n");
 =09=09return ret;
 =09}
=20
-=09ret =3D device_create_file(dev, &dev_attr_counter);
+=09ret =3D device_create_file(&(pdev->dev), &dev_attr_counter);
 =09if (ret) {
-=09=09device_remove_file(dev, &dev_attr_period);
+=09=09device_remove_file(&(pdev->dev), &dev_attr_period);
 =09=09printk(KERN_ERR "retu_wdt_probe: Error creating "
 =09=09=09=09=09"sys device file: counter\n");
 =09}
@@ -125,10 +125,10 @@ static int __devinit retu_wdt_probe(struct device *dev=
)
 =09return ret;
 }
=20
-static int __devexit retu_wdt_remove(struct device *dev)
+static int __devexit retu_wdt_remove(struct platform_device *pdev)
 {
-=09device_remove_file(dev, &dev_attr_period);
-=09device_remove_file(dev, &dev_attr_counter);
+=09device_remove_file(&(pdev->dev), &dev_attr_period);
+=09device_remove_file(&(pdev->dev), &dev_attr_counter);
 =09return 0;
 }
=20
@@ -145,11 +145,12 @@ static struct platform_device retu_wdt_device =3D {
 =09},
 };
=20
-static struct device_driver retu_wdt_driver =3D {
-=09.name =3D "retu-watchdog",
-=09.bus =3D &platform_bus_type,
+static struct platform_driver retu_wdt_driver =3D {
 =09.probe =3D retu_wdt_probe,
 =09.remove =3D __devexit_p(retu_wdt_remove),
+=09.driver =3D {
+=09=09.name =3D "retu-watchdog",
+=09}
 };
=20
 static int __init retu_wdt_init(void)
@@ -158,7 +159,7 @@ static int __init retu_wdt_init(void)
=20
 =09init_completion(&retu_wdt_completion);
=20
-=09ret =3D driver_register(&retu_wdt_driver);
+=09ret =3D platform_driver_register(&retu_wdt_driver);
 =09if (ret)
 =09=09return ret;
=20
@@ -178,7 +179,7 @@ static int __init retu_wdt_init(void)
 =09return ret;
=20
 exit1:
-=09driver_unregister(&retu_wdt_driver);
+=09platform_driver_unregister(&retu_wdt_driver);
 =09wait_for_completion(&retu_wdt_completion);
=20
 =09return ret;
@@ -187,7 +188,7 @@ exit1:
 static void __exit retu_wdt_exit(void)
 {
 =09platform_device_unregister(&retu_wdt_device);
-=09driver_unregister(&retu_wdt_driver);
+=09platform_driver_unregister(&retu_wdt_driver);
=20
 =09wait_for_completion(&retu_wdt_completion);
 }
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 84d7840..d9f28d5 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2004, 2005 Nokia Corporation
  *
- * Written by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>,
+ * Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>,
  *=09      David Weinehall <david.weinehall@nokia.com>, and
  *=09      Mikko Ylinen <mikko.k.ylinen@nokia.com>
  *
@@ -319,7 +319,7 @@ static void retu_power_off(void)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit retu_probe(struct device *dev)
+static int __devinit retu_probe(struct platform_device *pdev)
 {
 =09const struct omap_em_asic_bb5_config * em_asic_config;
 =09int rev, ret;
@@ -384,7 +384,7 @@ static int __devinit retu_probe(struct device *dev)
 =09return 0;
 }
=20
-static int retu_remove(struct device *dev)
+static int retu_remove(struct platform_device *pdev)
 {
 #ifdef CONFIG_CBUS_RETU_USER
 =09retu_user_cleanup();
@@ -403,11 +403,12 @@ static void retu_device_release(struct device *dev)
 =09complete(&device_release);
 }
=20
-static struct device_driver retu_driver =3D {
-=09.name=09=09=3D "retu",
-=09.bus=09=09=3D &platform_bus_type,
+static struct platform_driver retu_driver =3D {
 =09.probe=09=09=3D retu_probe,
 =09.remove=09=09=3D retu_remove,
+=09.driver =09=3D {
+=09=09.name=09=09=3D "retu",
+=09}
 };
=20
 static struct platform_device retu_device =3D {
@@ -431,11 +432,11 @@ static int __init retu_init(void)
=20
 =09init_completion(&device_release);
=20
-=09if ((ret =3D driver_register(&retu_driver)) < 0)
+=09if ((ret =3D platform_driver_register(&retu_driver)) < 0)
 =09=09return ret;
=20
 =09if ((ret =3D platform_device_register(&retu_device)) < 0) {
-=09=09driver_unregister(&retu_driver);
+=09=09platform_driver_unregister(&retu_driver);
 =09=09return ret;
 =09}
 =09return 0;
@@ -447,7 +448,7 @@ static int __init retu_init(void)
 static void __exit retu_exit(void)
 {
 =09platform_device_unregister(&retu_device);
-=09driver_unregister(&retu_driver);
+=09platform_driver_unregister(&retu_driver);
 =09wait_for_completion(&device_release);
 }
=20
@@ -464,4 +465,4 @@ module_exit(retu_exit);
=20
 MODULE_DESCRIPTION("Retu ASIC control");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4, David Weinehall, and Mikko Ylinen");
+MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, David Weinehall, and Mikko Ylin=
en");
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index d8ad836..df74d28 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -9,9 +9,9 @@
  * Copyright (C) 2004 Texas Instruments
  * Copyright (C) 2004 David Brownell
  *
- * Written by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>,
+ * Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>,
  *=09      Tony Lindgren <tony@atomide.com>, and
- *=09      Timo Ter=E4s <timo.teras@nokia.com>
+ *=09      Timo Ter=EF=BF=BDs <timo.teras@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of this
@@ -186,11 +186,11 @@ static int omap_otg_init(void)
 =09return 0;
 }
=20
-static int omap_otg_probe(struct device *dev)
+static int omap_otg_probe(struct platform_device *pdev)
 {
 =09int ret;
=20
-=09tahvo_otg_dev =3D to_platform_device(dev);
+=09tahvo_otg_dev =3D pdev;
 =09ret =3D omap_otg_init();
 =09if (ret !=3D 0) {
 =09=09printk(KERN_ERR "tahvo-usb: omap_otg_init failed\n");
@@ -202,19 +202,21 @@ static int omap_otg_probe(struct device *dev)
 =09=09=09   &tahvo_usb_device);
 }
=20
-static int omap_otg_remove(struct device *dev)
+static int omap_otg_remove(struct platform_device *pdev)
 {
-=09free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
+=09if (tahvo_otg_dev !=3D NULL)
+=09=09free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
 =09tahvo_otg_dev =3D NULL;
=20
 =09return 0;
 }
=20
-struct device_driver omap_otg_driver =3D {
-=09.name=09=09=3D "omap_otg",
-=09.bus=09=09=3D &platform_bus_type,
+struct platform_driver omap_otg_driver =3D {
 =09.probe=09=09=3D omap_otg_probe,
 =09.remove=09=09=3D omap_otg_remove,
+=09.driver=09=09=3D {
+=09=09.name=09=09=3D "omap_otg",
+=09}
 };
=20
 /*
@@ -641,19 +643,19 @@ static ssize_t otg_mode_store(struct device *device,
 static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
 #endif
=20
-static int tahvo_usb_probe(struct device *dev)
+static int tahvo_usb_probe(struct platform_device *pdev)
 {
 =09struct tahvo_usb *tu;
 =09int ret;
=20
-=09dev_dbg(dev, "probe\n");
+=09dev_dbg(&(pdev->dev), "probe\n");
=20
 =09/* Create driver data */
 =09tu =3D kmalloc(sizeof(*tu), GFP_KERNEL);
 =09if (!tu)
 =09=09return -ENOMEM;
 =09memset(tu, 0, sizeof(*tu));
-=09tu->pt_dev =3D container_of(dev, struct platform_device, dev);
+=09tu->pt_dev =3D pdev;
 #ifdef CONFIG_USB_OTG
 =09/* Default mode */
 #ifdef CONFIG_CBUS_TAHVO_USB_HOST_BY_DEFAULT
@@ -680,9 +682,9 @@ static int tahvo_usb_probe(struct device *dev)
 =09}
=20
 =09/* Attributes */
-=09ret =3D device_create_file(dev, &dev_attr_vbus_state);
+=09ret =3D device_create_file(&(pdev->dev), &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-=09ret |=3D device_create_file(dev, &dev_attr_otg_mode);
+=09ret |=3D device_create_file(&(pdev->dev), &dev_attr_otg_mode);
 #endif
 =09if (ret)
 =09=09printk(KERN_ERR "attribute creation failed: %d\n", ret);
@@ -706,7 +708,7 @@ static int tahvo_usb_probe(struct device *dev)
 =09=09return ret;
 =09}
=20
-=09dev->driver_data =3D tu;
+=09pdev->dev.driver_data =3D tu;
=20
 =09/* Act upon current vbus state once at startup. A vbus state irq may or
 =09 * may not be generated in addition to this. */
@@ -714,25 +716,26 @@ static int tahvo_usb_probe(struct device *dev)
 =09return 0;
 }
=20
-static int tahvo_usb_remove(struct device *dev)
+static int tahvo_usb_remove(struct platform_device *pdev)
 {
-=09dev_dbg(dev, "remove\n");
+=09dev_dbg(&(pdev->dev), "remove\n");
=20
 =09tahvo_free_irq(TAHVO_INT_VBUSON);
 =09flush_scheduled_work();
 =09otg_set_transceiver(0);
-=09device_remove_file(dev, &dev_attr_vbus_state);
+=09device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-=09device_remove_file(dev, &dev_attr_otg_mode);
+=09device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
 #endif
 =09return 0;
 }
=20
-static struct device_driver tahvo_usb_driver =3D {
-=09.name=09=09=3D "tahvo-usb",
-=09.bus=09=09=3D &platform_bus_type,
+static struct platform_driver tahvo_usb_driver =3D {
 =09.probe=09=09=3D tahvo_usb_probe,
 =09.remove=09=09=3D tahvo_usb_remove,
+=09.driver=09=09=3D {
+=09=09.name=09=09=3D "tahvo-usb",
+=09}
 };
=20
 static struct platform_device tahvo_usb_device =3D {
@@ -745,18 +748,18 @@ static int __init tahvo_usb_init(void)
 =09int ret =3D 0;
=20
 =09printk(KERN_INFO "Tahvo USB transceiver driver initializing\n");
-=09ret =3D driver_register(&tahvo_usb_driver);
+=09ret =3D platform_driver_register(&tahvo_usb_driver);
 =09if (ret)
 =09=09return ret;
 =09ret =3D platform_device_register(&tahvo_usb_device);
 =09if (ret < 0) {
-=09=09driver_unregister(&tahvo_usb_driver);
+=09=09platform_driver_unregister(&tahvo_usb_driver);
 =09=09return ret;
 =09}
-=09ret =3D driver_register(&omap_otg_driver);
+=09ret =3D platform_driver_register(&omap_otg_driver);
 =09if (ret) {
 =09=09platform_device_unregister(&tahvo_usb_device);
-=09=09driver_unregister(&tahvo_usb_driver);
+=09=09platform_driver_unregister(&tahvo_usb_driver);
 =09=09return ret;
 =09}
 =09return 0;
@@ -766,12 +769,12 @@ subsys_initcall(tahvo_usb_init);
=20
 static void __exit tahvo_usb_exit(void)
 {
-=09driver_unregister(&omap_otg_driver);
+=09platform_driver_unregister(&omap_otg_driver);
 =09platform_device_unregister(&tahvo_usb_device);
-=09driver_unregister(&tahvo_usb_driver);
+=09platform_driver_unregister(&tahvo_usb_driver);
 }
 module_exit(tahvo_usb_exit);
=20
 MODULE_DESCRIPTION("Tahvo USB OTG Transceiver Driver");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4, Tony Lindgren, and Timo Ter=E4s");
+MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, Tony Lindgren, and Timo Ter=EF=
=BF=BDs");
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index e734c4c..29fd4b8 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2004, 2005 Nokia Corporation
  *
- * Written by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>,
+ * Written by Juha Yrj=EF=BF=BDl=EF=BF=BD <juha.yrjola@nokia.com>,
  *=09      David Weinehall <david.weinehall@nokia.com>, and
  *=09      Mikko Ylinen <mikko.k.ylinen@nokia.com>
  *
@@ -287,7 +287,7 @@ void tahvo_free_irq(int id)
  * Probe for the Tahvo ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit tahvo_probe(struct device *dev)
+static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 =09const struct omap_em_asic_bb5_config * em_asic_config;
 =09int rev, id, ret;
@@ -356,7 +356,7 @@ static int __devinit tahvo_probe(struct device *dev)
 =09return 0;
 }
=20
-static int tahvo_remove(struct device *dev)
+static int tahvo_remove(struct platform_device *pdev)
 {
 #ifdef CONFIG_CBUS_TAHVO_USER
 =09tahvo_user_cleanup();
@@ -375,11 +375,12 @@ static void tahvo_device_release(struct device *dev)
 =09complete(&device_release);
 }
=20
-static struct device_driver tahvo_driver =3D {
-=09.name=09=09=3D "tahvo",
-=09.bus=09=09=3D &platform_bus_type,
+static struct platform_driver tahvo_driver =3D {
 =09.probe=09=09=3D tahvo_probe,
 =09.remove=09=09=3D tahvo_remove,
+=09.driver=09=09=3D {
+=09=09.name=09=09=3D "tahvo",
+=09}
 };
=20
 static struct platform_device tahvo_device =3D {
@@ -403,11 +404,11 @@ static int __init tahvo_init(void)
=20
 =09init_completion(&device_release);
=20
-=09if ((ret =3D driver_register(&tahvo_driver)) < 0)
+=09if ((ret =3D platform_driver_register(&tahvo_driver)) < 0)
 =09=09return ret;
=20
 =09if ((ret =3D platform_device_register(&tahvo_device)) < 0) {
-=09=09driver_unregister(&tahvo_driver);
+=09=09platform_driver_unregister(&tahvo_driver);
 =09=09return ret;
 =09}
 =09return 0;
@@ -419,7 +420,7 @@ static int __init tahvo_init(void)
 static void __exit tahvo_exit(void)
 {
 =09platform_device_unregister(&tahvo_device);
-=09driver_unregister(&tahvo_driver);
+=09platform_driver_unregister(&tahvo_driver);
 =09wait_for_completion(&device_release);
 }
=20
@@ -439,4 +440,4 @@ module_exit(tahvo_exit);
=20
 MODULE_DESCRIPTION("Tahvo ASIC control");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4, David Weinehall, and Mikko Ylinen");
+MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, David Weinehall, and Mikko Ylin=
en");
--=_1mhn56xvfayo--

