From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Fri, 14 Jun 2013 14:57:49 +0100
Message-ID: <20130614135749.GS1403@sirena.org.uk>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <20130611142358.GG29135@zurbaran>
 <51B74252.5090906@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/OxAoNYcURhUkoHv"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B74252.5090906-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--/OxAoNYcURhUkoHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 05:29:22PM +0200, Sebastian Andrzej Siewior wrote:
> On 06/11/2013 04:23 PM, Samuel Ortiz wrote:

> > Please fix your commit logs, and your subject lines. It should be e.g.
> > mfd: input: ti_am335x_adc: Blablabla

> > if it's mostly an mfd patch that also touches an input driver.

> I usually do "subsystem / driver: short description" but if you want
> the ":" as delimiter I can do this.

You should always aim to be consistent with the style used by the code
you're updating - do a git log and make sure your patches don't have
changelogs that are obivously using a different style.

--/OxAoNYcURhUkoHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuyFaAAoJELSic+t+oim9MHUQAI4k6ZFd3GEwPZgVcptmG09S
gXyleNtbhmtiFGUsZEZDhX8fQjAnGMq6i2fsBQXQv9WcdZNFWuBWyoYL5D9YWm+z
oWmwrsMB9WncNyd1otHRH+k+qRWhosroOtjRSi+oBPGZKE2Nb9BzyUxxsWbmq4iW
Vq5V6KKRX0rWGA6zrD/ZCerQR81A/b+DQWd7UT56GRWIGYle2s7MI7zMXXQQer+u
nXmm/Df7kSdeXDupuepUIyc3dw7c4yfjENM2vvcmIVchXBLEvBpjBGBlTlaPfeJu
Sflwu/pUeeuVJYUXWtDV85Ec3ymVh4YVPjwMeno7dlSow3l5z9SWr22dMgzMY2Y3
mGLwDVkwYx/2Y/jaLrFPR5eDQU7DKBoLFqeN+eh0ZL/vkmmJrfRy+HoVv6WF7yGb
RbU25Z+hJ1dgWvuCFZU/5lpxF/fXBm00rXWgZ3nkOLfbQVupBRh98IwMAFPerQjm
LydU8L8iN8nl/MJLjcwtpN1ODVXhilodAlBk7Zn7GJUf+Id9xybtMKLzixTBGN2a
s1dy6/fpJAX7l8Bwwt7uYrP4kZPVD63YPzm7Z6CEoIcg/s18byxnzoE6eYB4HXCg
8ZGAV7+pam7fe/jR1f6aTpnL8RKrwdujsWlkpQwGntGTgxed1DywWWpf5MCEpOmq
GwRs87ym96jNXPEWvvPV
=vm2j
-----END PGP SIGNATURE-----

--/OxAoNYcURhUkoHv--
