From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv11 5/6] i2c: omap: Correct I2C revision for OMAP3
Date: Thu, 12 Jul 2012 14:21:09 +0200
Message-ID: <20120712122109.GE2194@pengutronix.de>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340896292-12112-6-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 08:41:31PM +0530, Shubhrajyoti D wrote:
> From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>=20
> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> revision is the same for 3430 and 3530. However, the OMAP3630 device has =
the
> same I2C revision as OMAP4. Correct the revision definition to reflect th=
is.
>=20
> This patch is based on work done by Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Changes from his patch
> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
>=20
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Applied to next, thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+wTUACgkQD27XaX1/VRvZnACfXzaxCc50+BPWTAKIi8QVMFlM
wYEAninQ7KDgs8d8O3m1WAHhRA506gV/
=ERm1
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
