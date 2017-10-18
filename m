From: Mark Brown <broonie@kernel.org>
Subject: linux-next: manual merge of the usb-gadget tree with the usb tree
Date: Wed, 18 Oct 2017 15:49:12 +0100
Message-ID: <20171018144912.qlc7vlnhdqmr5tdd@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5d7v5p6ug5xmult"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allen Pais <allen.lkml@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--o5d7v5p6ug5xmult
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

Today's linux-next merge of the usb-gadget tree got a conflict in:

  drivers/usb/phy/phy-isp1301-omap.c

between commit:

  4c13fec1ba55595 ("usb: isp1301-omap: Convert timers to use timer_setup()")

=66rom the usb tree and commit:

  687f272c6b0e89d ("usb: phy: omap: use setup_timer() helper.")

=66rom the usb-gadget tree.

I fixed it up with the USB version and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--o5d7v5p6ug5xmult
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnnaecACgkQJNaLcl1U
h9BCcQf/WCV3dUsTxQDAv08RrOAkfGjHKDPDaj2qBwuurvZkG1AlNWTGq0DArw3a
g5rKFGxOSp4gTUvTmU2Sj5QY8QoPYV5XyERrxTmJlHVp0d4gZytB7rsrs2POmBfs
ooiPKncoYgScbs3GvoVlTTAaVBlxwDWeXcOUH07Xph4UplNoL3Or/k8LytFpJ26M
0b0Zy1bT58GiHka+ZpN/xH4SosLT75UF3l+L4H1O8Ro3IawORkadCH70MLmy45zN
DB3iiL540MsIGN3xiwKuOJWsODO64u+piwesTa01PhOwDl6HEnjSuRNpkqDMojyh
5bnh76l61e9+DiYlSOKkem6l0idalQ==
=4yl8
-----END PGP SIGNATURE-----

--o5d7v5p6ug5xmult--
