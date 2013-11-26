From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/17] spi/spi.h: Add configure from slave support.
Date: Tue, 26 Nov 2013 10:29:51 +0000
Message-ID: <20131126102951.GX14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMGrAD5L3cjpiKtl"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385451313-1875-3-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eMGrAD5L3cjpiKtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:04:58PM +0530, Sourav Poddar wrote:

>  	void	(*get_buf)(struct spi_master *master);
>  	void	(*put_buf)(struct spi_master *master);
> +	void	(*configure_from_slave)(struct spi_device *spi, u8 *val);

Clearly this is far too unstructured to be useful, this is only ever
going to work with one specific combination of slave and master since
there's absolutely no semantics defined.

--eMGrAD5L3cjpiKtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlHgcAAoJELSic+t+oim9MAEP/jksyOHV60pekSBgUvF0lDQa
/20gnPmbYp9Z4uCZEiiWXOP7HUhfvngAgVS2d6RuFLf1Km0FJ2Z9d0rs0gAZsvSo
LnzVuSdAMtDgKjjuKqJmpL2DiOtRk9veL8w+D30e5uqjY4R4PWlbnWRAZ2RNwvpn
9pVJHfHdAvKvkgpjCZ7FMIGJbW2hHmgieNP5m5B8TvRS0nycQuoBXwRYsbpLDIKf
Munb9Rg0nibRXUU1EDvx7nBGRETX961nP3Ix9aDvlBkvAihZ4L7+B76VdY0t9Ya6
du92IbzDnDexkkxEgMcVZQmgBJOEz3xwBgv3qsPFzB2spPDzqcR8F9rnsegWUvlM
E+znd+fCesDyE2s3jC2tk7C4vrX5amcZ910hHvvYYRT/Oir3ET37NKugAZ+Y8EHK
RHyjH1BEzdm774fAz8TDena31kzGyMBBZoYDCIqEPeMPkC6PUiOVD9nqMLue/iQF
+pvYTqFKiVz9Q/4KDRhyl2ChCqCPL6wlIXKzVne//1oWWjIT/Sy7PUvbNvQhn8Ga
40joh9duOjS7ND2gA2FLV07OdchctHiKnbcQGfXegWGagWLTx0X/IdX7RE/Jof0g
hG9+NInn+XNMXNfbq+xw5PPEOqMI4BxLE/HcIh4WFNBYKtNFlPjvTKMlsdwYvt3N
u1uSdPIIXWsXMN1DkJIa
=gnfI
-----END PGP SIGNATURE-----

--eMGrAD5L3cjpiKtl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
