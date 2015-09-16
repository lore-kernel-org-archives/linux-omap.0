From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 16 Sep 2015 16:24:21 +0100
Message-ID: <20150916152421.GL11268@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
 <20150914183553.GE12027@sirena.org.uk>
 <CAD6G_RQOazkS7KHrG75wgMXx1cH_pKjx43Mve6fz1qOJGPpq9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RQOazkS7KHrG75wgMXx1cH_pKjx43Mve6fz1qOJGPpq9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2015 at 06:16:55PM +0530, Jagan Teki wrote:
> On 15 September 2015 at 00:05, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > There seem to be a reasonable number of SPI controllers out there which
> > have as an extension the ability to do memory mapped reads but are
> > otherwise perfectly normal SPI controllers and which rely on that for
> > everything except reads.

> This is true, but exposing direct spi-nor arguments or features like
> read_opcode, addr_width or dummy_byte to spi layer isn't fine? because
> for spi layer there is a spi to flash transition mtd m25p80.c is there
> to handle is it?

The m25p80 driver is a generic, SPI level piece of code not a driver for
specific controller hardware.  The controller hardware drivers live in
the SPI subsystem.  In order to support this memory mapped feature we
need the controller drivers to expose an interface for controlling it.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+YmkAAoJECTWi3JdVIfQHf0IAIACpwZyIQQHENTwLqckYkld
Dh8gtSVtQ5ONVXG6fKdztQivwKTFw4Kh/BcmQYMUv6Glf/dhPHOA5dhDF+AmbRUb
Ld7f06b6n4aAk3URhR2EEFJSlCpHGcz099t6VONILlPss+N7/x4kZcHbGEs6DQvu
omKwGZN3UsLJiSKcibZiJjCzbBFcyf0rtv1RA6PzbO7jt4TeDHZ/4fM8wZ81jc89
onYapT+fWg8i7A8EwAeWSaPi3rQny1dZZ/MiCZqEZnrHFcTd7zMPI08TK6r4hsHN
CI6iVWgwxGgZX1XGUP9hMR6tDLu0CwAoK7N/RlMrZFI2gkggs8he3c4dbmDLM2s=
=F3z7
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
