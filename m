From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Mon, 1 Jun 2015 16:58:25 +0200
Message-ID: <20150601145825.GA20557@lukather>
References: <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58897 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbbFAPAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 11:00:04 -0400
Content-Disposition: inline
In-Reply-To: <20150601140605.GA26908@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2015 at 04:06:06PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > But that's not what I'm asking. See a changelog of
> > > 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> > > actually does.
> > >=20
> > > It is buggy. If fuzz is specified but maximum is not, it overwites
> > > maximum with zero.
> >=20
> > If maximum is not set, you'll have other issues anyway. But it really
> > boils down on what the default behaviour should be.
>=20
> It was not broken before commit
> 3eea8b5d68c801fec788b411582b803463834752. Maximum was set, but after
> your patch, it is overwritten with zero.
>=20
> > > Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".
> >=20
> > It's not a new failure, it's testing against stupid code.
>=20
> Yes. In a commit marked "cleanup". We call this "undocumented
> feature".

It has never been said that it was a "cleanup" (whatever the double
quotes mean) but a rework. And it's not a feature either.

> > If an axis is setup in the DT but not registered in the driver,
> > something is wrong, most probably the DT.
>=20
> Yes, we have fixed the DT, so that bug you introduced will not happen
> on n900 with updated device tree.

s/updated/fixed/

> > > Plus it fails to distinguish between "value not specified in the dt"
> > > and "zero is specified in the dt".
> >=20
> > Again, default behaviour.
>=20
> Again, regression from 4.0 kernel, you are not willing to fix.
>
> > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> >=20
> > You were very welcome to review this patch at the time and/or suggest
> > a fix that pleases everyone.
>=20
> You should be the one that should suggest fixes, as you broke it in
> the first place. But clearly you don't understand that.

You actually never asked for a fix, and went head first calling this
patch "bad" and asking for nothing but reverting it.

It's not really a very good way to move forward and start a productive
discussion.

I'm sorry if this cause you any issues, but reverting this patch will
break users (and this time at the kernel level only, the DT has
nothing to do with that) just like you are right now.

What about:

-- >8 --
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/tou=
chscreen/of_touchscreen.c
index b82b5207c78b..7e98c2e443ab 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -14,10 +14,10 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
=20
-static u32 of_get_optional_u32(struct device_node *np,
+static int of_get_optional_u32(struct device_node *np,
 			       const char *property)
 {
-	u32 val =3D 0;
+	int val =3D -1;
=20
 	of_property_read_u32(np, property, &val);
=20
@@ -42,8 +42,12 @@ static void touchscreen_set_params(struct input_dev *dev,
 	}
=20
 	absinfo =3D &dev->absinfo[axis];
-	absinfo->maximum =3D max;
-	absinfo->fuzz =3D fuzz;
+
+	if (max >=3D 0)
+		absinfo->maximum =3D max;
+
+	if (fuzz >=3D 0)
+		absinfo->fuzz =3D fuzz;
 }
=20
 /**
@@ -57,7 +61,7 @@ static void touchscreen_set_params(struct input_dev *dev,
 void touchscreen_parse_of_params(struct input_dev *dev)
 {
 	struct device_node *np =3D dev->dev.parent->of_node;
-	u32 maximum, fuzz;
+	int maximum, fuzz;
=20
 	input_alloc_absinfo(dev);
 	if (!dev->absinfo)
-- >8 --

That reduces the max size of the screens, but I don't really expect the scr=
een
size to reach that order of magnitude before a few years...

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbHMRAAoJEBx+YmzsjxAgcZYP/jFmam836a2CDrj/e9f9vX2K
aKMRwA5vi8g6VaepK+nFJLXTPH/7mXh8JhNj1E6fiLL9cbPmYlpVa8uiZ8seyp+n
9apmsmKJ+lvAEzV4Sdl5yY/OV7T0e+f3Ern1dPiRhdWTVEKg2Q/EKew6vPZHMG2E
eMDnYDk09qbxVqAMb5gJHcnegFIl0wHdRcXTs8HvaIbIr31u8VRm9XQJwjEfHQZw
QJGR6DT4jrU6XI2S8Gz4+WOyP5f70TCVl69Jmq5a/a4m++DBMvbfZqMe2dOfB4rR
XO/+3VmZi0LfAP3+qYpAFJT35xoZcOJHIdJX2PYZmIFE00uiSdQIrr3Br+fAS8Xv
0XgaWbtPNxWOAYVJPsEPPoKQnMtzVGXhAtzUBGsD8culsFDoAPaE0+8ToctTFUsD
XqlOeYU5Cbj0lzAVYaAmo9lBgDRkeAHlyjnxn9Bg88hxfaAt5cN+7pGhKIyH55gh
pUpu0qU0TwIyDuKFM6L0xcqOnizQVAuwZ47jBZYuIBjSY9izrXEcDt1dwxDkCqUo
l4RuUqFRrD4IXnZtVsHGjlPEDrGh6xnTxV7BDfAdeaQ5nAUKvzNZxxLHY5RfBNix
FiQS8+DVgdmUlAeH5B51RaJQGcSz9LrDWZ8oCaWmTwwuOvWxU+RiVG2qVfRDU+5E
h5ELnhga3oDeT1Qy/t+3
=ZtUy
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
