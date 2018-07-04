From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Date: Wed, 4 Jul 2018 22:22:07 +0200
Message-ID: <20180704202207.GA15246@amd>
References: <20180621121542.GA4836@amd>
 <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com>
 <20180627205834.GB29478@amd>
 <20180628090655.GL112168@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628090655.GL112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> OK. I checked and duovero runs only at 600MHz. I can only
> get down to 19 seconds with omap2plus_defconfig if I disable
> CONFIG_CPU_FREQ so the max speed is maintained from bootloader.
> Otherwise it runs at most at 1GHz, I think any higher speeds
> need smartreflex and voltage scaling working which we don't
> have in the mainline kernel. Not sure what happens with higher
> speeds with mainline kernel or if they are unsafe in the long
> run.
>=20
> Anyways, care to post your .config somewhere so I can see what
> the numbers are for me with it?

After reboot (same config as in previous mail), before x / ofono /
unicsy_demo /... were started:

user@devuan:~$ uname -a
Linux devuan 4.18.0-rc3-88788-g528947b #758 SMP Wed Jul 4 10:05:21
CEST 2018 armv7l GNU/Linux
user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
| wc -c
10044041
11.50user 0.37system 11.57 (0m11.570s) elapsed 102.63%CPU
user@devuan:~$

droid 4.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9LG8ACgkQMOfwapXb+vKkBACguD2Wcgm4Fs4kre3F2DTv5R+f
BbYAn39a41KR/CDNWcpIq5PG4+ryFKzY
=PZbk
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
