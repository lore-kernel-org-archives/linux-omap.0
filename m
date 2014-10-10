From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] regulator: Add helper function to get
 "poweroff-source" property
Date: Fri, 10 Oct 2014 12:53:59 +0100
Message-ID: <20141010115359.GE18557@sirena.org.uk>
References: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
 <CABgxDoL2cztT6Y0oodtk4Q4jaDc1Rtx_RokxC+f0XykSojrdyg@mail.gmail.com>
 <CACxGe6vmBSgGpJgJ51Ki5KbQO65GDw3kSGSxnswYMfE8OGj9gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6vmBSgGpJgJ51Ki5KbQO65GDw3kSGSxnswYMfE8OGj9gw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: PERIER Romain <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2014 at 12:47:08PM +0100, Grant Likely wrote:

> This is an extremely simple wrapper. It may be best to simply make it
> a static inline. It is also generic enough that I don't have a problem
> with it living in include/linux/of.h; but of_regulator.h would be fine
> too.

I think of.h might be a better idea - it's not something that needs to
be regulator specific, system power controllers could provide the same
functionality but may not offer any regulator control to Linux.

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUN8jWAAoJECTWi3JdVIfQL84H/1LIL/5/DYEQwAMprFKH8pLv
BfFv863V5x1QtGRxC+OiDANdj61PBIrAB78PswZ5tPpX13mca3WbEqqOFSnIGdeA
AbtMTWiznlEdQoO04vwm7lbGkAH3M7KKjq9EMIDsGnQJ4Qi+JyxTNKuwbPRIFL6e
CiRnwPuz180PeBsUWw2b4oqcK8CPk/Bq4txHz/9Q7C59IBdzd9q62oFtLf5l6C9Y
lqspLR7EiZOzXx3DkJ6+Jphq7SN84MZwFYoyI9WvP1MxpSzp1XLrNOXnBeyHDoSl
7bCr0uVL8YtxUdGAKFAdWZ/IqVh9zAvct5YTw6MKNhYumkHuTrfYWRzU8p7s+zA=
=Illa
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
