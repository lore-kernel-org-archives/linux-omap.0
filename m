From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 5/9] ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
Date: Fri, 8 Mar 2013 21:25:00 +0100
Message-ID: <CABxcv==OKX4z8x7ztqDJ5CozNmTQ5UaD43mTLWfQuqUt-y7xcQ@mail.gmail.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
	<1362763654-9660-6-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:35622 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3CHUZB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 15:25:01 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so1506576wey.40
        for <linux-omap@vger.kernel.org>; Fri, 08 Mar 2013 12:25:00 -0800 (PST)
In-Reply-To: <1362763654-9660-6-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 8, 2013 at 6:27 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Add the device-tree node for GPMC on OMAP2, OMAP4 and OMAP5 devices.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/omap2430.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   11 +++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   11 +++++++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index af65609..d4ce6c2 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -29,6 +29,17 @@
>                         pinctrl-single,function-mask = <0x3f>;
>                 };
>
> +               gpmc: gpmc@6800a000 {
> +                       compatible = "ti,omap2420-gpmc";
> +                       reg = <0x6800a000 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +                       interrupts = <20>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <4>;
> +                       ti,hwmods = "gpmc";
> +               };
> +
>                 mcbsp1: mcbsp@48074000 {
>                         compatible = "ti,omap2420-mcbsp";
>                         reg = <0x48074000 0xff>;
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index c392445..832f184 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -29,6 +29,17 @@
>                         pinctrl-single,function-mask = <0x3f>;
>                 };
>
> +               gpmc: gpmc@6e000000 {
> +                       compatible = "ti,omap2430-gpmc";
> +                       reg = <0x6e000000 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +                       interrupts = <20>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <4>;
> +                       ti,hwmods = "gpmc";
> +               };
> +
>                 mcbsp1: mcbsp@48074000 {
>                         compatible = "ti,omap2430-mcbsp";
>                         reg = <0x48074000 0xff>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 827f6f3..726ef11 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -196,6 +196,17 @@
>                         #interrupt-cells = <1>;
>                 };
>
> +               gpmc: gpmc@50000000 {
> +                       compatible = "ti,omap4430-gpmc";
> +                       reg = <0x50000000 0x1000>;

Hi Jon,

By looking at the GPMC Register Summary from both the OMAP4460 and OMAP OMAP35x
Technical Reference Manuals I see that the GPMC register address space
is only 720 bytes length. From base address + 0x0 to base address +
0x02d0.

So shouldn't the regs property be <0x50000000 0x2d0> instead?

Of course are only a few kilobytes but still I wonder if it makes
sense to map them when they are not going to be used.

Best regards,
Javier
