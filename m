From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent
 to dss_dss_clk
Date: Fri, 23 May 2014 12:33:03 +0300
Message-ID: <537F15CF.9060607@ti.com>
References: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36098 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaEWJcg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 05:32:36 -0400
In-Reply-To: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/21/2014 03:16 PM, Tomi Valkeinen wrote:
> Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
> set the rate.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Both patches queued for 3.16, thanks.

-Tero

> ---
>   arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> index d487fdab3921..d44bdaa8fe68 100644
> --- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> @@ -851,6 +851,7 @@
>   		clocks = <&dpll_per_h12x2_ck>;
>   		ti,bit-shift = <8>;
>   		reg = <0x1420>;
> +		ti,set-rate-parent;
>   	};
>
>   	dss_sys_clk: dss_sys_clk {
>

