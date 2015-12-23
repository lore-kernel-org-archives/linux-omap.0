From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
Date: Wed, 23 Dec 2015 11:58:38 +0000
Message-ID: <20151223115838.GT16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-4-git-send-email-contact@paulk.fr>
 <20151223114126.GR16023@sirena.org.uk>
 <1450871420.2648.6.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450871420.2648.6.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 12:50:20PM +0100, Paul Kocialkowski wrote:
> Le mercredi 23 d=E9cembre 2015 =E0 11:41 +0000, Mark Brown a =E9crit :

> > I would expect the driver at least needs to know how the pins or
> > strapped, or otherwise have configuration for ignoring the input on the
> > pins.  This just deletes the warnings, it doesn't have any handling for
> > this case that I can see.

> When the DVS GPIO is invalid, lp872x_init_dvs jumps to the
> set_default_dvs_mode label, which instructs the chip not to use the DVS
> pin at all and do it all in software instead (by clearing the
> LP8720_EXT_DVS_M bit in the LP872X_GENERAL_CFG register).

> That is reflected later in the code, when setting the bucks (the DVS pin
> only applies to the bucks) by checking for the LP8720_EXT_DVS_M bit on
> the LP872X_GENERAL_CFG register (in lp872x_select_buck_vout_addr) to
> decide whether to use software or hardware DVS selection.

> As far as I understood, everything goes well when the GPIO is invalid.

So please put this analysis in the changelog so that the changelog
accurately reflects what the change is doing.

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeoxuAAoJECTWi3JdVIfQi/YH/jcqPJlsU9m1FUCaGWFuowH9
0nJMQ7roEWkDbOdDLmyWAsZWGZ5smERjZe5W+EPrL6uZFolnb1m/3JXnLrs7U1Fg
NDJdRzXcsdtrNvbRcOftOnEU9Q1lepQrLsukEAd7tUQw0lvCIMHG1KVdxdZiKTUh
2iM7sDymy0c4cG/z19fGV4f9iU/Zs2TO3G5Nx9owQVANw8j8/VLVoXd8r9o2Pj7M
nm3tsRkbduD6yxCXtpqwjpwLjL0ImHGlJ5AUQMM5Fd8QJH7J29O71A0mNU0xqTGN
RYEcqPIQatbYLl5svL4nVKjoDl3ntWycvQ1scOI/5TD7vjlmIPe2ya7yyd7JiQE=
=kuyp
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
