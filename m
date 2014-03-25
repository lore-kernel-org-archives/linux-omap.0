From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 2/5] ARM: dts: am43xx clock data
Date: Tue, 25 Mar 2014 11:49:21 +0200
Message-ID: <53315121.3040900@ti.com>
References: <1395223803-4714-1-git-send-email-george.cherian@ti.com> <1395223803-4714-3-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395223803-4714-3-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/19/2014 12:10 PM, George Cherian wrote:
> Add USB and USB PHY reference clock data
> 
> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

> ---
>  arch/arm/boot/dts/am43xx-clocks.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index 142009c..5171d3e 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -653,4 +653,36 @@
>  		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>;
>  		reg = <0x4260>;
>  	};
> +
> +	usb_phy0_always_on_clk32k: usb_phy0_always_on_clk32k {
> +        	#clock-cells = <0>;
> +	        compatible = "ti,gate-clock";
> +	        clocks = <&usbphy_32khz_clkmux>;
> +	        ti,bit-shift = <8>;
> +	        reg = <0x2a40>;
> +	};
> +
> +	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k {
> +        	#clock-cells = <0>;
> +	        compatible = "ti,gate-clock";
> +	        clocks = <&usbphy_32khz_clkmux>;
> +	        ti,bit-shift = <8>;
> +	        reg = <0x2a48>;
> +	};
> +
> +	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m {
> +		#clock-cells = <0>;
> +	        compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_clkdcoldo>;
> +	        ti,bit-shift = <8>;
> +	        reg = <0x8a60>;
> +	};
> +
> +	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
> +		#clock-cells = <0>;
> +	        compatible = "ti,gate-clock";
> +		clocks = <&dpll_per_clkdcoldo>;
> +	        ti,bit-shift = <8>;
> +		reg = <0x8a68>;
> +	};
>  };
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
