From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 1/3] serial: mctrl_gpio: restrict MCTRL initialization
Date: Thu, 27 Jul 2017 16:00:09 +0200
Message-ID: <20170727140008.myhk2w6mwxxinhyb@taurus.defre.kleine-koenig.org>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
 <1501161456-13367-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7k2occw46ajkdrqb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501161456-13367-2-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--7k2occw46ajkdrqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Thu, Jul 27, 2017 at 03:17:34PM +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> GPIOs specified for serial port can be used either as GPIO driven MCTRL
> or as a wakeup-source. Use the latter property to abort the MCTRL
> initialization.

Why is that an either-or and not an and?

Best regards
Uwe

--7k2occw46ajkdrqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAll58eUACgkQwfwUeK3K
7AnynQf9HfyaMLwnAv/WGOA5x3+ZYMe9jELLAs0ABcyXZLT162Rt0dadFdSVRotx
18kpVEh/7UrBQzQT+v6LbqutKCAvhpPYAbzQM0+Op96l0S4xySRmtGBUbWLnSGJs
ieCaw0oAP69Q7eQdTASLJsEZj5gagXYnecY4YKCusdM7esNWqaZfkTGI6VSFzGsi
miv1qjM6dZYwgpTVmZHwwRwhIeOGmNFhqcaWkCJ4gfz2iHe2iu6EpYxR/NcNBT/M
4MRvgyyx8Rwz/soaYhFIcqX7gp6UDKycWREHaCkvqQs93GsBbRKjErdHkXcDFqfE
h2C/hZm6ey+9X/cl99RgGBbb2l1b0w==
=7off
-----END PGP SIGNATURE-----

--7k2occw46ajkdrqb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
