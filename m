From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/17] ARM: dts: Add missing mcasp node for omap4
Date: Thu, 31 Aug 2017 08:47:32 +0300
Message-ID: <aef213f9-723f-dbf9-f0d2-8b1dd8b1eae1@ti.com>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-12-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-12-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-08-30 18:19, Tony Lindgren wrote:
> On omap4 we're missing the mcasp node with it's related "ti,hwmods"
> property that the SoC interconnect code needs.
>=20
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
>=20
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt | 1 +
>  arch/arm/boot/dts/omap4.dtsi                                    | 9 ++++=
+++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.=
txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
>  	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, AM43xx, TI81xx)
>  	"ti,dra7-mcasp-audio"	: for DRA7xx platforms
> +	"ti,omap4-mcasp-audio"	: for OMAP4 platforms
> =20
>  - reg : Should contain reg specifiers for the entries in the reg-names p=
roperty.
>  - reg-names : Should contain:
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -775,6 +775,15 @@
>  			status =3D "disabled";
>  		};
> =20
> +		mcasp: mcasp@40128000 {
> +			compatible =3D "ti,omap4-mcasp-audio";
> +			reg =3D <0x40128000 0x400>, /* MPU private access */
> +			      <0x49028000 0x400>; /* L3 Interconnect */
> +			reg-names =3D "mpu", "dma";
> +			interrupts =3D <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods =3D "mcasp";
> +		};

I would not do this. We don't support the NcASP on OMAP4 or OMAP5 for
that matter.
In theory it is the same IP as found in other SoCs, but in OMAP4 the TX
path is disabled and (in theory) the i2s support is also a thing which
is not supported - only DIT mode.
We do not even have any hardware where it can be tested (Galaxy Nexus
uses McASP for S/PDIF output when it is docked.
For Android we have had omap-mcasp driver, but it is not upstream and is
never will as if we are going to support McASP it should be done via the
davinci-mcasp driver.

By adding the node we might give the impression that McASP on OMAP4/5 is
usable, which is not.

On the other hand, the DT describes the HW, so it should be OK to add
all peripherals even if there is no driver to support it. In this case
the status =3D "disabled"; must be there.

> +
>  		slimbus1: slimbus@4012c000 {
>  			compatible =3D "ti,omap4-slimbus";
>  			reg =3D <0x4012c000 0x400>, /* MPU private access */
>=20

- P=C3=A9ter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
