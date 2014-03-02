From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 4/5] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Sun, 2 Mar 2014 10:19:22 -0800
Message-ID: <20140302181922.GE18496@atomide.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
 <1391606914-9947-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60750 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaCBSTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 13:19:35 -0500
Content-Disposition: inline
In-Reply-To: <1391606914-9947-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minal.shah@ti.com>

* Pekon Gupta <pekon@ti.com> [140205 05:31]:
> From: Minal Shah <minal.shah@ti.com>
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -93,6 +93,37 @@
>  			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
>  		>;
>  	};
> +
> +	nand_flash_x16: nand_flash_x16 {
> +		/* On DRA7 EVM, GPMC_WPN and NAND_BOOTn comes from DIP switch
> +		 * So NAND flash requires following switch settings:
> +		 * SW5.9 (GPMC_WPN) = LOW
> +		 * SW5.1 (NAND_BOOTn) = HIGH */
> +		pinctrl-single,pins = <
> +			0x0 	0x70000 /* (PIN_INPUT | MUX_MODE0)	gpmc_ad0	*/
> +			0x4 	0x70000 /* (PIN_INPUT | MUX_MODE0)	gpmc_ad1	*/
...

Can you guys please update this one to use the macros in
arch/arm/boot/dts/include/dt-bindings/pinctrl/omap.h?

Preferrably the new DRA7XX_CORE_IOPAD and friends macros.
I've picked up the other patches in this series already.

Regards,

Tony
