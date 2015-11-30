From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap4: Add elm node
Date: Mon, 30 Nov 2015 13:17:38 -0800
Message-ID: <20151130211738.GR2517@atomide.com>
References: <1446066137-11527-1-git-send-email-fcooper@ti.com>
 <1446066137-11527-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446066137-11527-2-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [151028 14:02]:
> Add device tree entry for the error location module.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Applying this one into omap-for-v4.5/dt thanks.

Tony


>  arch/arm/boot/dts/omap4.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 5a206c1..a40eb23 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -348,6 +348,14 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		elm: elm@48078000 {
> +			compatible = "ti,am3352-elm";
> +			reg = <0x48078000 0x2000>;
> +			interrupts = <4>;
> +			ti,hwmods = "elm";
> +			status = "disabled";
> +		};
> +
>  		gpmc: gpmc@50000000 {
>  			compatible = "ti,omap4430-gpmc";
>  			reg = <0x50000000 0x1000>;
> -- 
> 2.6.1
> 
