From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: dra7xx-clocks: Add gate clock for CLKOUT2
Date: Mon, 16 Mar 2015 15:01:43 -0700
Message-ID: <20150316220143.GL12397@atomide.com>
References: <1424957963-15418-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37879 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573AbbCPWGc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 18:06:32 -0400
Content-Disposition: inline
In-Reply-To: <1424957963-15418-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150226 05:43]:
> To be able to control the gate for the clkout2 clock output.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Applying into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/dra7xx-clocks.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 4bdcbd61ce47..2a9994f73974 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1421,6 +1421,14 @@
>  		ti,dividers = <1>, <8>;
>  	};
>  
> +	clkout2_clk: clkout2_clk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&clkoutmux2_clk_mux>;
> +		ti,bit-shift = <8>;
> +		reg = <0x06b0>;
> +	};
> +
>  	l3init_960m_gfclk: l3init_960m_gfclk {
>  		#clock-cells = <0>;
>  		compatible = "ti,gate-clock";
> -- 
> 2.3.0
> 
