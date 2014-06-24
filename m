From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
Date: Tue, 24 Jun 2014 16:11:48 -0500
Message-ID: <CAL_JsqJx_DJqxpEJebi0Etfv5g7=eYje_53vd_44GykreA-rkQ@mail.gmail.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com> <1403547659-24558-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403547659-24558-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 23, 2014 at 1:20 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> by providing phandles to rtc, wdt, cpu and dispc nodes,
> boards can access them to add board-specific data.

Strictly speaking, you are adding labels, not phandles. You can do
phandles without using labels, but the syntax is not so obvious. I'd
tell you what it is but offhand I don't remember. :)

Rob

> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>
> Changes since v1:
>         - added phandles to cpu and dispc
>
>  arch/arm/boot/dts/am4372.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 49fa596..8d3c163 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -30,7 +30,7 @@
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> -               cpu@0 {
> +               cpu: cpu@0 {
>                         compatible = "arm,cortex-a9";
>                         device_type = "cpu";
>                         reg = <0>;
> @@ -270,7 +270,7 @@
>                         ti,hwmods = "counter_32k";
>                 };
>
> -               rtc@44e3e000 {
> +               rtc: rtc@44e3e000 {
>                         compatible = "ti,am4372-rtc","ti,da830-rtc";
>                         reg = <0x44e3e000 0x1000>;
>                         interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
> @@ -279,7 +279,7 @@
>                         status = "disabled";
>                 };
>
> -               wdt@44e35000 {
> +               wdt: wdt@44e35000 {
>                         compatible = "ti,am4372-wdt","ti,omap3-wdt";
>                         reg = <0x44e35000 0x1000>;
>                         interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> @@ -871,7 +871,7 @@
>                         #size-cells = <1>;
>                         ranges;
>
> -                       dispc@4832a400 {
> +                       dispc: dispc@4832a400 {
>                                 compatible = "ti,omap3-dispc";
>                                 reg = <0x4832a400 0x400>;
>                                 interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.0.0.390.gcb682f8
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
