From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver
 autoprobing
Date: Tue, 18 Nov 2014 13:21:12 -0600
Message-ID: <20141118192112.GM6179@saruman>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-6-git-send-email-balbi@ti.com>
 <20141118183847.GE3003@dtor-ws>
 <20141118190922.GL6179@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118190922.GL6179@saruman>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <lw@karo-electronics.de>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 18, 2014 at 01:09:22PM -0600, Felipe Balbi wrote:
> On Tue, Nov 18, 2014 at 10:38:47AM -0800, Dmitry Torokhov wrote:
> > Hi Felipe,
> >=20
> > On Tue, Nov 18, 2014 at 12:07:04PM -0600, Felipe Balbi wrote:
> > > i2c devices match against struct i2c_device_id
> > > even for CONFIG_OF case, so adding a struct of_device_id
> > > doesn't change anything. As a result, currently, edt-ft5x06
> > > will not autoprobe if built as a module.
> >=20
> > Why doe snot it autoprobe? We properly declare MODULE_DEVICE_TABLE for
> > OF, is it because we are missing some data in device uevent?
>=20
> because of of_i2c_register_devices(). Maybe Wolfram can give a better
> explanation here, but it just doesn't match through of_device_id.
>=20
> Apply this:
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2f90ac6..f0dc16e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -449,8 +449,10 @@ static const struct i2c_device_id *i2c_match_id(cons=
t struct i2c_device_id *id,
>  						const struct i2c_client *client)
>  {
>  	while (id->name[0]) {
> -		if (strcmp(client->name, id->name) =3D=3D 0)
> +		if (strcmp(client->name, id->name) =3D=3D 0) {
> +			dev_info(&client->dev, "i2c_device_id match\n");
>  			return id;
> +		}
>  		id++;
>  	}
>  	return NULL;
> @@ -465,8 +467,10 @@ static int i2c_device_match(struct device *dev, stru=
ct device_driver *drv)
>  		return 0;
> =20
>  	/* Attempt an OF style match */
> -	if (of_driver_match_device(dev, drv))
> +	if (of_driver_match_device(dev, drv)) {
> +		dev_info(dev, "of driver match\n");
>  		return 1;
> +	}
> =20
>  	/* Then ACPI style match */
>  	if (acpi_driver_match_device(dev, drv))
> @@ -1081,6 +1085,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c=
_board_info const *info)
>  	client->dev.bus =3D &i2c_bus_type;
>  	client->dev.type =3D &i2c_client_type;
>  	client->dev.of_node =3D info->of_node;
> +	dev_info(&adap->dev, "%s: of_node %p\n", __func__, info->of_node);
>  	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
> =20
>  	i2c_dev_set_name(adap, client);
> @@ -1411,6 +1416,7 @@ static void of_i2c_register_devices(struct i2c_adap=
ter *adap)
> =20
>  		info.irq =3D irq_of_parse_and_map(node, 0);
>  		info.of_node =3D of_node_get(node);
> +		dev_info(&adap->dev, "%s: of_node %p\n", __func__, info.of_node);
>  		info.archdata =3D &dev_ad;
> =20
>  		if (of_get_property(node, "wakeup-source", NULL))
>=20
> then boot the board and you get http://hastebin.com/oqemezajez
>=20
> Interesting, it's matching against of but only when I modprobe.
>=20
> Let me debug this one a little more.

this is a simpler patch:

+MODULE_ALIAS("i2c:edt-ft5206");
+MODULE_ALIAS("i2c:edt-ft5306");
+MODULE_ALIAS("i2c:edt-ft5406");

I'll send it in a bit.

--=20
balbi

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa5woAAoJEIaOsuA1yqREABsP/3N5plLWcPVGdO+1oKL+3k1S
fGaZSywm+elnEMJzdA3Z26+h0xfsJPea8DdyH/j0aObYv/xLZpMrurrrJKLILvyr
ocYPYhQdu0kZ7J1ZbhKTIPrF6NJThccZK9/D429XFU2Vingv7joCdI/2l30ExBQK
uemqqdXLQaWOL83j2/VZCaIq2D6E2y/V8//K9nv+/zm+iQK7SHv2Qja0ikASFbov
GQQwpzKUVkPwM5NIGS1LslRiQo1ieTrbGsW5Y9clhNMbPoiqiueKwbZGuLJjTeaq
zQSpaxZoIJTtVuYssXw6hee69ZfIjhKAE85i/LdSYqmDXWVdoNt8/DXtQmUGcTxQ
Z5s3WfkEa2l8puHPfB1cTmyNZ104MeDNw0ON+2qo+/K6YduE0erNcVcP2lR0QddZ
XjpPHk4C4/LDkcYSXAFHUCvst+IK6JhT8GZ8CUe8sZYH/+JzkL0Osadfb000YKub
KvUMHTLgII1JdRbaga+zRwxOFJ0aMohiCMv/nL4U6KlAXkmfsaz/HnBKVjDdeH+V
Wi5ZZ923sveTBDDY4SWTL8+9XSZGD4gHnIxCO4xeDOs3+d0YChsoP/QepQLR09k6
rUMKYG5/y9sH7s+4VM3P57FSPszBUKhhdRDCH0Ifdtm7jaOteJAyqx8dpwelaBXz
Q1pKckWzXxgOIGwurSlk
=ween
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--
