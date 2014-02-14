From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 6/8] ARM: dts: use ti,fixed-factor-clock for dpll4_m4x2_mul_ck
Date: Fri, 14 Feb 2014 15:54:09 +0200
Message-ID: <52FE2001.1020906@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbaBNNyc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Feb 2014 08:54:32 -0500
In-Reply-To: <1392285846-13199-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
> We need to use set-rate-parent for dpll4_m4 clock path, so use the
> ti,fixed-factor-clock version which supports set-rate-parent property.


.... you are talking about the flag but not introducing it in this 
patch, maybe squash this + patch 7...?

-Tero

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
>   arch/arm/boot/dts/omap3xxx-clocks.dtsi | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
> index 0b2df76b9d38..6b5280d04a0e 100644
> --- a/arch/arm/boot/dts/omap36xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
> @@ -79,7 +79,7 @@
>   };
>
>   &dpll4_m4x2_mul_ck {
> -	clock-mult = <1>;
> +	ti,clock-mult = <1>;
>   };
>
>   &dpll4_m5x2_mul_ck {
> diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> index cb04d4b37e7f..df3c699a1893 100644
> --- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> @@ -425,10 +425,10 @@
>
>   	dpll4_m4x2_mul_ck: dpll4_m4x2_mul_ck {
>   		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> +		compatible = "ti,fixed-factor-clock";
>   		clocks = <&dpll4_m4_ck>;
> -		clock-mult = <2>;
> -		clock-div = <1>;
> +		ti,clock-mult = <2>;
> +		ti,clock-div = <1>;
>   	};
>
>   	dpll4_m4x2_ck: dpll4_m4x2_ck {
>

