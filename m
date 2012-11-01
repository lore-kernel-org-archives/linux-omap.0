From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Thu, 1 Nov 2012 23:23:16 +0100
Message-ID: <20121101222316.GC22956@pengutronix.de>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46388 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760695Ab2KAWXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 18:23:25 -0400
Content-Disposition: inline
In-Reply-To: <1351155648-20429-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 12:00:48PM +0300, Felipe Balbi wrote:
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
> ---
>=20
> This bug has been there forever, but it's quite annoying.
> I think it deserves being pushed upstream during this -rc
> cycle, but if Wolfram decides to wait until v3.8, I don't
> mind.

I would add this into 3.7, but what about the comments suggesting to use
barrier()?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCS9lQACgkQD27XaX1/VRve2QCgkBaAJ5+rXP1fEfGN9G5AYojd
YdkAoIxQq0KpGL1Xug51J8B0Bd7T7gm2
=2xu7
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
