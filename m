From: Suman Anna <s-anna@ti.com>
Subject: Re: [v3 PATCH 6/6] ARM: dts: omap5: Add prm_resets node
Date: Tue, 22 Jul 2014 14:09:01 -0500
Message-ID: <53CEB6CD.9020002@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com> <1405615531-15649-6-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38019 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaGVTJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 15:09:24 -0400
In-Reply-To: <1405615531-15649-6-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

Hi Dan,

On 07/17/2014 11:45 AM, Murphy, Dan wrote:
> Add the prm_resets node to the prm parent node.
> 
> Add the omap54xx_resets file to define the
> omap5 reset lines that are handled by this reset
> framework.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - No changes
> 
>  arch/arm/boot/dts/omap5.dtsi           |    7 ++++
>  arch/arm/boot/dts/omap54xx-resets.dtsi |   66 ++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap54xx-resets.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a4ed549..97bfef5 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -139,6 +139,12 @@
>  
>  			prm_clockdomains: clockdomains {
>  			};
> +
> +			prm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

Should be corrected as per comment on DT bindings.

> +				#reset-cells = <1>;
> +			};
>  		};
>  
>  		cm_core_aon: cm_core_aon@4a004000 {
> @@ -989,3 +995,4 @@
>  };
>  
>  /include/ "omap54xx-clocks.dtsi"
> +/include/ "omap54xx-resets.dtsi"
> diff --git a/arch/arm/boot/dts/omap54xx-resets.dtsi b/arch/arm/boot/dts/omap54xx-resets.dtsi
> new file mode 100644
> index 0000000..cba6f52
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap54xx-resets.dtsi
> @@ -0,0 +1,66 @@
> +/*
> + * Device Tree Source for OMAP5 reset data
> + *
> + * Copyright (C) 2014 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +&prm_resets {
> +	dsp_rstctrl {
> +		reg = <0x1c00>,
> +			  <0x1c04>;
> +
> +		dsp_reset: dsp_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +
> +		dsp_mmu_reset: dsp_mmu_reset {
> +			control-bit = <0x02>;
> +			status-bit = <0x02>;
> +		};
> +	};
> +
> +	ipu_rstctrl {
> +		reg = <0x910>,
> +			  <0x914>;
> +
> +		ipu_cpu0_reset: ipu_cpu0_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +
> +		ipu_cpu1_reset: ipu_cpu1_reset {
> +			control-bit = <0x02>;
> +			status-bit = <0x02>;
> +		};
> +
> +		ipu_mmu_reset: ipu_mmu_reset {
> +			control-bit = <0x04>;
> +			status-bit = <0x04>;
> +		};
> +	};

Missing reset node for SGX/GFX?

> +
> +	iva_rstctrl {
> +		reg = <0x1210>,
> +			  <0x1214>;
> +
> +		iva_reset: iva_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};

IVA also has three resets, one for logic and two for the sequencers. You
are describing only one of them.

regards
Suman

> +	};
> +
> +	device_rstctrl {
> +		reg = <0x1c00>,
> +			  <0x1c04>;
> +
> +		device_reset: device_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +};
> 

