From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 23 Dec 2015 11:56:32 +0000
Message-ID: <20151223115632.GS16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vEk28Nl/eckWL8CC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450868319-20513-5-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--vEk28Nl/eckWL8CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:

> +	gpio = lp->pdata->enable_gpio;
> +	if (!gpio_is_valid(gpio))
> +		return 0;
> +
> +	/* Always set enable GPIO high. */
> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> +	if (ret) {
> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> +		return ret;
> +	}

This isn't really adding support for the enable GPIO as the changelog
suggests, it's requesting but not managing the GPIO.  Since there is
core support for manging enable GPIOs this seems especially silly,
please tell the core about the GPIO and then it will work at runtime
too.

--vEk28Nl/eckWL8CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeovvAAoJECTWi3JdVIfQ7UMIAIb3vSgxdrjCknsOEp7PlNYc
2yFA5tIjYndDjzIncdOngvJL1pxUYBseJSHQMMBqOqXRT3B+IVgMwGKO2KudTMeb
E74/Qy4A1vkYN/bbkUr9iF2yga1sVm8l3upS2Vb1Z0OHFZuiwU0CMdR0NdFltyPC
nfAsZ4AFazs6OShOWwvPDkYn0J0wA04TOYG2JG5Gf/3NB8yNT9FjqHr+n8en+Nud
7Y4sSbgPc7nXai/DZiyur4yYs1dQKPFLNSuASfqfDPsi3n0kEKUZW+3XmQl6UHes
vjpQ/5uIqIYi4UUBTVqO8tL2iGRJf8dzADEWtQqhlDV5M6Fo9mWTVuTHcFwVhes=
=b6j0
-----END PGP SIGNATURE-----

--vEk28Nl/eckWL8CC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
