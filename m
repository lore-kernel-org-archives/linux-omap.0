From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 1/3] ARM: dts: am43xx: add support for clkout1 clock
Date: Tue, 22 Oct 2019 08:48:16 -0700
Message-ID: <20191022154816.GO5610@atomide.com>
References: <20191016184954.14048-1-bparrot@ti.com>
 <20191016184954.14048-2-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191016184954.14048-2-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191016 18:47]:
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -704,6 +704,60 @@
>  		ti,bit-shift = <8>;
>  		reg = <0x2a48>;
>  	};
> +
> +	clkout1_osc_div_ck: clkout1_osc_div_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,divider-clock";
> +		clocks = <&sys_clkin_ck>;
> +		ti,bit-shift = <20>;
> +		ti,max-div = <4>;
> +		reg = <0x4100>;
> +	};

Here too please describe why the clock names are not generic.

Regards,

Tony
