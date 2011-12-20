From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] omap-serial: add RS485 mode support
Date: Tue, 20 Dec 2011 22:53:33 +0100
Message-ID: <20111220215333.GA6775@pengutronix.de>
References: <1324416212-10012-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41222 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab1LTVxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 16:53:34 -0500
Content-Disposition: inline
In-Reply-To: <1324416212-10012-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, sasha_d@emcraft.com


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2011 at 10:23:32PM +0100, Ilya Yanok wrote:

> Add support for asserting RTS line while TX is in progress. OMAP
> hardware doesn't support auto-RS485 mode so we control the line from
> software. We use TX_EMPTY_CTL_IT bit in SCR register to generate TX
> empty interrupt.

Sorry to bring bad news, but software RS485 is not mainlinable [1].
You can browse linux-serial for RS485 to find more threads about it.

Regards,

   Wolfram

[1] http://article.gmane.org/gmane.linux.serial/3619/

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7xA90ACgkQD27XaX1/VRtCTACfZxKBulFF3XyFIxpJ/vf+hy14
9jsAn04KXRYrLOMRyNahHdw/5LL+VYRK
=iACt
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
