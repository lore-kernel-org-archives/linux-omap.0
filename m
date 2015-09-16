From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 16 Sep 2015 11:56:47 +0100
Message-ID: <20150916105647.GK11268@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <20150914183744.GF12027@sirena.org.uk>
 <55F93F89.7060708@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F93F89.7060708-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2015 at 03:38:09PM +0530, Vignesh R wrote:

> But, I didn't get how to integrate with existing message queue. Memory
> mapped read by-passes message queue of SPI core. Could you please
> explain a bit more on integrating with message queue? Did you mean
> locking the existing message queue when memory mapped read is being
> requested?

Yes, and also making sure that we don't everything gets processed in
order so memory mapped requests come after any commands needed to set
them up and don't starve other work.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+UruAAoJECTWi3JdVIfQiDQH/0Hi5Z9tD7PeziQs0l+wtJjR
/EIB5RAhEyMzQ6Y+PiHd9eg/Vl+0ENDdP6RNXkigIortX74pLibDTpWn05X/STgq
Tr12ifAmSmQrnYYA0mmqRPhYzffA2N/dEYLb2F5Bp7S0qqEHNlkkGyEAxKYsLLRN
uxNzdtv6DAkSO1XuwMGYeutDwXwOglsUKcYbGAHTXk10QZOamopdy0fZPZqamYq3
OdRKBWgtSu3XUrLGCsv45uCs3GA7nivLYM+NnV0Q0aAwElK/dSy0Ok7TU0XakR4E
LXKT+eI2UdrS/iVQXuRXg88MwVEi3KvnefLE01FOn9jrgo76IUcqdmWYhGOjZro=
=BkOA
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
