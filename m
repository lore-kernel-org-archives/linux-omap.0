From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] arm: boot: beaglex15: pass correct interrupt
Date: Fri, 20 Nov 2015 14:39:33 +0900
Message-ID: <564EB215.5080209@samsung.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447350781-20649-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447350781-20649-3-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:53, Felipe Balbi wrote:
> According to latest schematics [1], GPIO_1/VBUSDET
> on TPS659038 is tied to AM57x GPIO4_21. We can use
> that as a VBUS interrupt, instead of relying on
> PMIC's VBUS interrupts which don't seem to be firing
> on x15 at all.
>=20
> A follow up patch will add support for using this
> GPIO-based interrupt mechanism for notifying about
> VBUS.
>=20
> [1] https://github.com/beagleboard/beagleboard-x15/blob/master/Beagle=
Board-X15_RevA2.pdf
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/=
dts/am57xx-beagle-x15.dts
> index 6f3a1a7ec5f9..5e47162f7883 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -560,6 +560,7 @@
>  		extcon_usb2: tps659038_usb {
>  			compatible =3D "ti,palmas-usb-vid";
>  			ti,enable-vbus-detection;
> +			interrupts-extended =3D <&gpio4 21 IRQ_TYPE_EDGE_RISING>;
>  		};
> =20
>  	};
>=20

I check the schematic file. The GPIO4_21 pin is connected as following:
- GPIO_1/VBUSDET -> PMIC_VBUS_DET -> VBUS_DET -> AM5728 GPIO4_21 pin

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
