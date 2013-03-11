From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 14:05:04 +0200
Message-ID: <513DC870.3030908@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com> <513D6D06.7030902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37F4569D775F257B6E69B057"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39350 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3CKMFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 08:05:06 -0400
In-Reply-To: <513D6D06.7030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig37F4569D775F257B6E69B057
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 07:35, Archit Taneja wrote:
> Hi,
>=20
> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>> The DISPC channel used for each output is currently passed in panel
>> platform data from the board files.
>>
>> To simplify this, and to make the panel drivers less dependent on OMAP=
,
>> this patch changes omapdss to resolve the channel independently. The
>> channel is resolved based on the OMAP version and, in case of DSI, the=

>> DSI module id.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dpi.c  |   37 ++++++++++++++++++++++++++----=
-
>>   drivers/video/omap2/dss/dsi.c  |   48
>> ++++++++++++++++++++++++++++++++++++++++
>>   drivers/video/omap2/dss/rfbi.c |    2 ++
>>   drivers/video/omap2/dss/sdi.c  |    2 ++
>>   4 files changed, 84 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dpi.c
>> b/drivers/video/omap2/dss/dpi.c
>> index e282456..3261644 100644
>> --- a/drivers/video/omap2/dss/dpi.c
>> +++ b/drivers/video/omap2/dss/dpi.c
>> @@ -396,12 +396,44 @@ static int __init dpi_verify_dsi_pll(struct
>> platform_device *dsidev)
>>       return 0;
>>   }
>>
>> +/*
>> + * Return a hardcoded channel for the DPI output. This should work fo=
r
>> + * current use cases, but this can be later expanded to either resolv=
e
>> + * the channel in some more dynamic manner, or get the channel as a u=
ser
>> + * parameter.
>> + */
>> +static enum omap_channel dpi_get_channel(void)
>> +{
>> +    switch (omapdss_get_version()) {
>> +    case OMAPDSS_VER_OMAP24xx:
>> +    case OMAPDSS_VER_OMAP34xx_ES1:
>> +    case OMAPDSS_VER_OMAP34xx_ES3:
>> +    case OMAPDSS_VER_OMAP3630:
>> +    case OMAPDSS_VER_AM35xx:
>> +        return OMAP_DSS_CHANNEL_LCD;
>> +
>> +    case OMAPDSS_VER_OMAP4430_ES1:
>> +    case OMAPDSS_VER_OMAP4430_ES2:
>> +    case OMAPDSS_VER_OMAP4:
>> +        return OMAP_DSS_CHANNEL_LCD2;
>> +
>> +    case OMAPDSS_VER_OMAP5:
>> +        return OMAP_DSS_CHANNEL_LCD2;
>> +
>> +    default:
>> +        DSSWARN("unsupported DSS version\n");
>> +        return OMAP_DSS_CHANNEL_LCD;
>> +    }
>> +}
>> +
>>   static int __init dpi_init_display(struct omap_dss_device *dssdev)
>>   {
>>       struct platform_device *dsidev;
>>
>>       DSSDBG("init_display\n");
>>
>> +    dssdev->channel =3D dpi_get_channel();
>=20
> In patch 14 of the series, we remove these dssdev->channel assignments.=

> I don't see the point of adding them in this patch in the first place.
> The dssdev->channel assignments will not be modified in this series, so=

> we don't need to worry about a kernel crash or something after this pat=
ch.
>=20
> I feel this patch should only add the dpi_get_channel and
> dsi_get_channel funcs.

Here's the combined patch. I changed the recommended_channel to dispc_cha=
nnel.
"recommended" was not that good name, as currently the channel cannot be =
changed
later, because, for example in DPI case, we store the DSI PLL which is ba=
sed on
the channel.


Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Wed Feb 13 11:23:54 2013 +0200

    OMAPDSS: add output->dispc_channel
   =20
    The DISPC channel used for each output is currently passed in panel
    platform data from the board files.
   =20
    To simplify this, and to make the panel drivers less dependent on OMA=
P,
    this patch changes omapdss to resolve the channel independently. The
    channel is resolved based on the OMAP version and, in case of DSI, th=
e
    DSI module id. This resolved channel is stored into a new field in
    output, dispc_channel.
   =20
    The few places where dssdev->channel was used are changed to use
    output->recommended_channel. After this patch, dssdev->channel is
    obsolete.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.=
c
index e282456..409e53b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -396,6 +396,36 @@ static int __init dpi_verify_dsi_pll(struct platform=
_device *dsidev)
 	return 0;
 }
=20
+/*
+ * Return a hardcoded channel for the DPI output. This should work for
+ * current use cases, but this can be later expanded to either resolve
+ * the channel in some more dynamic manner, or get the channel as a user=

+ * parameter.
+ */
+static enum omap_channel dpi_get_channel(void)
+{
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP24xx:
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		return OMAP_DSS_CHANNEL_LCD;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		return OMAP_DSS_CHANNEL_LCD2;
+
+	case OMAPDSS_VER_OMAP5:
+		return OMAP_DSS_CHANNEL_LCD3;
+
+	default:
+		DSSWARN("unsupported DSS version\n");
+		return OMAP_DSS_CHANNEL_LCD;
+	}
+}
+
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev;
@@ -416,12 +446,7 @@ static int __init dpi_init_display(struct omap_dss_d=
evice *dssdev)
 		dpi.vdds_dsi_reg =3D vdds_dsi;
 	}
=20
-	/*
-	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
-	 * source for DPI is SoC integration detail, not something that should
-	 * be configured in the dssdev
-	 */
-	dsidev =3D dpi_get_dsidev(dssdev->channel);
+	dsidev =3D dpi_get_dsidev(dpi.output.dispc_channel);
=20
 	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
 		dsidev =3D NULL;
@@ -513,6 +538,7 @@ static void __init dpi_init_output(struct platform_de=
vice *pdev)
 	out->id =3D OMAP_DSS_OUTPUT_DPI;
 	out->type =3D OMAP_DISPLAY_TYPE_DPI;
 	out->name =3D "dpi";
+	out->dispc_channel =3D dpi_get_channel();
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.=
c
index 1a6ad6f..28e0b99 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4946,6 +4946,55 @@ void omapdss_dsi_set_videomode_timings(struct omap=
_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
=20
+/*
+ * Return a hardcoded channel for the DSI output. This should work for
+ * current use cases, but this can be later expanded to either resolve
+ * the channel in some more dynamic manner, or get the channel as a user=

+ * parameter.
+ */
+static enum omap_channel dsi_get_channel(int module_id)
+{
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP24xx:
+		DSSWARN("DSI not supported\n");
+		return OMAP_DSS_CHANNEL_LCD;
+
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		return OMAP_DSS_CHANNEL_LCD;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		switch (module_id) {
+		case 0:
+			return OMAP_DSS_CHANNEL_LCD;
+		case 1:
+			return OMAP_DSS_CHANNEL_LCD2;
+		default:
+			DSSWARN("unsupported module id\n");
+			return OMAP_DSS_CHANNEL_LCD;
+		}
+
+	case OMAPDSS_VER_OMAP5:
+		switch (module_id) {
+		case 0:
+			return OMAP_DSS_CHANNEL_LCD;
+		case 1:
+			return OMAP_DSS_CHANNEL_LCD3;
+		default:
+			DSSWARN("unsupported module id\n");
+			return OMAP_DSS_CHANNEL_LCD;
+		}
+
+	default:
+		DSSWARN("unsupported DSS version\n");
+		return OMAP_DSS_CHANNEL_LCD;
+	}
+}
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev =3D
@@ -5184,6 +5233,7 @@ static void __init dsi_init_output(struct platform_=
device *dsidev)
=20
 	out->type =3D OMAP_DISPLAY_TYPE_DSI;
 	out->name =3D dsi->module_id =3D=3D 0 ? "dsi0" : "dsi1";
+	out->dispc_channel =3D dsi_get_channel(dsi->module_id);
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
index 888cfe3..e03619a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1012,8 +1012,6 @@ static void __init hdmi_probe_pdata(struct platform=
_device *pdev)
 	hdmi.ls_oe_gpio =3D priv->ls_oe_gpio;
 	hdmi.hpd_gpio =3D priv->hpd_gpio;
=20
-	dssdev->channel =3D OMAP_DSS_CHANNEL_DIGIT;
-
 	r =3D hdmi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
@@ -1047,6 +1045,7 @@ static void __init hdmi_init_output(struct platform=
_device *pdev)
 	out->id =3D OMAP_DSS_OUTPUT_HDMI;
 	out->type =3D OMAP_DISPLAY_TYPE_HDMI;
 	out->name =3D "hdmi";
+	out->dispc_channel =3D OMAP_DSS_CHANNEL_DIGIT;
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfb=
i.c
index a47a9e5..05c0646 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1026,6 +1026,7 @@ static void __init rfbi_init_output(struct platform=
_device *pdev)
 	out->id =3D OMAP_DSS_OUTPUT_DBI;
 	out->type =3D OMAP_DISPLAY_TYPE_DBI;
 	out->name =3D "rfbi";
+	out->dispc_channel =3D OMAP_DSS_CHANNEL_LCD;
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.=
c
index 0802927..5d37db5 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -279,6 +279,7 @@ static void __init sdi_init_output(struct platform_de=
vice *pdev)
 	out->id =3D OMAP_DSS_OUTPUT_SDI;
 	out->type =3D OMAP_DISPLAY_TYPE_SDI;
 	out->name =3D "sdi";
+	out->dispc_channel =3D OMAP_DSS_CHANNEL_LCD;
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/ven=
c.c
index c8130f8..866e015 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -786,8 +786,6 @@ static void __init venc_probe_pdata(struct platform_d=
evice *vencdev)
=20
 	dss_copy_device_pdata(dssdev, plat_dssdev);
=20
-	dssdev->channel =3D OMAP_DSS_CHANNEL_DIGIT;
-
 	r =3D venc_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
@@ -820,6 +818,7 @@ static void __init venc_init_output(struct platform_d=
evice *pdev)
 	out->id =3D OMAP_DSS_OUTPUT_VENC;
 	out->type =3D OMAP_DISPLAY_TYPE_VENC;
 	out->name =3D "venc";
+	out->dispc_channel =3D OMAP_DSS_CHANNEL_DIGIT;
=20
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/oma=
p2/omapfb/omapfb-main.c
index ca585ef..f38348e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2388,7 +2388,7 @@ static int omapfb_init_connections(struct omapfb2_d=
evice *fbdev,
 		struct omap_dss_device *dssdev =3D fbdev->displays[i].dssdev;
 		struct omap_dss_output *out =3D dssdev->output;
=20
-		mgr =3D omap_dss_get_overlay_manager(dssdev->channel);
+		mgr =3D omap_dss_get_overlay_manager(out->dispc_channel);
=20
 		if (!mgr || !out)
 			continue;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ba9cea7..ec322a7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -547,6 +547,9 @@ struct omap_dss_output {
 	/* display type supported by the output */
 	enum omap_display_type type;
=20
+	/* DISPC channel for this output */
+	enum omap_channel dispc_channel;
+
 	/* output instance */
 	enum omap_dss_output_id id;
=20



--------------enig37F4569D775F257B6E69B057
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPchwAAoJEPo9qoy8lh71ELIP/AjMBMghfT6LyzsCbsJd2IqG
8ah8XdJaYyodp+P93qrK5xu88Nq83xYvrhvHm/zx/kTw7uNteGdH5OMlNjEolXi4
LNt+Uty7q5QURgQI/mnYO7SCCmRaSdUJWkumaYX+VH1XHh9dirt2GToN3/7Gax/U
/ICInN/XohDcxpDn5WrQKGG2c+Y5VhfShCIht0mrbljTL0e7oKlBi4gLDSEGAMVr
1xAy6krvveXkNUiiJ6hOo9V5s7bu6yJAF/MXZicVKr61yYlHMJt1GRtf+LjMetfl
ftI36SETZzReythXYfAdP1SyqZAUEtFzWLpTSJlkntyMM7hkUK3n3DmqmK1mRUZB
c7NYcUelAsoUWOKxfuA+pauD/WEANYp7VsuXL4PkLGmlc/GSyV0cETgP0UAlcn8E
H3WH1DHY0USz1HVeZY+nGJ4JJE2YpbsDOuhO7hRvhaI265DM4GuAboWQmY7lx3kR
nqpusitVZ9/gSCDnlqp8saSBSstaUxj1/fzsZPfW5h5SqdAtNPJiMtA168faC7ql
7CncSUER3vE2fHSeWIXKBPQzc99tCtS/foPesXsqAS2lhoSQRQ9VwJ8vuRLWSg9N
Gwp5FzXsMS+/oS4vydfU50vf9Gnv0l/CxPt8aYH8m3mEmpdGeUUWZraoReaj3N4s
UKicU36rpdCkg7iRAZ4t
=4KOP
-----END PGP SIGNATURE-----

--------------enig37F4569D775F257B6E69B057--
