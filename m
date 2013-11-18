From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 11:25:10 -0600
Message-ID: <20131118172510.GI16038@saruman.home>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8cpS+6Cx+xtICsjy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37502 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3KRRZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 12:25:56 -0500
Content-Disposition: inline
In-Reply-To: <20131118102907.GC13640@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

--8cpS+6Cx+xtICsjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 18, 2013 at 10:29:07AM +0000, Lee Jones wrote:
> > Since we still need to rely on a mix of device tree initialized
> > drivers and legacy platform data initialize drivers, let's fix
> > the passing of platform data to twl4030-gpio.
> >=20
> > As the twl4030 GPIO is initialized by twl-core.c, we need to register
> > the auxdata for twl4030 GPIO in twl-core.c.
> >=20
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >=20
> > Samuel & Lee, I'd like to merge this fix via arm-soc tree if this looks
> > OK to you as I have other patches that depend on this.
> >=20
> > ---
> >  drivers/mfd/twl-core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 29473c2..d5b3dd8 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -1133,6 +1133,11 @@ static int twl_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> > =20
> > +static struct of_dev_auxdata twl_auxdata_lookup[] =3D {
> > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > +	{ /* sentinel */ },
> > +};
> > +
> >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
> >  static int
> >  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const stru=
ct i2c_device_id *id)
> >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> >  	}
> > =20
> > -	if (node)
> > -		status =3D of_platform_populate(node, NULL, NULL, &client->dev);
> > -	else
> > +	if (node) {
> > +		if (pdata)
> > +			twl_auxdata_lookup[0].platform_data =3D pdata->gpio;
> > +		status =3D of_platform_populate(node, NULL, twl_auxdata_lookup,
> > +					      &client->dev);
> > +	} else {
> >  		status =3D add_children(pdata, irq_base, id->driver_data);
>=20
> Why doesn't the TWL driver use the MFD framework for this stuff?

that's reminiscent from years ago and, surely, needs to be fixed. Should
we gate $subject for that, though ? This has been in tree for quite a
few years already and Tony's patch is still a step forward, since most
omap3 platforms would break on DT-only without it.

There are quite a few folks who could volunteer to fixing that after
Tony's patch is in (me included, although there could be better choices
hehe).

cheers

--=20
balbi

--8cpS+6Cx+xtICsjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSik12AAoJEIaOsuA1yqREw10QAJDdTviJNDLjAmoDWzfH0g85
eobv3i7TxDr23HLgSWJfuFzsGkgDySxw8fDSkJl6AFBsVpz4jBj9EmRclQ/uyIz5
IJn89IwRyXebyN4vrBp+OvLols8lAUkzhgUMwtb3RKGESECxuFa84s1Q9DsIhUxa
t1S76AjlEP+Muuff73IZDbjDbdECfvHzV2Xv7UWvQuY79vMpfSbduauyRmb2WzQ7
PUTwF6MTcnS8Da2h2eboWH1CALjanyAspjbuCQ+TFVGXd1xkDsFHC0yMRizQI678
8ANPgm8nl+LM6USPf7xQjUEN95lB8oQBiStUg527zkQEvh32oDuWIZ4Z+jtHRxz7
/cc4IffX/MmQov1GpsM47+iDM5BZW8vc0/gRBey6jVQelhf3agQO1kD87SH0AQVK
rub3dBAqweLTX0qurzU+OS7Zgv7ngaWieUlYxUtAtqgESP6HH06bzxyCJpmtei4j
p1mgii4hnsgeFhBPKwOXyjPsu28UUtdpRaDRFqa7MFSyz4v+4XDA6ut2EqcN+XKL
WSEEWs4/8Mkf00UFuqtZ43QGB4gFrPyqtVGaGV4aFtZUjBE+kleZLnFQCoQqRQty
ledo1y2WIwX+DR1BvEyWocJPbr5QmytQ0mnXp/wjwJxhWPIAG15Z0WmmSBhYhMUa
K4gJwrhR1CzByKW2rQiu
=d+3e
-----END PGP SIGNATURE-----

--8cpS+6Cx+xtICsjy--
