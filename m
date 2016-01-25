From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Mon, 25 Jan 2016 12:41:23 +0000
Message-ID: <20160125124123.GQ6588@sirena.org.uk>
References: <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
 <20160121162646.GK6588@sirena.org.uk>
 <20160122064145.36b7f2b4@ipc1.ka-ro>
 <20160122162610.GZ6588@sirena.org.uk>
 <20160125133731.72669115@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YLKJzIir88lqKfby"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160125133731.72669115-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--YLKJzIir88lqKfby
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 01:37:31PM +0100, Lothar Wa=DFmann wrote:
> On Fri, 22 Jan 2016 16:26:10 +0000 Mark Brown wrote:

> > You're not just making the interrupt optional, you are also implementing
> > polling support.  That's really unusual and there's no clear reason for

> Any suggestions how to handle this case in a more sensible way?

The above, for example - make the interrupt optional.

--YLKJzIir88lqKfby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWphfyAAoJECTWi3JdVIfQCREH/09odrajuuSeKq+JoiSzA7Pn
9jHudQAkI0XvA+dGL8TVGKtZjWLzqeg7itQQLHeYOzbHQrPTajjtSq5ZdE5m/6pH
1KNllZmyIhZB+pSb2zszmLmCAfeugqpA+7tm+jihKFaP3zMR7a8sRTySvy8p4Gli
ff9VyDiVXPSxE/qgI0lSBoO55o58rH+x4Xzxn3sv+TmsEH+p+DUFyenbC0xMIZ3h
6bAojQ0q1o99dJ86RQgLWpX8XFfMVwMRdrkz4tYpR25bA8jRpv07Ps7xLHCMSmFT
3lw6kBsN6DaEC0ZR8qCG2kG4x0sguSILpsgpTC+HDDvBNvRfS3Ys4AHdSPKx4G8=
=zwc/
-----END PGP SIGNATURE-----

--YLKJzIir88lqKfby--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
