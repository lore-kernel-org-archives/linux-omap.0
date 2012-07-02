From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH V3 1/2] arm/dts: OMAP2: Add support for
 OMAP2420H4 Board
Date: Mon, 2 Jul 2012 01:10:19 -0700
Message-ID: <20120702081018.GD1122@atomide.com>
References: <1339548046-27988-1-git-send-email-jon-hunter@ti.com>
 <1339548046-27988-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab2GBIKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:10:22 -0400
Content-Disposition: inline
In-Reply-To: <1339548046-27988-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120612 17:45]:
> Simple DTS file for OMAP2420H4 board adding memory information to allow
> device-tree testing on an OMAP2420. OMAP2420H4 board has 64MB of RAM.
> 
> Verified that kernel boots with DT using a simple RAMDISK file-system on
> OMAP2420H4.

Thanks, applying into dt branch.

Tony

 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap2420-h4.dts
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> new file mode 100644
> index 0000000..25b50b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap2.dtsi"
> +
> +/ {
> +	model = "TI OMAP2420 H4 board";
> +	compatible = "ti,omap2420-h4", "ti,omap2420", "ti,omap2";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x84000000>; /* 64 MB */
> +	};
> +};
> -- 
> 1.7.9.5
> 
