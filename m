From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] ARM: dts: OMAP2+: Identify GPIO banks that are
 always powered
Date: Thu, 4 Apr 2013 13:35:19 -0700
Message-ID: <20130404203519.GR10155@atomide.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-6-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11385 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758406Ab3DDUf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 16:35:27 -0400
Content-Disposition: inline
In-Reply-To: <1365106576-31816-6-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130404 13:21]:
> Add the "ti,gpio-always-on" property to the appropriate GPIO banks to
> indicate which banks are always powered and will never lose logic state.

This patch should be queued by Benoit as this will likely cause
pointless merge conflicts with the other .dts files.

Regards,

Tony
 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420.dtsi |    4 ++++
>  arch/arm/boot/dts/omap2430.dtsi |    4 ++++
>  arch/arm/boot/dts/omap3.dtsi    |    1 +
>  arch/arm/boot/dts/omap4.dtsi    |    1 +
>  arch/arm/boot/dts/omap5.dtsi    |    1 +
>  5 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index 455b239..76446ff 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -34,6 +34,7 @@
>  			reg = <0x48018000 0x200>;
>  			interrupts = <29>;
>  			ti,hwmods = "gpio1";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -45,6 +46,7 @@
>  			reg = <0x4801a000 0x200>;
>  			interrupts = <30>;
>  			ti,hwmods = "gpio2";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -56,6 +58,7 @@
>  			reg = <0x4801c000 0x200>;
>  			interrupts = <31>;
>  			ti,hwmods = "gpio3";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -67,6 +70,7 @@
>  			reg = <0x4801e000 0x200>;
>  			interrupts = <32>;
>  			ti,hwmods = "gpio4";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index 477b120..ca2c4a3 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -34,6 +34,7 @@
>  			reg = <0x4900c000 0x200>;
>  			interrupts = <29>;
>  			ti,hwmods = "gpio1";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -45,6 +46,7 @@
>  			reg = <0x4900e000 0x200>;
>  			interrupts = <30>;
>  			ti,hwmods = "gpio2";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -56,6 +58,7 @@
>  			reg = <0x49010000 0x200>;
>  			interrupts = <31>;
>  			ti,hwmods = "gpio3";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> @@ -67,6 +70,7 @@
>  			reg = <0x49012000 0x200>;
>  			interrupts = <32>;
>  			ti,hwmods = "gpio4";
> +			ti,gpio-always-on;
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 3344f05..626406f 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -116,6 +116,7 @@
>  			reg = <0x48310000 0x200>;
>  			interrupts = <29>;
>  			ti,hwmods = "gpio1";
> +			ti,gpio-always-on;
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 3329140..627f6ca 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -140,6 +140,7 @@
>  			reg = <0x4a310000 0x200>;
>  			interrupts = <0 29 0x4>;
>  			ti,hwmods = "gpio1";
> +			ti,gpio-always-on;
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index f4c71d9..82a4b03 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -133,6 +133,7 @@
>  			reg = <0x4ae10000 0x200>;
>  			interrupts = <0 29 0x4>;
>  			ti,hwmods = "gpio1";
> +			ti,gpio-always-on;
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
