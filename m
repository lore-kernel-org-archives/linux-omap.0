From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 17:46:56 +0100
Message-ID: <20150806164656.GY20873@sirena.org.uk>
References: <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
 <55C35233.2000105@ti.com>
 <20150806135129.GJ7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pwuPNfS0paSTjpGn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150806135129.GJ7576-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--pwuPNfS0paSTjpGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 02:51:29PM +0100, Russell King - ARM Linux wrote:

> The M25P80 driver just appends additional bytes to the message to
> achieve this:
>=20
>         struct m25p *flash =3D nor->priv;
>         unsigned int dummy =3D nor->read_dummy;
>=20
>         /* convert the dummy cycles to the number of bytes */
>         dummy /=3D 8;
>=20
>         flash->command[0] =3D nor->read_opcode;
>         m25p_addr2cmd(nor, from, flash->command);
>=20
>         t[0].tx_buf =3D flash->command;
>         t[0].len =3D m25p_cmdsz(nor) + dummy;
>         spi_message_add_tail(&t[0], &m);

> The reason that the number of dummy bytes can't be detected is because
> it's all hidden in the first transaction as the total number of bytes to
> be transmitted - and the dummy bytes are uninitialised, so you can't
> make any assumptions what value they are.  There is no way for the SPI
> driver to know whether these dummy bytes are dummy bytes or whether they
> have an effect on the targetted device.

We *could* (as you suggest below) indicate dummy transfers by having a
separate transfer which omits the transmit buffers though I'd expect
that normally that is going to be a small performance hit if interpreted
directly so we need to think what to do there.  We do get other devices
sending dummy bytes, it's sometimes a requirement for high speed
register access to give settling time for the device, so other things
would get some milage from it.

> What may make more sense from the SPI point of view is to communicate to
> all SPI drivers how many dummy bytes are to be transferred.  I'm not fully
> up on SPI, but maybe something like this:

> 	t[0].tx_buf =3D flash->command;
> 	t[0].len =3D m25p_cmdsz(nor);
> 	spi_message_add_tail(&t[0], &m);
> 	t[1].tx_buf =3D dummy_buffer;
> 	t[1].len =3D dummy;
> 	t[1].dummy =3D 1;
> 	spi_message_add_tail(&t[1], &m);

> This way, we're describing the transfer to the SPI core, and explicitly
> indicating that there are some dummy bytes.  The SPI driver can then
> tell that these are dummy bytes, and if the SPI message consists of:

That'd work as well, my first thought would to use NULL as a dummy
buffer pointer and let the core substitute in data for the drivers.  We
currently insist on having at least one buffer but that's fixable.

> This would not be a hack to the SPI code: we're describing to the SPI
> code what we want to achieve in terms of the activity on the bus, and
> providing that level of description then allows the SPI driver to make
> informed decisions on whether it can handle the transfer using some
> non-standard feature.

Yup.

--pwuPNfS0paSTjpGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw49/AAoJECTWi3JdVIfQ1F0H/0r3XHXrg83DWGFZidmiKHIM
3RTAuQQspERwEFOCDEKHJr2h7ZcZsusPTQcOK5IwadiaQL9izDyeDoeDswABr99Z
FBVKKa9S1KlLZrlT3NmfOftQpCXTmX9CG9N8mBqgqVQdrJ7IS2bn3Kn4ztFCMhsT
6OyjWIkL4y2hKnHDSedaB/CK0K219yS2bL+D6S1EkTrTk8nEU3OQOaRFbHPknCCO
9VN0dF4/n70OqvYQYEgJ4yr7w+13TZu/gINRpzJ8kCon6JmrgGbNFydYGWNf61p0
naxSlkptfPEOGyrkv19VaIE9LnlbKWjP5+DV3i8iwg7PdRy9AM25Bo8KXYQDQCU=
=bduc
-----END PGP SIGNATURE-----

--pwuPNfS0paSTjpGn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
