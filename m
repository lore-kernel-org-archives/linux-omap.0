From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv3] i2c: omap: Move the remove constraint
Date: Fri, 16 Nov 2012 15:20:06 +0100
Message-ID: <20121116142006.GG7313@pengutronix.de>
References: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55666 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2KPOUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 09:20:08 -0500
Content-Disposition: inline
In-Reply-To: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 02:19:21PM +0530, Shubhrajyoti D wrote:
> Currently we just queue the transfer and release the
> qos constraints, however we do not wait for the transfer
> to complete to release the constraint. Move the remove
> constraint after the bus busy as we are sure that the
> transfers are completed by then.
>=20
> Acked-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Applied to for-next. Please let me know if it should go to for-current.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmS5YACgkQD27XaX1/VRtR2gCgxIntofypqUxRICxvLPFXg67c
Ou0AnjJjDP1A+/HAlOL9H92PAukcGXgw
=ZLDc
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
