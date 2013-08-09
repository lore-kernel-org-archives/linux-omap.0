From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [GIT PULL, FOR LINUX-OMAP] usb: nop phy rename
Date: Fri, 9 Aug 2013 17:28:25 +0300
Message-ID: <20130809142824.GO12041@radagast>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w6U88vdWm8UqIXvc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--w6U88vdWm8UqIXvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

here's a pull request of one patch to avoid conflicts during the merge
window.

Please consider applying to your tree and I'll take this same patch
upstream.

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git nop-phy-rename

for you to fetch changes up to 3fa4d7344be0afebd80382ffeea6b1787cccf971:

  usb: phy: rename nop_usb_xceiv =3D> usb_phy_gen_xceiv (2013-08-09 17:26:0=
0 +0300)

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      usb: phy: rename nop_usb_xceiv =3D> usb_phy_gen_xceiv

 arch/arm/mach-omap2/board-omap3beagle.c            |  4 +-
 arch/arm/mach-omap2/board-omap3evm.c               |  4 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |  2 +-
 arch/arm/mach-omap2/usb-host.c                     | 10 ++---
 drivers/usb/dwc3/dwc3-exynos.c                     |  8 ++--
 drivers/usb/dwc3/dwc3-pci.c                        |  8 ++--
 drivers/usb/musb/am35x.c                           |  2 +-
 drivers/usb/musb/blackfin.c                        |  2 +-
 drivers/usb/musb/da8xx.c                           |  2 +-
 drivers/usb/musb/davinci.c                         |  2 +-
 drivers/usb/musb/musb_dsps.c                       |  2 +-
 drivers/usb/musb/tusb6010.c                        |  2 +-
 drivers/usb/phy/Makefile                           |  2 +-
 drivers/usb/phy/{phy-nop.c =3D> phy-generic.c}       | 44 +++++++++++-----=
------
 .../usb/{nop-usb-xceiv.h =3D> usb_phy_gen_xceiv.h}   |  4 +-
 15 files changed, 49 insertions(+), 49 deletions(-)
 rename drivers/usb/phy/{phy-nop.c =3D> phy-generic.c} (83%)
 rename include/linux/usb/{nop-usb-xceiv.h =3D> usb_phy_gen_xceiv.h} (81%)

--=20
balbi

--w6U88vdWm8UqIXvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSBPyIAAoJEIaOsuA1yqREhZkP/i6yU2beGP/k8Ou559VwKdH8
m200CvoCcl9gAU/2h97lDmiosfIJrESwnscfeNTblvA0uS8jhjljNeMjNRNP95Oh
r4tZ8NYIwSmwET6hzHEj+hhoB+3TXTZqssSe8Z3KCVeWse5R3rEhsTzBI3OhbXvA
2A2e4cyPhushtRYJ0eSrhT5Y9Q8Vvv7hC4TrpSXOKTJH4jnWvI/kDw6fO+yHRXMv
aQGw4kQofFONCpI/Ma1d+schuTvmDfRSbI7/Me5quhpv7dbEvoGxLGtQgBYQ95f0
aJJIW7+aqYvUWSOglFAbhkwVrFWc5hNVO/dP1gauUmr/Kxr9u2p8m3pXi9aajH13
FhprQ9AXGDVlelmcnOZdNGpat/guUEF6e7jiG52jx9jdJugK8LOW83tb2xYlcJsE
aS1tliewqoj6oMpfUzcCgAUj1uRl5J0hNSslwY07H9bgimahsLNVcb+g7ky9yPO5
Jv6PJzPLeaInqKKch//ib8JYB8mK0r7AJmy3/n5juFO/Eh3cFrlGYoAhk5al4QPI
ARoz6M60h/HZhsCMzTfJ1BTh3gKtZCYINILsw/fzxNS/R5hjQbioc3dLuyagKvw+
OohgzUKOrstyZHemOMhC1WkTRF7oXRKfbNSKZ8SIeZf+Nj28bPwZ9fhUCfvSkcC7
XUw8V3symn/Lynjqfn5+
=j/LW
-----END PGP SIGNATURE-----

--w6U88vdWm8UqIXvc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
