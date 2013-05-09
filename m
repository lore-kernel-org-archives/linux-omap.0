From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3,2/3] ARM: dts: AM33XX: Add GPMC node
Date: Wed, 8 May 2013 17:16:07 -0700
Message-ID: <20130509001606.GZ32546@atomide.com>
References: <2645efefa3d36388ff1d4b64255d880b6587770f.1359007746.git.avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2645efefa3d36388ff1d4b64255d880b6587770f.1359007746.git.avinashphilip-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org> [130502 02:49]:
> From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
> 
> Add GPMC data node to AM33XX device tree file.
> 
> Signed-off-by: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>

Thanks adding into omap-for-v3.10/dt-fixes.

Tony
 
> ---
> Changes in v2:
> 	- Change number of chip select to 7
> 
>  arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 24fc835..1048795 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -407,5 +407,17 @@
>  			ti,hwmods = "elm";
>  			status = "disabled";
>  		};
> +
> +		gpmc: gpmc@50000000 {
> +			compatible = "ti,am3352-gpmc";
> +			ti,hwmods = "gpmc";
> +			reg = <0x50000000 0x2000>;
> +			interrupts = <100>;
> +			num-cs = <7>;
> +			num-waitpins = <2>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +		};
>  	};
>  };
