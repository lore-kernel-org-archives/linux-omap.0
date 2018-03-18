From: Pavel Machek <pavel@ucw.cz>
Subject: 4.16-rc5 on Motorola Droid 4
Date: Sun, 18 Mar 2018 23:04:18 +0100
Message-ID: <20180318220418.GA22880@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have the phone, I have safestrap installed, kexec seems to work
(crashes my system). But I can't get any output from the new kernel.

All the howtos assume serial connection, but I don't yet have
that. I'm really bad at soldering. IIRC display should work in the
latest kernels, maybe with some patches?

Could someone give me .config and git hash that works for him? Once I
get working display I should be able to continue easily. I'd really
like to get voice calls working...

I took a brief look through dts, and I did not find anything that
could be easily used for debugging. (It seems that capslock LED and
keyboard backlight is not yet supported? Also volume down  seems to be
supported but not volume up, funny).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqu4mIACgkQMOfwapXb+vJ6UQCeISS+Gu2M4fPORKYEVg9c1Uci
gLwAmQGV6dJXHKA+tmri4Irwr6lUxNa1
=iPZk
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
