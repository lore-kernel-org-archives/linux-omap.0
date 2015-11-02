From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Mon, 2 Nov 2015 01:21:19 -0800
Message-ID: <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
	<1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444979892-31626-14-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

1) This seems to have broken BBB in -next for me, bisected down to this patch.

For bootlog:
http://arm-soc.lixom.net/bootlogs/next/next-20151102/bbb-arm-omap2plus_defconfig.html

2) Please avoid merging DT/platform code in your driver tree, Vinod,
at least without an ack from the platform maintainer. It can be a a
huge mess if they end up causing conflicts, so we always ask to merge
the DT changes through the platform maintainer (Tony in this case) by
default.


Thanks,

-Olof

On Fri, Oct 16, 2015 at 12:18 AM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> wrote:
> Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eDMA3 and
> enable the DMA even crossbar with ti,am335x-edma-crossbar.
> With the new bindings boards can customize and tweak the DMA channel
> priority to match their needs. With the new binding the memcpy is safe
> to be used since with the old binding it was not possible for a driver
> to know which channel is allowed to be used as non HW triggered channel.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-evm.dts    |  9 +---
>  arch/arm/boot/dts/am335x-pepper.dts | 11 +----
>  arch/arm/boot/dts/am33xx.dtsi       | 96 ++++++++++++++++++++++++++-----------
>  3 files changed, 73 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 1942a5c8132d..507980672c32 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -743,8 +743,8 @@
>  &mmc3 {
>         /* these are on the crossbar and are outlined in the
>            xbar-event-map element */
> -       dmas = <&edma 12
> -               &edma 13>;
> +       dmas = <&edma_xbar 12 0 1
> +               &edma_xbar 13 0 2>;
>         dma-names = "tx", "rx";
>         status = "okay";
>         vmmc-supply = <&wlan_en_reg>;
> @@ -766,11 +766,6 @@
>         };
>  };
>
> -&edma {
> -       ti,edma-xbar-event-map = /bits/ 16 <1 12
> -                                           2 13>;
> -};
> -
>  &sham {
>         status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 7106114c7464..39073b921664 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -339,13 +339,6 @@
>         ti,non-removable;
>  };
>
> -&edma {
> -       /* Map eDMA MMC2 Events from Crossbar */
> -       ti,edma-xbar-event-map = /bits/ 16 <1 12
> -                                            2 13>;
> -};
> -
> -
>  &mmc3 {
>         /* Wifi & Bluetooth on MMC #3 */
>         status = "okay";
> @@ -354,8 +347,8 @@
>         vmmmc-supply = <&v3v3c_reg>;
>         bus-width = <4>;
>         ti,non-removable;
> -       dmas = <&edma 12
> -               &edma 13>;
> +       dmas = <&edma_xbar 12 0 1
> +               &edma_xbar 13 0 2>;
>         dma-names = "tx", "rx";
>  };
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index d23e2524d694..6053e75c6e99 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -174,12 +174,54 @@
>                 };
>
>                 edma: edma@49000000 {
> -                       compatible = "ti,edma3";
> -                       ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> -                       reg =   <0x49000000 0x10000>,
> -                               <0x44e10f90 0x40>;
> +                       compatible = "ti,edma3-tpcc";
> +                       ti,hwmods = "tpcc";
> +                       reg =   <0x49000000 0x10000>;
> +                       reg-names = "edma3_cc";
>                         interrupts = <12 13 14>;
> -                       #dma-cells = <1>;
> +                       interrupt-names = "edma3_ccint", "emda3_mperr",
> +                                         "edma3_ccerrint";
> +                       dma-requests = <64>;
> +                       #dma-cells = <2>;
> +
> +                       ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> +                                  <&edma_tptc2 0>;
> +
> +                       ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> +               };
> +
> +               edma_tptc0: tptc@49800000 {
> +                       compatible = "ti,edma3-tptc";
> +                       ti,hwmods = "tptc0";
> +                       reg =   <0x49800000 0x100000>;
> +                       interrupts = <112>;
> +                       interrupt-names = "edma3_tcerrint";
> +               };
> +
> +               edma_tptc1: tptc@49900000 {
> +                       compatible = "ti,edma3-tptc";
> +                       ti,hwmods = "tptc1";
> +                       reg =   <0x49900000 0x100000>;
> +                       interrupts = <113>;
> +                       interrupt-names = "edma3_tcerrint";
> +               };
> +
> +               edma_tptc2: tptc@49a00000 {
> +                       compatible = "ti,edma3-tptc";
> +                       ti,hwmods = "tptc2";
> +                       reg =   <0x49a00000 0x100000>;
> +                       interrupts = <114>;
> +                       interrupt-names = "edma3_tcerrint";
> +               };
> +
> +               edma_xbar: dma-router@44e10f90 {
> +                       compatible = "ti,am335x-edma-crossbar";
> +                       reg = <0x44e10f90 0x40>;
> +
> +                       #dma-cells = <3>;
> +                       dma-requests = <32>;
> +
> +                       dma-masters = <&edma>;
>                 };
>
>                 gpio0: gpio@44e07000 {
> @@ -233,7 +275,7 @@
>                         reg = <0x44e09000 0x2000>;
>                         interrupts = <72>;
>                         status = "disabled";
> -                       dmas = <&edma 26>, <&edma 27>;
> +                       dmas = <&edma 26 0>, <&edma 27 0>;
>                         dma-names = "tx", "rx";
>                 };
>
> @@ -244,7 +286,7 @@
>                         reg = <0x48022000 0x2000>;
>                         interrupts = <73>;
>                         status = "disabled";
> -                       dmas = <&edma 28>, <&edma 29>;
> +                       dmas = <&edma 28 0>, <&edma 29 0>;
>                         dma-names = "tx", "rx";
>                 };
>
> @@ -255,7 +297,7 @@
>                         reg = <0x48024000 0x2000>;
>                         interrupts = <74>;
>                         status = "disabled";
> -                       dmas = <&edma 30>, <&edma 31>;
> +                       dmas = <&edma 30 0>, <&edma 31 0>;
>                         dma-names = "tx", "rx";
>                 };
>
> @@ -322,8 +364,8 @@
>                         ti,dual-volt;
>                         ti,needs-special-reset;
>                         ti,needs-special-hs-handling;
> -                       dmas = <&edma 24
> -                               &edma 25>;
> +                       dmas = <&edma_xbar 24 0 0
> +                               &edma_xbar 25 0 0>;
>                         dma-names = "tx", "rx";
>                         interrupts = <64>;
>                         interrupt-parent = <&intc>;
> @@ -335,8 +377,8 @@
>                         compatible = "ti,omap4-hsmmc";
>                         ti,hwmods = "mmc2";
>                         ti,needs-special-reset;
> -                       dmas = <&edma 2
> -                               &edma 3>;
> +                       dmas = <&edma 2 0
> +                               &edma 3 0>;
>                         dma-names = "tx", "rx";
>                         interrupts = <28>;
>                         interrupt-parent = <&intc>;
> @@ -474,10 +516,10 @@
>                         interrupts = <65>;
>                         ti,spi-num-cs = <2>;
>                         ti,hwmods = "spi0";
> -                       dmas = <&edma 16
> -                               &edma 17
> -                               &edma 18
> -                               &edma 19>;
> +                       dmas = <&edma 16 0
> +                               &edma 17 0
> +                               &edma 18 0
> +                               &edma 19 0>;
>                         dma-names = "tx0", "rx0", "tx1", "rx1";
>                         status = "disabled";
>                 };
> @@ -490,10 +532,10 @@
>                         interrupts = <125>;
>                         ti,spi-num-cs = <2>;
>                         ti,hwmods = "spi1";
> -                       dmas = <&edma 42
> -                               &edma 43
> -                               &edma 44
> -                               &edma 45>;
> +                       dmas = <&edma 42 0
> +                               &edma 43 0
> +                               &edma 44 0
> +                               &edma 45 0>;
>                         dma-names = "tx0", "rx0", "tx1", "rx1";
>                         status = "disabled";
>                 };
> @@ -831,7 +873,7 @@
>                         ti,hwmods = "sham";
>                         reg = <0x53100000 0x200>;
>                         interrupts = <109>;
> -                       dmas = <&edma 36>;
> +                       dmas = <&edma 36 0>;
>                         dma-names = "rx";
>                 };
>
> @@ -840,8 +882,8 @@
>                         ti,hwmods = "aes";
>                         reg = <0x53500000 0xa0>;
>                         interrupts = <103>;
> -                       dmas = <&edma 6>,
> -                              <&edma 5>;
> +                       dmas = <&edma 6 0>,
> +                              <&edma 5 0>;
>                         dma-names = "tx", "rx";
>                 };
>
> @@ -854,8 +896,8 @@
>                         interrupts = <80>, <81>;
>                         interrupt-names = "tx", "rx";
>                         status = "disabled";
> -                       dmas = <&edma 8>,
> -                               <&edma 9>;
> +                       dmas = <&edma 8 2>,
> +                               <&edma 9 2>;
>                         dma-names = "tx", "rx";
>                 };
>
> @@ -868,8 +910,8 @@
>                         interrupts = <82>, <83>;
>                         interrupt-names = "tx", "rx";
>                         status = "disabled";
> -                       dmas = <&edma 10>,
> -                               <&edma 11>;
> +                       dmas = <&edma 10 2>,
> +                               <&edma 11 2>;
>                         dma-names = "tx", "rx";
>                 };
>
> --
> 2.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
