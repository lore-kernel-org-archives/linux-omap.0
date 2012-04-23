From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 09/10] I2C: OMAP: Do not set the XUDF if the underflow
 is not reached
Date: Mon, 23 Apr 2012 18:42:12 +0200
Message-ID: <20120423164212.GC27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38696 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab2DWQmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 12:42:14 -0400
Content-Disposition: inline
In-Reply-To: <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Alexander Shishkin <virtuoso@slind.org>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 06:58:20PM +0530, Shubhrajyoti D wrote:
> Currently in the 1.153 errata handling while waiting for transmitter
> underflow if NACK is got the XUDF flag is also set.
> The flag is set after wait for the condition is over.

What does XUDF mean? Please update the commit description, I can't know
all terminology for all architectures.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VhmQACgkQD27XaX1/VRtGWQCfXrA62qe8KQBK4zv9bWMF55WV
G5oAn3miWpokEDMH0sr0NhwCO3e64fOu
=s+mY
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
