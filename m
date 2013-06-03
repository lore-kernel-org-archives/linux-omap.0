From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v3] ARM: dts: AM43x: initial support
Date: Mon, 3 Jun 2013 16:15:10 +0200
Message-ID: <51ACA4EE.6070603@ti.com>
References: <1370265594-12883-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370265594-12883-1-git-send-email-afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ankur Kishore <a-kishore@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/03/2013 03:19 PM, Afzal Mohammed wrote:
> DT source (minimal) for AM4372 SoC to represent AM43x SoC's. Those
> represented here are the minimal DT nodes necessary to get kernel
> booting.
> 
> In DT nodes, "ti,hwmod" property has not been added, this would be
> added along with PRCM support for AM43x.
> 
> Signed-off-by: Ankur Kishore <a-kishore@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Thanks Afzal. I've just applied it in my branch.

Regards,
Benoit

> ---
> 
> v3: Make use of C preprocessor, rebased over Benoit's 'for_3.11/dts' branch
> v2: Add gptimer 1ms, timer2, synctimer and remove twd local timer
> 
>  arch/arm/boot/dts/am4372.dtsi | 68 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am4372.dtsi
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> new file mode 100644
> index 0000000..ddc1df7
> --- /dev/null
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -0,0 +1,68 @@
> +/*
> + * Device Tree Source for AM4372 SoC
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +	compatible = "ti,am4372", "ti,am43";
> +	interrupt-parent = <&gic>;
> +
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +		};
> +	};
> +
> +	gic: interrupt-controller@48241000 {
> +		compatible = "arm,cortex-a9-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0x48241000 0x1000>,
> +		      <0x48240100 0x0100>;
> +	};
> +
> +	ocp {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		uart0: serial@44e09000 {
> +			compatible = "ti,am4372-uart","ti,omap2-uart";
> +			reg = <0x44e09000 0x2000>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		timer1: timer@44e31000 {
> +			compatible = "ti,am4372-timer-1ms","ti,am335x-timer-1ms";
> +			reg = <0x44e31000 0x400>;
> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,timer-alwon;
> +		};
> +
> +		timer2: timer@48040000  {
> +			compatible = "ti,am4372-timer","ti,am335x-timer";
> +			reg = <0x48040000  0x400>;
> +			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		counter32k: counter@44e86000 {
> +			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
> +			reg = <0x44e86000 0x40>;
> +		};
> +	};
> +};
> 
