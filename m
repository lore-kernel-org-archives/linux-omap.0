From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 03/11] arm/dts: Add support for OMAP4 PandaBoard
Date: Fri, 23 Sep 2011 17:21:42 -0600
Message-ID: <20110923232142.GG24631@ponder.secretlab.ca>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35417 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1IWXVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 19:21:47 -0400
Received: by yib18 with SMTP id 18so2981832yib.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 16:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316809399-19579-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, "G, Manjunath Kondaiah" <manjugk@ti.com>

On Fri, Sep 23, 2011 at 10:23:11PM +0200, Benoit Cousson wrote:
> Based on the original omap4-panda.dts file from Manju.
> http://www.spinics.net/lists/linux-omap/msg55836.html
> 
> Add memory information and a default bootargs to allow
> a boot from RAMDISK.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda.dts |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap4-panda.dts
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> new file mode 100644
> index 0000000..c702657
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap4.dtsi"
> +
> +/ {
> +	model = "TI OMAP4 PandaBoard";
> +	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
> +
> +	/*
> +	 * Since the initial device tree board file does not create any
> +	 * devices (MMC, network...), the only way to boot is to provide a
> +	 * ramdisk.
> +	 */
> +	chosen {
> +		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";

Generally, we don't want bootargs in the .dts files; we want them
added to the .dtb by the boot firmware.  However, we are bootstrapping
here, so I'm okay with it in the short term until firmware matures a
bit more.

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>; /* 1 GB */
> +	};
> +};
> -- 
> 1.7.0.4
> 
