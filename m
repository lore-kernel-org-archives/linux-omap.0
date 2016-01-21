From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns back on
Date: Thu, 21 Jan 2016 20:34:07 +0100
Message-ID: <201601212034.07727@pali>
References: <20160121184234.GA17679@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1692836.PSnzyFpy5v";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121184234.GA17679@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, sre@kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1692836.PSnzyFpy5v
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 21 January 2016 19:42:34 Pavel Machek wrote:
> Hi!
>=20
> In 4.4, n900 battery charging works. If indicator is turned off, it
> stays off, and if I select 1.8A charge, it sticks. (There may be
> problems after system suspend and resume. But normal operation seems
> to be pretty reliable).

Hm... right, bq2415x driver does not have support for suspend/resume.=20
Before suspend registers should be stored and after resume restored,=20
plus check charger auto detection.

> In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery
> charging works for few hours. But then indicator (yellow light on
> 3color LED) turns back on, and if I ask for 1.8A charge, it goes
> back to .1A, discharging battery.
>=20
> Any ideas?

Look into bq24150a sysfs node what changes. Also if there is something=20
in dmesg.

> Best regards,
> 									Pavel


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1692836.PSnzyFpy5v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlahMq8ACgkQi/DJPQPkQ1LKFACeOW5IHwz1muFLmI7vBBXPIO8W
TzEAnifTCLCd6KmALkD8H02NAMqHwd4x
=8sTb
-----END PGP SIGNATURE-----

--nextPart1692836.PSnzyFpy5v--
