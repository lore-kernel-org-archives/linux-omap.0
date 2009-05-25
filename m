From: Andrew de Quincey <adq@lidskialf.net>
Subject: Patch: Init/shutdown correctness fixes for drivers/cbus/retu*
Date: Tue, 26 May 2009 00:18:56 +0100
Message-ID: <20090526001856.117145k514vqy2kg@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_4400wkfarkow"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:41568 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZEYXS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 19:18:56 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id D6AF648A598C7
	for <linux-omap@vger.kernel.org>; Tue, 26 May 2009 00:18:56 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This message is in MIME format.

--=_4400wkfarkow
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

I noticed there were a number of problems with the init and shutdown  
routines for the code in drivers/cbus/retu*. This patch (for review)  
attempts to fix them.



--=_4400wkfarkow
Content-Type: text/x-patch;
	charset=UTF-8;
	name="retu-correctness.patch"
Content-Disposition: attachment;
	filename="retu-correctness.patch"
Content-Transfer-Encoding: quoted-printable

commit 59e589227131abbe5e07576f542cc35a8821c9d3
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Mon May 25 23:58:27 2009 +0100

    Correctness fixes for the retu drivers

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index e798bc2..fe8266f 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Nokia Corporation
  *
- * Written by Juha Yrj=F6l=E4
+ * Written by Juha Yrj=EF=BF=BDl=EF=BF=BD
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of this
@@ -265,6 +265,8 @@ static int __init retu_headset_probe(struct platform_dev=
ice *pdev)
 =09retu_disable_irq(RETU_INT_HOOK);
 =09return 0;
 err6:
+=09del_timer_sync(&hs->enable_timer);
+=09del_timer_sync(&hs->detect_timer);
 =09device_remove_file(&pdev->dev, &dev_attr_enable_det);
 err5:
 =09device_remove_file(&pdev->dev, &dev_attr_enable);
@@ -291,6 +293,7 @@ static int retu_headset_remove(struct platform_device *p=
dev)
 =09retu_free_irq(RETU_INT_HOOK);
 =09input_unregister_device(hs->idev);
 =09input_free_device(hs->idev);
+=09kfree(hs);
 =09return 0;
 }
=20
@@ -352,4 +355,4 @@ module_exit(retu_headset_exit);
=20
 MODULE_DESCRIPTION("Retu/Vilma headset detection");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4");
+MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD");
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 38d7aa4..cc47691 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -7,7 +7,7 @@
  *
  * Written by Ari Saastamoinen <ari.saastamoinen@elektrobit.com>
  *
- * Contact Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ * Contact Juha Yrj=EF=BF=BDl=EF=BF=BD <juha.yrjola@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of this
@@ -75,29 +75,40 @@ static void retubutton_irq(unsigned long arg)
  */
 static int __init retubutton_init(void)
 {
-=09int irq;
-
-=09printk(KERN_INFO "Retu power button driver initialized\n");
-=09irq =3D RETU_INT_PWR;
+=09int ret;
=20
 =09init_timer(&pwrbtn_timer);
 =09pwrbtn_timer.function =3D retubutton_timer_func;
=20
-=09if (retu_request_irq(irq, &retubutton_irq, 0, "PwrOnX") < 0) {
+=09if (retu_request_irq(RETU_INT_PWR, &retubutton_irq, 0, "PwrOnX") < 0) {
+=09=09del_timer_sync(&pwrbtn_timer);
 =09=09printk(KERN_ERR "%s@%s: Cannot allocate irq\n",
 =09=09       __FUNCTION__, __FILE__);
 =09=09return -EBUSY;
 =09}
=20
 =09pwrbtn_dev =3D input_allocate_device();
-=09if (!pwrbtn_dev)
+=09if (!pwrbtn_dev) {
+=09=09retu_free_irq(RETU_INT_PWR);
+=09=09del_timer_sync(&pwrbtn_timer);
 =09=09return -ENOMEM;
+=09}
=20
 =09pwrbtn_dev->evbit[0] =3D BIT_MASK(EV_KEY);
 =09pwrbtn_dev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
 =09pwrbtn_dev->name =3D "retu-pwrbutton";
=20
-=09return input_register_device(pwrbtn_dev);
+=09ret =3D input_register_device(pwrbtn_dev);
+=09if (ret < 0) {
+=09=09retu_free_irq(RETU_INT_PWR);
+=09=09del_timer_sync(&pwrbtn_timer);
+=09=09input_free_device(pwrbtn_dev);
+=09=09return ret;
+=09}
+
+=09printk(KERN_INFO "Retu power button driver initialized\n");
+
+=09return 0;
 }
=20
 /**
@@ -108,6 +119,7 @@ static void __exit retubutton_exit(void)
 =09retu_free_irq(RETU_INT_PWR);
 =09del_timer_sync(&pwrbtn_timer);
 =09input_unregister_device(pwrbtn_dev);
+=09input_free_device(pwrbtn_dev);
 }
=20
 module_init(retubutton_init);
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 76343f9..5a6a816 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -381,7 +381,7 @@ static int __devinit retu_rtc_probe(struct platform_devi=
ce *pdev)
 =09=09retu_rtc_do_reset();
=20
 =09if ((r =3D device_create_file(&(pdev->dev), &dev_attr_time)) !=3D 0)
-=09=09return r;
+=09=09goto err_free_irqs;
 =09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_reset)) !=3D =
0)
 =09=09goto err_unregister_time;
 =09else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_alarm)) !=3D =
0)
@@ -401,6 +401,9 @@ err_unregister_reset:
 =09device_remove_file(&(pdev->dev), &dev_attr_reset);
 err_unregister_time:
 =09device_remove_file(&(pdev->dev), &dev_attr_time);
+err_free_irqs:
+=09retu_free_irq(RETU_INT_RTCS);
+=09retu_free_irq(RETU_INT_RTCA);
 =09return r;
 }
=20
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index d9f28d5..8c0d7cb 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -331,6 +331,7 @@ static int __devinit retu_probe(struct platform_device *=
pdev)
 =09=09=09=09=09 struct omap_em_asic_bb5_config);
 =09if (em_asic_config =3D=3D NULL) {
 =09=09printk(KERN_ERR PFX "Unable to retrieve config data\n");
+=09=09tasklet_kill(&retu_tasklet);
 =09=09return -ENODATA;
 =09}
=20
@@ -338,6 +339,7 @@ static int __devinit retu_probe(struct platform_device *=
pdev)
=20
 =09if ((ret =3D gpio_request(retu_irq_pin, "RETU irq")) < 0) {
 =09=09printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
+=09=09tasklet_kill(&retu_tasklet);
 =09=09return ret;
 =09}
=20
@@ -364,6 +366,7 @@ static int __devinit retu_probe(struct platform_device *=
pdev)
 =09if (ret < 0) {
 =09=09printk(KERN_ERR PFX "Unable to register IRQ handler\n");
 =09=09gpio_free(retu_irq_pin);
+=09=09tasklet_kill(&retu_tasklet);
 =09=09return ret;
 =09}
 =09set_irq_wake(gpio_to_irq(retu_irq_pin), 1);
@@ -377,6 +380,7 @@ static int __devinit retu_probe(struct platform_device *=
pdev)
 =09=09printk(KERN_ERR "Unable to initialize driver\n");
 =09=09free_irq(gpio_to_irq(retu_irq_pin), 0);
 =09=09gpio_free(retu_irq_pin);
+=09=09tasklet_kill(&retu_tasklet);
 =09=09return ret;
 =09}
 #endif
--=_4400wkfarkow--

