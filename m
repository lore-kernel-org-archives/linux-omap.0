From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Mon, 29 Feb 2016 15:23:48 -0800
Message-ID: <20160229232348.GV13417@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456439796-28546-4-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: paul@pwsan.com, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
> From: Vignesh R <vigneshr@ti.com>
> 
> tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
> clock to control ehrpwm tbclk.
> The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
> ehrpwm functional clock derived from the gateable interface and
> functional clock of PWMSS(l4_root_clk_div).
> Refer AM57x TRM SPRUHZ6[1], October 2014, Table 29-4 and Section 29.2.2.1,
> Table 29-19 and the NOTE at the end of the table.
> 
> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf

Applying this into omap-for-v4.6/dt thanks.

Note for Tero, let's plan on getting rid of the duplicate
reg entries by using the standard clock output offset within
the clock register. I think we should easily be able to add
a binding for this and then deprecate the overlapping reg
entries.

Regards,

Tony

> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -2146,4 +2146,28 @@
>  		ti,bit-shift = <0>;
>  		reg = <0x558>;
>  	};
> +
> +       ehrpwm0_tbclk: ehrpwm0_tbclk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l4_root_clk_div>;
> +		ti,bit-shift = <20>;
> +		reg = <0x0558>;
> +	};
> +
> +	ehrpwm1_tbclk: ehrpwm1_tbclk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l4_root_clk_div>;
> +		ti,bit-shift = <21>;
> +		reg = <0x0558>;
> +	};
> +
> +	ehrpwm2_tbclk: ehrpwm2_tbclk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l4_root_clk_div>;
> +		ti,bit-shift = <22>;
> +		reg = <0x0558>;
> +	};
>  };
> -- 
> 2.7.0
> 
