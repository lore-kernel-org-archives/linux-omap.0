From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 17:36:06 +0100
Message-ID: <20161110163606.GD28832@amd>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <d2941e6f-d277-a68d-2837-00b628dd3be7@redhat.com>
 <7cc1ba55-1bd0-ae3f-5c9b-f16efb8dcc80@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7cc1ba55-1bd0-ae3f-5c9b-f16efb8dcc80@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >>>The current docs say not about (sw) blinking, but that should be treat=
ed
> >>>just
> >>>like a trigger IMHO.
> >>
> >>You'r right, we should describe the semantics on reading, but it would
> >>have to be as follows:
> >>
> >>Reading from this file returns LED brightness at given moment, i.e.
> >>even though LED class device brightness setting is greater than 0, the
> >>momentary brightness can be 0 if the readout occurred during low phase
> >>of blink cycle.
> >
> >Why would it need to read like this, because this is the current behavio=
r ?
>=20
> We have led_update_brightness() which was introduced long time ago and
> is used in brightness_show(). Note that if LED controller changed
> actual LED brightness e.g. due to battery voltage dropping below
> certain threshold, we wouldn't be able to find it out otherwise
> (except if we added separate sysfs file for that).

And we should have a separate sysfs file for that. Note that on some
hardware leds, you are able to let hardware control them, but if you
do, you can't really tell the current state. Examples are n900 and
thinkpad-acpi. So it is better we don't pretend we can get that value
for userspace.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgkofYACgkQMOfwapXb+vJZAgCgpeZKks6yw8bm7Pg1TBobhYMN
dagAoLC7Q4i37KVwL/KgqQvBLcyZIoSx
=3Nms
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
