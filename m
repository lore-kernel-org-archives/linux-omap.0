From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency
 constraints
Date: Sat, 6 Oct 2012 13:46:14 +0200
Message-ID: <20121006114614.GB10164@pengutronix.de>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2012 at 06:08:03PM +0200, Jean Pihet wrote:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATE=
NCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>=20
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
>=20
> Signed-off-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>

Applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBwGgUACgkQD27XaX1/VRvgngCfcfkDWK/FdK+HjbKVq/Bl5/GJ
HiQAn1veQAvl4OTensBE133GKXxRzKbR
=Gfq7
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
