From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: am33xx: Add external clock provider
Date: Mon, 8 Sep 2014 16:30:38 -0700
Message-ID: <20140908233037.GT3238@atomide.com>
References: <cover.1408397864.git.jsarha@ti.com>
 <9d4974b949b9b3bc1b08d73b1ec2d9cdd7a8e5da.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43507 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755009AbaIHXaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 19:30:46 -0400
Content-Disposition: inline
In-Reply-To: <9d4974b949b9b3bc1b08d73b1ec2d9cdd7a8e5da.1408397864.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, ezequiel.garcia@free-electrons.com, t-kristo@ti.com

* Jyri Sarha <jsarha@ti.com> [140818 14:49]:
> Add external clock provider for am33xx devices.

Please send all the .dts and defconfig changes separately
so I can pick them up and we don't get pointless merge
conflicts.

Regards,

TOny
 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 3a0a161..d2cc397 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -92,6 +92,16 @@
>  		pinctrl-single,function-mask = <0x7f>;
>  	};
>  
> +	ext_clocks {
> +		compatible = "ti,external-clocks";
> +
> +		ext_clocks: clocks {
> +		};
> +
> +		ext_clockdomains: clockdomains {
> +		};
> +	};
> +
>  	/*
>  	 * XXX: Use a flat representation of the AM33XX interconnect.
>  	 * The real AM33XX interconnect network is quite complex. Since
> -- 
> 1.7.9.5
> 
