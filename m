From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch: Fix N770 brf6150 bluetooth driver
Date: Sat, 23 May 2009 18:42:08 +0100
Message-ID: <20090523184208.14202m390hgqxv28@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_2kg9qhgc5o5c"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:43480 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbZEWRmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 13:42:08 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id 7C8CC48A6119C
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 18:42:08 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This message is in MIME format.

--=_2kg9qhgc5o5c
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This driver has the same problem as the cbus drivers - mismatch  
between platform_device and non-platform driver APIs.

Switching it to use platform_driver removes the random corruption and  
badness I was seeing on boot.


--=_2kg9qhgc5o5c
Content-Type: text/x-patch;
	charset=UTF-8;
	name="fix-brf6150.patch"
Content-Disposition: attachment;
	filename="fix-brf6150.patch"
Content-Transfer-Encoding: quoted-printable

commit e6dce93304c6c692e187b95eaea227cfe3cb3317
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Sat May 23 18:37:25 2009 +0100

    Fix brf6150.c platform_device breakage
   =20
    This driver has the mismatch between platform_devices and non-platform d=
rivers.
    Switch it to use platform_driver as well.
   =20
    Signed-off-by: Andrew de Quincey <adq@lidskialf.net>

diff --git a/drivers/bluetooth/brf6150.c b/drivers/bluetooth/brf6150.c
index 211fa5e..f29caf5 100644
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -90,9 +90,10 @@ static struct platform_device brf6150_device =3D {
 =09}
 };
=20
-static struct device_driver brf6150_driver =3D {
-=09.name=09=09=3D BT_DRIVER,
-=09.bus=09=09=3D &platform_bus_type,
+static struct platform_driver brf6150_driver =3D {
+=09.driver =3D {
+=09=09.name=09=09=3D BT_DRIVER,
+=09}
 };
=20
 static inline void brf6150_outb(struct brf6150_info *info, unsigned int off=
set, u8 val)
@@ -1002,7 +1003,7 @@ static int __init brf6150_init(void)
 =09=09goto cleanup_irq;
 =09}
 =09/* Register the driver with LDM */
-=09if (driver_register(&brf6150_driver)) {
+=09if (platform_driver_register(&brf6150_driver)) {
 =09=09printk(KERN_WARNING "failed to register brf6150 driver\n");
 =09=09platform_device_unregister(&brf6150_device);
 =09=09err =3D -ENODEV;
@@ -1012,7 +1013,7 @@ static int __init brf6150_init(void)
 =09if (brf6150_register_hdev(info) < 0) {
 =09=09printk(KERN_WARNING "failed to register brf6150 hci device\n");
 =09=09platform_device_unregister(&brf6150_device);
-=09=09driver_unregister(&brf6150_driver);
+=09=09platform_driver_unregister(&brf6150_driver);
 =09=09goto cleanup_irq;
 =09}
=20
--=_2kg9qhgc5o5c--

