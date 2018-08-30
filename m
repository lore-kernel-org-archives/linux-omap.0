From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
Date: Thu, 30 Aug 2018 18:46:44 -0500
Message-ID: <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-3-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040929.23357-3-sz.lin@moxa.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Wes Huang <wes.huang@moxa.com>, Fero JD Zhou <FeroJD.Zhou@moxa.com>
List-Id: linux-omap@vger.kernel.org



On 08/29/2018 11:09 PM, SZ Lin (林上智) wrote:
> Add support for Moxa UC-2101 open platform
> 
> The UC-2101 computing platform is designed for industrial embedded
> data acquisition and processing applications.
> 
> The features of UC-2101 are:
> * eMMC
> * SPI flash
> * 1x LAN
> * 1x RS-232/422/485 ports, software-selectable
> * EEPROM
> * TPM 2.0
> * Watchdog
> * RTC
> * User gpio-keys
> * User LEDs
> * User button
> 
> Signed-off-by: Wes Huang (黃淵河) <wes.huang@moxa.com>
> Signed-off-by: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> ---
>   .../devicetree/bindings/arm/omap/omap.txt     |  3 +
>   arch/arm/boot/dts/Makefile                    |  1 +
>   arch/arm/boot/dts/am335x-moxa-uc-2101.dts     | 63 +++++++++++++++++++
>   3 files changed, 67 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 2ecc712bf707..c5ca3d6a8099 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -157,6 +157,9 @@ Boards:
>   - AM335X phyCORE-AM335x: Development kit
>     compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
>   
> +- AM335X UC-2100: Wireless-enabled palm-sized industrial computing platform
> +  compatible = "moxa,uc-2101", "ti,am33xx"
> +
>   - AM335X UC-8100-ME-T: Communication-centric industrial computing platform
>     compatible = "moxa,uc-8100-me-t", "ti,am33xx";
>   
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..6167c068601c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -706,6 +706,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>   	am335x-evmsk.dtb \
>   	am335x-icev2.dtb \
>   	am335x-lxm.dtb \
> +	am335x-moxa-uc-2101.dtb \
>   	am335x-moxa-uc-8100-me-t.dtb \
>   	am335x-nano.dtb \
>   	am335x-pdu001.dtb \
> diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> new file mode 100644
> index 000000000000..d0c1eea4a6c9
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 MOXA Inc. - https://www.moxa.com/
> + *
> + * Authors: SZ Lin (林上智) <sz.lin@moxa.com>
> + *          Wes Huang (黃淵河) <wes.huang@moxa.com>
> + *          Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "am335x-moxa-uc-2100-common.dtsi"
> +

> +
> +&cpsw_emac0 {
> +	status = "okay";
> +	phy_id = <&davinci_mdio>, <0x4>;

Pls, use phy-handle instead of phy_id here and in the next patch.

> +	phy-mode = "rmii";
> +};
> +
> +&cpsw_emac1 {
> +	status = "disable";
> +};
> 

-- 
regards,
-grygorii
