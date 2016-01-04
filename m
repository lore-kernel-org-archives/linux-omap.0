From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Tue, 5 Jan 2016 00:34:12 +0100
Message-ID: <201601050034.12810@pali>
References: <201507251228.27128@pali> <55BFB77C.6000208@bitmer.com> <55C0638F.30000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1907339.mtUAciBVlV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C0638F.30000@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

--nextPart1907339.mtUAciBVlV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 04 August 2015 09:02:39 Peter Ujfalusi wrote:
> On 08/03/2015 09:48 PM, Jarkko Nikula wrote:
> > It is well possible that some regression got introduced to
> > TPA6130A2 I2C communication over the years without nobody than you
> > now notices. We used to do QA back in Meego N900 days but that was
> > pre 3.x kernels.
>=20
> No major changes has been done to the tpa driver during the past
> years... I wanted to do some updates, like moving it to regmap, but
> as you said, n900 is the only user (and n9) and I do not feel
> comfortable to hack on a device where I do not have serial
> console... And I'm using the n900 time to time also.
>=20
> >> So maybe something similar? Kernel expects that some PM or
> >> regulator parts are initialized, but they are only sometimes?
> >> Just speculation...
> >=20
> > I'm thinking the same. I could figure SCL could be stuck low if TPA
> > or some other chip connected to the same I2C bus is without power
> > and is pulling I2C signals down.
>=20
> What would happen with the SCL stuck on i2c.2 bus if you remove the
> tpa driver from the kernel? If you remove the other drivers for the
> devices on i2c.2?

Hi Peter and Jarkko! Do you have some code samples for testing? Or=20
something else which I can test? This problem is still reproducible on=20
more N900 devices and I would like to see it fixed.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1907339.mtUAciBVlV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaLAXQACgkQi/DJPQPkQ1KHTgCgwqp1CmhZXTVWk1hrngJUp9Vq
PsMAoLxcu/yZTqKg8IxvN4MN29ElES2O
=jWRJ
-----END PGP SIGNATURE-----

--nextPart1907339.mtUAciBVlV--
