From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 13:02:09 +0200
Message-ID: <513DB9B1.1030900@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com> <513D6D06.7030902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig630E65D549D6AD6E42228551"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3CKLCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 07:02:12 -0400
In-Reply-To: <513D6D06.7030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig630E65D549D6AD6E42228551
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

Yes, you're right. It's just extra going back and forth. I think I'll
merge this with the patch adding recommended channel.

>> +
>>       if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
>>                       dpi.vdds_dsi_reg =3D=3D NULL) {
>>           struct regulator *vdds_dsi;
>> @@ -416,11 +448,6 @@ static int __init dpi_init_display(struct
>> omap_dss_device *dssdev)
>>           dpi.vdds_dsi_reg =3D vdds_dsi;
>>       }
>>
>> -    /*
>> -     * XXX We shouldn't need dssdev->channel for this. The dsi pll cl=
ock
>> -     * source for DPI is SoC integration detail, not something that
>> should
>> -     * be configured in the dssdev
>> -     */
>>       dsidev =3D dpi_get_dsidev(dssdev->channel);
>>
>>       if (dsidev && dpi_verify_dsi_pll(dsidev)) {
>> diff --git a/drivers/video/omap2/dss/dsi.c
>> b/drivers/video/omap2/dss/dsi.c
>> index 1a6ad6f..c39ca86 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -4946,6 +4946,52 @@ void omapdss_dsi_set_videomode_timings(struct
>> omap_dss_device *dssdev,
>>   }
>>   EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
>>
>> +/*
>> + * Return a hardcoded channel for the DSI output. This should work fo=
r
>> + * current use cases, but this can be later expanded to either resolv=
e
>> + * the channel in some more dynamic manner, or get the channel as a u=
ser
>> + * parameter.
>> + */
>> +static enum omap_channel dsi_get_channel(int module_id)
>> +{
>> +    switch (omapdss_get_version()) {
>> +    case OMAPDSS_VER_OMAP24xx:
>=20
> We should remove the above case so that we hit the default case and get=

> a warning about omap2 not having DSI.

Yep, I'll fix that.

 Tomi




--------------enig630E65D549D6AD6E42228551
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPbmxAAoJEPo9qoy8lh716DUQALGCo1ZcCKS3NsjRjdxPosvx
nxNmbAq+LrC/FyJZKTyj7FF4BdYS9u4zMmePivgW/aQBqvMHzRJ8Ein9s148cVQB
m+vNWzbC6riCBO29WlWnUhGPbZa5VKkr0JCfQ3M1WHrXsZet9/QA+ApEAKGznJo4
BLDAXaCc/L/h4pi5Pjv/gzYVzPgG8HC0HjGjRo0HEmRrylIE6d9SQEWVtd0EY5IB
Qdcf99VxY52LkpEfv6XziP6VyzQbARwa0DtUTt7L9owfO9FMErGNsvl16awSrU0F
SNP0H9TG0gkZ3Wz9UN0vHOkzMIeJuQn+ohgScndtD/uUXGgm//EwHxq2AgN1L2vU
JXjAJuQM72lwo2aEyM5BPKFC9P7r9D+OVSnp9CyMyZ0l9QDLiZDrRekCjLKNTofI
0AI2utGngeqv/Q7wUmSP62vFdq/9jHuR2HlXcj2qnKOsyQ4NjO8CZ2JBWZyAmdHd
lfTIwppIz2MMbK+mCuRlRVCbYSJhtbrl46eZfzd8wTp9FGdh+ENK5QuASZhMBdOv
sx2zSpEhwvQNnvV8//S6t7F5Pu1XOb7aD3AU/NVLfrgjHUfDUwmR3ctO/xkNOC5W
Rca0MsJ+Al4tFyj1SgMDZOFU7h31CjzLC7RwQtMmuKkCdNj2PwN8SKIJmpz9afUh
jQ44SS0eNm5vsgd+4nHs
=XJNm
-----END PGP SIGNATURE-----

--------------enig630E65D549D6AD6E42228551--
