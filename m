From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 30 Dec 2015 16:33:07 +0000
Message-ID: <20151230163307.GW16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
 <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins>
 <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UTjKcilERHWBCdCp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451464521.2531.4.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--UTjKcilERHWBCdCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:

> In my opinion, it would be more elegant to adapt the core regulator
> framework to first enable the GPIO and then call the regulator enable
> ops callback instead of handling the GPIO in the driver.

Why would we want to actively manage both things at runtime?  It's more
work, what do we gain from it?

--UTjKcilERHWBCdCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhAdCAAoJECTWi3JdVIfQQmYH/jsIV1f+vwmsJYUCVshMxwso
+W4sZ+0R9otbA3HQMt1pvQyF8UUaQMk0WatGhbCF88EzOXgO2GCPIcBw1pi7q7mA
oUmdbXeHyd4OrTfKi/OOGqlk6kIlrp8i2PHOF3ubOdXvLQHJ3r8JYWufDFpLDaT3
c1FfGW+pC7whF+nixEeoPIJvqvBUCFNA9rTN0jqfS667IqVrztoXACrEkqsHrMtt
zV09Cs80t4Ez6W16F2klnh41nntt+Wp9x0FrV2HzIIJzeHz6uwFwabkOi4D8kjhA
abIIVVO4nmNiv8kanwP/CblT50iMKre3z366m3jZNxoZtBDQwG7+ZnGjNA8ZB4k=
=eFvT
-----END PGP SIGNATURE-----

--UTjKcilERHWBCdCp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
