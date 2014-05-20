From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 2/4] ARM: dts: am437x-gp-evm: add support for
 parallel NAND flash
Date: Tue, 20 May 2014 04:06:47 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACE46E@DBDE04.ent.ti.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-3-git-send-email-pekon@ti.com>
 <20140519220659.GF11945@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaETEHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 00:07:01 -0400
In-Reply-To: <20140519220659.GF11945@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

From: Tony Lindgren [mailto:tony@atomide.com]
>* Pekon Gupta <pekon@ti.com> [140519 02:16]:
>> Adds pinmux and DT node for Micron (MT29F4G08AB) x8 NAND device present on
>> am437x-gp-evm board.
>> (1) As NAND Flash data lines are muxed with eMMC, Thus at a given time either
>>     eMMC or NAND can be enabled. Selection between eMMC and NAND is controlled:
>>     (a) By dynamically driving following GPIO pin from software
>>         SPI2_CS0(GPIO) == 0 NAND is selected (default)
>>         SPI2_CS0(GPIO) == 1 eMMC is selected
>>     (b) By statically using Jumper (J89) on the board
>
>So which MMC controller has eMMC then? How do we select which one we
>have enabled in the am437x-gp-evm.dts by default?
>
If there is no Jumper on the board, then driving SPI2_CS0 before device
probe decides the selection between NAND and eMMC. Therefore NAND
pin-mux also includes SPI2_CS0 and enables PULLDOWN on it to select NAND.

+ 0x26c(PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* spi2_cs0.gpio/eMMCorNANDsel */

>Regards,
>
>Tony
>
>> (2) As NAND device connnected to this board has page-size=4K and oob-size=224,
>>     So ROM code expects boot-loaders to be flashed in BCH16 ECC scheme for
>>     NAND boot.
>>
>> Signed-off-by: Pekon Gupta <pekon@ti.com>
>> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>  arch/arm/boot/dts/am437x-gp-evm.dts | 108 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
>> index 30ace1b..f432685 100644
>> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
>> @@ -150,6 +150,27 @@
>>  			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>>  		>;
>>  	};
>> +
>> +	nand_flash_x8: nand_flash_x8 {
>> +		pinctrl-single,pins = <
>> +			0x26c(PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/*  <------
>spi2_cs0.gpio/eMMCorNANDsel */


with regards, pekon
