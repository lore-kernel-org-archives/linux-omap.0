From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 4 Nov 2015 14:39:15 +0000
Message-ID: <20151104143915.GI1717@sirena.org.uk>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446545174-14193-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2015 at 03:36:10PM +0530, Vignesh R wrote:

> +	}
> +	mutex_lock(&master->mmap_lock_mutex);
> +	ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
> +					read_opcode, addr_width,
> +					dummy_bytes);
> +	mutex_unlock(&master->mmap_lock_mutex);
> +	if (master->auto_runtime_pm)
> +		pm_runtime_put(master->dev.parent);

It's a bit worrying that this doesn't sync with the message queue except
via the mutex: this means that we might be out of order with respect to
any asynchronous transfers that are happening on the device.  I'm not
sure that this is a practical problem, though there is some risk of
unfair scheduling that would have to be under extreme load and it might
make sense to prioritise reads anyway.

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhiSAAoJECTWi3JdVIfQTRUH/1uWG9cTPuPv1CXknjCrEk6G
OVAeJ52giZk1ODMqpPShiAn/Juf3zrceIoBtTd76Avd75I0ez05D71T7KgRhLEOG
ZWnXnsgRnHDxOJ/47pKeqO3tYv5ftylQ93541fJ+RsJq6q5ICUnI1SpC6aNMkt/F
lEVgVhDW+6bXFU9bxej1O7GD2YNAAd9sqoWNBS0m118wMa/fyRkfmG0FuaUQTtJ+
2PQHn4T+uKxDzqQtNbRbC05vg8xMsALZx6r1o1Zbih8IKmJ4EzjEpTg0dsMtl96U
KKYMxXY14Xd0/ejdY7uEJovZyGk75HIe2I8v0bQD4ye9GJdId/ebtKqBIt4r+8g=
=l/Wm
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
