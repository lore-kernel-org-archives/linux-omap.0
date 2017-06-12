From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap4: add missing des_fck
Date: Mon, 12 Jun 2017 00:26:47 -0700
Message-ID: <20170612072647.GQ3730@atomide.com>
References: <20170609231206.19798-1-sre@kernel.org>
 <20170609231206.19798-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170609231206.19798-2-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170609 16:16]:
> Add missing functional clock for DES3DES IP core. This is
> documented in the TRM as CM_L4SEC_DES3DES_CLKCTRL.

Tero care to ack? Also, see the other two hwmod patches
in this series for your clkctrl changes.

Regards,

Tony

> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  arch/arm/boot/dts/omap44xx-clocks.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> index 9573b37fbaa7..e997265460d4 100644
> --- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> @@ -985,6 +985,14 @@
>  		reg = <0x15a8>;
>  	};
>  
> +	des_fck: des_fck@15b0 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l3_div_ck>;
> +		ti,bit-shift = <1>;
> +		reg = <0x15b0>;
> +	};
> +
>  	dss_sys_clk: dss_sys_clk@1120 {
>  		#clock-cells = <0>;
>  		compatible = "ti,gate-clock";
> -- 
> 2.11.0
> 
