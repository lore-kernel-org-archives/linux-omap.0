From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Mon, 17 Jun 2013 17:03:26 +0100
Message-ID: <20130617160326.GE1403@sirena.org.uk>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-2-git-send-email-bigeasy@linutronix.de>
 <20130611142336.GE29135@zurbaran>
 <51B7358D.7000605@linutronix.de>
 <20130614135358.GR1403@sirena.org.uk>
 <51BEF5F4.4090600@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFw2VRElW3V0Y7aQ"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51BEF5F4.4090600-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--nFw2VRElW3V0Y7aQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2013 at 01:41:40PM +0200, Sebastian Andrzej Siewior wrote:
> On 06/14/2013 03:53 PM, Mark Brown wrote:

> > It does give you tracepoints and debugfs.  If it's making things at
> > all complicated we need to look at why that is and figure out how
> > to fix that since it's probably an issue for other users.

> debugfs are tracepoints is our offer? Let me check the price one more
> time.

OK...

> This is a lot of for a simple mmio access. In terms of performance: If
> I add a trace point to my read and write I have still less code which
> is called and it can be disabled. This regmap overhead is always there
> chasing pointers.

Equally well what you're implementing here is support for something
that's typically implemented with an I2C or SPI control interface so
you're already going to be quite a way ahead of the norm.  This is part
of what's confusing me, usually for this application things aren't that
bad performance wise even on a massively slower bus.

If all you're saying here is that there's some overhead that's fine if a
bit surprising, but the way you're talking made it sound like there was
some issue that made the API actually unusable.

> As I said before: I doubt that you get this regmap access in an one GiB
> network driver and in turn remove their trace points to register access.

Well, of course for that sort of thing the general trick is not to talk
to the hardware at all and do as much as possible with memory that the
hardware can DMA - there's actually still non-trivial costs in talking
over the buses.

> Please don't get me wrong: It is still nice for slow buses and this ADC
> driver isn't anything close to high performance like a 1GiB network
> driver but it adds a lot of unwanted overhead which I prefer not to
> have.

OK, but equally well remember that from a subsystem maintainer point of
view having things factored out is a win in itself; for example with the
MFDs locking on the register I/O has been a persistent issue in the past.

--nFw2VRElW3V0Y7aQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvzNLAAoJELSic+t+oim9vmEP/j1XJ015WyfVwWwRJ+bfdNex
qhxUYMGMTRXJi76ZgJtKWxnG+d2BeV6uSN5ov6reXOwA8OnDrcil+h3VyY/79bHt
YU6D1uOJVO9O2XnwSboBDWrYv8zrFKrH5yLJ8j8h51xqO7RzZ84j0GtCdqYBARn9
Hf0/gZZV3HFXzrLE+qHMoCG8UHxujf95MW6f2B48SaT17G/oDXSMwncKHImJicer
pPpCuGO9JRH0PCr6JdnBkq8OG5qMr5X6Mi4JQkA30lN9AX6qypW76JuA/CANRsQo
AOAqdtYrojocjM2FJhmp1EVrQXN2o9FUKjTtiCUrxsQsDXLEektZsdUQhuh1+fPz
elI97Re6NJql4DUAWo71h/Gt6cHWusjjstAL2pg4/ayJeBqtGLQfUINx+fdKt6RP
XS0qMDd3n+UONXb+VL4IpOYiTaV9rqi8So1JpG8DkbLBfLRYDCUeQI8gfD0HIeha
VB1fMIxENJ86q5NA3rrYV59btyg3+dexcCp1bUcGs3/JkJQLfSgt+8kek9nNrOEC
Z/9vQbs00haHftBWSAlXKOUaCkg4mQGZuQT3nEAuzDNORH3W+CVFc5rmSNmcZUFo
SQOD7VmHT9uNOB1ZYZCE6eglKC6TmxN0F+eHg+HbhqR4goYKhOwbWDbfISVtx9k2
0fcMLRGa659l+WWANP7u
=gQTL
-----END PGP SIGNATURE-----

--nFw2VRElW3V0Y7aQ--
