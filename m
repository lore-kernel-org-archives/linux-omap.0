From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 13:52:24 +0200
Message-ID: <20121031115224.GA10733@arwen.pp.htv.fi>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <20121031101201.GB10094@arwen.pp.htv.fi>
 <509101EF.1070108@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2JaL6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 07:58:44 -0400
Content-Disposition: inline
In-Reply-To: <509101EF.1070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 04:18:15PM +0530, Shubhrajyoti wrote:
> On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Oct 31, 2012 at 02:29:19PM +0530, Shubhrajyoti D wrote:
> >> The revision register on OMAP4 is a 16-bit lo and a 16-bit
> >> hi. Currently the driver reads only the lower 8-bits.
> >> Fix the same by preventing the truncating of the rev register
> >> for OMAP4.
> > very good, but you need to test this with OMAP2/3/4 (5 ??). How was this
> > tested ?
> >
> >> Also use the scheme bit ie bit-14 of the hi register to know if it
> >> is OMAP_I2C_IP_VERSION_2.
> >>
> >> On platforms previous to OMAP4 the offset 0x04 is IE register whose
> >> bit-14 reset value is 0, the code uses the same to its advantage.
> >>
> >> The dev->regs is populated after reading the rev_hi. A NULL check
> >> has been added in the resume handler to prevent the access before
> >> the setting of the regs.
> > this could get some rephrasing, I guess. At least to me it's difficult
> > to understand what you mean :-s
> >
> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> >> ---
> >> todo: some of the flag checks can be removed in favour of revision che=
ck.
> >>
> >>  drivers/i2c/busses/i2c-omap.c |   35 +++++++++++++++++++++++++-------=
---
> >>  1 files changed, 25 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-om=
ap.c
> >> index db31eae..651a7f7 100644
> >> --- a/drivers/i2c/busses/i2c-omap.c
> >> +++ b/drivers/i2c/busses/i2c-omap.c
> >> @@ -51,7 +51,8 @@
> >>  /* I2C controller revisions present on specific hardware */
> >>  #define OMAP_I2C_REV_ON_2430		0x36
> >>  #define OMAP_I2C_REV_ON_3430_3530	0x3C
> >> -#define OMAP_I2C_REV_ON_3630_4430	0x40
> >> +#define OMAP_I2C_REV_ON_3630		0x40
> >> +#define OMAP_I2C_REV_ON_4430_PLUS	0x5040
> > I would rather see a proper decoding of the revision, meaning that you
> > would:
> >
> > For omap2/3:
> >
> > rev major =3D rev >> 8;
> > rev minor =3D rev & 0xff;
> you mean
>=20
> rev major =3D rev >> 4;
> rev minor =3D rev & 0xf;

might be, I didn't look at the TRM to make sure, my bad :-)

> thats doable too. However that currently that is read together
> currently.

and that's what's wrong IMHO. What's current in driver is only valid for
OMAP1 IIRC.

> > For OMAP4/5:
> >
> > well, that's a lot more complex, but you have that data ;-)
> >
> >>  /* timeout waiting for the controller to respond */
> >>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> >> @@ -202,7 +203,7 @@ struct omap_i2c_dev {
> >>  						 * fifo_size=3D=3D0 implies no fifo
> >>  						 * if set, should be trsh+1
> >>  						 */
> >> -	u8			rev;
> >> +	u16			rev;
> > IMHO this should be u32, so you don't need rev_lo and rev_hi below.
> >
> >>  	unsigned		b_hw:1;		/* bad h/w fixes */
> >>  	unsigned		receiver:1;	/* true when we're in receiver mode */
> >>  	u16			iestate;	/* Saved interrupt register */
> >> @@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_d=
ev *dev, u8 size, bool is_rx)
> >> =20
> >>  	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
> >> =20
> >> -	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> >> +	if (dev->rev < OMAP_I2C_REV_ON_3630)
> >>  		dev->b_hw =3D 1; /* Enable hardware fixes */
> >> =20
> >>  	/* calculate wakeup latency constraint for MPU */
> >> @@ -1064,6 +1065,8 @@ omap_i2c_probe(struct platform_device *pdev)
> >>  	const struct of_device_id *match;
> >>  	int irq;
> >>  	int r;
> >> +	u16 rev_lo;
> >> +	u16 rev_hi;
> >> =20
> >>  	/* NOTE: driver uses the static register mapping */
> >>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> @@ -1117,11 +1120,6 @@ omap_i2c_probe(struct platform_device *pdev)
> >> =20
> >>  	dev->reg_shift =3D (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & =
3;
> >> =20
> >> -	if (dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
> >> -		dev->regs =3D (u8 *)reg_map_ip_v2;
> >> -	else
> >> -		dev->regs =3D (u8 *)reg_map_ip_v1;
> >> -
> >>  	pm_runtime_enable(dev->dev);
> >>  	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
> >>  	pm_runtime_use_autosuspend(dev->dev);
> >> @@ -1130,7 +1128,21 @@ omap_i2c_probe(struct platform_device *pdev)
> >>  	if (IS_ERR_VALUE(r))
> >>  		goto err_free_mem;
> >> =20
> >> -	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> >> +	/* Read the Rev hi bit-14 ie scheme this is 1 indicates ver2 or
> >> +	* highlander.
> > the "scheme" in highlander is a 2 bit value. In order to make this
> > future proof, you need to read both bits (31:30).
> Good point will fix it.
> >
> >> +	* On omap3 Offset 4 is IE Reg the bit 14 is XDR_IE which is 0 at res=
et.
> >> +	*/
> > please align the * characters.
> yes will repost
> >
> >> +	rev_hi =3D __raw_readw(dev->base + 0x04);
> > you should make omap_i2c_read_reg() work fine for this case too.
> =20
> Just felt it is more readlable this way also I didnt want to use the
> reg_shift etc.
>=20
> which also may get cleaned up sometime.

correct, but I think for now using omap_i2c_read_reg() is fine.

Maybe defining (for now) REV_HI and REV_LO on both reg_maps would do it?
Just for the time being until we can get rid of reg_shift and
omap_i2c_ip_version ??

I don't know, but to me using __raw_readl() with a hardcoded offset is a
bit odd.


--=20
balbi

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkRD4AAoJEIaOsuA1yqREtl8P/ibvOW3/J/YvdJhzd+ID2enB
m+iFoL60dO6IoOx2bfMwWiP+MyQZqDgFLvcZ9adJIumeMIHRnzVLWsV3XJVf3b4+
y6ySWeHKxWpIv2XnD8h9cpfsMd9R21evKDaqLHOf/L0yTX8w7Hdxetjj0MIeyQDz
/oLUl+T+2czHUaz4nmGKpyMmtGXRpT3JKQIxs1RWCuY08eotMH7wK5CS1k6HlRHV
HD5xXavp99wvtZDwgcz3S+Xs/AYg9Q3kSUVxCpnKLP9wX3O5Zp1x5gbNKS4Hix61
GtEV7sJcvOcRr+B34UTLlj7/udISdwbPLsGhYZqRmaJML3be9ixUbWl7Yu6EcLZg
+uDWJweUdaXnZ4p7Gdp3npmMxcFtlgK1GRx5olv5HF2gE+7WP4r3ilqizdx4tPpw
n4obvbTS84tjhHidIhhz3stnFbUg0HsBpIoPqBKncXv18cFlflhuuNJpO6uVeNtz
embpZIA7YEkWGV7d1EYvdEoddOZNz/STOk5LEBDLW62bSSLx+//syY4GwKogzNlJ
TCXwZR0qGC3pwyu2JgFRRvlkBpSmvoVjJl9zCpDTOavChMXPl1qK3sN9ROzfv/h/
gNjjuV3Jl7Uri7HmTYA4WB2f2m7mkurfyUrm81BZTJwW+W5DwYl5LiuWiI97zPVI
LCcka8WOpSnssZgMjhtK
=q+32
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
