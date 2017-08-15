From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Add support for rev C
Date: Tue, 15 Aug 2017 08:41:51 +0530
Message-ID: <bf2a5868-4c0b-58a1-350e-cba7dcfb5166@ti.com>
References: <20170814175820.12065-1-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170814175820.12065-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Monday 14 August 2017 11:28 PM, Robert Nelson wrote:
> Latest update to the BeagleBoard-X15 platform (revision C). This board contains
> a silicon update (Rev 2.0), which includes a fix for the 2nd ethernet phy when
> running at 1000 Mbps speeds.
> 
> This board can be indentified by the [C.00] after [BBRDX15_] in the at24 eeprom:
> [BBRDX15_C.001731PX150249]
> 
> Rev C is now in full production and boards are available for end users.
> 
> https://beagleboard.org/x15
> https://github.com/beagleboard/beagleboard-x15/
> 
> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
> CC: Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
> ---
>  arch/arm/boot/dts/Makefile                   |  1 +
>  arch/arm/boot/dts/am57xx-beagle-x15-revc.dts | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c293e841eea3..d3a4fe7eb6f7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -651,6 +651,7 @@ dtb-$(CONFIG_SOC_OMAP5) += \
>  dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-beagle-x15-revb1.dtb \
> +	am57xx-beagle-x15-revc.dtb \
>  	am57xx-cl-som-am57x.dtb \
>  	am57xx-sbc-am57x.dtb \
>  	am572x-idk.dtb \
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
> new file mode 100644
> index 000000000000..742eeb96b8aa
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2014-2016 Texas Instruments Incorporated - http://www.ti.com/
						^^2017 :)

Rest of the patch looks good to me.

Reviewed-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

Thanks and regards,
Lokesh


> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "am57xx-beagle-x15-common.dtsi"
> +
> +/ {
> +	model = "TI AM5728 BeagleBoard-X15 rev C";
> +};
> +
> +&tpd12s015 {
> +	gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
> +		<&gpio2 30 GPIO_ACTIVE_HIGH>,	/* gpio2_30, LS OE */
> +		<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vdd_3v3>;
> +	vqmmc-supply = <&ldo1_reg>;
> +};
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
