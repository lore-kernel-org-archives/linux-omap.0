From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 14:01:45 +0200
Message-ID: <513DC7A9.5000405@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com> <513D716C.2050807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig83AEF23C369237EB65820988"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab3CKMBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 08:01:47 -0400
In-Reply-To: <513D716C.2050807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig83AEF23C369237EB65820988
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 07:53, Archit Taneja wrote:
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
>=20
> I had another comment for this patch. On OMAP5, it makes sense for us t=
o
> not use LCD2 as the recommended channel. LCD2_CLK's only source is
> DSS_CLK from PRCM. So it's not a very flexible channel to use. We could=

> use LCD3 (at the cost of not using DSI2).
>=20
> We also need to fix dpi_get_dsidev() for OMAP5. Currently, it assumes
> that LCD2_CLK can be sourced from DSI2 PLL, we need to ensure DPI has a=

> dsidev only if it's LCD1 or LCD3.

I fixed it this way:


Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Mon Mar 11 13:57:38 2013 +0200

    OMAPDSS: DPI: fix dpi_get_dsidev() for omap5
   =20
    On OMAP5 the DISPC channels and DSI PLLs are not connected the same w=
ay.
    LCD2 on OMAP5 cannot use any DSI PLL as a source clock, but LCD3 can =
use
    DSI2's PLL.
   =20
    This patch fixes dpi_get_dsidev() by adding separate case for OMAP5 t=
o
    handle the difference.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.=
c
index 409e53b..433eff7 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -63,15 +63,29 @@ static struct platform_device *dpi_get_dsidev(enum om=
ap_channel channel)
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
 		return NULL;
-	default:
-		break;
-	}
=20
-	switch (channel) {
-	case OMAP_DSS_CHANNEL_LCD:
-		return dsi_get_dsidev_from_id(0);
-	case OMAP_DSS_CHANNEL_LCD2:
-		return dsi_get_dsidev_from_id(1);
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		switch (channel) {
+		case OMAP_DSS_CHANNEL_LCD:
+			return dsi_get_dsidev_from_id(0);
+		case OMAP_DSS_CHANNEL_LCD2:
+			return dsi_get_dsidev_from_id(1);
+		default:
+			return NULL;
+		}
+
+	case OMAPDSS_VER_OMAP5:
+		switch (channel) {
+		case OMAP_DSS_CHANNEL_LCD:
+			return dsi_get_dsidev_from_id(0);
+		case OMAP_DSS_CHANNEL_LCD3:
+			return dsi_get_dsidev_from_id(1);
+		default:
+			return NULL;
+		}
+
 	default:
 		return NULL;
 	}



--------------enig83AEF23C369237EB65820988
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPcepAAoJEPo9qoy8lh71/cEQAJ8w0l680m8oqWwGupuET06A
/bdFJ1FSEsxSLmBQ+2ZQ32IMb5IOI5oPFF4HVF6azI49KSqZfzj8Tz8RUN6pl0xu
fOAKqncR6ml3YS9efK1SkJ12WZFF3HyUjhYYKIcyDAHta9SmyIZbYEgArfs4grgQ
YqHHXftAzxJZArDTtbwsiDJrRZsiG/13SN7o7Te06gmXa5y1B8rrvAOsac7Jz/Ve
C7fxf42IpDuH2cpYIjDSEyw+wVm7zhMf7bTwrVdElzr1e7Jq2tWcLnHWyvD6zfdr
z/Ci3qWEia+sz64OQTwUuUJinqoO61BpVRCnu5M7GOsGuptVNYynXBjKnYdXx5tR
8SW5pmFLCB6f52snGKoQbk4QhoUomzC94NyYl9EGzMO3I340sSNtzknakAVDKrLd
KnrQJPOH+Mg0l6Yv90t3PDZaq/lpkTGlnNdPBpt7XnBOYc7jtDbL6NxH9DbyWGzM
xtWDfPGuf6rpK/kCKTvaCcbRS+GiiWO45sBLdDF0jwLrjQpcIxFhOEr8SdWhewmO
b+BLXEJngQT99ItrnJdtGnCAqjB0iCA19o9wkTTwv2V+1lHf8cIk38tRlbxz+i2u
k0xMA5Cb540qFKzCAcR1YJpr5Z8E3bVQVCRcNY0WDKOYo4BwkPiaAK/4bwjpYFvp
Y4A4vRywxRev8OvsP+cl
=xCS2
-----END PGP SIGNATURE-----

--------------enig83AEF23C369237EB65820988--
