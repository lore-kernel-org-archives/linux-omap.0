From: NeilBrown <neilb@suse.de>
Subject: Re: twl4030_charger seems to be broken by switch from 'notifier' to
 'mailbox'.
Date: Sat, 15 Dec 2012 11:17:38 +1100
Message-ID: <20121215111738.1be514af@notabene.brown>
References: <20121214200427.2405f30a@notabene.brown>
	<20121214093659.GB14997@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ZAgiCVgB2K./T1+0CUQ+Kn8"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797Ab2LOARz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 19:17:55 -0500
In-Reply-To: <20121214093659.GB14997@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org

--Sig_/ZAgiCVgB2K./T1+0CUQ+Kn8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Dec 2012 11:36:59 +0200 Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>=20
> On Fri, Dec 14, 2012 at 08:04:27PM +1100, NeilBrown wrote:
> >  this commit:
> >=20
> > commit c9721438c009adf8e81d376839ed037c53b9b8d9
> > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > Date:   Fri Jun 22 17:40:52 2012 +0530
> >=20
> >     usb: musb: twl: use mailbox API to send VBUS or ID events
> >    =20
> >     The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID eve=
nts,
> >     is replaced by a direct call to omap musb blue.
> >    =20
> >     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >     Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> >=20
> > Seems to have broken twl4030_charger.c.
> > This code relies on the notifier to know when the USB has been plugged =
in and
> > so it should consider enabling the charger.
> >=20
> > now that the notification has gone, the charger never turns on.
> >=20
> > If I put the atomic_notifier_call_chain() calls back in, then the charg=
er is
> > activated as appropriate.
> >=20
> > What is the plan here?  Should the calls go back, or is there some way =
for
> > twl4030_charger to hook into the "mailbox"?  Or is there some other way=
 it
> > should work?
>=20
> hmmm, tricky situation. Maybe we add back the notifer calls but keep the
> mailbox API ?
>=20

Maybe.  This is my current patch.  I'm not entirely confident about the
mapping from omap_musb_vbus_id_status to usb_phy_events.

Thanks,
NeilBrown


=46rom ffafe1fe4da3c848631c082f70745017c03e23bf Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Sat, 15 Dec 2012 10:35:37 +1100
Subject: [PATCH] twl4030-usb - re-instate event notifications

commit c9721438c009adf8e81d376839ed037c53b9b8d9
    usb: musb: twl: use mailbox API to send VBUS or ID events

went a bit too far in removing all event notification
from twl4030-usb.  The notifications are still needed for
twl4030_charger.c to know when to enable the charger.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index f0d2e75..15733f9 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -38,6 +38,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
+#include <linux/notifier.h>
 #include <linux/slab.h>
=20
 /* Register defines */
@@ -388,6 +389,28 @@ static void twl4030_phy_power(struct twl4030_usb *twl,=
 int on)
 	}
 }
=20
+static void do_notify(struct twl4030_usb *twl,
+		      enum omap_musb_vbus_id_status status)
+{
+	enum usb_phy_events event;
+
+	switch (status) {
+	case OMAP_MUSB_UNKNOWN:
+		event =3D USB_EVENT_NONE; break;
+	case OMAP_MUSB_ID_GROUND:
+		event =3D USB_EVENT_ID; break;
+	case OMAP_MUSB_ID_FLOAT:
+		event =3D USB_EVENT_NONE; break;
+	case OMAP_MUSB_VBUS_VALID:
+		event =3D USB_EVENT_VBUS; break;
+	case OMAP_MUSB_VBUS_OFF:
+		event =3D USB_EVENT_NONE; break;
+	}
+
+	atomic_notifier_call_chain(&twl->phy.notifier, event,
+				   twl->phy.otg->gadget);
+}
+
 static void twl4030_phy_suspend(struct twl4030_usb *twl, int controller_of=
f)
 {
 	if (twl->asleep)
@@ -514,6 +537,7 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 			twl4030_phy_suspend(twl, 0);
 		else
 			twl4030_phy_resume(twl);
+		do_notify(twl, status);
=20
 		omap_musb_mailbox(twl->linkstat);
 	}
@@ -537,6 +561,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *tw=
l)
 			twl->asleep =3D 0;
 		}
=20
+		do_notify(twl, status);
 		omap_musb_mailbox(twl->linkstat);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
@@ -634,6 +659,8 @@ static int __devinit twl4030_usb_probe(struct platform_=
device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
=20
+	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
+
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
 	 *

--Sig_/ZAgiCVgB2K./T1+0CUQ+Kn8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUMvBojnsnt1WYoG5AQLI2Q//dhsESqZSaBc2Ej2i5pMZ+fSRNGfc5fl9
gJufdx9/+94nry3mRjamcMsLuOhKKHiybIkx4FkxDGEfd0EpJF7DhDxxB7NUAxFS
LPdoY7GlkPTaSM1P2qAmvRAt26FGSuF+6BFxUVpHzKPpBx3Vx9ZMySGtpZRUehSO
r/qVg901YoAdLrc33EmHxalapBSMMbNPgzK3nUJ+0iWsWW/86io/2qHoeiZ3YHXt
1U8MGQpV/z41LyXfzfB3ghyQl6R25fv1b+WakqJSUQSJoE0wsIJOTdf236v6zxtm
Eav4SShqy6bFbagOphJdhgIeLzbDhizGtUiFLtZUv9EYdT1UOsfxtqhzOqT6HotT
d8ApIfW1eYYr+8SYbxjbyYgJFELrpFXtWutGYj2CvU6nYkWTmcrfgzqHpOu0y/ys
WNwioSNfnsUoktpYsLOj8dJJnHip9tCbLcl/EC3MgmVG9tFhxttIgBOt/p9N0LSM
pJKLI2UjiGKc7LBBbHozK8PMVFIYkoLD1c+K06c+zG358Hc6deMATKXV8U7Bswjq
BVRzLk2xEyKOLx0euvdSSBHRc1G9SHjvoUcI2PrD7PxVWJjFR9pnYiZlhW7kS0xw
PQK9yz4vtMd0lVFjrlrvEgRvANbFRZ0xXjO0pK7we7Y1ZFWx1bb80ji03E6JO7Cb
ecfQhheVSSk=
=yHiu
-----END PGP SIGNATURE-----

--Sig_/ZAgiCVgB2K./T1+0CUQ+Kn8--
