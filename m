From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Enable backlight when trigger is activated
Date: Wed, 24 Jul 2019 10:33:55 +0200
Message-ID: <20190724083355.GA27716@amd>
References: <20190718190849.GA11409@amd>
 <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
 <20190722075032.GA27524@amd>
 <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, linux-leds@vger.kernel.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> +++ b/drivers/leds/trigger/ledtrig-backlight.c
> >>> @@ -114,6 +114,8 @@ static int bl_trig_activate(struct led_classdev *=
led)
> >>>  	n->old_status =3D UNBLANK;
> >>>  	n->notifier.notifier_call =3D fb_notifier_callback;
> >>> =20
> >>> +	led_set_brightness(led, LED_ON);
> >>> +
> >>
> >> This looks fishy.
> >>
> >> Maybe you should use a default-state =3D "keep" instead? (and you'll h=
ave
> >> to support it in the LED driver).
> >>
> >> That'll give you proper "don't touch the LED if it was turned on" beha=
vior,
> >> which is what you seem to want.
> >=20
> > Actually no, that's not what I want. LED should go on if the display
> > is active, as soon as trigger is activated.
> >=20
> > Unfortunately, I have see no good way to tell if the display is
> > active (and display is usually active when trigger is activated).
>=20
> default-state DT property can be also set to "on"
> (see Documentation/devicetree/bindings/leds/common.txt).

Yes, except that it does not work with all drivers :-(. In particular,
it does not work with lm3532.

We should really move more of the device tree parsing into core, so
that there's one place to fix...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04F/MACgkQMOfwapXb+vISagCfdaWbZQ6RjvGQ3Edw3INdzb04
i5gAoItfTEBcniDsblUC4rEvK/EzZthi
=NU1f
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
