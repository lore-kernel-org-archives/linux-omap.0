From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Mon, 24 Oct 2016 23:48:47 +0200
Message-ID: <201610242348.47484@pali>
References: <20161024212250.GA31336@amd> <20161024212932.uhjz752z2cy5hohl@atomide.com> <20161024214152.GA32310@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart16986840.ZGJVRzGtid";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024214152.GA32310@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart16986840.ZGJVRzGtid
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 24 October 2016 23:41:52 Pavel Machek wrote:
> On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> > Also, the shutdown voltage can depend on external devices
> > connected. It could be for example 3.3V depending on eMMC on some
> > devices while devices with no eMMC could have it at 3.0V.
>=20
> Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
> going below that is pretty mean to the battery. But if I set
> threshold too high, GSM activity will push it below that for a very
> short while, and I'll shutdown too soon.
>=20
> Ideas welcome...

bq27x00 has EDVF flag which means that battery is empty. Maemo with=20
bq27x00 driver is configured to issue system shutdown when EDVF is set.

Maybe kernel should issue emergency shutdown e.g. after minute or two=20
after EDVF flag is set?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart16986840.ZGJVRzGtid
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgOgb8ACgkQi/DJPQPkQ1J42wCeIqBcayIJa0aGXDxrcqMJJNNQ
9n4AoKNV1+kkLJxtRwlzWztF77ROqJ8N
=gZ2F
-----END PGP SIGNATURE-----

--nextPart16986840.ZGJVRzGtid--
