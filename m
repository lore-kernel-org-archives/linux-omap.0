From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: omap: fix error checking
Date: Thu, 25 Oct 2012 13:10:10 +0300
Message-ID: <20121025101010.GC21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-4-git-send-email-balbi@ti.com>
 <5087FE07.6090504@amarulasolutions.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5087FE07.6090504-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 24, 2012 at 04:41:11PM +0200, Michael Trimarchi wrote:
> Hi
>=20
> On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> > It's impossible to have Arbitration Lost,
> > Read Overflow, and Tranmist Underflow all
> > asserted at the same time.
> >=20
> > Those error conditions are mutually exclusive
> > so what the code should be doing, instead, is
> > check each error flag separataly.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-omap.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
> > index bea0277..e0eab38 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -587,9 +587,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ad=
ap,
> >  		goto err_i2c_init;
> >  	}
> > =20
> > -	/* We have an error */
> > -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> > -			    OMAP_I2C_STAT_XUDF)) {
> > +	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
> > +			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
> > +			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
>=20
> Sorry, what is the difference? I didn't understand the optimisation
> and why now is more clear. Can you just add a comment?

semantically they're not the same, right ? We want to check if each of
those bits are set, not if all of them are set together.

my 2 cents.

--=20
balbi

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiRACAAoJEIaOsuA1yqREWjoP/RXgCgZFjn+0pvNuKFlroTB3
8Qn5+mS+zeNlPzZBTFVBaCqZ3rgEFUxv3VcA43C+Lmo93NpeFFogXpa2HppdQrke
E0onuXAPGI1tlRb72BsMzh3xb8NHubzSB2DuTqtGAvKVVYgNU/zPf1dQtkBYnbJX
upjlclmqgWdD4qVuyEOSEQASt4tL3h5r0l/0zHgTRYPcjjw0VRQPCQlH+8IGXJK+
KLOchcoe1JHth1voRi/O/060VA+3WSwvEaa5Bcp6QZO74+Jv/CeBF6SuV8W9QxXQ
bOC1k6SKsB3SKVPVj5ZE3kqDnnBW2Ytg2XkzPyKsJnU84ItGIO1rdd29uMYGp+/O
8+WEZAECXO8UdRcWZ/Iu+bUXo2c6m4/wJZz4qucvkH5xRV25SZeZPl8Cxe8KeUEj
g/x09I0KDItn1ftSGnT4FUeVxmlu3kVHiR33sJpZ3eD3k9Atq85Qy42v8THCP+NG
f9CkCqLtXkOzEIT5gdGoOAxvXFWa/Gwt2oYBB7ib7FrnHz4kobc+sCU5QJyCMo/J
0QibBHyDBXzfEuIEap8CJZpDbPiBDQJncM1ef5ZoaBj66cTk9cZiUI4MhEr+jIn8
XtPDZ8Th1T2TC0xyqVdFBuctKxOlu5LjI6tWTTDSyBk0Or1+Bq4SjzzBowtdt7iS
cjGaDLZ2CPGjlaMJz2XS
=f2ow
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
