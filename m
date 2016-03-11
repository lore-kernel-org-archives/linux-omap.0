From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 2/7] ARM: dts: am33xx: Fix GPMC dma properties
Date: Fri, 11 Mar 2016 15:58:28 +0200
Message-ID: <56E2CF04.4020806@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-3-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457654203-20856-3-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/11/2016 01:56 AM, Franklin S Cooper Jr wrote:
> This patch updates the GPMC's DT DMA property to reflect the updated =
eDMA
> bindings.
>=20
> Fixes: b5e509066074 ("ARM: DTS: am33xx: Use the new DT bindings for t=
he eDMA3")

I have double checked the switch over to the new eDMA bindings when I s=
ent it
and there were no gpmc node existed back then afaik.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 4 changes:
> Split in its own commit. Uses correct syntax for Fixes
>=20
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
> index 1fafaad..97471d6 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -860,7 +860,7 @@
>  			ti,no-idle-on-init;
>  			reg =3D <0x50000000 0x2000>;
>  			interrupts =3D <100>;
> -			dmas =3D <&edma 52>;
> +			dmas =3D <&edma 52 0>;
>  			dma-names =3D "rxtx";
>  			gpmc,num-cs =3D <7>;
>  			gpmc,num-waitpins =3D <2>;
>=20


--=20
P=E9ter
