From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 7/8] ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
Date: Fri, 14 Feb 2014 15:54:40 +0200
Message-ID: <52FE2020.2010601@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35932 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbaBNNzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 08:55:03 -0500
In-Reply-To: <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
> Set 'ti,set-rate-parent' property for clocks in the dpll4_m4 clock
> path, which is used for DSS functional clock. This fixes DSS driver's
> clock rate configuration, which needs the rate to be propagated properly
> to the divider node (dpll4_m4_ck).


... squash to #6?

-Tero

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/boot/dts/omap3xxx-clocks.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> index df3c699a1893..12be2b35dae9 100644
> --- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> @@ -429,6 +429,7 @@
>   		clocks = <&dpll4_m4_ck>;
>   		ti,clock-mult = <2>;
>   		ti,clock-div = <1>;
> +		ti,set-rate-parent;
>   	};
>
>   	dpll4_m4x2_ck: dpll4_m4x2_ck {
> @@ -438,6 +439,7 @@
>   		ti,bit-shift = <0x1d>;
>   		reg = <0x0d00>;
>   		ti,set-bit-to-disable;
> +		ti,set-rate-parent;
>   	};
>
>   	dpll4_m5_ck: dpll4_m5_ck {
>

