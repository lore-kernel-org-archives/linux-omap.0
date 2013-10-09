From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7-evm: Add mmc2 node for eMMC support
Date: Wed, 9 Oct 2013 08:12:33 -0500
Message-ID: <52555641.1060907@ti.com>
References: <1381163104-6318-1-git-send-email-balajitk@ti.com> <1381163104-6318-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45661 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756990Ab3JINM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:12:58 -0400
In-Reply-To: <1381163104-6318-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On 10/07/2013 11:25 AM, Balaji T K wrote:
> Add mmc2 dt node to dra7-evm board
> and model eMMC vcc as fixed regulator.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> Rebase to for_3.13/dts
> and removed ti,non-removable
> 
>  arch/arm/boot/dts/dra7-evm.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 65cd15a..3abf5f4 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -17,6 +17,13 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x60000000>; /* 1536 MB */
>  	};
> +
> +	mmc2_3v3: fixedregulator-mmc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc2_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>  };
>  
>  &dra7_pmx_core {
> @@ -256,3 +263,9 @@
>  	vmmc-supply = <&ldo1_reg>;
>  	bus-width = <4>;
>  };
> +
> +&mmc2 {
> +	status = "okay";
> +	vmmc-supply = <&mmc2_3v3>;
> +	bus-width = <8>;
> +};
> 
boot tested on DRA7-EVM
voltage rail is correct based on schematics(rev d1) too.
Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
