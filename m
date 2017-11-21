From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 4/4] drm: omapdrm: Fix DPI on platforms using the DSI VDDS
Date: Tue, 21 Nov 2017 11:38:13 +0100
Message-ID: <040DF543-B168-4537-A3B1-B0D4A2BD1E7D@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com> <dd2427920427440e051951071377265fc0a830d4.1510822218.git.hns@goldelico.com> <7f34033e-4af7-f5f5-47ef-759249ddfe39@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f34033e-4af7-f5f5-47ef-759249ddfe39@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 21.11.2017 um 11:25 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>=20
> On 16/11/17 10:50, H. Nikolaus Schaller wrote:
>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>=20
>> Commit d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI =
feature
>> to dpi code") replaced usage of platform data version with SoC =
matching
>> to configure DPI VDDS. The SoC match entries were incorrect, they =
should
>> have matched on the machine name instead of the SoC family. Fix it.
>>=20
>> The result was observed on OpenPandora with OMAP3530 where the panel =
only
>> had the Blue channel and Red&Green were missing. It was not observed =
on
>> GTA04 with DM3730.
>>=20
>> Fixes: d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI =
feature to dpi code")
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpu/drm/omapdrm/dss/dpi.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c =
b/drivers/gpu/drm/omapdrm/dss/dpi.c
>> index 4ed5fde11313..a91e5f1a0490 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dpi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
>> @@ -566,8 +566,8 @@ static int dpi_verify_pll(struct dss_pll *pll)
>> }
>>=20
>> static const struct soc_device_attribute dpi_soc_devices[] =3D {
>> -	{ .family =3D "OMAP3[456]*" },
>> -	{ .family =3D "[AD]M37*" },
>> +	{ .machine =3D "OMAP3[456]*" },
>> +	{ .machine =3D "[AD]M37*" },
>> 	{ /* sentinel */ }
>> };
>>=20
>>=20
>=20
> I have picked this one.

Fine.

> I think the rest of the patches are more of a
> cleanup, right? And you'll be sending v3 at some point.

Yes. Should we wait for more comments or should I send now?

BR and thanks,
Nikolaus Schaller


>=20
> Tomi
>=20
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
