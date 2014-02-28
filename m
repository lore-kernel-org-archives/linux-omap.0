From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: dts: am33xx.dtsi: Add node name to rtc device
 node
Date: Fri, 28 Feb 2014 14:45:05 -0800
Message-ID: <20140228224504.GQ13624@atomide.com>
References: <1391602361-2666-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16352 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751729AbaB1WpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:45:18 -0500
Content-Disposition: inline
In-Reply-To: <1391602361-2666-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Lukas Stockmann <lukas.stockmann@siemens.com>, Benoit Cousson <bcousson@baylibre.com>

* Stefan Roese <sr@denx.de> [140205 04:14]:
> Making it possible to reference and therefor change (disable) this
> device node from other dts file which import this dtsi file.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks applying into omap-for-v3.15/dt.

Tony

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..b8daf8c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -399,7 +399,7 @@
>  			ti,timer-pwm;
>  		};
>  
> -		rtc@44e3e000 {
> +		rtc: rtc@44e3e000 {
>  			compatible = "ti,da830-rtc";
>  			reg = <0x44e3e000 0x1000>;
>  			interrupts = <75
> -- 
> 1.8.5.3
> 
