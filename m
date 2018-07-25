From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4: suspend to RAM?
Date: Wed, 25 Jul 2018 22:02:05 +0200
Message-ID: <20180725200205.GA29594@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
have no idea why. Second is power consumption -- it seems to be rather
high even before modem (and thus USB) is enabled.

Interestingly, CyanogenMod and Jolla seem to have higher power
consumption than stock operating system.

(My Linux can survive for 10 hours, stock system could survive for 4
days if I'm not mistaken).

I thought I would experiment with suspend to RAM.. and it indeed
seemed to suspend ok, but I could not wake it up. Do I need to set up
wakeup with button somehow? Is suspend to RAM required for good power
consumption?

Best regards,								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltY1z0ACgkQMOfwapXb+vKsdQCfXWEMTjEB61nbc4AfE4BXvBmI
DQgAoKVMRru93oblVP5zv8M7sMjTe6hX
=yGlm
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
