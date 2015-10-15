From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio
 support
Date: Thu, 15 Oct 2015 07:09:59 -0700
Message-ID: <20151015140959.GN10113@atomide.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68A60.6050900@ti.com>
 <20150914162851.GM4215@atomide.com>
 <20151012205732.GW23801@atomide.com>
 <561F50F5.9060909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561F50F5.9060909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151015 00:13]:
> Tony,
>=20
> On 10/12/2015 11:57 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150914 09:32]:
> >> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150914 01:54]:
> >>> Hi Tony,
> >>>
> >>> On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
> >>>> Hi,
> >>>>
> >>>> this series will enable analog audio (via onboard aic310x codec)=
 for dra7-evm,
> >>>> dra72-evm and am57xx-beagle-x15 boards.
> >>>> In these board McASP3 is connected to the codec and for the McAS=
P3 we needed to
> >>>> have the DMA crossbar in place since the request lines are not m=
apped by
> >>>> default.
> >>>
> >>> Did you had a chance to look at this series?
> >>
> >> Looks OK to me, will look at it more once we have the fixes merged=
=2E
> >>
> >> Paul may have comments on the hwmod chage, looks like you forgot
> >> to Cc him on it. Can you please resend that one with Paul in Cc?
> >=20
> > Applying all the dts changes into omap-for-v4.3/dt thanks. Paul
> > can pick up the hwmod change then after reviewing it.
>=20
> Thanks for taking the DTS patches, however if Paul agrees with the wa=
y I think we can handle the McASP in DRA7xx then the patch which adds t=
he mcasp3 node to dra7.dtsi needs to be replaced by:

Oh OK so the clocks may change. Well please send a follow up patch on
that then.

BTW, we should not set status =3D "disabled" in the SoC specific dtsi f=
iles.
The internal devices are there and we're better off having a struct dev=
ice
created for them. If someobdy really wants to "disable" some internal d=
evice
for yet to be seen good reason, it should be done in the board specific=
 dts
file.

Regards,

Tony

> From b6733f9ca96a997fab3d0455783e875dd9ae032b Mon Sep 17 00:00:00 200=
1
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date: Tue, 24 Feb 2015 15:12:59 +0200
> Subject: [PATCH v2 03/12] ARM: DTS: dra7: Add McASP3 node
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dts=
i
> index 8fedddc35999..cde0a3cbf262 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1404,6 +1404,21 @@
>  			status =3D "disabled";
>  		};
> =20
> +		mcasp3: mcasp@48468000 {
> +			compatible =3D "ti,dra7-mcasp-audio";
> +			ti,hwmods =3D "mcasp3";
> +			reg =3D <0x48468000 0x2000>;
> +			reg-names =3D "mpu";
> +			interrupts =3D <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "tx", "rx";
> +			dmas =3D <&sdma_xbar 133>, <&sdma_xbar 132>;
> +			dma-names =3D "tx", "rx";
> +			clocks =3D <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
> +			clock-names =3D "fck", "ahclkx";
> +			status =3D "disabled";
> +		};
> +
>  		crossbar_mpu: crossbar@4a002a48 {
>  			compatible =3D "ti,irq-crossbar";
>  			reg =3D <0x4a002a48 0x130>;
> --=20
> 2.6.1
>=20
>=20
>=20
>=20
> --=20
> P=C3=A9ter
