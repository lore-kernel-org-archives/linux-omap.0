From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI regression in today's Linux next
Date: Tue, 17 Oct 2017 15:40:21 +0100
Message-ID: <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
References: <20171017143454.GA4394@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xf4exqfvdwdir37e"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171017143454.GA4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--xf4exqfvdwdir37e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 07:34:54AM -0700, Tony Lindgren wrote:
> Hi Lucas and Mark,
>=20
> Looks like commit 9ce70d49fa80 ("spi: fix IDR collision on systems with
> both fixed and dynamic SPI bus numbers") causes the following regression
> at least for omaps. Reverting commit 9ce70d49fa80 fixes it.
>=20
> Any ideas?

There's a fix already.

--xf4exqfvdwdir37e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnmFlUACgkQJNaLcl1U
h9Ag4Af/fNlVr/fa69ImnBAzWkbyFe7tx9D9cok44OpCZ6Utx5t2yaMq7VHN8ejW
DBldaQroZlnyzJeCERzyxavASuZGfM8nIUHCyu+TfTejyBFqSORkHTt0Yqv5ga01
QPA44LnR6mPtwvDpuKCBMecYAd+kUYb4ROIxiMQMshBMbRoofvV/PTnM1Jz5G/US
XvIh0cDPCDGex8vjJqoKybymOwc0p9fXiTVubD0UNqFHxPGQ3QkgPJhCmZSTjJrY
Bl7xWuyXclWwPmzNQaBVVXvxXoZAiqXB6VkdOcnzI0lyuYXzuILMSUIDjwuFyvEo
eIJHehDlgA91kcrOq3uMl3BjwmqRaA==
=LPSA
-----END PGP SIGNATURE-----

--xf4exqfvdwdir37e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
