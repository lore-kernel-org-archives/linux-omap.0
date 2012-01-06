From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller bindings
 for INTC
Date: Fri, 6 Jan 2012 14:24:23 -0700
Message-ID: <20120106212423.GD7457@ponder.secretlab.ca>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54433 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2AFVY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 16:24:26 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so3177487iae.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 13:24:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324388398-2683-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rob.herring@calxeda.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 20, 2011 at 02:39:57PM +0100, Benoit Cousson wrote:
> Update the DTS with the proper information required by the
> INTC bindings.
> 
> - Add the number of interrupt lines
> - Add the reg and the compatible entries.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/boot/dts/omap3.dtsi |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..6866dc7 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -54,10 +54,12 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> -		intc: interrupt-controller@1 {
> -			compatible = "ti,omap3-intc";
> +		intc: interrupt-controller@48200000 {
> +			compatible = "ti,omap2-intc";
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> +			ti,intc-size = <96>;
> +			reg = <0x48200000 0x1000>;
>  		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
