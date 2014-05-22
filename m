From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v4 3/4] mtd: nand: omap: add support for BCH16_ECC -
 NAND driver updates
Date: Thu, 22 May 2014 17:56:48 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAD6215@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42300 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaEVR5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 13:57:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, "Balbi, Felipe" <balbi@ti.com>, "Quadros, Roger" <rogerq@ti.com>

Hi Brian,

>From: Brian Norris
>>On Mon, May 19, 2014 at 01:24:41PM +0530, Pekon Gupta wrote:
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -1201,6 +1219,41 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info
>*mtd,
>>  			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
>>  			*ecc_code++ = ((bch_val1 & 0xF) << 4);
>>  			break;
>> +		case OMAP_ECC_BCH16_CODE_HW:
>> +			val = readl(gpmc_regs->gpmc_bch_result6[i]);
>
>For all of these 'gpmc_bch_resultX' fields, couldn't you make this into
>a 2-D array? So to access BCH result 6 at sector i, it would be:
>
>			val = readl(gpmc_regs->gpmc_bch_result[6][i];
>
>This could help you to rewrite some of this stuff as loops, instead of
>giant blocks of copy-paste-modify.
>

Thanks for excepting the series. With this series OMAP NAND driver
comes to a stable point supporting NAND boot on all latest platforms.

I had earlier experimented with something similar to your suggestions
but these clean-ups require update in multiple drivers (GPMC, NAND, ...),
and it was becoming messy, so I dropped it. There are some practical
challenges to this type of clean-up like;

(1) GPMC register addresses here "gpmc_regs" are initialized in GPMC driver
 So your suggested changes will affect multiple subsystems, hence
This type of clean-up is bit deferred from sometime.


(2) The register space for gpmc_bch_results is not contiguous.
GPMC_BCH_RESULT_0	RW	0x240-0x2B0
GPMC_BCH_RESULT_1	RW	0x244-0x2B4
GPMC_BCH_RESULT_2	RW	0x248-0x2B8
GPMC_BCH_RESULT_3	RW	0x24C-0x2BC
[...]
GPMC_BCH_RESULT_4	RW	0x300-0x370
GPMC_BCH_RESULT_5	RW	0x304-0x374
GPMC_BCH_RESULT_6	RW	0x308-0x378

This is because older version of GPMC hardware IP  (like in OMAP3)
supported only till BCH8 ecc-scheme. Later same hardware IP was
extended to support BCH16. So newer platforms have extended
register-map. So it was felt that instead of having separate for..loops
lets continue with replicating all 7 GPMC_BCH_RESULT registers.


>> +			ecc_code[0]  = ((val >>  8) & 0xFF);
>> +			ecc_code[1]  = ((val >>  0) & 0xFF);
>> +			val = readl(gpmc_regs->gpmc_bch_result5[i]);
>> +			ecc_code[2]  = ((val >> 24) & 0xFF);
>> +			ecc_code[3]  = ((val >> 16) & 0xFF);
>> +			ecc_code[4]  = ((val >>  8) & 0xFF);
>> +			ecc_code[5]  = ((val >>  0) & 0xFF);
>
>A lot of this code can be rewritten to use the endian swapping macros, I
>expect. Something like this looks equivalent:
>
>			*((uint32_t *)&ecc_code[2]) = cpu_to_be32(val);
>
>You could probably fix the types up to make this look a little nicer.
>

(3) BCH4 use different alignment than BCH8 and BCH16 as ECC syndrome
is not bytewise aligned (it's of 6 1/2 bytes = 13 nibbles).  So for BCH4
higher-nibble or reg1 is shifted and ORed with lower-nibble of reg2.
There is no byte-to-byte mapping. So generic implementation becomes messy.

However, Roger Quadros is planning GPMC driver clean-up, so looping him
in-case he can incorporate some of these things while re-factoring GPMC code.


with regards, pekon
