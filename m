From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due
 for the v4.9 merge window
Date: Fri, 9 Sep 2016 13:11:40 +0100
Message-ID: <20160909121140.GQ27946@sirena.org.uk>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
 <20160831122435.GD9415@dell>
 <CACRpkdbfOdaouKEooLsGRYXhbwkjfNoTXTqunumF4bOPjOUD4w@mail.gmail.com>
 <20160908072646.GH4921@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160908072646.GH4921@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2016 at 08:26:46AM +0100, Lee Jones wrote:
> On Wed, 07 Sep 2016, Linus Walleij wrote:

> > Hm it is based on a later release candidate than my tree so I'll wait
> > and see if I
> > have to pull it (like if there are clashes in linux-next...)

> You use -rc1 as your base?  Crazy man. :)

I do that too for the topic branches.  It's really helpful for cross
tree work as it avoids issues like the above - wherever it's being
merges it shouldn't pull in any extra dependencies so things are clearer
when reviewing diffs/logs and git has an easier time coping.

--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX0qb7AAoJECTWi3JdVIfQlIwH/3JlMjntU4SE+E0eIwcAxz5T
RGJO7cW9QWJdE+F9QcuR1MX0dglbuXJ2ldIn5PqSpd+5omutORngSbnKZosiPe7b
kqWpFrBIUZ4jtQIE0dKhu2zlUz76pdkcgfKsjktPnD9eeAXwBLm6NwTexSSO3g8N
B4A/MlOm9n/YY6mIq75WOob3+71gniFiFlyF+Drn2kdk3xkrfCj/mjKDIeo4WNe+
ShaAFqfFjHuZ4mADVYVETdX6t3CqRyZfwx1NWJAmfkEAOJFoz0thjPy/PG/E7XdS
y9uYDRjQ5eD/F6HNTbIZwlHCcMvTRfUN0f0CJz4VugyGmCqeHlOmqzC2kqpXFLI=
=Daby
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
