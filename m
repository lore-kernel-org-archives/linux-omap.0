From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/7] ARM: dts: am437x: Fix GPMC dma properties
Date: Fri, 11 Mar 2016 16:03:13 +0200
Message-ID: <56E2D021.5010805@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457654203-20856-4-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/11/2016 01:56 AM, Franklin S Cooper Jr wrote:
> This patch updates the GPMC's DT DMA property to reflect the updated =
eDMA
> bindings.
>=20
> Fixes: cce1ee000187 ("ARM: DTS: am437x: Use the new DT bindings for t=
he eDMA3")

I have also converted all users of the edma back when I sent, I guess t=
he gpmc
DMA binding went in parallel...

Acked-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
> Version 4 changes:
> Split into its own commit. Use proper Fixes syntax.
>=20
>  arch/arm/boot/dts/am4372.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372=
=2Edtsi
> index 92068fb..2878b04 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -884,7 +884,7 @@
>  		gpmc: gpmc@50000000 {
>  			compatible =3D "ti,am3352-gpmc";
>  			ti,hwmods =3D "gpmc";
> -			dmas =3D <&edma 52>;
> +			dmas =3D <&edma 52 0>;
>  			dma-names =3D "rxtx";
>  			clocks =3D <&l3s_gclk>;
>  			clock-names =3D "fck";
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
