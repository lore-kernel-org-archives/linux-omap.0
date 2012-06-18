From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv8 00/13] I2C cleanups
Date: Mon, 18 Jun 2012 17:33:36 +0200
Message-ID: <20120618153336.GD10768@pengutronix.de>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 08:00:15PM +0530, Shubhrajyoti D wrote:
>=20
> The patch series does the following
>=20
> - I2C register restore only if context if the context is lost
> - Bus busy recovery mechanism.
> - the reset is not done in init.
> - Adds a patch to use devm_* functions
> - Adds a pdata function pointer to do context save restore
> - Split the omap_i2c_isr to increase readability
> - Make the i2c use SET_RUNTIME_PM_OPS
> - Use INIT_COMPLETION instead of init_completion
> - Dropping a cleanup and taking few patchs Felipe's series as it may
>  not be needed.

Patches look mostly okay for me without knowing the platform too much.
For that reason, I'd be really appreciating Tested-by or even
Reviewed-by tags!

> This series mainly is the cleanups rebased on
> i2c-embedded/for-next branch.

Thanks.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/fSlAACgkQD27XaX1/VRuPSACfRL5irOgsgcH6d1iEVw5M31my
+AgAn1Rh5AWEarA2qLJdREWdDKeLUWCA
=FQcG
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
