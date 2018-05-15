From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: dts: dra762: Add MCAN clock support
Date: Tue, 15 May 2018 10:16:59 -0700
Message-ID: <20180515171659.GQ98604@atomide.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-3-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523181542-3770-3-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, linux@armlinux.org.uk, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> MCAN is clocked by H14 divider of DPLL_GMAC. Unlike other
> DPLL dividers this DPLL_GMAC H14 divider is controlled by
> control module. Adding support for these clocks.

Adding Tero to Cc on this one.

> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/boot/dts/dra76x.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
> index 1c88c58..bfc8263 100644
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -17,3 +17,36 @@
>  &crossbar_mpu {
>  	ti,irqs-skip = <10 67 68 133 139 140>;
>  };
> +
> +&scm_conf_clocks {
> +	dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
> +		#clock-cells = <0>;
> +		compatible = "ti,divider-clock";
> +		clocks = <&dpll_gmac_x2_ck>;
> +		ti,max-div = <63>;
> +		reg = <0x03fc>;
> +		ti,bit-shift=<20>;
> +		ti,latch-bit=<26>;
> +		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
> +		assigned-clock-rates = <80000000>;
> +	};
> +
> +	dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
> +		#clock-cells = <0>;
> +		compatible = "ti,mux-clock";
> +		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
> +		reg = <0x3fc>;
> +		ti,bit-shift = <29>;
> +		ti,latch-bit=<26>;
> +		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
> +		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
> +	};
> +
> +	mcan_clk: mcan_clk@3fc {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
> +		ti,bit-shift = <27>;
> +		reg = <0x3fc>;
> +	};
> +};
> -- 
> 2.7.4
> 
