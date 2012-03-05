From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] mcx: very basic support for HTKW mcx board
Date: Mon, 5 Mar 2012 11:53:29 -0800
Message-ID: <20120305195329.GP12083@atomide.com>
References: <1324482822-24221-1-git-send-email-yanok@emcraft.com>
 <1324482822-24221-2-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19753 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab2CETxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:53:33 -0500
Content-Disposition: inline
In-Reply-To: <1324482822-24221-2-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Ilya Yanok <yanok@emcraft.com> [111221 07:22]:
> Very basic support for HTKW mcx board. Able to boot via board-generic
> and ramdisk/initramfs, however most of peripherals is unsupported.
> Produces tons of twl4030 related errors as this board doesn't have
> twl4030 installed.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Grant, care to ack this one?

Regards,

Tony

> 
> ---
> Changes from V2:
> 
>  - None
> 
> Changes from V1:
> 
>  - device tree move to the separate patch
>  - iva node is disabled instead of using custom includes
>  - removed bootargs entry
> 
>  arch/arm/boot/dts/mcx.dts |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mcx.dts
> 
> diff --git a/arch/arm/boot/dts/mcx.dts b/arch/arm/boot/dts/mcx.dts
> new file mode 100644
> index 0000000..66b81bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/mcx.dts
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	model = "HTKW mcx";
> +	compatible = "htkw,mcx", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +
> +	/* AM35xx doesn't have IVA */
> +	soc {
> +		iva {
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 1.7.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
