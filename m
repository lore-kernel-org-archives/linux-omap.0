From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/20] OMAPDSS: remove initial display code from omapdss
Date: Mon, 29 Oct 2012 12:25:03 +0200
Message-ID: <508E597F.60406@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-6-git-send-email-tomi.valkeinen@ti.com> <508E54C8.9070209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3594F552AFC1D3AA757217F1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56269 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758492Ab2J2KZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 06:25:09 -0400
In-Reply-To: <508E54C8.9070209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig3594F552AFC1D3AA757217F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-29 12:04, Archit Taneja wrote:
> On Wednesday 24 October 2012 02:58 PM, Tomi Valkeinen wrote:
>> Currently omapdss driver sets up the initial connections between
>> overlays, overlay manager and a panel, based on default display
>> parameter coming from the board file or via module parameters.
>>
>> This is unnecessary, as it's the higher level component that should
>> decide what display to use and how. This patch removes the code from
>> omapdss, and implements similar code to omapfb.
>>
>> The def_disp module parameter and the default display platform_data
>> parameter are kept in omapdss, but omapdss doesn't do anything with
>> them. It will just return the default display name with
>> dss_get_default_display_name() call, which omapfb uses. This is done t=
o
>> keep the backward compatibility.
>=20
> We might need to do something similar for omap_vout and omapdrm also to=

> set the initial connections.

I believe omapdrm already does this.

For omap_vout... I'm not sure if we can do that. Both omapfb and
omap_vout work at the same time, so they could be setting up the
settings at the same time, perhaps with conflicting values. The reason I
left omap_vout out is that I think omapfb is always used with omap_vout,
thus the config can be left for omapfb. I didn't test this, though.

>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/core.c           |    1 +
>>   drivers/video/omap2/dss/display.c        |   78
>> +++---------------------------
>>   drivers/video/omap2/omapfb/omapfb-main.c |   77
>> ++++++++++++++++++++++++-----
>>   include/video/omapdss.h                  |    1 +
>>   4 files changed, 75 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/core.c
>> b/drivers/video/omap2/dss/core.c
>> index 685d9a9..4cb669e 100644
>> --- a/drivers/video/omap2/dss/core.c
>> +++ b/drivers/video/omap2/dss/core.c
>> @@ -57,6 +57,7 @@ const char *dss_get_default_display_name(void)
>>   {
>>       return core.default_display_name;
>>   }
>> +EXPORT_SYMBOL(dss_get_default_display_name);
>=20
> Since we are exporting this, it might be better to name it
> omapdss_get_default_display_name

True.

>>   enum omapdss_version omapdss_get_version(void)
>>   {
>> diff --git a/drivers/video/omap2/dss/display.c
>> b/drivers/video/omap2/dss/display.c
>> index 1e58730..6d33112 100644
>> --- a/drivers/video/omap2/dss/display.c
>> +++ b/drivers/video/omap2/dss/display.c
>> @@ -320,86 +320,21 @@ void omapdss_default_get_timings(struct
>> omap_dss_device *dssdev,
>>   }
>>   EXPORT_SYMBOL(omapdss_default_get_timings);
>>
>> -/*
>> - * Connect dssdev to a manager if the manager is free or if force is
>> specified.
>> - * Connect all overlays to that manager if they are free or if force =
is
>> - * specified.
>> - */
>> -static int dss_init_connections(struct omap_dss_device *dssdev, bool
>> force)
>> +int dss_init_device(struct platform_device *pdev,
>> +        struct omap_dss_device *dssdev)
>>   {
>> +    struct device_attribute *attr;
>>       struct omap_dss_output *out;
>> -    struct omap_overlay_manager *mgr;
>>       int i, r;
>>
>>       out =3D omapdss_get_output_from_dssdev(dssdev);
>>
>> -    WARN_ON(dssdev->output);
>> -    WARN_ON(out->device);
>> -
>>       r =3D omapdss_output_set_device(out, dssdev);
>>       if (r) {
>>           DSSERR("failed to connect output to new device\n");
>>           return r;
>>       }
>=20
> So, we still manage the output-device links in the omapdss driver, but
> move the manager-output and overlay-manager links to omapfb. I guess
> this is fine. But maybe this split might change based on how generic
> panel framework looks like, and how much we want to expose outputs to
> fb/drm.

We can set the output-device link in omapdss because it's a hardware
configuration. A panel is connected to an output, so there's nothing to
configure there. ovls and ovl-mgrs, on the other hand, may be configured
depending on the use cases.

But yes, I wouldn't be surprised if this will be changed with common
panel framework.

 Tomi



--------------enig3594F552AFC1D3AA757217F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQjlmCAAoJEPo9qoy8lh71ucgQAKaLWU/3zBeOSetY1jkRdJio
9VAuq1TzRm6PLTNdTHLY9en1q2iQx+jEm81/cU5dGxgA6BYPjN2aBqy55kVIOP/L
2txh3COqrcfgq+WiGuAs0nM9/wdyoG5Ae4FSi7Du6NGmhrduCKl19tsa8+KidgTs
IgwYqEsLbGRVLTSpLc/+WmCAW/VZ9oq5B5dVCYmq4v0zR7Dqj0ARYNbI2ecq7q4c
lt21MpZu5Dcm4aeDtFJN9JH7xHi3Nng4dDd8bv7ThZ0WH2v2mQIiHTa/P8m90xwZ
ElKf9rQwF7oRco6kXB3pT9PZUQjy9aA6+SJ4Pet5z0klRSlQtSOxLMpBzCP9YPYn
+gVlPy4UY+Lmp4S/qEPod/Fk5KVqyagC5SCkNOlHfD8GXDGAxZoZMqHC9JJI8+PP
LV81B5h78bpm7+nQkRZxBM3irYJIRfe7swYsa6lTmQYdoTHgrCLjFW9NpiBszWbp
eLwsPIRLs2aYlGe2k66LjV5cefeOKYXELcwwTyj/BAAy6Zg4WxEP8Khk804OojgS
wW36TOzEtEyqm6C0b6ZLa93KTLPvs/sGGRf1Eh6BNw7DIEV/2t5CpSt+2Tw6h+4M
//2uir2ZUseH7F50ZesGM/r9JJOZnpfoM4JnFhBqz2cMzjXl3gqeNQajHyVXXJ8a
JZWim8C7IXzEjd/rg9A/
=twdh
-----END PGP SIGNATURE-----

--------------enig3594F552AFC1D3AA757217F1--
