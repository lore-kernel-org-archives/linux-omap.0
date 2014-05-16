From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v6 2/4] ARM: dts: am437x-gp-evm: add support for
 parallel NAND flash
Date: Fri, 16 May 2014 18:52:45 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACDBE5@DBDE04.ent.ti.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
 <1400238230-26357-3-git-send-email-pekon@ti.com> <537602FE.4020108@ti.com>
 <20140516162049.GF22031@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52887 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758101AbaEPSwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 14:52:55 -0400
In-Reply-To: <20140516162049.GF22031@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Quadros, Roger" <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Tony, Roger,

>From: Tony Lindgren [mailto:tony@atomide.com]
>
>* Roger Quadros <rogerq@ti.com> [140516 05:23]:
>> On 05/16/2014 02:03 PM, Pekon Gupta wrote:
>> > +&gpmc {
>> > +	status = "okay";
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&nand_flash_x8>;
>> > +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
>> > +	nand@0,0 {
>> > +		reg = <0 0 0x37c>;	/* device IO registers */
>>
>> This register space is used by the parent GPMC node as well as the NAND controller. So doing a
>request_and_ioremap() on this space will fail as it is already taken by the GPMC driver.
>>
>> Further, the GPMC register space doesn't map to the GPMC memory map created by this Chip select
>but it is mapped to L3_IO space. i.e. (physical address 0x6e00 0000)
>>
>> We could have split the GPMC register space into GPMC part and NAND part but to add to the
>complexity, the register spaces for GPMC vs NAND are interleaved so it can't be easily split up. The way
>the NAND driver is currently written is that it expects the register addresses to come via platform data,
>primarily to get around this address interleaving issue.
>>
>> Apart from the GPMC register space, the NAND controller uses 4 bytes of GPMC memory map for
>I/O, and that is something that could be reflected here.
>>
>> e.g.
>> 		reg = <0 0 4>;		/* NAND I/O space */
>
>Guys, the reg size here is size of the IO region for the
>NAND driver, it should not have anything to do with the GPMC
>registers for the GPMC functions that the NAND driver may call.
>
>So it sounds like 0x37c is wrong, and 4 is the right value if
>the NAND chip has only one IO register.
>
Yes, Roger and myself both agree on the actual size of 4.
But what I'm not sure is what should be offset for a io-remapped region.

Apologies for my ignorance here, as I'm not good in this memory mapping concept..
-  I understand that for 'memory mapped' device <offset> is with respect to
   base-address of chip-select.
- But for indirectly mapped device (like NAND) how is  <offset> calculated?

Example: For CS0 in GPMC ..
GPMC_NAND_COMMAND_0 = 0x007c
GPMC_NAND_ADDRESS_0 = 0x0080
GPMC_NAND_DATA_0 = 0x0084

(1) Now, should the 'offset' for <reg> property used for NAND node
   connected at CS=0.  reg = <0 ??  4>
   (a) Should it be equal to 'GPMC_NAND_ADDRESS_0'?
   OR
   (b) There is no relation between 'GPMC register' and 'NAND partition' offset?

(2) If considering (a) then should size consider only GPMC_NAND_ADDRESS_0
   or also include GPMC_NAND_COMMAND_0 and GPMC_NAND_DATA_0?

This is why I used the size of complete GPMC register space for NAND region also.


>> But still, the start address can't be 0 and has to be assigned when this CS region is mapped. It is still
>unclear to me how that can be done.
>
>If the offset for the NAND driver needs to be different from 0,
>it can be in the offset. For example, the smsc,lan91c94 driver
>wants the IO address space to be at offset 0x300 to avoid some
>extra warnings during the boot. So for that, the reg entry is:
>
>reg = <1 0x300 0xf>;
>
>Where we have:
>
>1 = chip select
>0x300 = offset of smsc device register IO space from the start of
>        16MB minimum GPMC partition

This is where my confusion lies, where is the 0x300 coming from?
Is this the offset of I/O register in given Ethernet IP register space?

>0xf = size of smsc device register IO space that the Ethernet
>      driver ioremaps
>


with regards, pekon
