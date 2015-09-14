From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Mon, 14 Sep 2015 19:35:53 +0100
Message-ID: <20150914183553.GE12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TbSr5s+wTV5WAS2d"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RT8Q+Uyp1ZjzHf54Tno1wHm0SmLKEwRAe2gkdp772FD9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--TbSr5s+wTV5WAS2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 04:55:33PM +0530, Jagan Teki wrote:
> On 4 September 2015 at 13:59, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:

> > + * @spi_mtd_mmap_read: some spi-controller hardwares provide memory
> > + *                     mapped interface to communicate with mtd flashes.
> > + *                     For this, spi  controller needs to know flash
> > + *                     memory settings like read command to use, dummy
> > + *                     bytes and address width. Once these settings are
> > + *                     populated in hardware registers, any read
> > + *                     accesses to flash's memory map region(as defined
> > + *                     by SoC) through memcpy or mem-to-mem DMA copy
> > + *                     will be handled by controller hardware. The
> > + *                     hardware will automatically generate spi signals
> > + *                     required to read data from flash and present it
> > + *                     to CPU or DMA. SPI master drivers can use this
> > + *                     callback to implement memory mapped read
> > + *                     interface. Flash driver (like m25p80) requests
> > + *                     memory mapped read via this method. The interface
> > + *                     should  only be used mtd flashes and cannot be
> > + *                     used with other spi devices.

This comment is *way* too verbose - probably you just need up to the
"Once" here.

> > +       int (*spi_mtd_mmap_read)(struct  spi_device *spi,
> > +                                loff_t from, size_t len, size_t *retlen,
> > +                                u_char *buf, u8 read_opcode,
> > +                                u8 addr_width, u8 dummy_bytes);

> This looks un-manageable to know spi core or master knows what are the
> command or opcode used by spi-nor flash and also I think mmap support
> seems to be flash related or any justification this is spi bus
> master/controller feature?

There seem to be a reasonable number of SPI controllers out there which
have as an extension the ability to do memory mapped reads but are
otherwise perfectly normal SPI controllers and which rely on that for
everything except reads.

--TbSr5s+wTV5WAS2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xOIAAoJECTWi3JdVIfQqgcH/3Ekg6pdRGJdZXUWeq96lbf2
RqMNZrClp0GhaW2FGFFNKqNIFMMLB37lSaZHsONuauahceTqeVeFRnsXzv4xn3vB
x9ou9s5XFCJ33J4U2cSD60lG3+DFerOYTyX455Tak0hD7nm88uPw7BRqkF35+wIN
2Rxp1IRMrIYSJ590yes2gCYbzsiTSAZ2PBFHJCmNNtRstGZkKmQEgjFNtBOnzu+7
rLxdsovxNA4LP1Xk8838RQqcfwCZcC+NS5SV6P1rCcGaV3G0UKI3OwYApvY6nJBI
o99K7Mg9++onPyoZYQPy+S9d/quYmDk8Go6pYD3zAg23DIhXVge863oAl6bOkUI=
=EWog
-----END PGP SIGNATURE-----

--TbSr5s+wTV5WAS2d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
