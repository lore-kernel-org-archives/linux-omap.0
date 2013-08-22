From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 1/4] ARM: OMAP2+: cleaned-up DT support of various ECC
 schemes
Date: Wed, 21 Aug 2013 21:54:52 -0700
Message-ID: <20130822045452.GA5151@quad.lixom.net>
References: <1373748891-7779-1-git-send-email-pekon@ti.com>
 <1373748891-7779-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40927 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab3HVEze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 00:55:34 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1392432pde.9
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 21:55:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373748891-7779-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: dedekind1@gmail.com, dwmw2@infradead.org, arnd@arndb.de, mugunthanvnm@ti.com, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Sun, Jul 14, 2013 at 02:24:48AM +0530, Pekon Gupta wrote:
> ECC scheme on NAND devices can be implemented in multiple ways.Some using
> Software algorithm, while others using in-build Hardware engines.
> omap2-nand driver currently supports following flavours of ECC schemes,
> selectable via DTB.
> 
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_DEFAULT          |S/W            |S/W            |
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
> |OMAP_ECC_HAMMING_CODE_HW_ROMCODE       |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_OMAP_BCH)    |               |               |
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> 
> Selection of some ECC schemes also require enabling following Kconfig options.
> This was done to optimize footprint of omap2-nand driver.
> -Kconfig:CONFIG_MTD_NAND_ECC_BCH	enables S/W based BCH ECC algorithm
> -Kconfig:CONFIG_MTD_NAND_OMAP_BCH	enables H/W based BCH ECC algorithm
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          | 45 ++++++++++++++++------
>  arch/arm/mach-omap2/gpmc.c                         | 14 ++++---
>  include/linux/platform_data/mtd-nand-omap2.h       | 22 +++++++----
>  3 files changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index df338cb..c6551b6 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -17,17 +17,42 @@ Required properties:
>  
>  Optional properties:
>  
> - - nand-bus-width: 		Set this numeric value to 16 if the hardware
> -				is wired that way. If not specified, a bus
> -				width of 8 is assumed.
> + - nand-bus-width: 		Determines data-width of the connected device
> +				x16 = "16"
> +				x8  = "8" (default)

This change doesn't look like an improvement to me.

> - - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
>  
> -		"sw"		Software method (default)
> -		"hw"		Hardware method
> -		"hw-romcode"	gpmc hamming mode method & romcode layout
> -		"bch4"		4-bit BCH ecc code
> -		"bch8"		8-bit BCH ecc code
> + - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
> +				It can be any of the following strings:

The device tree should define the hardware, not configure the software.

Also, if it defines the scheme then you should probably call it something like
"ti,nand-ecc-scheme" instead.

> +
> +	"hamming_code_sw"		1-bit Hamming ECC
> +					- ECC calculation in software
> +					- Error detection in software
> +
> +	"hamming_code_hw"		1-bit Hamming ECC
> +					- ECC calculation in hardware
> +					- Error detection in software

Bzzt. Same here. It really doesn't matter to the hardware if the ECC is
calculated in HW or SW, and it doesn't belong in the device tree.
> +
> +	"hamming_code_hw_romcode"	1-bit Hamming ECC
> +					- ECC calculation in hardware
> +					- Error detection in software
> +					- ECC layout compatible to ROM code
> +
> +	"bch8_hw_code_detection_sw"	8-bit BCH ECC
> +					- ECC calculation in hardware
> +					- Error detection in software
> +					- depends on CONFIG_MTD_NAND_ECC_BCH

Configuration options don't belong in here either.

> +
> +	"bch8_code_hw"             	8-bit BCH ECC
> +					- ECC calculation in hardware
> +					- Error detection in hardware
> +					- depends on CONFIG_MTD_NAND_OMAP_BCH
> +					- requires <elm_id> to be specified

Some of the above clearly shouldn't be described in the device tree at all, but
it's also not very convenient to describe them as strings. Since you have
a binding, it's probably easier to give them integer values and just define
what those mean.

> +
> +
> + - elm_id:			Specifies elm device node. This is required to
> +				support some BCH ECC schemes mentioned above.

Use dashes instead of underscores for properties. if all other properties are
prepended with "ti,", then so should this.

What's an ELM device node? How is it specified? A phandle?



-Olof
