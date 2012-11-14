From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Wed, 14 Nov 2012 17:46:00 +0100
Message-ID: <20121114164600.GA1020@pengutronix.de>
References: <20121114112050.GG5954@pengutronix.de>
 <1352902965-25666-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53631 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KNQqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 11:46:04 -0500
Content-Disposition: inline
In-Reply-To: <1352902965-25666-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 04:22:45PM +0200, Felipe Balbi wrote:
> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
>=20
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
>=20
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
>=20
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied to for-current, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjysgACgkQD27XaX1/VRt0ygCeLKAAJi6/98/w5nbrO07/oo/R
LI8An3BcHpIUHjMmccsM9DQMIX5Bc+JA
=mHPm
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
