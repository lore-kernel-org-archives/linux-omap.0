From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: Add support for both OMAP35xx and OMAP36xx
 Overo/Tobi
Date: Thu, 13 Feb 2014 08:41:58 -0600
Message-ID: <52FCD9B6.8000407@ti.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch> <1392287116-4548-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40857 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaBMOm2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 09:42:28 -0500
In-Reply-To: <1392287116-4548-4-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Unfortunatly the device tree for older OMAP35xx Overo cannot be used
> with newer OMAP36xx and vice-versa. To address this issue, move most of
> the Tobi DTS to a common include file, and create model-specific Tobi
> DTS.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> Tested-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  3 ++-
>  arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
>  ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  6 ------
>  arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
>  rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (91%)
>  create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b9d6a8b..e8355f4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -208,7 +208,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-n900.dtb \
>  	omap3-n9.dtb \
>  	omap3-n950.dtb \
> -	omap3-tobi.dtb \
> +	omap3-overo-tobi.dtb \
> +	omap3-overo-storm-tobi.dtb \
>  	omap3-gta04.dtb \
>  	omap3-igep0020.dtb \
>  	omap3-igep0030.dtb \
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
> new file mode 100644
> index 0000000..966b5c9
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * Tobi expansion board is manufactured by Gumstix Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "omap36xx.dtsi"
> +#include "omap3-overo-tobi-common.dtsi"
> +
> +/ {
> +	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi";
> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
> +};
> +
> diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
> similarity index 91%
> rename from arch/arm/boot/dts/omap3-tobi.dts
> rename to arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
> index c742afa..4edc013 100644
> --- a/arch/arm/boot/dts/omap3-tobi.dts
> +++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
> @@ -10,15 +10,9 @@
>   * Tobi expansion board is manufactured by Gumstix Inc.
>   */
>  
> -/dts-v1/;
> -
> -#include "omap36xx.dtsi"
>  #include "omap3-overo.dtsi"
>  
>  / {
> -	model = "TI OMAP3 Gumstix Overo on Tobi";
> -	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
> -
>  	leds {
>  		compatible = "gpio-leds";
>  		heartbeat {
> diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
> new file mode 100644
> index 0000000..de5653e
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * Tobi expansion board is manufactured by Gumstix Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "omap34xx.dtsi"
> +#include "omap3-overo-tobi-common.dtsi"
> +
> +/ {
> +	model = "OMAP35xx Gumstix Overo on Tobi";
> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3";
> +};
> +
> 


-- 
Regards,
Nishanth Menon
