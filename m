From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver
 autoprobing
Date: Tue, 18 Nov 2014 13:09:22 -0600
Message-ID: <20141118190922.GL6179@saruman>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-6-git-send-email-balbi@ti.com>
 <20141118183847.GE3003@dtor-ws>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36322 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbaKRTJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 14:09:48 -0500
Content-Disposition: inline
In-Reply-To: <20141118183847.GE3003@dtor-ws>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <lw@karo-electronics.de>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 10:38:47AM -0800, Dmitry Torokhov wrote:
> Hi Felipe,
>=20
> On Tue, Nov 18, 2014 at 12:07:04PM -0600, Felipe Balbi wrote:
> > i2c devices match against struct i2c_device_id
> > even for CONFIG_OF case, so adding a struct of_device_id
> > doesn't change anything. As a result, currently, edt-ft5x06
> > will not autoprobe if built as a module.
>=20
> Why doe snot it autoprobe? We properly declare MODULE_DEVICE_TABLE for
> OF, is it because we are missing some data in device uevent?

because of of_i2c_register_devices(). Maybe Wolfram can give a better
explanation here, but it just doesn't match through of_device_id.

Apply this:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6..f0dc16e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -449,8 +449,10 @@ static const struct i2c_device_id *i2c_match_id(const =
struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
 	while (id->name[0]) {
-		if (strcmp(client->name, id->name) =3D=3D 0)
+		if (strcmp(client->name, id->name) =3D=3D 0) {
+			dev_info(&client->dev, "i2c_device_id match\n");
 			return id;
+		}
 		id++;
 	}
 	return NULL;
@@ -465,8 +467,10 @@ static int i2c_device_match(struct device *dev, struct=
 device_driver *drv)
 		return 0;
=20
 	/* Attempt an OF style match */
-	if (of_driver_match_device(dev, drv))
+	if (of_driver_match_device(dev, drv)) {
+		dev_info(dev, "of driver match\n");
 		return 1;
+	}
=20
 	/* Then ACPI style match */
 	if (acpi_driver_match_device(dev, drv))
@@ -1081,6 +1085,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_b=
oard_info const *info)
 	client->dev.bus =3D &i2c_bus_type;
 	client->dev.type =3D &i2c_client_type;
 	client->dev.of_node =3D info->of_node;
+	dev_info(&adap->dev, "%s: of_node %p\n", __func__, info->of_node);
 	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
=20
 	i2c_dev_set_name(adap, client);
@@ -1411,6 +1416,7 @@ static void of_i2c_register_devices(struct i2c_adapte=
r *adap)
=20
 		info.irq =3D irq_of_parse_and_map(node, 0);
 		info.of_node =3D of_node_get(node);
+		dev_info(&adap->dev, "%s: of_node %p\n", __func__, info.of_node);
 		info.archdata =3D &dev_ad;
=20
 		if (of_get_property(node, "wakeup-source", NULL))

then boot the board and you get http://hastebin.com/oqemezajez

Interesting, it's matching against of but only when I modprobe.

Let me debug this one a little more.

> > To fix the issue and still maintain backwards compatibility
> > with all DTS files currently in tree, we're just moving
> > all ids from of_device_id to i2c_device_id while also
> > adding the following specific ids which should be used
> > from now on:
> >=20
> > 	{ "edt-ft5206", 0, }
> > 	{ "edt-ft5306", 0, }
> > 	{ "edt-ft5406", 0, }
>=20
> Is this a tee-wide change? Link to the discussion?

nope, just found it with my AM437x Starter Kit.

--=20
balbi

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa5liAAoJEIaOsuA1yqREeacQAIPcqtTprNSQYLWrXNj6Ifxn
0IvLKEqEnLhvjIhCXr2E0PpO+jWyli6c8UI8Vc7/zqcliFYQ4kUad2tFK5o0wva7
n0TSjaBtqIUIORmeRrs9QxX969IDJFzQyWQ8DTs8kVb1e5OLYyl/ArvNFcdi+o4k
4FEgJm2YNHghXGjAyNeLKgWqSJFso2JWA99Rh/3g3IIRsT/csyADXwNPzaliNA5L
uXKZXxeSmtDgFql9g+p+PZF44Pdli8MiH53sfyAkNVWWV2VP10kfJ8FaFmP6m82V
cRPStn+jHQs3rnO7uiFEsJcIQaKLkKdfeU+qd3KHMbfG2LtZpPpFo7t0RRcFMK4M
kpcRcvAIkNb/ULS+d/vCgYblc7WwJ+K+MvQp4SLUfvaHRq5RFGCo0/V2NUmlCDmF
TnZo+IRJ+R/F9sMVjmsXsgR6UZTk1Gbi/Mlfn+XBEpIXoLNb2JmI8JTuRMUQgAT0
z8+3SzVBjNmOw3Lm6Yulu0O/vYB9Gw3FSX/43tUO0aBF9ZVv74NuTF6hdVNhHiUO
1HFStRmrDOPHfQ6I9onsAoCsoTP0D1AF18Di+7Bb3Yyy0HBqYteFTV+E8tEW2xOp
acN7iA0it5j96JrCkKZDsFK4cPWhsAllkh6HTPgN+Vb6F1qUdcjMz0f+ES+PdB1T
iFSQokyhnMNwE327E/Ud
=pq3h
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
