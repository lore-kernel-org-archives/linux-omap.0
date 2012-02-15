From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] arm/dts: OMAP4: Add SPI controller nodes
Date: Wed, 15 Feb 2012 13:02:40 -0700
Message-ID: <20120215200240.GA25779@ponder.secretlab.ca>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
 <1329327457-2121-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34348 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab2BOUCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 15:02:43 -0500
Received: by iacb35 with SMTP id b35so1874359iac.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 12:02:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329327457-2121-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 15, 2012 at 06:37:35PM +0100, Benoit Cousson wrote:
> Add the 4 McSPI controller nodes present in an OMAP4 device.
> 
> Remove SPI static device initialisation if DT is populated.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/boot/dts/omap4.dtsi  |   32 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/devices.c |    4 +++-
>  2 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 4b81f03..7fc0cbe 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -209,5 +209,37 @@
>  			#size-cells = <0>;
>  			ti,hwmods = "i2c4";
>  		};
> +
> +		mcspi1: mcspi@1 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "mcspi1";
> +			ti,spi-num-cs = <4>;

No reg or interrupts properties?  And the @<num> in the name must match the
first entry in a reg property.  This looks wrong.

> +		};
> +
> +		mcspi2: mcspi@2 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "mcspi2";
> +			ti,spi-num-cs = <2>;
> +		};
> +
> +		mcspi3: mcspi@3 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "mcspi3";
> +			ti,spi-num-cs = <2>;
> +		};
> +
> +		mcspi4: mcspi@4 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "mcspi4";
> +			ti,spi-num-cs = <1>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 283d11e..8a489ba 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -725,7 +725,9 @@ static int __init omap2_init_devices(void)
>  	omap_init_dmic();
>  	omap_init_camera();
>  	omap_init_mbox();
> -	omap_init_mcspi();
> +	/* If dtb is there, the devices will be created dynamically */
> +	if (!of_have_populated_dt())
> +		omap_init_mcspi();
>  	omap_init_pmu();
>  	omap_hdq_init();
>  	omap_init_sti();
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
