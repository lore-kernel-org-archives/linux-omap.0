From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] dts/omap3: split omap3.dtsi
Date: Thu, 10 Nov 2011 14:18:19 +0200
Message-ID: <4EBBC10B.6070206@compulab.co.il>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-4-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:51213
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932395Ab1KJMSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 07:18:31 -0500
In-Reply-To: <1320797568-11169-4-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Ilya,

On 11/09/11 02:12, Ilya Yanok wrote:
> Split omap3.dtsi file into common part, OM3xxx specific part and
> AM35xx specific part. For now the only difference is missing IVA node on
> AM35xx.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/boot/dts/am35xx.dtsi      |   15 +++++++++++++++
>  arch/arm/boot/dts/om3xxx.dtsi      |   28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-beagle.dts |    2 +-
>  arch/arm/boot/dts/omap3.dtsi       |    9 ---------
>  4 files changed, 44 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am35xx.dtsi
>  create mode 100644 arch/arm/boot/dts/om3xxx.dtsi

om3xxx name is confusing - I haven't seen this name
in any documentation/code before...
Am I missing something?

What do you think of omap3-iva.dtsi or omap3-dsp.dtsi?

> 
> diff --git a/arch/arm/boot/dts/am35xx.dtsi b/arch/arm/boot/dts/am35xx.dtsi
> new file mode 100644
> index 0000000..0dbc69d
> --- /dev/null
> +++ b/arch/arm/boot/dts/am35xx.dtsi
> @@ -0,0 +1,15 @@
> +/*
> + * Device Tree Source for TI AM35xx SoCs
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	compatible = "ti,am35xx", "ti,omap3";
> +};
> diff --git a/arch/arm/boot/dts/om3xxx.dtsi b/arch/arm/boot/dts/om3xxx.dtsi
> new file mode 100644
> index 0000000..e8a17dd
> --- /dev/null
> +++ b/arch/arm/boot/dts/om3xxx.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * Device Tree Source for TI OM3xxx SoCs
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	/*
> +	 * The soc node represents the soc top level view. It is uses for IPs
> +	 * that are not memory mapped in the MPU view or for the MPU itself.
> +	 */
> +	soc {
> +		iva {
> +			compatible = "ti,iva2.2";
> +			ti,hwmods = "iva";
> +
> +			dsp {
> +				compatible = "ti,omap3-c64";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 9486be6..63e4be1 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -7,7 +7,7 @@
>   */
>  /dts-v1/;
>  
> -/include/ "omap3.dtsi"
> +/include/ "om3xxx.dtsi"
>  
>  / {
>  	model = "TI OMAP3 BeagleBoard";
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..2b12b0e 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -29,15 +29,6 @@
>  			compatible = "ti,omap3-mpu";
>  			ti,hwmods = "mpu";
>  		};
> -
> -		iva {
> -			compatible = "ti,iva2.2";
> -			ti,hwmods = "iva";
> -
> -			dsp {
> -				compatible = "ti,omap3-c64";
> -			};
> -		};
>  	};
>  
>  	/*

-- 
Regards,
Igor.
