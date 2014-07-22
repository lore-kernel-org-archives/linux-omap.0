From: Suman Anna <s-anna@ti.com>
Subject: Re: [v3 PATCH 3/6] ARM: dts: am33xx: Add prcm_resets node
Date: Tue, 22 Jul 2014 13:54:05 -0500
Message-ID: <53CEB34D.7000601@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com> <1405615531-15649-3-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbaGVSy2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2014 14:54:28 -0400
In-Reply-To: <1405615531-15649-3-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

Hi Dan,

On 07/17/2014 11:45 AM, Murphy, Dan wrote:
> Add the prcm_resets node to the prcm parent node.
> 
> Add the am33xx_resets file to define the
> am33xx reset lines that are handled by this reset
> framework.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - No changes
> 
>  arch/arm/boot/dts/am33xx-resets.dtsi |   42 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi        |    7 ++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am33xx-resets.dtsi
> 
> diff --git a/arch/arm/boot/dts/am33xx-resets.dtsi b/arch/arm/boot/dts/am33xx-resets.dtsi
> new file mode 100644
> index 0000000..9260626
> --- /dev/null
> +++ b/arch/arm/boot/dts/am33xx-resets.dtsi
> @@ -0,0 +1,42 @@
> +/*
> + * Device Tree Source for AM33XX reset data
> + *
> + * Copyright (C) 2014 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +&prcm_resets {
> +	gfx_rstctrl {
> +		reg = <0x1104>,
> +			  <0x1114>;
> +
> +		gfx_reset: gfx_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +	per_rstctrl {
> +		reg = <0xD00>,
> +			  <0xD0C>;
> +
> +		iva_reset: iva_reset {

There is no IVA on AM33xx, this should be corrected to reflect the PRU_ICSS.

> +			control-bit = <0x04>;
> +			status-bit = <0x10>;
> +		};
> +	};

Not defining the WkupM3 reset control?

> +
> +	device_rstctrl {
> +		reg = <0xf00>,
> +			  <0xf08>;
> +
> +		device_reset: device_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 4a4e02d..5cdc8f0 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -117,6 +117,12 @@
>  
>  			prcm_clockdomains: clockdomains {
>  			};
> +
> +			prcm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

Should be corrected as per comment on DT bindings.

regards
Suman

> +				#reset-cells = <1>;
> +			};
>  		};
>  
>  		scrm: scrm@44e10000 {
> @@ -834,3 +840,4 @@
>  };
>  
>  /include/ "am33xx-clocks.dtsi"
> +/include/ "am33xx-resets.dtsi"
> 

