From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch: Init/shutdown correctness fixes for drivers/cbus/tahvo*
Date: Tue, 26 May 2009 00:20:46 +0100
Message-ID: <20090526002046.52484z9m6ufsxjb4@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_4xkfie8xnnk0"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:54511 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZEYXUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 19:20:45 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id A713048A70916
	for <linux-omap@vger.kernel.org>; Tue, 26 May 2009 00:20:46 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This message is in MIME format.

--=_4xkfie8xnnk0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is a companion review patch to the cbus one that fixes  
init/shutdown correctness in drivers/cbus/tahvo*


--=_4xkfie8xnnk0
Content-Type: text/x-patch;
	charset=UTF-8;
	name="tahvo-correctness.patch"
Content-Disposition: attachment;
	filename="tahvo-correctness.patch"
Content-Transfer-Encoding: quoted-printable

commit 76dfa5c81201df2340e4f5902a4552dea449d771
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Tue May 26 00:13:21 2009 +0100

    Fix tahvo errors

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index df74d28..5f70c44 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -651,10 +651,9 @@ static int tahvo_usb_probe(struct platform_device *pdev=
)
 =09dev_dbg(&(pdev->dev), "probe\n");
=20
 =09/* Create driver data */
-=09tu =3D kmalloc(sizeof(*tu), GFP_KERNEL);
+=09tu =3D kzalloc(sizeof(*tu), GFP_KERNEL);
 =09if (!tu)
 =09=09return -ENOMEM;
-=09memset(tu, 0, sizeof(*tu));
 =09tu->pt_dev =3D pdev;
 #ifdef CONFIG_USB_OTG
 =09/* Default mode */
@@ -683,11 +682,23 @@ static int tahvo_usb_probe(struct platform_device *pde=
v)
=20
 =09/* Attributes */
 =09ret =3D device_create_file(&(pdev->dev), &dev_attr_vbus_state);
+=09if (ret) {
+=09=09tahvo_free_irq(TAHVO_INT_VBUSON);
+=09=09kfree(tu);
+=09=09printk(KERN_ERR "attribute creation failed: %d\n", ret);
+=09=09return ret;
+=09}
+
 #ifdef CONFIG_USB_OTG
-=09ret |=3D device_create_file(&(pdev->dev), &dev_attr_otg_mode);
-#endif
-=09if (ret)
+=09ret =3D device_create_file(&(pdev->dev), &dev_attr_otg_mode);
+=09if (ret) {
+=09=09device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
+=09=09tahvo_free_irq(TAHVO_INT_VBUSON);
+=09=09kfree(tu);
 =09=09printk(KERN_ERR "attribute creation failed: %d\n", ret);
+=09=09return ret;
+=09}
+#endif
=20
 =09/* Create OTG interface */
 =09tahvo_usb_power_off(tu);
@@ -703,8 +714,12 @@ static int tahvo_usb_probe(struct platform_device *pdev=
)
 =09ret =3D otg_set_transceiver(&tu->otg);
 =09if (ret < 0) {
 =09=09printk(KERN_ERR "Cannot register USB transceiver\n");
-=09=09kfree(tu);
 =09=09tahvo_free_irq(TAHVO_INT_VBUSON);
+=09=09device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
+#ifdef CONFIG_USB_OTG
+=09=09device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
+#endif
+=09=09kfree(tu);
 =09=09return ret;
 =09}
=20
@@ -718,6 +733,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
=20
 static int tahvo_usb_remove(struct platform_device *pdev)
 {
+=09struct tahvo_usb *tu =3D (struct tahvo_usb*) pdev->dev.driver_data;
 =09dev_dbg(&(pdev->dev), "remove\n");
=20
 =09tahvo_free_irq(TAHVO_INT_VBUSON);
@@ -727,6 +743,7 @@ static int tahvo_usb_remove(struct platform_device *pdev=
)
 #ifdef CONFIG_USB_OTG
 =09device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
 #endif
+=09kfree(tu);
 =09return 0;
 }
=20
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 29fd4b8..09a69c0 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -298,6 +298,7 @@ static int __devinit tahvo_probe(struct platform_device =
*pdev)
 =09em_asic_config =3D omap_get_config(OMAP_TAG_EM_ASIC_BB5,
 =09=09=09=09=09 struct omap_em_asic_bb5_config);
 =09if (em_asic_config =3D=3D NULL) {
+=09=09tasklet_kill(&tahvo_tasklet);
 =09=09printk(KERN_ERR PFX "Unable to retrieve config data\n");
 =09=09return -ENODATA;
 =09}
@@ -314,6 +315,7 @@ static int __devinit tahvo_probe(struct platform_device =
*pdev)
 =09=09tahvo_is_betty =3D 1;
 =09=09tahvo_7bit_backlight =3D 1;
 =09} else {
+=09=09tasklet_kill(&tahvo_tasklet);
 =09=09printk(KERN_ERR "Tahvo/Betty chip not found");
 =09=09return -ENODEV;
 =09}
@@ -324,6 +326,7 @@ static int __devinit tahvo_probe(struct platform_device =
*pdev)
 =09tahvo_irq_pin =3D em_asic_config->tahvo_irq_gpio;
=20
 =09if ((ret =3D gpio_request(tahvo_irq_pin, "TAHVO irq")) < 0) {
+=09=09tasklet_kill(&tahvo_tasklet);
 =09=09printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
 =09=09return ret;
 =09}
@@ -342,6 +345,7 @@ static int __devinit tahvo_probe(struct platform_device =
*pdev)
 =09if (ret < 0) {
 =09=09printk(KERN_ERR PFX "Unable to register IRQ handler\n");
 =09=09gpio_free(tahvo_irq_pin);
+=09=09tasklet_kill(&tahvo_tasklet);
 =09=09return ret;
 =09}
 #ifdef CONFIG_CBUS_TAHVO_USER
@@ -350,6 +354,7 @@ static int __devinit tahvo_probe(struct platform_device =
*pdev)
 =09=09printk(KERN_ERR "Unable to initialize driver\n");
 =09=09free_irq(gpio_to_irq(tahvo_irq_pin), 0);
 =09=09gpio_free(tahvo_irq_pin);
+=09=09tasklet_kill(&tahvo_tasklet);
 =09=09return ret;
 =09}
 #endif
--=_4xkfie8xnnk0--

