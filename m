From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 27/27] OMAPDSS: connector-analog-tv: Add DT support
Date: Wed, 27 Aug 2014 12:37:37 +0300
Message-ID: <53FDA6E1.9030103@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-28-git-send-email-tomi.valkeinen@ti.com> <21704808.AJTjtXoZly@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cSeAi14muu4gp06nHfSFB8Aowl6cRjxet"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35213 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549AbaH0Jhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2014 05:37:42 -0400
In-Reply-To: <21704808.AJTjtXoZly@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--cSeAi14muu4gp06nHfSFB8Aowl6cRjxet
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/08/14 19:58, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Monday 16 December 2013 16:56:34 Tomi Valkeinen wrote:
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  .../video/omap2/displays-new/connector-analog-tv.c | 66 +++++++++++++=
+++++-
>>  1 file changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c
>> b/drivers/video/omap2/displays-new/connector-analog-tv.c index
>> ccd9073f706f..ebed25a86487 100644
>> --- a/drivers/video/omap2/displays-new/connector-analog-tv.c
>> +++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/of.h>
>>
>>  #include <video/omapdss.h>
>>  #include <video/omap-panel-data.h>
>> @@ -42,6 +43,12 @@ static const struct omap_video_timings tvc_pal_timi=
ngs =3D
>> { .interlace	=3D true,
>>  };
>>
>> +static const struct of_device_id tvc_of_match[];
>> +
>> +struct tvc_of_data {
>> +	enum omap_dss_venc_type connector_type;
>> +};
>> +
>>  #define to_panel_data(x) container_of(x, struct panel_drv_data, dssde=
v)
>>
>>  static int tvc_connect(struct omap_dss_device *dssdev)
>> @@ -92,7 +99,10 @@ static int tvc_enable(struct omap_dss_device *dssde=
v)
>>  	in->ops.atv->set_timings(in, &ddata->timings);
>>
>>  	in->ops.atv->set_type(in, ddata->connector_type);
>> -	in->ops.atv->invert_vid_out_polarity(in, ddata->invert_polarity);
>> +
>> +	if (!ddata->dev->of_node)
>> +		in->ops.atv->invert_vid_out_polarity(in,
>> +			ddata->invert_polarity);
>>
>>  	r =3D in->ops.atv->enable(in);
>>  	if (r)
>> @@ -205,6 +215,35 @@ static int tvc_probe_pdata(struct platform_device=

>> *pdev) return 0;
>>  }
>>
>> +static int tvc_probe_of(struct platform_device *pdev)
>> +{
>> +	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
>> +	struct device_node *node =3D pdev->dev.of_node;
>> +	struct omap_dss_device *in;
>> +	const struct of_device_id *match;
>> +	const struct tvc_of_data *data;
>> +
>> +	match =3D of_match_node(tvc_of_match, pdev->dev.of_node);
>> +	if (!match) {
>> +		dev_err(&pdev->dev, "unsupported device\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	data =3D match->data;
>> +
>> +	in =3D omapdss_of_find_source_for_first_ep(node);
>> +	if (IS_ERR(in)) {
>> +		dev_err(&pdev->dev, "failed to find video source\n");
>> +		return PTR_ERR(in);
>> +	}
>> +
>> +	ddata->in =3D in;
>> +
>> +	ddata->connector_type =3D data->connector_type;
>> +
>> +	return 0;
>> +}
>> +
>>  static int tvc_probe(struct platform_device *pdev)
>>  {
>>  	struct panel_drv_data *ddata;
>> @@ -222,6 +261,10 @@ static int tvc_probe(struct platform_device *pdev=
)
>>  		r =3D tvc_probe_pdata(pdev);
>>  		if (r)
>>  			return r;
>> +	} else if (pdev->dev.of_node) {
>> +		r =3D tvc_probe_of(pdev);
>> +		if (r)
>> +			return r;
>>  	} else {
>>  		return -ENODEV;
>>  	}
>> @@ -263,12 +306,33 @@ static int __exit tvc_remove(struct platform_dev=
ice
>> *pdev) return 0;
>>  }
>>
>> +static const struct tvc_of_data tv_svideo_data =3D {
>> +	.connector_type =3D OMAP_DSS_VENC_TYPE_SVIDEO,
>> +};
>> +
>> +static const struct tvc_of_data tv_composite_video_data =3D {
>> +	.connector_type =3D OMAP_DSS_VENC_TYPE_COMPOSITE,
>> +};
>> +
>> +static const struct of_device_id tvc_of_match[] =3D {
>> +	{
>> +		.compatible =3D "svideo-connector",
>> +		.data =3D &tv_svideo_data,
>> +	},
>> +	{
>> +		.compatible =3D "composite-video-connector",
>=20
> I've just noticed that this doesn't match the bindings that document th=
e=20
> compatible value to be "composite-connector".

Thanks. arch/arm/boot/dts/omap3-n900.dts uses the same value as in the
bindings document, so I think the proper fix is to change the compatible
value for this driver. I'll make a patch.

 Tomi



--cSeAi14muu4gp06nHfSFB8Aowl6cRjxet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/abhAAoJEPo9qoy8lh71PXUP/jGF6fPcF++0TOYcaJ/H7kfq
qhhr99VPeOdCqkiwCR1tmWUgaNPzORusV7pPNNXozr0G62TJCqAKIVKrjzSrOOoa
a9vw1QPY0MDTO5k+Mqmlz/Voi7IiyRaPP/jNrvtmCxvaQOGwL7ZIhMhtgcFM5j5k
p1n6MRvz8EQrbUFKzh4RFMLTKHsrdHbcGfLFGktV7TS9sHh0bWdURv/uURuqvaGM
DOTQUDK7e4QM1z2fW9NGGPF45nnhKeyznFHRQDvdNLHP1mF/SfHDfQAyH3alcs5m
piL86b9d6Cl5GLZ2kLtueOGZMRYQSE8HIUUijLQfEEw3myhAywTtPhWvZXGrn2SS
ShffOtmn+9Q1Kym2I7FQ3LTSKtfO9qOM3VeT3Y1thkT/NYET6e3dED5YLrCy/6XC
Q74HM+RSL/NgmYJYEewR+0QPzANkb/Q5iOVahoA2357HkS9/6V2RHj7gh0h38Zzl
lupO939uv/jB1YKoPmgW+qiUiFXKULcSVLNYVgxzDep/I7fOWR6oTq+j5iBpb81O
rqFU3uvc0qN5JAw5efIyXa95v4zasJ1IJLUEVXRMVFXb94V6Hzxr8gFs1MoMwVrr
fTfyF7ZJelaGWZInOAg6HP54R56laEzJeHjMoeOxa3h2z21tey7DRatN6rWgRv+o
5rSoNdqy3wJEoOIFkU8L
=wayN
-----END PGP SIGNATURE-----

--cSeAi14muu4gp06nHfSFB8Aowl6cRjxet--
