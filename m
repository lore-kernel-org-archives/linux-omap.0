From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: [patch] Fix brf6510 cleanup code
Date: Mon, 08 Jun 2009 21:03:33 +0100
Message-ID: <20090608210333.11295srly8te8xog@lidskialf.net>
References: <20090530180721.75203sfsqbpppfi8@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_5r9vyl0nzrsw"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:47776 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbZFHUDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 16:03:32 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id C138848860091
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2009 21:03:33 +0100 (BST)
In-Reply-To: <20090530180721.75203sfsqbpppfi8@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This message is in MIME format.

--=_5r9vyl0nzrsw
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The brf6150 driver is missing several necessary cleanup steps to allow  
module unloading. Add them.


Signed-off-by: Andrew de Quincey <adq@lidskialf.net>


--=_5r9vyl0nzrsw
Content-Type: text/x-patch;
	charset=UTF-8;
	name="brf6510-cleanup-fix.patch"
Content-Disposition: attachment;
	filename="brf6510-cleanup-fix.patch"
Content-Transfer-Encoding: quoted-printable

commit bf0e4cba53819df5590a88d551b35a2e79f4de75
Author: Andrew de Quincey <adq@lidskialf.net>
Date:   Sat May 30 18:01:58 2009 +0100

    Fix brf6150 init/shutdown cleanup

diff --git a/drivers/bluetooth/brf6150.c b/drivers/bluetooth/brf6150.c
index f29caf5..4f0112a 100644
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -312,7 +312,7 @@ static int brf6150_send_negotiation(struct brf6150_info =
*info)
 =09skb =3D brf6150_read_fw_cmd(info, GFP_KERNEL);
=20
 =09if (!skb) {
-=09=09printk(KERN_WARNING "Cannot read negoatiation message");
+=09=09printk(KERN_WARNING "Cannot read negotiation message");
 =09=09return -1;
 =09}
=20
@@ -873,6 +873,7 @@ static int brf6150_register_hdev(struct brf6150_info *in=
fo)
 =09hdev->owner =3D THIS_MODULE;
=20
 =09if (hci_register_dev(hdev) < 0) {
+=09=09hci_free_dev(hdev);
 =09=09printk(KERN_WARNING "brf6150: Can't register HCI device %s.\n", hdev-=
>name);
 =09=09return -ENODEV;
 =09}
@@ -885,10 +886,9 @@ static int __init brf6150_init(void)
 =09struct brf6150_info *info;
 =09int irq, err;
=20
-=09info =3D kmalloc(sizeof(struct brf6150_info), GFP_KERNEL);
+=09info =3D kzalloc(sizeof(struct brf6150_info), GFP_KERNEL);
 =09if (!info)
 =09=09return -ENOMEM;
-=09memset(info, 0, sizeof(struct brf6150_info));
=20
 =09brf6150_device.dev.driver_data =3D info;
 =09init_completion(&info->init_completion);
@@ -906,8 +906,11 @@ static int __init brf6150_init(void)
 =09exit_info =3D NULL;
=20
 =09info->btinfo =3D omap_get_config(OMAP_TAG_NOKIA_BT, struct omap_bluetoot=
h_config);
-=09if (info->btinfo =3D=3D NULL)
+=09if (info->btinfo =3D=3D NULL) {
+=09=09tasklet_kill(&info->tx_task);
+=09=09kfree(info);
 =09=09return -1;
+=09}
=20
 =09NBT_DBG("RESET gpio: %d\n", info->btinfo->reset_gpio);
 =09NBT_DBG("BTWU gpio: %d\n", info->btinfo->bt_wakeup_gpio);
@@ -920,6 +923,7 @@ static int __init brf6150_init(void)
 =09{
 =09=09printk(KERN_WARNING "Cannot get GPIO line %d",=20
 =09=09       info->btinfo->reset_gpio);
+=09=09tasklet_kill(&info->tx_task);
 =09=09kfree(info);
 =09=09return err;
 =09}
@@ -930,6 +934,7 @@ static int __init brf6150_init(void)
 =09=09printk(KERN_WARNING "Cannot get GPIO line 0x%d",
 =09=09       info->btinfo->bt_wakeup_gpio);
 =09=09gpio_free(info->btinfo->reset_gpio);
+=09=09tasklet_kill(&info->tx_task);
 =09=09kfree(info);
 =09=09return err;
 =09}
@@ -941,6 +946,7 @@ static int __init brf6150_init(void)
 =09=09       info->btinfo->host_wakeup_gpio);
 =09=09gpio_free(info->btinfo->reset_gpio);
 =09=09gpio_free(info->btinfo->bt_wakeup_gpio);
+=09=09tasklet_kill(&info->tx_task);
 =09=09kfree(info);
 =09=09return err;
 =09}
@@ -1027,6 +1033,7 @@ cleanup:
 =09gpio_free(info->btinfo->reset_gpio);
 =09gpio_free(info->btinfo->bt_wakeup_gpio);
 =09gpio_free(info->btinfo->host_wakeup_gpio);
+=09tasklet_kill(&info->tx_task);
 =09kfree(info);
=20
 =09return err;
@@ -1035,12 +1042,16 @@ cleanup:
 static void __exit brf6150_exit(void)
 {
 =09brf6150_hci_close(exit_info->hdev);
+=09hci_unregister_dev(exit_info->hdev);
 =09hci_free_dev(exit_info->hdev);
 =09gpio_free(exit_info->btinfo->reset_gpio);
 =09gpio_free(exit_info->btinfo->bt_wakeup_gpio);
 =09gpio_free(exit_info->btinfo->host_wakeup_gpio);
 =09free_irq(exit_info->irq, (void *)exit_info);
 =09free_irq(gpio_to_irq(exit_info->btinfo->host_wakeup_gpio), (void *)exit_=
info);
+=09tasklet_kill(&exit_info->tx_task);
+=09platform_device_unregister(&brf6150_device);
+=09platform_driver_unregister(&brf6150_driver);
 =09kfree(exit_info);
 }
=20
--=_5r9vyl0nzrsw--

