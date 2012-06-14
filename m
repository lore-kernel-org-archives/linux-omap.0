From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 00/17] Big OMAP I2C Cleanup
Date: Thu, 14 Jun 2012 19:59:50 +0200
Message-ID: <20120614175950.GE14419@pengutronix.de>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50710 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab2FNSAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 14:00:08 -0400
Content-Disposition: inline
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 07:24:10PM +0300, Felipe Balbi wrote:
> Hi guys,
>=20
> I have dropped a few patches from the series and also
> tested every single patch on my pandaboard. I2C messages
> are still working fine with panda after each patch.
>=20
> There's still lots of work to be done on the i2c-omap.c
> driver but it's now easier to read, IMO.
>=20
> Changes since v1:
> 	- removed tabification on patch 6/17
> 	- removed dev_err() which was introduced on patch 09/17

To prevent the list being flooded, I would appreciate if you could wait
a few days to collect reviews before resending. It will take some time
until I pick this series anyhow, because I want people to have time to
donate Tested-by tags.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/aJpYACgkQD27XaX1/VRtM3gCfZY41dY4bD+w/iHITlDLm3VOV
Ww4AnidaJyBM8GHHLfCi+4FgLmS8Pawr
=g4ZL
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
