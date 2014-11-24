From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.18-rc1: n900 battery discharged down to 2.97V
Date: Mon, 24 Nov 2014 19:58:34 +0100
Message-ID: <201411241958.34578@pali>
References: <20141124183130.GA2927@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart24860448.4cI6gHVUIl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141124183130.GA2927@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

--nextPart24860448.4cI6gHVUIl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 24 November 2014 19:31:30 Pavel Machek wrote:
> Hi!
>=20
> I left the machine on usb-networking for extended period of
> time. Unfortunately, Xfce screensaver kept screen busy, and
> kernel failed to kill the machine.
>=20
> At the end, hardware protections worked (I guess), but result
> is battery discharged down to 2.97V.
>=20
> Best regards,
> 									Pavel

So you need some program which will monitor battery status and=20
when battery status is empty it should turn of device.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart24860448.4cI6gHVUIl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRzf9oACgkQi/DJPQPkQ1JlVACeORqh+refDqK0v1R/2K1DtpJp
Vc8AnjO0jGEMnMaQK5/brlIolL7TOF1i
=Notd
-----END PGP SIGNATURE-----

--nextPart24860448.4cI6gHVUIl--
