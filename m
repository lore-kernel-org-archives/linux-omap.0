From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply fix for 4.4
Date: Fri, 6 Nov 2015 21:29:03 +0100
Message-ID: <20151106202902.GA13762@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3e069adabc9487b5e28065a17e6a228da3412dfd:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2015-11-06 11:57:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.4-important-fix

for you to fetch changes up to 829a7da03fd5f94c3a3ee1f8e22371e81cf73c79:

  Revert "ARM: dts: twl4030: Add iio properties for bci subnode" (2015-11-06 21:17:53 +0100)

----------------------------------------------------------------
power supply fixes for the v4.4 series

Just a single revert for a patch, that I should not have queued.
More detailed description is inside the patch. It's totally my
fault, that this happened, sorry about that :(

----------------------------------------------------------------
Sebastian Reichel (1):
      Revert "ARM: dts: twl4030: Add iio properties for bci subnode"

 arch/arm/boot/dts/twl4030.dtsi | 2 --
 1 file changed, 2 deletions(-)

-- Sebastian

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWPQ2OAAoJENju1/PIO/qaJw8P/0QfeNeO0eCSwYdBF1FWtwEw
uofsPDhDKZh+XoksKguVLtklb2R6TSFTq0qGfRTc0+l9hEEXyp6HJ+rkUVTi6f+n
CMzx5dXmKwHB3zaCpEl0l8U+yDoLx//8a/ck2nIorh2aIWahpj4innE1SWxnVEXv
3NnlW5XpGdRaqM0U2oRQjAe31XzoQyvxHawhaAzjyowTla7XsPaTlqK7DnkDwDLM
XQnbwVtDfrk/URRGlyi+0klI3JIpL7HWpdoSHcfOuq7sWNd7PVIYhMTrsztz4klf
neTE+5HbRCBfdIPX23ZaciSJNpbjaO4yusSUYIDAXlts8iMWT+n6Gt49LBe5lor7
smYsyuPMfNdypc5+RG1zupyjHqUvQeZx7ou6AzwdLqd82u2LU/scR8Mik2qiFZRy
fb6AzTmmNjuspQhpkQbjNtFXkMMOZZt/Aj+f71pxlYZn8mi4mX/yd4xMY0HQZuC4
g3VK+EELpNTvpYsnB7TN2ERVkfwHmDdNiRy2jNJONiOcTiKsB+MSX/62HxmjmjFh
KaXHlxUc3+73jnAP4FfD6k3YGOsauweAA0fr8dsvSmDGiNoL75yUQ+H3uI0KPiO3
ObLd2WKq4n9ei/0BwEcKQVLgzZdI5Uzf4vYkc5TzrDSX9BKjVfCGBuTpCGz2E+cQ
b7WOJx1vzXClBCs/iD9a
=LBaA
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
