From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Mon, 14 Sep 2015 19:27:04 +0100
Message-ID: <20150914182704.GD12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AVLaZh4WnxHuffer"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441355402-6837-4-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--AVLaZh4WnxHuffer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 02:00:00PM +0530, Vignesh R wrote:

> +	if (spi->master->spi_mtd_mmap_read) {
> +		return  spi->master->spi_mtd_mmap_read(spi, from, len,
> +						       retlen, buf,
> +						       nor->read_opcode,
> +						       nor->addr_width,
> +						       dummy);
> +	}

We should be calling some API provided by the SPI core here, not peering
directly into the ops struture.

--AVLaZh4WnxHuffer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xF3AAoJECTWi3JdVIfQ5M0H/3yU9921hxdGY3rVvxGA70tH
O5QKkifeOiPHlY07/JO+G0HoyjHft+Q1TIQAarTtUzi/srLSIi9EcjEr7NsPG6dY
FXkypuw9y5lG7wzCPGVwo5dT6NcjpL09azm7jPYzAcysL+cI9FBgWMQBHWAsJyzw
WcVa/BQUrdiLJbH02U+xtf/cgoyzxvPpGhDRSYMlUMppsLZsJ0w4sxT94YC5u8aG
/dnKVA6OteHl5+SkyP1ZMKWWgkk7ZgucRHaSXQdB6olx+R5hlvnELw4rMJnVflv1
1Qcgl0/c2Cp9hldvBUSITIhXr2eLgi/Q4F2xpsy61B9TODNrjyWuUg3XrvUjnkA=
=eeIx
-----END PGP SIGNATURE-----

--AVLaZh4WnxHuffer--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
