From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Fri, 14 Jun 2013 14:53:58 +0100
Message-ID: <20130614135358.GR1403@sirena.org.uk>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-2-git-send-email-bigeasy@linutronix.de>
 <20130611142336.GE29135@zurbaran>
 <51B7358D.7000605@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mu1Tvth33Vj8K2q"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B7358D.7000605-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--5mu1Tvth33Vj8K2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 04:34:53PM +0200, Sebastian Andrzej Siewior wrote:

> >> Therefore this patch removes regmap part of the driver.

> > NAK. Using regmap is better than open coding your register accesses, and
> > the children not using this API is not a reason for the MFD driver to do
> > the same.

> There is no advantage over using regmap in the first place. It goes
> through a few layers, uses no caching because almost all registers are
> volatile and this is a direct bus. In the end it complicates more than
> it helps.

It does give you tracepoints and debugfs.  If it's making things at all
complicated we need to look at why that is and figure out how to fix
that since it's probably an issue for other users.

--5mu1Tvth33Vj8K2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuyBtAAoJELSic+t+oim9BbYP/1+zKwt1iB3j76z88fQnyubj
KOiwAO9mDpaTdX69TCrRyhSfL/soylTxHBvHpHv7WNhWGF/MAaz7ivhOJ7ENBojg
fX8LAMSFhWRq5KpCOKKWQGcdiyaQhqBknfHMAIoahBC+1Y9v/k2sNnuHogOLzybp
rb+bewLZIcoo6eSMeuxauwvXukkQNWJTL8NB92LME2toFntazY0uPshwDVbbZjCs
bFAyv0RXkljqlfUGwYe6rubfaGYR+6GNCIWMl1A1aiWhKW4tspktsk0aI+uEVznk
5YCtpfAm4dsQecaoQtsgIRmK0978Zrm0R5buj8pkbiv6kYBmpGQ8BMV+CXRqOXjp
4CGKn2mHOnvHJdQ518xmnvxUhYP0j9bh+GzvMLM5Mbuou/P9vf3SSMFTO+FKvGJ7
Ee51mW0d5u/NBUKtcTyjp4zytuvh0yHteX/L3f+XONT6izUCg9z/LnmuaTrv9x7A
dQ8LLORyqGtgL/rUGZ6cb8fSRfPKa82noi8dXm5TSp5eQbDlPLsRg48XDPqCkOYl
W8ns1GUVu0+xIEjHET8w+Ff/LttXYG9if8Y6S6tKziohfizX46X9PIabiFpeKO3u
x66j6t9ui+HEtklLKgRYtbOzAIvExgmNMnx81fA3HpmduSoarhtOJzECkdFZt6od
QdyKhuqOeBEmM4YA/3lK
=mCoi
-----END PGP SIGNATURE-----

--5mu1Tvth33Vj8K2q--
