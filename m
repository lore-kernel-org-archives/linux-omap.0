From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DTS: ARM: TWL4030: Add madc
Date: Mon, 5 May 2014 12:26:51 -0700
Message-ID: <20140505192651.GB25949@atomide.com>
References: <1395184426-316-1-git-send-email-sre@debian.org>
 <1395184426-316-2-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62493 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774AbaEET05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 15:26:57 -0400
Content-Disposition: inline
In-Reply-To: <1395184426-316-2-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [140318 16:17]:
> Add madc node to twl4030, so that board DTS
> files can simply reference the A/D converter.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Applying into omap-for-v3.16/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/twl4030.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 86cfc7d..36ae916 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -152,4 +152,10 @@
>  		keypad,num-rows = <8>;
>  		keypad,num-columns = <8>;
>  	};
> +
> +	twl_madc: madc {
> +		compatible = "ti,twl4030-madc";
> +		interrupts = <3>;
> +		#io-channel-cells = <1>;
> +	};
>  };
> -- 
> 1.9.0
> 
