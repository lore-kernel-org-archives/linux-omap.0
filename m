From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 18 Jan 2016 16:32:48 +0000
Message-ID: <20160118163248.GI6588@sirena.org.uk>
References: <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk>
 <1451599146.9673.2.camel@collins>
 <20151231221407.GF16023@sirena.org.uk>
 <1452929533.2520.1.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/CLXJPJLvRXjqaTD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452929533.2520.1.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--/CLXJPJLvRXjqaTD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2016 at 08:32:13AM +0100, Paul Kocialkowski wrote:

> Is there some git tree I can work with that has regulator runtime PM
> support at this point? I'll certainly end up handling the GPIO in the
> driver otherwise.

No, the last week was much more busy than I was expecting.  I'm hoping
for this week (or you could have a go at implementing it, it'd be adding
the PM operations in _regulator_enable() or _regulator_do_enable() if a
flag was set in the regulator_desc).

--/CLXJPJLvRXjqaTD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnROvAAoJECTWi3JdVIfQHTkH/RDCAaJnEI0ZOHLLtFg9SWsE
zgk3R6xUDXLPRBSqBST6fdyAcyIiC1EwRw00f0FgPQMH5IpI2rracgMhJLbCNjzv
LfjI+XjfK2z89bsDM5dGL7Dc5BOO7vzZMP+7SxGz/zghEmAHQVXHaVLwyPse7MQf
MPnKbs/tGRIUOzLT1GX2xmtNFYn9NH1e8i6a1neNwH+tpLZ3LhV2dAuqFvCrdalM
yn0dYPAfLomImwGXuJD5YgovqbqxTq+WZQOIlQmqUZFTfYtkwJ/fdD0GE4BiJ5LS
+idARVJOJ3j133F1/eTq2dBeYZMaK4XqVS9UO7nKxKIAGaBkzQjEYYbuzZmskb0=
=4pXh
-----END PGP SIGNATURE-----

--/CLXJPJLvRXjqaTD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
