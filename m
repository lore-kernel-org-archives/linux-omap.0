From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] i2c: omap: also complete() when stat becomes zero
Date: Thu, 25 Oct 2012 15:39:27 +0300
Message-ID: <20121025123927.GY21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-4-git-send-email-balbi@ti.com>
 <508933E4.7070608@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <508933E4.7070608-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 06:13:16PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >In case we loop on IRQ handler until stat is
> >finally zero, we would end up in a situation
> >where all I2C transfers would misteriously
> >timeout because we were not calling complete()
> >in that situation.
> >
> >Fix the issue by moving omap_i2c_complete_cmd()
> >call inside the 'out' label.
> >
> >Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >---
> Looks fine. Have you hit this issue in any corner case ?

in fact, yes. With a difficult to reproduce situation with drv2665 (one
of TI's piezo drivers) I saw that I was missing the ack and all
transfers were timing out ;-)

--=20
balbi

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiTL/AAoJEIaOsuA1yqRESV8P/AnbGxCq9WYFCqiCQ0B/SRbM
I4qy5bHJG5ZxCcpcbC4IBv4XaX+rPCqbtq7OQbEf+r4x8iHoF3ZM6kGzG0e41e2e
WnmDuyD9HChogIMvO2ckiZNT9+ZIhpr7pdoQQV0omAS0gzHzoyZKk8p1fLz+Pnp4
xvqF308sT/fyn6a2S5NG8SWUEA8gfx0WU9w97Angb8koIBRuF6cWYzUMYCoME9iP
MrlyZ3P6CpYMpKDE9on2I8asKX6qQHO/GxFLJgc2z7qLNYsiGlczITzb1sLOs+XA
DASrIowmeLFDN+JWbFtbM6gg1dQ1cx6y+aRfBmYCLqf2SXoZ6H9t4UjFjsW4Ybwu
6frPhBySxBNOwII+UBVL0+vtWOGWJaUcN85uH4RPmIop0SEgYqc9+EWZfUnkMRTO
11Ng/o24zYdUMotYM/i4leN/MbdNUPdn7tZAoWZTE0pgXC3TF40oR31H+JHur+li
nL8JJkzDKuyjwvE6NiTReiVlzGeYYltO4kdh7z9IH1f8cEdz8u7/zKrdxsgyPldv
F7L/c5/Z1y3f+O2YHppJc9iAidAogP0XVWrP8BbrdVJ+VcDBI6czxeyFRWDTFvBB
GCeYK3/weS+LKjamm2iQ6ZR6ZBgAWhT48mtC2vjWBT5jxt8VS28AmJn0COGF284J
/mYjFR4Dht3kRJmLJyXN
=xjGS
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--
