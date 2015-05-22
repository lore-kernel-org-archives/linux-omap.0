From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Fri, 22 May 2015 13:25:44 +0100
Message-ID: <20150522122544.GL21391@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
 <20150521211638.GN21577@sirena.org.uk>
 <20150521234832.GA1827@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150521234832.GA1827@deathray>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 06:48:33PM -0500, Michael Welling wrote:

> So after reverting this patch I found there is a issue in that it is diff=
icult
> to determine when a transfer is complete to properly drive the chipselect=
 from
> within the transfer_one function.

Is unprepare_message() a suitable place here?  I've got a feeling the
answer is no...

> Then I figured that we could handle the case when GPIOs are being used wi=
th
> some conditional calls to omap2_mcspi_set_cs in the omap2_mcspi_work_one
> function.
>=20
> Near the beginning of the function I added:
> 	if (gpio_is_valid(spi->cs_gpio))
> 		omap2_mcspi_set_cs(spi, 0);
>=20
> Near the end of the function I added:
> 	if (gpio_is_valid(spi->cs_gpio))
> 		omap2_mcspi_set_cs(spi, 1);
>=20
> This makes GPIO chip select support work while leaving the native working
> as previous.
>=20
> Is this solution acceptible?

I think that's probably OK as well, it's not ideal though (and risky if
the chip select is routed somewhere...). =20

> In the process of reviewing the changes I found a few other things that
> should be changed as well.

Please send fixes for these as separate patches (ideally without any
dependency on your new work so we can send them to Linus as fixes).

> Here you will see a delay that is already handled by the core spi driver:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/dri=
vers/spi/spi-omap2-mcspi.c#n1166

I can't actually see that since I have no internet access right now!

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyBHAAoJECTWi3JdVIfQLXEH/A3tohzct0hl9M0gPaU0f38W
Iz2AfUtTRKrYL/BISLzyCfNcAlai7eZmCgvlCq7VZ0oCDDTVoQyWRXSK7TeMkd56
KbKvI91aY7McvciIEAwm6HoABFfX3PA8PsG1IP3V7NzaSsNQ8Kxffanv574+K42Z
VvKgQ9ev3ln0nSUTtq+ZwqEzuUtH/oAHcn8WGuVqT48ApQN17ieapBKnpl4KId5h
WHFyMweQq3XP9gPttW7qH1yMC74MNJeyL2kWB3Y501Ai/BGQZ2Ig2yZwodUMHbEr
s/COrutw2gaDaKP1diAAUEv8rbQEVMqIx+P9csJo4Zk5wfulqE3iHszEuFlbrKc=
=jhsf
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
