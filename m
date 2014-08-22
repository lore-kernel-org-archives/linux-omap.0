From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Remove twl6030 clk32g "regulator"
Date: Fri, 22 Aug 2014 16:13:00 -0700
Message-ID: <20140822231259.GC17254@atomide.com>
References: <1407865760-15448-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46861 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbaHVXNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2014 19:13:04 -0400
Content-Disposition: inline
In-Reply-To: <1407865760-15448-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

* Mark Brown <broonie@kernel.org> [140812 10:52]:
> From: Mark Brown <broonie@linaro.org>
> 
> The kernel has never supported clk32g as a regulator since it is a clock
> and not a regulator. Fortunately nothing actually references this node so
> we can just remove it.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

If not too late:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/twl6030.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 2e3bd3172b23..55eb35f068fb 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -83,10 +83,6 @@
>  		regulator-always-on;
>  	};
>  
> -	clk32kg: regulator-clk32kg {
> -		compatible = "ti,twl6030-clk32kg";
> -	};
> -
>  	twl_usb_comparator: usb-comparator {
>  		compatible = "ti,twl6030-usb";
>  		interrupts = <4>, <10>;
> -- 
> 2.0.1
> 
