From: Suman Anna <s-anna@ti.com>
Subject: Re: [v3 PATCH 5/6] ARM: dts: dra7: Add prm_resets node
Date: Tue, 22 Jul 2014 14:07:34 -0500
Message-ID: <53CEB676.5050804@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com> <1405615531-15649-5-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39278 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbaGVTIC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2014 15:08:02 -0400
In-Reply-To: <1405615531-15649-5-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

Hi Dan,

On 07/17/2014 11:45 AM, Murphy, Dan wrote:
> Add the prcm_resets node to the prm parent node.
> 
> Add the draxx_resets file to define the
> dra7xx reset lines that are handled by this reset
> framework.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - No changes
> 
>  arch/arm/boot/dts/dra7.dtsi          |    7 +++
>  arch/arm/boot/dts/dra7xx-resets.dtsi |   82 ++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7xx-resets.dtsi
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 8012763..f3a8819 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -93,6 +93,12 @@
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
>  		cm_core_aon: cm_core_aon@4a005000 {
> @@ -998,3 +1004,4 @@
>  };
>  
>  /include/ "dra7xx-clocks.dtsi"
> +/include/ "dra7xx-resets.dtsi"
> diff --git a/arch/arm/boot/dts/dra7xx-resets.dtsi b/arch/arm/boot/dts/dra7xx-resets.dtsi
> new file mode 100644
> index 0000000..4c4966d
> --- /dev/null
> +++ b/arch/arm/boot/dts/dra7xx-resets.dtsi
> @@ -0,0 +1,82 @@
> +/*
> + * Device Tree Source for DRA7XX reset data
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
> +		reg = <0x410>,
> +			  <0x414>;
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
> +		reg = <0x510>,
> +			  <0x514>;
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

There are two IPUs on DRA7. Which one is this node for? And please add
the other reset node for the other IPU as well.

> +
> +	iva_rstctrl {
> +		reg = <0xf10>,
> +			  <0xf14>;
> +
> +		iva_reset: iva_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};

IVA also has three resets, one for logic and two for the sequencers. You
are describing only one of them.

> +	};
> +
> +	pcie_rstctrl {
> +		reg = <0x1310>,
> +			  <0x1314>;
> +
> +		pcie1_reset: pcie1_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +
> +		pcie2_reset: pcie2_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};

Copy-paste error? Both pcie resets cannot have the same control and
status bits.

regards
Suman

> +	};
> +
> +	device_rstctrl {
> +		reg = <0x1D00>,
> +			  <0x1D04>;
> +
> +		device_reset: device_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +};
> 

