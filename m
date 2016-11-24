From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 9/9] ARM: dts: omap3: Fix NAND device nodess
Date: Thu, 24 Nov 2016 12:49:20 +0200
Message-ID: <5f2d91c2-09c6-da0f-a09f-303773fe4cd8@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
 <1456245445-31824-10-git-send-email-rogerq@ti.com>
 <CAHCN7xJqzgtuSW4KK93tHQh2WVRE4L5Zh6+5sGM+DZGU4qy5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHCN7xJqzgtuSW4KK93tHQh2WVRE4L5Zh6+5sGM+DZGU4qy5zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Adam

On 24/11/16 00:34, Adam Ford wrote:
> 
> On Tue, Feb 23, 2016 at 10:37 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org <mailto:rogerq-l0cyMroinI0@public.gmane.org>> wrote:
> 
>     Add compatible id, GPMC register resource and interrupt
>     resource to NAND controller nodes.
> 
>     The GPMC node will provide an interrupt controller for the
>     NAND IRQs.
> 
>     Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org <mailto:rogerq-l0cyMroinI0@public.gmane.org>>
>     ---
>      arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  3 ++-
>      arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |  8 ++++++--
>      arch/arm/boot/dts/omap3-beagle.dts                |  5 ++++-
>      arch/arm/boot/dts/omap3-cm-t3x.dtsi               |  6 +++++-
>      arch/arm/boot/dts/omap3-devkit8000-common.dtsi    |  4 ++++
>      arch/arm/boot/dts/omap3-evm-37xx.dts              |  8 ++++++--
>      arch/arm/boot/dts/omap3-gta04.dtsi                |  4 ++++
>      arch/arm/boot/dts/omap3-igep.dtsi                 |  6 +++++-
>      arch/arm/boot/dts/omap3-igep0020-common.dtsi      |  4 ++--
>      arch/arm/boot/dts/omap3-igep0030-common.dtsi      |  4 ++++
>      arch/arm/boot/dts/omap3-ldp.dts                   | 10 +++++++---
>      arch/arm/boot/dts/omap3-lilly-a83x.dtsi           |  6 +++++-
>      arch/arm/boot/dts/omap3-overo-base.dtsi           |  6 +++++-
>      arch/arm/boot/dts/omap3-pandora-common.dtsi       |  4 ++++
>      arch/arm/boot/dts/omap3-tao3530.dtsi              |  6 +++++-
>      arch/arm/boot/dts/omap3.dtsi                      |  2 ++
>      arch/arm/boot/dts/omap3430-sdp.dts                |  6 +++++-
>      17 files changed, 75 insertions(+), 17 deletions(-)
> 
>     diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
>     index fb13f18..d0211fc 100644
>     --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
>     +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
>     @@ -93,7 +93,8 @@
>      };
> 
>      &gpmc {
>     -       ranges = <1 0 0x08000000 0x1000000>;    /* CS1: 16MB for LAN9221 */
>     +       ranges = <0 0 0x30000000 0x1000000      /* CS0: 16MB for NAND */
>     +                 1 0 0x2c000000 0x1000000>;    /* CS1: 16MB for LAN9221 */
> 
> I just noticed this change earlier today, and I have question.
> 
> There is a DTS and a DTSI file.  The DTSI has the NAND information and the range was updated.  If this was included in the dts, is there really a need to add the CS0 range info in the dts file as well?
> 
> My preference would be to eliminate the new CS0 entry in the DTS file and leave the update in the DTSI. Is that reasonable, or am I missing something?

The ranges property will be overridden so you can't have only CS0 defined in .dtsi
and CS1 defined in the .dts. You will have to either define both in .dts and
remove the ranges property from the .dts or define both in the .dts.

AFAIK .dtsi file didn't have CS1 range so I had to define both CS0 and CS1 in the .dts.
>  
> 
>             ethernet@gpmc {
>                     pinctrl-names = "default";
>     diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>     index 7fed0bd..b46789a 100644
>     --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>     +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>     @@ -35,11 +35,15 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x1000000>;    /* CS0: 16MB for NAND */
>     +       ranges = <0 0 0x30000000 0x1000000>;    /* CS0: 16MB for NAND */
> 
> 
> From what I can tell this exactly matches the same entry listed above in the dtsi.
> 

Yes, but we don't have CS1 here.
If all torpedo boards don't have CS1 in use then we can't define CS1 here.

cheers,
-roger

> adam
>  
> 
>             nand@0,0 {
>     -               linux,mtd-name = "micron,mt29f4g16abbda3w";
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>     +               linux,mtd-name = "micron,mt29f4g16abbda3w";
>                     nand-bus-width = <16>;
>                     ti,nand-ecc-opt = "bch8";
>                     gpmc,sync-clk-ps = <0>;
>     diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
>     index 8ba465d..4602866 100644
>     --- a/arch/arm/boot/dts/omap3-beagle.dts
>     +++ b/arch/arm/boot/dts/omap3-beagle.dts
>     @@ -384,8 +384,11 @@
> 
>             /* Chip select 0 */
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>;          /* NAND I/O window, 4 bytes */
>     -               interrupts = <20>;
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     ti,nand-ecc-opt = "ham1";
>                     nand-bus-width = <16>;
>                     #address-cells = <1>;
>     diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>     index e5f7f5c..a8127bc 100644
>     --- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>     +++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>     @@ -261,10 +261,14 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x01000000>;
>     +       ranges = <0 0 0x30000000 0x01000000>;   /* CS0: 16MB for NAND */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <8>;
>                     gpmc,device-width = <1>;
>                     ti,nand-ecc-opt = "sw";
>     diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
>     index 86850bb..b1b8ebf 100644
>     --- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
>     +++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
>     @@ -204,7 +204,11 @@
>             ranges = <0 0 0x30000000 0x1000000>;       /* CS0: 16MB for NAND */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;
>                     ti,nand-ecc-opt = "sw";
>     diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
>     index ac18865..76056ba 100644
>     --- a/arch/arm/boot/dts/omap3-evm-37xx.dts
>     +++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
>     @@ -154,12 +154,16 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x1000000>,    /* CS0: 16MB for NAND */
>     +       ranges = <0 0 0x30000000 0x1000000>,    /* CS0: 16MB for NAND */
>                      <5 0 0x2c000000 0x01000000>;
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>     +               reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     linux,mtd-name= "hynix,h8kds0un0mer-4em";
>     -               reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;
>                     ti,nand-ecc-opt = "bch8";
>     diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
>     index 5e2d643..ab9fb8f 100644
>     --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>     +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>     @@ -492,7 +492,11 @@
>             ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     ti,nand-ecc-opt = "bch8";
> 
>     diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
>     index 3caf062..81aec99 100644
>     --- a/arch/arm/boot/dts/omap3-igep.dtsi
>     +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>     @@ -95,8 +95,12 @@
> 
>      &gpmc {
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>     +               reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     linux,mtd-name= "micron,mt29c4g96maz";
>     -               reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;
>                     ti,nand-ecc-opt = "bch8";
>     diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>     index d90f12c..d6f839c 100644
>     --- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>     +++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
>     @@ -210,8 +210,8 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x20000000>,
>     -                <5 0 0x2c000000 0x01000000>;
>     +       ranges = <0 0 0x30000000 0x01000000>,   /* CS0: 16MB for NAND */
>     +                <5 0 0x2c000000 0x01000000>;   /* CS5: 16MB for ethernet */
> 
>             ethernet@gpmc {
>                     pinctrl-names = "default";
>     diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
>     index 640f066..cd91ef0 100644
>     --- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
>     +++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
>     @@ -58,3 +58,7 @@
>             pinctrl-names = "default";
>             pinctrl-0 = <&uart2_pins>;
>      };
>     +
>     +&gpmc {
>     +       ranges = <0 0 0x30000000 0x01000000>;   /* CS0: 16MB for NAND */
>     +};
>     diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
>     index 5401630..2f353da 100644
>     --- a/arch/arm/boot/dts/omap3-ldp.dts
>     +++ b/arch/arm/boot/dts/omap3-ldp.dts
>     @@ -97,12 +97,16 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x01000000>,
>     -                <1 0 0x08000000 0x01000000>;
>     +       ranges = <0 0 0x30000000 0x1000000>,    /* CS0 space, 16MB */
>     +                <1 0 0x08000000 0x1000000>;    /* CS1 space, 16MB */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>     +               reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     linux,mtd-name= "micron,nand";
>     -               reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;
>                     ti,nand-ecc-opt = "bch8";
>     diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>     index 93f8dfe..eff816e 100644
>     --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>     +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
>     @@ -362,7 +362,11 @@
>                     <7 0 0x15000000 0x01000000>;
> 
>             nand@0,0 {
>     -               reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>     +               compatible = "ti,omap2-nand";
>     +               reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     ti,nand-ecc-opt = "bch8";
>                     /* no elm on omap3 */
>     diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
>     index a29ad16..de256fa 100644
>     --- a/arch/arm/boot/dts/omap3-overo-base.dtsi
>     +++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
>     @@ -226,8 +226,12 @@
>             ranges = <0 0 0x00000000 0x20000000>;
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     linux,mtd-name= "micron,mt29c4g96maz";
>     -               reg = <0 0 0>;
>     +               reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;
>                     ti,nand-ecc-opt = "bch8";
>     diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
>     index 13e9d1f..bcf39d6 100644
>     --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
>     +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
>     @@ -546,7 +546,11 @@
>             ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     ti,nand-ecc-opt = "sw";
> 
>     diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
>     index ae5dbbd..644d3c8 100644
>     --- a/arch/arm/boot/dts/omap3-tao3530.dtsi
>     +++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
>     @@ -275,10 +275,14 @@
>      };
> 
>      &gpmc {
>     -       ranges = <0 0 0x00000000 0x01000000>;
>     +       ranges = <0 0 0x30000000 0x01000000>;   /* CS0: 16MB for NAND */
> 
>             nand@0,0 {
>     +               compatible = "ti,omap2-nand";
>                     reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     nand-bus-width = <16>;
>                     gpmc,device-width = <2>;        /* GPMC_DEVWIDTH_16BIT */
>                     ti,nand-ecc-opt = "sw";
>     diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>     index d1ffabb..b41d07e 100644
>     --- a/arch/arm/boot/dts/omap3.dtsi
>     +++ b/arch/arm/boot/dts/omap3.dtsi
>     @@ -723,6 +723,8 @@
>                             gpmc,num-waitpins = <4>;
>                             #address-cells = <2>;
>                             #size-cells = <1>;
>     +                       interrupt-controller;
>     +                       #interrupt-cells = <2>;
>                     };
> 
>                     usb_otg_hs: usb_otg_hs@480ab000 {
>     diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
>     index 16b0cdf..a0dc8d8 100644
>     --- a/arch/arm/boot/dts/omap3430-sdp.dts
>     +++ b/arch/arm/boot/dts/omap3430-sdp.dts
>     @@ -103,10 +103,14 @@
>             };
> 
>             nand@1,0 {
>     +               compatible = "ti,omap2-nand";
>     +               reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>     +               interrupt-parent = <&gpmc>;
>     +               interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>     +                            <1 IRQ_TYPE_NONE>; /* termcount */
>                     linux,mtd-name= "micron,mt29f1g08abb";
>                     #address-cells = <1>;
>                     #size-cells = <1>;
>     -               reg = <1 0 4>;  /* CS1, offset 0, IO size 4 */
>                     ti,nand-ecc-opt = "sw";
>                     nand-bus-width = <8>;
>                     gpmc,cs-on-ns = <0>;
>     --
>     2.5.0
> 
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>     the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html <http://vger.kernel.org/majordomo-info.html>
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
