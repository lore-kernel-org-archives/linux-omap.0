From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor
Date: Mon, 16 Mar 2015 15:17:40 -0700
Message-ID: <20150316221740.GQ12397@atomide.com>
References: <1426203501-32115-1-git-send-email-prabhakar.csengg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426203501-32115-1-git-send-email-prabhakar.csengg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Lad Prabhakar <prabhakar.csengg@gmail.com> [150312 16:38]:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> this patch does the following:
> 1: adds DT node for fixed oscillator.
> 2: adds DT node entries for ov2659 sensor
> 3: adds remote-endpoint entry for VPFE.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Applying into omap-for-v4.1/dt thanks.

Tony

> ---
>  Note this patch depends on
>  https://patchwork.kernel.org/patch/6000161/
>  
>  arch/arm/boot/dts/am437x-gp-evm.dts | 42 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index f84d971..195f452 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -106,6 +106,14 @@
>  			};
>  		};
>  	};
> +
> +	/* fixed 12MHz oscillator */
> +	refclk: oscillator {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <12000000>;
> +	};
> +
>  };
>  
>  &am43xx_pinmux {
> @@ -404,6 +412,21 @@
>  			regulator-always-on;
>  		};
>  	};
> +
> +	ov2659@30 {
> +		compatible = "ovti,ov2659";
> +		reg = <0x30>;
> +
> +		clocks = <&refclk 0>;
> +		clock-names = "xvclk";
> +
> +		port {
> +			ov2659_0: endpoint {
> +				remote-endpoint = <&vpfe1_ep>;
> +				link-frequencies = /bits/ 64 <70000000>;
> +			};
> +		};
> +	};
>  };
>  
>  &i2c1 {
> @@ -423,6 +446,21 @@
>  		touchscreen-size-x = <1024>;
>  		touchscreen-size-y = <600>;
>  	};
> +
> +	ov2659@30 {
> +		compatible = "ovti,ov2659";
> +		reg = <0x30>;
> +
> +		clocks = <&refclk 0>;
> +		clock-names = "xvclk";
> +
> +		port {
> +			ov2659_1: endpoint {
> +				remote-endpoint = <&vpfe0_ep>;
> +				link-frequencies = /bits/ 64 <70000000>;
> +			};
> +		};
> +	};
>  };
>  
>  &epwmss0 {
> @@ -626,7 +664,7 @@
>  
>  	port {
>  		vpfe0_ep: endpoint {
> -			/* remote-endpoint = <&sensor>; add once we have it */
> +			remote-endpoint = <&ov2659_1>;
>  			ti,am437x-vpfe-interface = <0>;
>  			bus-width = <8>;
>  			hsync-active = <0>;
> @@ -643,7 +681,7 @@
>  
>  	port {
>  		vpfe1_ep: endpoint {
> -			/* remote-endpoint = <&sensor>; add once we have it */
> +			remote-endpoint = <&ov2659_0>;
>  			ti,am437x-vpfe-interface = <0>;
>  			bus-width = <8>;
>  			hsync-active = <0>;
> -- 
> 2.1.0
> 
