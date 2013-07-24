From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] arm: dts: dra7-evm: add sd/eMMC node
Date: Wed, 24 Jul 2013 11:20:30 -0500
Message-ID: <51EFFECE.4010800@ti.com>
References: <1374599867-13099-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935Ab3GXQUd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jul 2013 12:20:33 -0400
In-Reply-To: <1374599867-13099-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, benoit.cousson@linaro.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

On 07/23/2013 12:17 PM, Balaji T K wrote:
> Add micro SD card and eMMC support for dra7-evm
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>   arch/arm/boot/dts/dra7-evm.dts |   18 ++++++++++++++++++
>   1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index cb0703c..4656ab4 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -17,4 +17,22 @@
>   		device_type = "memory";
>   		reg = <0x80000000 0x60000000>; /* 1536 MB */
>   	};
> +
> +	vmmc_fixed: fixedregulator-mmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc_fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmc_fixed>;
> +	bus-width = <4>;
is'nt this going to LDO1 of TPS659039? which allows us to switch it off 
when MMC card is not needed?

> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&vmmc_fixed>;
this is fixes MMC2_3V3 (emmc supply) -> EVM_3V3
> +	bus-width = <8>;
> +	ti,non-removable;
>   };
>


-- 
Regards,
Nishanth Menon
