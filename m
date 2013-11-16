From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/11] ARM: dts: omap3-igep: Update to use the TI
 AM/DM37x processor.
Date: Sat, 16 Nov 2013 06:44:12 -0800
Message-ID: <20131116144412.GH10317@atomide.com>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-4-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18200 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958Ab3KPOoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 09:44:18 -0500
Content-Disposition: inline
In-Reply-To: <1384608224-9452-4-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
> From: Enric Balletbo i Serra <eballetbo@gmail.com>
> 
> Most of the boards are using the TI AM/DM37x processor, there is only a small
> quantity of IGEP Processor Boards based on TI OMAP3530. So it's better use the
> omap36xx.dtsi include instead of omap34xx.dtsi include.
> 
> To avoid confusion we have added to the model the (TI AM/DM37x) comment.

You could have omap3-igep-common.dtsi that contains most configurations
and then files including that where only the SoC type and name is set.

Regards,

Tony
 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi    | 4 ++--
>  arch/arm/boot/dts/omap3-igep0020.dts | 4 ++--
>  arch/arm/boot/dts/omap3-igep0030.dts | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index b3517b2..e4c8769 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Device Tree Source for IGEP Technology devices
> + * Common device tree for IGEP boards based on AM/DM37x
>   *
>   * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
>   * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
> @@ -10,7 +10,7 @@
>   */
>  /dts-v1/;
>  
> -#include "omap34xx.dtsi"
> +#include "omap36xx.dtsi"
>  
>  / {
>  	memory {
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index d5cc792..33ce123 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Device Tree Source for IGEPv2 board
> + * Device Tree Source for IGEPv2 Rev. (TI OMAP AM/DM37x)
>   *
>   * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
>   * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
> @@ -13,7 +13,7 @@
>  #include "omap-gpmc-smsc911x.dtsi"
>  
>  / {
> -	model = "IGEPv2";
> +	model = "IGEPv2 (TI OMAP AM/DM37x)";
>  	compatible = "isee,omap3-igep0020", "ti,omap3";
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 525e6d9..02a23f8 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Device Tree Source for IGEP COM Module
> + * Device Tree Source for IGEP COM MODULE (TI OMAP AM/DM37x)
>   *
>   * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
>   * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
> @@ -12,7 +12,7 @@
>  #include "omap3-igep.dtsi"
>  
>  / {
> -	model = "IGEP COM Module";
> +	model = "IGEP COM MODULE (TI OMAP AM/DM37x)";
>  	compatible = "isee,omap3-igep0030", "ti,omap3";
>  
>  	leds {
> -- 
> 1.8.4.2
> 
