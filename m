From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Thu, 21 Nov 2019 08:19:43 -0500
Message-ID: <0926767e-111b-22f5-e87d-51a7269307aa@ti.com>
References: <20191119202850.18149-1-c-robey@ti.com>
 <20191119202850.18149-2-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119202850.18149-2-c-robey@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/19/19 3:28 PM, Caleb Robey wrote:
> From: Jason Kridner <jdk@ti.com>
> 
> BeagleBoard.org BeagleBone AI is an open source hardware single
> board computer based on the Texas Instruments AM5729 SoC featuring
> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> signal processor (DSP), quad-core embedded vision engine (EVE),
> Arm Cortex-M4 processors, dual programmable realtime unit
> industrial control subsystems and more. The board features 1GB
> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> headers.
> 
> For more information, refer to:
> https://beaglebone.ai
> 
> This patch introduces the BeagleBone AI device tree.
> 
> Note that the device use the "ti,tpd12s016" component which is
> software compatible with "ti,tpd12s015". Thus we only use the
> latter driver.
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> Signed-off-by: Caleb Robey <c-robey@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> 
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/am5729-beagleboneai.dts | 782 ++++++++++++++++++++++
>  2 files changed, 783 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b21b3a64641a..b1154dbda73c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -791,6 +791,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-beagle-x15-revb1.dtb \
>  	am57xx-beagle-x15-revc.dtb \
> +	am5729-beagleboneai.dtb \
>  	am57xx-cl-som-am57x.dtb \
>  	am57xx-sbc-am57x.dtb \
>  	am572x-idk.dtb \
> diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
> new file mode 100644
> index 000000000000..7d0e132e6a23
> --- /dev/null
> +++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
> @@ -0,0 +1,782 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2014-2019 Texas Instruments Incorporated - http://www.ti.com/


I know this is mostly a copy/paste from other boards, but lets not claim
copyright 5 years back on a file describing a device that was not even
thought up then.


> + */
> +
> +/dts-v1/;
> +
> +#include "dra74x.dtsi"
> +#include "am57xx-commercial-grade.dtsi"
> +#include "dra74x-mmc-iodelay.dtsi"
> +#include "dra74-ipu-dsp-common.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/dra.h>
> +
> +/ {
> +	model = "BeagleBoard.org BeagleBone AI";
> +	compatible = "beagleboard.org,am5729-beagleboneai", "ti,am5728",
> +		     "ti,dra742", "ti,dra74", "ti,dra7";
> +
> +	aliases {
> +		rtc0 = &tps659038_rtc;
> +		rtc1 = &rtc;
> +		display0 = &hdmi_conn;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ipu2_memory_region: ipu2-memory@95800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x95800000 0x0 0x3800000>;
> +			reusable;
> +			status = "okay";
> +		};


Now these reserved memories are unused.

Andrew


> +
> +		dsp1_memory_region: dsp1-memory@99000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x99000000 0x0 0x4000000>;
> +			reusable;
> +			status = "okay";
> +		};
> +
> +		ipu1_memory_region: ipu1-memory@9d000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x9d000000 0x0 0x2000000>;
> +			reusable;
> +			status = "okay";
> +		};
> +
> +		dsp2_memory_region: dsp2-memory@9f000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x9f000000 0x0 0x800000>;
> +			reusable;
> +			status = "okay";
> +		};
> +
> +	};
> +
