From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: add OMAP5 DSIPHY lane-enable support
Date: Thu, 10 Aug 2017 11:28:44 +0300
Message-ID: <5a5d1dfe-2bed-41b5-83b3-0ebc6bd7359b@DLEE107.ent.ti.com>
References: <1502347520-27306-1-git-send-email-tomi.valkeinen@ti.com>
 <1545191.ArXLlpMNYh@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_816817cd-6192-4d56-bd69-875d931575e2_"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1545191.ArXLlpMNYh@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--_816817cd-6192-4d56-bd69-875d931575e2_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFThis message contains a digitally signed email which can be read b=
y opening the attachment.
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki



--_816817cd-6192-4d56-bd69-875d931575e2_
Content-Type: message/rfc822

Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.845.34; Thu, 10
 Aug 2017 03:28:46 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.845.34 via Frontend Transport;
 Thu, 10 Aug 2017 03:28:46 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
	by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id v7A8Sjaq025366;
	Thu, 10 Aug 2017 03:28:45 -0500
Subject: Re: [PATCH] drm/omap: add OMAP5 DSIPHY lane-enable support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: <dri-devel@lists.freedesktop.org>, "H . Nikolaus Schaller"
	<hns@goldelico.com>, <linux-omap@vger.kernel.org>
References: <1502347520-27306-1-git-send-email-tomi.valkeinen@ti.com>
 <1545191.ArXLlpMNYh@avalon>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <22c6c4f9-b86a-1be7-2938-b4794c833939@ti.com>
Date: Thu, 10 Aug 2017 11:28:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1545191.ArXLlpMNYh@avalon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="_357e939b-e376-448b-afc0-323b05636175_"
Return-Path: tomi.valkeinen@ti.com

--_357e939b-e376-448b-afc0-323b05636175_
Content-Type: multipart/mixed; boundary="U4AdpaE7iveUbQBHuriXMbkvhbSbbTjXL";
	protected-headers=v1
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: dri-devel@lists.freedesktop.org, "H . Nikolaus Schaller"
 <hns@goldelico.com>, linux-omap@vger.kernel.org
Message-ID: <22c6c4f9-b86a-1be7-2938-b4794c833939@ti.com>
Subject: Re: [PATCH] drm/omap: add OMAP5 DSIPHY lane-enable support
References: <1502347520-27306-1-git-send-email-tomi.valkeinen@ti.com>
 <1545191.ArXLlpMNYh@avalon>
In-Reply-To: <1545191.ArXLlpMNYh@avalon>

--U4AdpaE7iveUbQBHuriXMbkvhbSbbTjXL
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/08/17 10:22, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thank you for the patch.
>=20
> On Thursday 10 Aug 2017 09:45:20 Tomi Valkeinen wrote:
>> We are missing OMAP5 DSIPHY lane-enable support, which has prevented
>> OMAP5 DSI working in mainline. This patch adds the lane-enable similar=
ly
>> to the recently added OMAP4 version.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>
>> Based on Laurent's recent omapdrm series.
>>
>>  drivers/gpu/drm/omapdrm/dss/dsi.c | 50 ++++++++++++++++++++++++++++++=
+----
>>  1 file changed, 45 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> b/drivers/gpu/drm/omapdrm/dss/dsi.c index a66d2b1a6c74..1f0b29af9b86 1=
00644
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -2139,14 +2139,51 @@ static int dsi_omap4_mux_pads(struct dsi_data =
*dsi,
>> unsigned int lanes) return 0;
>>  }
>>
>> +#define OMAP5_DSIPHY_SYSCON_OFFSET	0x74
>> +
>> +#define OMAP5_DSI1_LANEENABLE_SHIFT	24
>> +#define OMAP5_DSI2_LANEENABLE_SHIFT	19
>> +#define OMAP5_DSI_LANEENABLE_MASK	0x1f
>> +
>> +static int dsi_omap5_mux_pads(struct dsi_data *dsi, unsigned int lane=
s)
>> +{
>> +	u32 enable_mask, enable_shift, reg;
>> +
>> +	if (!dsi->syscon)
>> +		return 0;
>=20
> The purpose of this check in dsi_omap4_mux_pads() was to handle the SoC=
s that=20
> don't require any driver action to mux the DSI pins. Now that=20
> dsi_enable_pads() and dsi_disable_pads() have new SoC checks, this isn'=
t=20
> needed anymore, dsi->syscon can't be NULL on OMAP4 or OMAP5.

True, I'll drop the check.

>> +	if (dsi->module_id =3D=3D 0)
>> +		enable_shift =3D OMAP5_DSI1_LANEENABLE_SHIFT;
>> +	else if (dsi->module_id =3D=3D 1)
>> +		enable_shift =3D OMAP5_DSI2_LANEENABLE_SHIFT;
>> +	else
>> +		return -ENODEV;
>> +
>> +	enable_mask =3D OMAP5_DSI_LANEENABLE_MASK << enable_shift;
>> +
>> +	regmap_read(dsi->syscon, OMAP5_DSIPHY_SYSCON_OFFSET, &reg);
>> +	reg &=3D ~enable_mask;
>> +	reg |=3D (lanes << enable_shift) & enable_mask;
>> +	regmap_write(dsi->syscon, OMAP5_DSIPHY_SYSCON_OFFSET, reg);
>> +
>> +	return 0;
>> +}
>> +
>>  static int dsi_enable_pads(struct dsi_data *dsi, unsigned int lane_ma=
sk)
>>  {
>> -	return dsi_omap4_mux_pads(dsi, lane_mask);
>> +	if (dsi->data->model =3D=3D DSI_MODEL_OMAP4)
>> +		return dsi_omap4_mux_pads(dsi, lane_mask);
>> +	if (dsi->data->model =3D=3D DSI_MODEL_OMAP5)
>> +		return dsi_omap5_mux_pads(dsi, lane_mask);
>> +	return 0;
>>  }
>>
>>  static void dsi_disable_pads(struct dsi_data *dsi)
>>  {
>> -	dsi_omap4_mux_pads(dsi, 0);
>> +	if (dsi->data->model =3D=3D DSI_MODEL_OMAP4)
>> +		dsi_omap4_mux_pads(dsi, 0);
>> +	if (dsi->data->model =3D=3D DSI_MODEL_OMAP4)
>=20
> Did you mean DSI_MODEL_OMAP5 ? As the two are mutually exclusive, I wou=
ld use=20
> an "else if".

Indeed, it should be OMAP5.

 Tomi


--U4AdpaE7iveUbQBHuriXMbkvhbSbbTjXL--

--_357e939b-e376-448b-afc0-323b05636175_
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZjBk8AAoJEPo9qoy8lh713gkP/jRpMgmz4331PtC38uLgcPHE
w7YPBVgHkxBW1I/T1jNuhcsFJSDsGfNRjQ18F/8aW2U4tsyg+nkJGkrzEPjSzJng
LHwhRe8IliEbvV5e9dYbgI5ZP2FhNKZSWQ5mefMFIoJDiwpFpU+z0xUsm5Mi+ymv
JPiZn01IFL2kiV5+BnUBna9XNpOR73dGEpA0gVFDj7TgqL5zuMGydCrI54K/Ndr0
yutakSy6yyTp0L0rrE8JAFwdAXofVbtQ3/VyeIeSvNnb4+xwTF23ffUWSSBM8R4D
TekZSJdv9Sb0eJKVrANrexxrGlheZfKgNjh0pgWwSrObGZskLMRp5PlavlOJeY8i
exuQKAfZnGo27lvHOUJ4uhMbss/tR6ReA9ex5a5p8uKMHf1rk6kjaLjwrHw2Xz9p
TEXjZMHDWVDbHZzJy2NlEz1aF0WoEk/1r/ehP0iYLcu/iltChFRh4abaSlTc7Qsp
1Re/wuM4509ZVX2Js3JYkvNzzz87EyIkPLUp2O32M90IFC1YnSEpXyhzykQK4otR
qNSGto+jk1qlMbgFagoqJao4RSi1sp1+x75MaHTkr/gazCA7BLcggAwlQ2plRD+u
czA8Hz/Nlka2TObKC4zL9QlL+prQX6CTdh9S/WYzBtai6ZP9X5PwchhOr3D68XwK
ovsGKOh0x7L9Fx0oDC8C
=HrL3
-----END PGP SIGNATURE-----

--_357e939b-e376-448b-afc0-323b05636175_--

--_816817cd-6192-4d56-bd69-875d931575e2_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--_816817cd-6192-4d56-bd69-875d931575e2_--
