From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 11:29:58 +0300
Message-ID: <52429F06.6030609@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FkihqlPN33vQOrI9r79pCSloO0H3MrSW3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33899 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab3IYIaF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 04:30:05 -0400
In-Reply-To: <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

--FkihqlPN33vQOrI9r79pCSloO0H3MrSW3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 10:45, Dr. H. Nikolaus Schaller wrote:
> Hi,
>=20
> Am 25.09.2013 um 09:09 schrieb Belisko Marek:
>=20
>> CC - Nikolaus Schaller
>>
>> On Wed, Sep 25, 2013 at 8:12 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>>> On 24/09/13 23:04, Belisko Marek wrote:
>>>> Hi,
>>>>
>>>> we're using connector-analog-tv driver to enable TV out on gta04
>>>> board. There is exception that we need to change some twl registers =
+
>>>> some gpio when enable/disable TV output. My question is if there is
>>>> some way how to do that or do we need to copy'n'paste code from
>>>> connector-analog-tv driver and extend it for handling we need (let's=

>>>> call it hack)?
>>>
>>> What are those TWL registers and GPIO used for?
>=20
> The GTA04 devices uses an OPA362 video amplifier connected to the TV_VF=
B1 pin
> of the DM3730. According to some not well known discussion with TI [1] =
we must
> therefore configure the AC bias and Bypass through the DEVCONF1 registe=
r.

Ah, OPA. A blast from the past =3D).

Well, OPA is a distinct hardware block in the video path, I see no issue
in having an OPA encoder driver, that sits in between VENC and the
connector.

The driver should handle things described in the OPA datasheet. With a
quick glance, there seems to be one GPIO and one power line to OPA.

> [1] https://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p=
/94072/343691.aspx
>=20
> And we have to disable (High-Z) the OPA362 amplifier if TVout is not in=
 use since the
> line is shared with a different function (microphone input).
>=20
> The reasons to use the OPA362 at all are to do short circuit protection=
 and to high-Z
> the driver (both are n/a with the DM3730 as far as we know).
>=20
> The code we did use successfully in the 2.6.32 board file is:
>=20
> 120 #define TV_OUT_GPIO     23
>=20
> 374 static int gta04_panel_enable_tv(struct omap_dss_device *dssdev)
> 375 {
> 376         u32 reg;
> 377=20
> 378 #define ENABLE_VDAC_DEDICATED           0x03
> 379 #define ENABLE_VDAC_DEV_GRP             0x20
> 380 #define OMAP2_TVACEN                            (1 << 11)
> 381 #define OMAP2_TVOUTBYPASS                       (1 << 18)
> 382=20
> 383         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
> 384                         ENABLE_VDAC_DEDICATED,
> 385                         TWL4030_VDAC_DEDICATED);
> 386         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
> 387                         ENABLE_VDAC_DEV_GRP, TWL4030_VDAC_DEV_GRP);=


All that i2c stuff should be handled by using the normal regulator
framework.

> 388=20
> 389         /* idea taken from https://e2e.ti.com/support/dsp/omap_appl=
ications_processors/f/447/p/94072/343691.aspx */
> 390         reg =3D omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
> 391 //      printk(KERN_INFO "Value of DEVCONF1 was: %08x\n", reg);
> 392         reg |=3D OMAP2_TVOUTBYPASS;       /* enable TV bypass mode =
for external video driver (for OPA362 driver) */
> 393         reg |=3D OMAP2_TVACEN;            /* assume AC coupling to =
remove DC offset */
> 394         omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
> 395         reg =3D omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
> 396 //      printk(KERN_INFO "Value of DEVCONF1 now: %08x\n", reg);
> 397=20
> 398         gpio_set_value(TV_OUT_GPIO, 1); /* enable output driver (OP=
A362) */
> 399=20
> 400         return 0;
> 401 }
> 402=20
> 403 static void gta04_panel_disable_tv(struct omap_dss_device *dssdev)
> 404 {
> 405         gpio_set_value(TV_OUT_GPIO, 0); /* disable output driver (a=
nd re-enable microphone) */
> 406=20
> 407         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x00,
> 408                         TWL4030_VDAC_DEDICATED);
> 409         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x00,
> 410                         TWL4030_VDAC_DEV_GRP);
> 411 }
> 412
> 413 static struct omap_dss_device gta04_tv_device =3D {
> 414         .name =3D "tv",
> 415         .driver_name =3D "venc",
> 416         .type =3D OMAP_DISPLAY_TYPE_VENC,
> 417         /* GTA04 has a single composite output (with external video=
 driver) */
> 418         .phy.venc.type =3D OMAP_DSS_VENC_TYPE_COMPOSITE,
> 419         .phy.venc.invert_polarity =3D true,       /* needed if we u=
se external video driver */
> 420         .platform_enable =3D gta04_panel_enable_tv,
> 421         .platform_disable =3D gta04_panel_disable_tv,
> 422 };
>=20
> I think (but don't know) that controlling the TWL/VDAC is no longer nee=
ded because
> it should be done through the connector-analog-tv driver.

I don't think VDAC is related to the connector (although I didn't
actually look at the analog video when I created the new
connector-analog-driver). If there's something specifically related to
an analog tv out connector that requires power, then, yes, it's needed.
But if it's all about OMAP's VENC and OPA, then the connector itself
does not require anything.

As an example, DVI connector does require a +5V (if I recall right), and
that +5V is not related to the DVI video source, it's only about the
connector. So in that case, the DVI connector driver should handle the
+5V (it doesn't, currently, but will soon be added).

> So we need to
> 1. control a GPIO - very similar to a TFT panel
> 2. invert polarity
> 3. configure the OMAP343X_CONTROL_DEVCONF1 register as needed
>=20
> I don't know if we must do step 3. each time we enable TVout (because w=
e can't
> assume that no other part of the kernel code writes to the DEVCONF1 reg=
ister) so that
> it could be done in the board init code.

So, is the GPIO the one that goes to OPA? Is VDAC the power to OPA? VDAC
is already used by VENC, which manages it, so if VDAC is only used for
VENC, there's no need for to handle it anywhere else.

The DEVCONF1 register is problematic. For that we need some kind of
platform hooks. We have some already for PM and DSI pins, so we could
add a new one for TV-out. However, the DSI pins (hopefully) could be
handled by the pinmuxing framework. Maybe that would be applicable here
also.

 Tomi



--FkihqlPN33vQOrI9r79pCSloO0H3MrSW3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQp8GAAoJEPo9qoy8lh71TQMP+wYQoexLADVClAHp2kBsfiUZ
BuPAid+SrfyBlQNfAEhxyYXB0wCDVUwY4fuMpwrQfhzv+EYjz9fQlX/4TXUCtV2D
ZspGBZsgyE+NIReMyk0nCKcCsdDIZUkoyAYJ/wTM+/d2xbWlgFDL/iA3/wVrO0v7
Ve5gp8G6w2h+jI1xRqGdeK/gwGOa8aBFC9Or77f/fMO9ovDo1JgNMIc/av2shknr
TQGxGz814juIRFGj8oYTZP7OciObmDhDP6jkgbSveHHmioAFNqkPmYEJKFPd0qsc
egHvZ/pPL4i1HgBzxvNcTFPQMjbfx/qyieWnND5uyxD0HMr9UPL0mNZx47K7EMn3
ama6p+3Tx9VYTsDWP2w3V9ICS8N3ueiRXinw4fwxruq+OQTtwHWpgQwWT9EhD0BM
DIYK8Z+88PsrHpsZgZOY0ncYY2rLaztr2nvZffZ4Uq+i73A9G6+UjPV0ymKisUgL
HOWkwRZO4jKE7TbcvZXnHMDKHzQLvGgy74FqvlGthVfE42Of0Mhai7Gx+IGhIQBa
jQvWEdHBpy1ncpzixXgVHCQBP4OdDWPLAsannOoXy6QNPyc/b/qW/g2UPa2UWEGo
qDHyzIN5WHGuOMpKg565i/BqWKinnoAztg0HAJtaI8GGpAbxw5Ko3be+P7gHp0yT
K799aWMDnrE87cOigFs5
=IYyj
-----END PGP SIGNATURE-----

--FkihqlPN33vQOrI9r79pCSloO0H3MrSW3--
