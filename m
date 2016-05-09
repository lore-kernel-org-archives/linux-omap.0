From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Mon, 9 May 2016 11:25:53 +0300
Message-ID: <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com> <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160505184609.GB5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, =?UTF-8?Q?Agust=c3=ad_Fontquerni?= <af@iseebcn.com>, Eduard Gavin <egavin@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

Adding Tomi,

On 05/05/16 21:46, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160504 11:03]:
>> On 05/04/2016 12:26 PM, Tony Lindgren wrote:
>>> Hi,
>>>
>>> Adding Nishanth to Cc.
>>>
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160429 05:15]:
>>>> ldo7_reg, obviously ;)
>>>>
>>>>> 	status =3D "okay";
>>>>> 	regulator-min-microvolt =3D <1800000>;
>>>>> 	regulator-max-microvolt =3D <1800000>;
>>>>> };
>>>
>>> It really seems to be ldo7, otherwise there's no HDMI output. I don=
't
>>> have the schematics either.
>>>
>>> But it seems we have at least two other regressions in Linux next t=
hat
>>> prevent me from testing this properly:
>>>
>>> 1. On igepv5, I get this for the MMC regulator
>>>
>>> ldo9: bypassed regulator has no supply!
>>> ldo9: failed to get the current voltage(-517)
>>> palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register =
48070000.i2c:palmar
>=20
> The patch I posted fixes this. Then for the HDMI see below.
> I've kept it at 2V like we have in omap5-board-common.dtsi,
> I wonder if it really should be 1.8V though for ldo7 in this
> case?

AFAIK the VDDA for the HDMI needs to be 1.8V along with other VDDAs for=
 DSS
(vdda_dsiporta, vdda_dsiportc and vdda_hdmi).

Tomi: what do you think?

According to the OMAP5 data manual the vdda_hdmi can be in 1.5V or 1.8V=
 mode,
2V is not mentioned in the recommended operating conditions table.

Just to note: on omap5-uevm the ldo7 is connected to VPP1 of OMAP5 (eFu=
se
power supply), which does require 2V.


> Regards,
>=20
> Tony
> 8< -----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 5 May 2016 11:29:23 -0700
> Subject: [PATCH] ARM: dts: Fix ldo7 source for HDMI on igepv5
>=20
> Fix ldo7 source for HDMI on igepv5.
>=20
> Suggested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts=
/omap5-igep0050.dts
> index 46ecb1d..72ff6a4 100644
> --- a/arch/arm/boot/dts/omap5-igep0050.dts
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -35,6 +35,12 @@
>  	};
>  };
> =20
> +&ldo7_reg {
> +	status =3D "okay";
> +	regulator-min-microvolt =3D <2000000>;
> +	regulator-max-microvolt =3D <2000000>;

If we are not changing the default voltage set in the common dtsi file =
we only
need to status =3D "okay"

> +};
> +
>  &omap5_pmx_core {
>  	i2c4_pins: pinmux_i2c4_pins {
>  		pinctrl-single,pins =3D <
>=20


--=20
P=E9ter
