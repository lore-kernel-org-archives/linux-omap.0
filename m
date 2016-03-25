From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: AM572x-IDK Initial Support
Date: Fri, 25 Mar 2016 10:03:44 -0500
Message-ID: <20160325150344.GA1268@rob-hp-laptop>
References: <1458858644-13800-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1458858644-13800-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Schuyler Patton <spatton@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 24, 2016 at 05:30:44PM -0500, Nishanth Menon wrote:
> From: Schuyler Patton <spatton@ti.com>
> 
> The AM572x-IDK board is a board based on TI's AM5728 SOC
> which has a dual core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 2GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
> 
> The link to the data sheet and TRM can be found here:
> 
> http://www.ti.com/product/AM5728
> 
> This patch creates a common dtsi file that will provide a common board
> dtsi file to define the nodes that are common to AM57xx (including the
> upcoming AM5718) IDK boards.
> 
> Initial support is only for basic peripherals
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Based on 6f30d29c603c Add linux-next specific files for 20160324
> 
> Test log: http://pastebin.ubuntu.com/15490907/
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am572x-idk.dts                   |  85 ++++++
>  arch/arm/boot/dts/am57xx-idk-common.dtsi           | 308 +++++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am572x-idk.dts
>  create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 21e71a5e866e..38659aa35ce3 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -169,6 +169,9 @@ Boards:
>  - AM57XX SBC-AM57x
>    compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> +- AM5728 IDK
> +  compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"

Okay, but I think the TI folks have gone a bit crazy with all these 
compatible strings...

> +
>  - DRA742 EVM:  Software Development Board for DRA742
>    compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b25621ae2ff7..fec03c814a95 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -526,6 +526,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-cl-som-am57x.dtb \
>  	am57xx-sbc-am57x.dtb \
> +	am572x-idk.dtb \
>  	dra7-evm.dtb \
>  	dra72-evm.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += \
> diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
> new file mode 100644
> index 000000000000..bb51f6de7b45
> --- /dev/null
> +++ b/arch/arm/boot/dts/am572x-idk.dts
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "dra74x.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "am57xx-idk-common.dtsi"
> +
> +/ {
> +	model = "TI AM5728 IDK";
> +	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
> +		     "ti,dra7";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;
> +	};
> +
> +	extcon_usb2: extcon_usb2 {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led@0 {

Unit-address without reg is going to start warning in dtc. Use something 
like "cpu0-led" instead.
