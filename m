From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v4 2/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Mon, 8 Jul 2013 04:37:36 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E5014@DBDE04.ent.ti.com>
References: <1372764757-29511-1-git-send-email-pekon@ti.com>
 <1372764757-29511-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab3GHEia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 00:38:30 -0400
In-Reply-To: <1372764757-29511-3-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "olof@lixom.net" <olof@lixom.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>

> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index 6a983c1..690070e 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -17,20 +17,42 @@ Required properties:
> 
>  Optional properties:
> 
> - - nand-bus-width: 		Set this numeric value to 16 if the hardware
> -				is wired that way. If not specified, a bus
> -				width of 8 is assumed.
> + - nand-bus-width: 		Determines data-width of the connected
> device
> +				x16 = "16"
> +				x8  = "8" (default)
> 
> - - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
> 
> -		"sw"		Software method (default)
> -		"hw"		Hardware method
> -		"hw-romcode"	gpmc hamming mode method & romcode
> layout
> -		"bch4"		4-bit BCH ecc code
> -		"bch8"		8-bit BCH ecc code
> + - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
> +				It can be any of the following strings:
> +
> +	"hamming_code_sw"		1-bit Hamming ECC
> +					- ECC calculation in software
> +					- Error detection in software
> +
> +	"hamming_code_hw"		1-bit Hamming ECC
> +					- ECC calculation in hardware
> +					- Error detection in software
> +
> +	"hamming_code_hw_romcode"	1-bit Hamming ECC
> +					- ECC calculation in hardware
> +					- Error detection in software
> +					- ECC layout compatible to ROM code
> +
> +	"bch8_hw_code_detection_sw"	8-bit BCH ECC
> +					- ECC calculation in hardware
> +					- Error detection in software
> +					- depends on
> CONFIG_MTD_NAND_ECC_BCH
> +
> +	"bch8_code_hw"             	8-bit BCH ECC
> +					- ECC calculation in hardware
> +					- Error detection in hardware
> +					- depends on
> CONFIG_MTD_NAND_OMAP_BCH
> +					- requires <elm_id> to be specified
> +
> +
> + - elm_id:			Specifies elm device node. This is required to
> +				support some BCH ECC schemes mentioned
> above.
> 
> - - elm_id:	Specifies elm device node. This is required to support BCH
> - 		error correction using ELM module.
> 

[Pekon] Requesting DT maintainers to please review the above 
changes in values for 'nand-ecc-opt' property. And please ACK | NAK it.

with regards, pekon

