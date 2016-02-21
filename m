From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Sun, 21 Feb 2016 12:12:49 +0100
Message-ID: <201602211212.49460@pali>
References: <201601091616.04193@pali> <20160126143450.GG25796@pali> <20160126172631.GZ19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4514341.u3sHogkbOi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160126172631.GZ19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart4514341.u3sHogkbOi
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160126 06:35]:
> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
> > > * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
> > > > > Do you have some pointer
> > > > > to the "certain resistor value on ID to GND" spec? Is it
> > > > > maybe part of the carkit related parts of the USB spec?
> > > >=20
> > > > ""Three additional ID pin states are defined[4] at the nominal
> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9, wit=
h respect
> > > > to the ground pin. These permit the device to work with USB
> > > > Accessory Charger Adapters that allows the OTG device to be
> > > > attached to both a charger and another device simultaneously.
> > > > [6]""
> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs
> > >=20
> > > OK thanks. So it's the "accessory charger" part of the
> > > battery charging specification 1.1.
> >=20
> > So, Tony, do you have some idea what needs to be changed and how to
> > fix peripheral mode after boot on Nokia N900?
>=20
> No, I'm waiting to hear an educated guess from Felipe on this one.

PING! Still no answer.
=46elipe changed email address.

> > First I would like to have fully working peripheral mode on Nokia
> > N900 and then we can try to hack host mode (if possible).
> >=20
> > But peripheral mode is a must due to development, because it
> > provides usb network or usb tty.
>=20
> Totally.
>=20
> Regards,
>=20
> Tony

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4514341.u3sHogkbOi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlbJm7EACgkQi/DJPQPkQ1KnXwCfVaTL+1gibc3lpZR3R0lNqtMd
jVEAniAAi6ef+6syL+Wp659YItYwb0Rc
=mgRx
-----END PGP SIGNATURE-----

--nextPart4514341.u3sHogkbOi--
