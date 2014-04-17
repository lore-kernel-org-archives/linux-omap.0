From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: HDMI on OMAP4460: clk rate mismatch warning
Date: Thu, 17 Apr 2014 10:24:26 +0300
Message-ID: <534F81AA.8060805@ti.com>
References: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>	<534E17B3.5050109@ti.com> <CAGhQ9Vx0RojsC=c8L_Dhg0u3uGRP3boiEtuq9XZPNMmEVtHWBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GqWmbdLo7nrPXTlwBXKkHnbM0ljGCNdL8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbaDQHYa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2014 03:24:30 -0400
In-Reply-To: <CAGhQ9Vx0RojsC=c8L_Dhg0u3uGRP3boiEtuq9XZPNMmEVtHWBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, "Sarha, Jyri" <jsarha@ti.com>

--GqWmbdLo7nrPXTlwBXKkHnbM0ljGCNdL8
Content-Type: multipart/mixed;
 boundary="------------000103060808050909040505"

This is a multi-part message in MIME format.
--------------000103060808050909040505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/04/14 19:11, Joachim Eastwood wrote:
> On 16 April 2014 07:40, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 15/04/14 20:36, Joachim Eastwood wrote:
>>> Hello,
>>>
>>> I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.=

>>> But during kernel boot I get the following message:
>>>
>>> [ 0.953796] ------------[ cut here ]------------
>>> [ 0.953826] WARNING: CPU: 0 PID: 1 at
>>> drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
>>> [ 0.953826] clk rate mismatch: 153600000 !=3D 170666666
>>
>> I have a fix (attached) for this in fbdev-fixes, which I'll probably b=
e
>> sending to Linus today. I couldn't send it in the main fbdev pull
>> request, as it depended on clk driver changes. And it's not fatal, mos=
t
>> likely things work fine even with the warning.
>=20
> The warning disappeared after the patch. Thanks.
> Feel free to add: Tested-By: Joachim Eastwood <manabian@gmail.com>

Thanks. It should be in -rc2.

> This board (VAR-STK-OM44) has a TPD12S521 which has no controllable
> settings so adding a driver for it would be pretty meaningless. I
> think it's the same situation with Gumstix Parlor. That board also
> just have a very simple HDMI transmitter which shouldn't require a
> driver.
>=20
> But never the less I got HDMI working on my board adding the tpd21s015
> nodes and providing a dummy gpio for "CT CP HPD". This works but it's
> a bit hacky.

Remove the tpd21s015 nodes and try the attached patch. It adds HPD
support to the hdmi connector. You also need something like this for the
hdmi-connector node:


pinctrl-names =3D "default";
pinctrl-0 =3D <&hdmi_conn_pins>;

hpd-gpios =3D <&gpio7 1 GPIO_ACTIVE_HIGH>; /* GPIO 193, HPD */


And the respective pinctrl node:

hdmi_conn_pins: pinmux_hdmi_conn_pins {
        pinctrl-single,pins =3D <
                0x0fe (PIN_INPUT_PULLDOWN | MUX_MODE6)
        >;
};

Note that I tested this yesterday on one board, but I couldn't get it
working yet, so no promises =3D). But that may be an issue with the HPD
pin on the board.

> One other thing.
> Does HDMI audio work with DT or is that a still TODO?
> I am only getting probe deferral's from omap-hdmi-audio. Haven't look
> to far into it.

It's still on the works. If you volunteer for testing it (and Jyri needs
someone to test), you can ask Jyri Sarha.

 Tomi


--------------000103060808050909040505
Content-Type: text/x-diff;
 name="0001-connector-hdmi-hpd-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-connector-hdmi-hpd-support.patch"

=46rom e004ca58936336f06339e216c1f4bd5f1e694932 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Apr 2014 10:18:58 +0300
Subject: [PATCH] connector-hdmi: hpd support

---
 drivers/video/omap2/displays-new/connector-hdmi.c | 23 +++++++++++++++++=
+++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/connector-hdmi.c b/drivers/=
video/omap2/displays-new/connector-hdmi.c
index 29ed21b9dce5..7b06ea430209 100644
--- a/drivers/video/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/omap2/displays-new/connector-hdmi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
=20
 #include <drm/drm_edid.h>
=20
@@ -43,6 +44,8 @@ struct panel_drv_data {
 	struct device *dev;
=20
 	struct omap_video_timings timings;
+
+	int hpd_gpio;
 };
=20
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
@@ -161,7 +164,10 @@ static bool hdmic_detect(struct omap_dss_device *dss=
dev)
 	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
 	struct omap_dss_device *in =3D ddata->in;
=20
-	return in->ops.hdmi->detect(in);
+	if (gpio_is_valid(ddata->hpd_gpio))
+		return gpio_get_value_cansleep(ddata->hpd_gpio);
+	else
+		return in->ops.hdmi->detect(in);
 }
=20
 static int hdmic_audio_enable(struct omap_dss_device *dssdev)
@@ -288,6 +294,8 @@ static int hdmic_probe_pdata(struct platform_device *=
pdev)
=20
 	pdata =3D dev_get_platdata(&pdev->dev);
=20
+	ddata->hpd_gpio =3D -ENODEV;
+
 	in =3D omap_dss_find_output(pdata->source);
 	if (in =3D=3D NULL) {
 		dev_err(&pdev->dev, "Failed to find video source\n");
@@ -307,6 +315,14 @@ static int hdmic_probe_of(struct platform_device *pd=
ev)
 	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
 	struct device_node *node =3D pdev->dev.of_node;
 	struct omap_dss_device *in;
+	int gpio;
+
+	/* HPD GPIO */
+	gpio =3D of_get_named_gpio(node, "hpd-gpios", 0);
+	if (gpio_is_valid(gpio))
+		ddata->hpd_gpio =3D gpio;
+	else
+		ddata->hpd_gpio =3D -ENODEV;
=20
 	in =3D omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
@@ -344,6 +360,11 @@ static int hdmic_probe(struct platform_device *pdev)=

 		return -ENODEV;
 	}
=20
+	r =3D devm_gpio_request_one(&pdev->dev, ddata->hpd_gpio,
+			GPIOF_DIR_IN, "hdmi_hpd");
+	if (r)
+		return r;
+
 	ddata->timings =3D hdmic_default_timings;
=20
 	dssdev =3D &ddata->dssdev;
--=20
1.8.3.2


--------------000103060808050909040505--

--GqWmbdLo7nrPXTlwBXKkHnbM0ljGCNdL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTT4GqAAoJEPo9qoy8lh71sn4P/2wzcbsByajTQEICjLm6bqed
KR075LylfjtVXAWFYrqnKdwuKgVbWcaOVRMv5/tdraK3Gc9D3n9KVT7kAdY6zhmZ
LkbMzC7S3uTv02Q++8zdHBFmbshxbx8YVJLuwOJj/U/2vTUrJOnTPGPcv9tpX03A
T3Ism02wF6oepPMcIPDIEWUR5je2tmgBkzRbIgbxYMmIUjgjGNhvk961grluuJv4
oJblPIzkLxqsASlzqysmzHC9eggL667oi3VLEKqEIU+2IhbQ1VUsliS6Rz/srsQQ
Yiww+4ILDWZ+HhANNFfXxTXI2H3zsKourDiEJEFLZHZJpI2DUrBFVwkNCcRfEZB+
WCfY2yLx+Hsgxx1mOhPSqAmNW2T7dm5qsG0A11Xj1IOTcr0QnXnfAVQWGLHDgTdA
cI7eKFeAiFkISXfa4Zo7eHbEzbCJ/UqiOlPXHeoPgfQUByIMYRy3qIMh3rUJkHMx
f8+voKI7pgdFWBOlI37+ZQ+W7oLt4bKX2lVWL7EbzOI6+yVREgKVoyZV0HwWbgv1
lKP5JUsbvTAHqSkwj5Cbl3y+AW+0qiNNsEFX3hDsmaEZPZuJViwUf7XUziXfgFxQ
AfZBH1mzjVnbWS5SFeTw8yDntJYbQ7b9dzEaMmmNVi/uLkii5tDRxn7LczdX60Ga
5MNlweWx6cm9M9K/Lkuf
=Jqse
-----END PGP SIGNATURE-----

--GqWmbdLo7nrPXTlwBXKkHnbM0ljGCNdL8--
