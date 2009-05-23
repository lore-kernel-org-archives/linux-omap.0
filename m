From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Tracking N770 breakage
Date: Sat, 23 May 2009 14:25:42 +0100
Message-ID: <20090523142542.10985fjvcwu3k9s0@lidskialf.net>
References: <20090516140653.10104565olvxrwjk@lidskialf.net>
	<20090517031715.92503qopn0joudhc@lidskialf.net>
	<20090519231500.GM19742@atomide.com>
	<20090520061544.560957looc5zgav4@lidskialf.net>
	<20090520151907.GC8308@atomide.com>
	<20090522184720.10616mt8vpjglk3k@lidskialf.net>
	<20090522193359.17514ptwyl8kdbls@lidskialf.net>
	<20090522231826.12833dwwkvi7rv0g@lidskialf.net>
	<20090523023901.33341jpwcx6nd70g@lidskialf.net>
	<20090523014717.GB9283@atomide.com>
	<20090523121108.14776dli2aeyapkw@lidskialf.net>
	<20090523123040.16971ty5wndy6mow@lidskialf.net>
	<20090523132812.14461t6dlahg2ew0@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_5e08ye28f5hc"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:38201 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZEWNZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 09:25:43 -0400
In-Reply-To: <20090523132812.14461t6dlahg2ew0@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

This message is in MIME format.

--=_5e08ye28f5hc
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:

> Quoting Andrew de Quincey <adq@lidskialf.net>:
>
>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>
>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>
>>>> * Andrew de Quincey <adq@lidskialf.net> [090522 18:39]:
>>>>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>>>>
>>>>>> Quoting Andrew de Quincey <adq@lidskialf.net>:
>>>>>>
>>>>>>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>>>>>>
>>>>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>>>>
>>>>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090519 22:15]:
>>>>>>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>>>>>>
>>>>>>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>>>>>>>>>>>> Argh, my N770 seems to have just died; it has been =20
>>>>>>>>>>>> behaving slightly
>>>>>>>>>>>> oddly and now it simply won't turn on (black screen and =20
>>>>>>>>>>>> no  sign of life
>>>>>>>>>>>> whatsoever).
>>>>>>>>>>>>
>>>>>>>>>>>> It is well out of warranty and frankly I don't see myself
>>>>>>>>>>>> buying another
>>>>>>>>>>>> one, so this effectively ends my hacking on it :(
>>>>>>>>>>>
>>>>>>>>>>> Bummer :(
>>>>>>>>>>>
>>>>>>>>>>> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first  =20
>>>>>>>>>>> stopper, then
>>>>>>>>>>> it could not mount the MMC root.
>>>>>>>>>>
>>>>>>>>>> Ahh excellent, that was why I posted my progress, in case =20
>>>>>>>>>> it  rang a bell
>>>>>>>>>> with anyone! I think the touchpad driver may be broken as well BT=
W.
>>>>>>>>>>
>>>>>>>>>>> I think there was a patch posted for the omap1 MMC by
>>>>>>>>>>> Ladislav few months
>>>>>>>>>>> ago that probably fixes it.
>>>>>>>>>>
>>>>>>>>>> Cool - I hope I may be back in the running soon (I was =20
>>>>>>>>>> rather annoyed
>>>>>>>>>> when I posted that message!); I've ordered a new battery in case =
its
>>>>>>>>>> just that. A kind person has also offered me one thats broken in =
a
>>>>>>>>>> different way that I can probably cobble together with the =20
>>>>>>>>>> remains of
>>>>>>>>>> mine if its something more critical that has died.
>>>>>>>>>
>>>>>>>>> Good to hear, let's hope it just needs a new battery.
>>>>>>>>>
>>>>>>>>> See also the n8x0 thread. If we get drivers/cbus to mainline, we
>>>>>>>>> pretty much have everything we need for 770 in mainline too.
>>>>>>>>>
>>>>>>>>> It would be nice to get the drivers/mmc/host/omap.c patch integrat=
ed
>>>>>>>>> for 2.6.30 to make omap1 MMC work again. Ladislav, any news on tha=
t?
>>>>>>>>
>>>>>>>> OK! My friend has lent me his N770 in the meantime so I can get
>>>>>>>> going again. It seems the board is fried on mine as my battery
>>>>>>>> works perfectly fine in his. gah!
>>>>>>>>
>>>>>>>> Anyway, I have just tried disabling RESET_CLOCKS, but it still
>>>>>>>> doesn't work for me with the very latest linux-omap-2.6.
>>>>>>>>
>>>>>>>> With my HWA patch applied, at least the screen goes black, but I
>>>>>>>> don't see any console output, and the thing doesn't appear as a
>>>>>>>> USB gadget (I'm mounting NFS as root over USB with cdc_ether).
>>>>>>>>
>>>>>>>> I wish the thing had an LED I could turn on! Hmm, I wonder if I
>>>>>>>> could turn off the backlight easily..
>>>>>>>
>>>>>>> Actually, after playing a bit, I discovered I'm getting a boot
>>>>>>> penguin logo ok, but no actual textual console output; weird!
>>>>>>
>>>>>> I feel really silly; the N770's bootloader had "serial-console"
>>>>>> enabled, which meant all the kernel messages were being sent out that
>>>>>> instead of being displayed on the fb. So I can now see WTF is going o=
n!
>>>>>>
>>>>>> Next problem for me: ohci-hcd.c is reporting an initialisation error
>>>>>> in the latest kernels, which is why my NFS-over-USB mount fails. I
>>>>>> can't see any changes in the initialisation *values* used, but there
>>>>>> have obviously been the "kill OMAP_TAG_USB" changes; I'm wondering if
>>>>>> its some initialisation ordering problem.
>>>>>
>>>>> OK got it, it IS a timing problem, due to non-ARM changes in the core
>>>>> kernel (possibly the recent async subsystem startup improvements?).
>>>>>
>>>>> In the middle of the boot with a recent kernel, I see a message
>>>>> "tahvo-usb: no tahvo_otg_dev" coming from
>>>>> drivers/cbus/tahvo-usb.c/omap_otg_init(). This is because the internal
>>>>> field "tahvo_otg_dev" is NULL. In turn, omap_otg_init() is being calle=
d
>>>>> by tahvo_usb_become_peripheral() which is called from higher up in the
>>>>> USB stack.
>>>>>
>>>>> However, from the code, what is /meant/ to happen is that the "omap_ot=
g"
>>>>> driver is meant to call omap_otg_probe() (which sets that field) befor=
e
>>>>> anything calls drivers/cbus/tahvo-usb.c/omap_otg_init(). However, due =
to
>>>>> the timing problem, it occurs out of sequence, so it thinks there isn'=
t a
>>>>> transceiver present.
>>>>>
>>>>> tahvo-usb.c looks as though it needs sorting out somehow; it seems to
>>>>> consist of two seperate drivers rammed together, plus it has this timi=
ng
>>>>> issue. The tahvo-usb code itself suggests splitting the tahvo-usb driv=
er
>>>>> into an "omap-otg.c" driver, though some thought will be needed to
>>>>> eliminate the timing issue properly.
>>>>>
>>>>
>>>> Hmm, a quick diff with $ git diff omap-2.6.28..master drivers/Makefile
>>>> shows that cbus order has changed in the Makefile, maybe that causes it=
?
>>>
>>> Oooh that'd be horrible! but reverting it doesn't appear fix anything.
>>>
>>> Anyway, the breaking changeset doesn't have that change in it... =20
>>> its  still the ones that I highlighted at the start of this thread.
>>>
>>> Doing
>>>
>>> git log -p  =20
>>> eba05254cb561dc27d5664503f91f7c21954e648..0595ee8a05836666b225e6bf003ede=
0da1e6e329  =20
>>> drivers/Makefile
>>>
>>> Doesn't show any ordering changes in Makefile affecting cbus or platform=
...
>>>
>>> Incidentally, I tried turning on CONFIG_BOOT_PRINTK_DELAY with a  =20
>>> boot_delay=3D100. With that, it now DOES probe the omap_otg device =20
>>> in  tahvo-usb first, but it dies with a NULL pointer dereference. =20
>>> Still  sounds like an initialisation timing problem here...
>>
>> The attached (nasty!) debugging patch reveals that omap_otg_probe() =20
>> is  not actually being called at all! Only =20
>> tahvo_usb_become_peripheral()  is called.
>>
>> If I comment out the:
>>
>> #ifdef CONFIG_USB_OTG
>>        if (!tahvo_otg_dev) {
>>                printk("tahvo-usb: no tahvo_otg_dev\n");
>>                return -ENODEV;
>>        }
>> #endif
>>
>> section, then it sees my USB device and attempts to boot over NFS. =20
>> Of  course, this isn't a proper solution :)
>>
>
>
> Found it!
>
> It is this change here: =20
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=3D=
commit;h=3D57fee4a58fe802272742caae248872c392a60670
>
> If I comment out the bit in platform.c with:
>        if (pdrv->id_table)
>                return platform_match_id(pdrv->id_table, pdev) !=3D NULL;
> Then all works fine (it drops back to using name comparison as prior =20
> to this change).
>
> With it left in however, pdrv->id_table is non-NULL for the =20
> tahvo-usb driver, so it fails the check. I'm /guessing/ its filled =20
> with crap since we're not setting it to anything anywhere, but I =20
> don't know enough about the platform device driver model yet.

Ok, I spent some time looking for the magic code in =20
drivers/base/platform.c that would mean you could use a device =20
registered with register_platform_device() with a driver which had =20
been registered with just driver_register().

As it turns out, there is no magic code:  it appears you must always =20
use register_platform_driver() for platform_devices (because the =20
drivers/base/platform.c code expects to be able to cast things =20
internally to a struct platform_driver, which is NOT the case when =20
using driver_register())

Attached is v1 of a patch which converts everything in drivers/cbus to =20
use register_platform_driver(). This means the USB gadget stuff is now =20
working properly, but obviously this needs review!

One problem though:  Juha Yrj=C3=B6l=C3=A4's name is being corrupted in the =
file =20
headers. I'm using all-UTF8 here, but obviously the files are in a =20
different encoding. What one is the correct to use? I can easily =20
convert them to the appropriate UTF8 characters, but I don't want to =20
piss people off by just doing so.

--=_5e08ye28f5hc
Content-Type: text/x-patch;
	charset=UTF-8;
	name="cbus-platform-drivers.patch"
Content-Disposition: attachment;
	filename="cbus-platform-drivers.patch"
Content-Transfer-Encoding: quoted-printable

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
--=_5e08ye28f5hc--

