From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 4/5] i2c: omap: don't re-enable IRQs after
 masking them
Date: Thu, 18 Oct 2012 20:07:39 +0300
Message-ID: <20121018170739.GC6641@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-5-git-send-email-balbi@ti.com>
 <874nlrg101.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757290Ab2JRRNP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:13:15 -0400
Content-Disposition: inline
In-Reply-To: <874nlrg101.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2012 at 10:10:06AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > OMAP I2C driver will re-enable IRQs right after
> > masking them during suspend.
> >
> > That's not what we want. We want to keep IRQs
> > masked until our resume method is called.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
> > index db31eae..7eeae11 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1247,14 +1247,8 @@ static int omap_i2c_runtime_suspend(struct devic=
e *dev)
> > =20
> >  	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
> > =20
> > -	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
> > -		iv =3D omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
> > -	} else {
> > -		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
> > -
> > -		/* Flush posted write */
> > -		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
> > -	}
>=20
> Are you sure this re-enables the interrupt?  It looks to me like
> it's meant to clear the interrupt.   =20
>=20
> > +	/* Flush posted write */
> > +	omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
>=20
> Assuming the above is correct, should this be IE_REG?

indeed. My eyes failed. This patch can be thrown away. My bad.

--=20
balbi

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDdbAAoJEIaOsuA1yqREMKYP/ia/NWBenh+kzw2NoLLsa8eg
NAYLxEFFk3LJ0rkfSaBMMIfgYFAT7wJdicjN6JNP3lOVV5eIVfiBKdALC620lKEp
IxbZAgEi9AwTQQsnNnX73OiY7MxZcZLrAhm2cV7alCBgJxxedWcYUgrHBmxQP4b4
LZVGKACF7kXjAm9FhyuVN5JTPC2aOuzgoR0/spHLtqlbEeoHddzJQ3rQYAdJtoaB
nzahuNL3L+N4FpYTIbJOeblQlhwHHN6ROhycA9HLO9bgen2lyuJGD8VWTQh8ZE9z
wWwdiXiZInYqTAYQFJl8ZjWhFzhjMirGZKjh5FNXm9wapEUpvacbmitGjEB+x/5T
dCsv2PUAcBEqsjo53Ab8kW/3cpGfv62QsVEt3505Ie28T/fsYSsYo1LlpOo4nJsm
5aTB3AMlnfnDLdORtz8U5srC/u3V3uPIetB4gM7sa4eB/srZdbTBee7EPSVuARq8
qN9RHrz9+IpW5k1qiFdZZg0nPBggmBbnOxzn0dANLagqytcz8lc2wFx4YYVvEDer
+e35O8zJXcfJx4wFbmm+/8dIhyqcdi5etKTPT+jJRVtZQeL7pkHj34fTgdrIaptb
Qds4557rGr21bOR+hbO4sqQwwfPMl2othYp1VuDY5mij+O1Cj68JeRx0+F8aIMgF
jWT539YsXzuaA23bJBOn
=stoa
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
