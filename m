From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4: poweroff reboots the machine
Date: Fri, 10 Aug 2018 12:45:58 +0200
Message-ID: <20180810104558.GA5198@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On droid4, "sudo poweroff" reboots the system... which is not exactly
welcome, because mainline kernel will discharge the battery in 10
hours.

I learned to reboot into stock Motorola Android (lasts few days), but
that takes some clicking; easier solution is powering it off in
SafeStrap ... which thankfully works.

But those are workarounds, if someone knows how to debug/fix it, let
me know.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlttbOYACgkQMOfwapXb+vL1KACfVxacOUHkeofM3NRIgejR1PXb
3W4AnjsOigXg7fDPS39GooLsPlJZRumH
=cmpW
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
