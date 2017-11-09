From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 1/4] omapdrm: fix compatible string for td028ttec1
Date: Thu, 9 Nov 2017 07:05:15 +0100
Message-ID: <C999B55A-771D-44AF-8072-2F30FE6B54B7@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com> <8678120467a1d0e67d4d882b3f01d58867586653.1510175371.git.hns@goldelico.com> <2790033.EQlQQc1BPI@avalon>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2790033.EQlQQc1BPI@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

> Am 09.11.2017 um 04:33 schrieb Laurent Pinchart =
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>:
>=20
> Hi Nikolaus,
>=20
> Thank you for the patch.
>=20
> On Wednesday, 8 November 2017 23:09:29 EET H. Nikolaus Schaller wrote:
>> The vendor name was "toppoly" but other panels and the vendor list
>> have defined it as "tpo". So let's fix it in driver and bindings.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> .../display/panel/{toppoly,td028ttec1.txt =3D> tpo,td028ttec1.txt} | =
4 ++--
>> drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c           | 4 =
++--
>> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c  | 4 =
++--
>> 3 files changed, 6 insertions(+), 6 deletions(-)
>> rename
>> =
Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt =
=3D>
>> tpo,td028ttec1.txt} (84%)
>>=20
>> diff --git
>> =
a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>> b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
>> similarity index 84%
>> rename from
>> =
Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>> rename to
>> Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt =
index
>> 7175dc3740ac..ed34253d9fb1 100644
>> --- =
a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
>> +++ =
b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt @@
>> -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>=20
>> Required properties:
>> -- compatible: "toppoly,td028ttec1"
>> +- compatible: "tpo,td028ttec1"
>>=20
>> Optional properties:
>> - label: a symbolic name for the panel
>> @@ -14,7 +14,7 @@ Example
>> -------
>>=20
>> lcd-panel: td028ttec1@0 {
>> -	compatible =3D "toppoly,td028ttec1";
>> +	compatible =3D "tpo,td028ttec1";
>> 	reg =3D <0>;
>> 	spi-max-frequency =3D <100000>;
>> 	spi-cpol;
>> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c index
>> 0a38a0e8c925..2dab491478c2 100644
>> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
>> @@ -452,7 +452,7 @@ static int td028ttec1_panel_remove(struct =
spi_device
>> *spi) }
>>=20
>> static const struct of_device_id td028ttec1_of_match[] =3D {
>> -	{ .compatible =3D "omapdss,toppoly,td028ttec1", },
>> +	{ .compatible =3D "omapdss,tpo,td028ttec1", },
>=20
> Doesn't this break backward compatibility with existing DT ?

Yes, it does. But I am only aware of the GTA04 which uses it and
there is a separate fix).

>=20
>> 	{},
>> };
>>=20
>> @@ -471,7 +471,7 @@ static struct spi_driver td028ttec1_spi_driver =3D =
{
>>=20
>> module_spi_driver(td028ttec1_spi_driver);
>>=20
>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>> MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
>> MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
>> MODULE_LICENSE("GPL");
>> diff --git
>> a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
>> b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c =
index
>> 57e9e146ff74..39e1754746d2 100644
>> --- =
a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
>> +++ =
b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
>> @@ -455,7 +455,7 @@ static int td028ttec1_panel_remove(struct =
spi_device
>> *spi) }
>>=20
>> static const struct of_device_id td028ttec1_of_match[] =3D {
>> -	{ .compatible =3D "omapdss,toppoly,td028ttec1", },
>> +	{ .compatible =3D "omapdss,tpo,td028ttec1", },
>> 	{},
>> };
>>=20
>> @@ -474,7 +474,7 @@ static struct spi_driver td028ttec1_spi_driver =3D =
{
>>=20
>> module_spi_driver(td028ttec1_spi_driver);
>>=20
>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>> MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
>> MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
>> MODULE_LICENSE("GPL");
>=20
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
