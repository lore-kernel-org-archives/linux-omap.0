From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain backward
 compatibility.
Date: Mon, 2 Dec 2013 11:19:08 -0500
Message-ID: <529CB2FC.2080106@ti.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com> <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com> <20131202115422.1f8c73f6@skate> <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com> <20131202160219.40286dc9@skate> <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com> <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com> <20131202165103.726314d9@skate>	<529CAEA3.2080808@ti.com> <20131202170606.2191fd89@skate> <20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42299 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3LBQTB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Dec 2013 11:19:01 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?ISO-8859-1?Q?Beno=EEt_?= =?ISO-8859-1?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

On 12/02/2013 11:13 AM, Gupta, Pekon wrote:
>> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>>> On Mon, 2 Dec 2013 11:00:35 -0500, Tom Rini wrote:
>>
>>>>> Although the new ECC schema breaks the compatibility between the board
>>>>> files and new DT based kernel, I think we should use BCH8 scheme.
>>>>> Sorry, because I had not realized that this was configurable in
>>>>> u-boot, so I think, if Thomas is also agree, the better fix in that
>>>>> case is change CONFIG_NAND_OMAP_ECCSCHEME to
>>>>> OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
>>>>> discard this patch.
>>>>
>>>> I theoretically don't have anything against that, but if I do this
>>>> change in U-Boot, and then use U-Boot to reflash to NAND the SPL and
>>>> U-Boot itself, will the OMAP ROM code still be able to read the SPL
>>>> from NAND ? I'm not sure which ECC scheme does the OMAP ROM code
>>>> support, and how it detects (or not) which ECC scheme to use to read
>>>> the SPL.
>>>
>>> Yes, this brings us back to one of the old and long-standing problems.
>>> The ROM on these devices will generally speak one format and that means
>>> using NAND chips that say for the first block (or N blocks or whatever)
>>> you only need 1bit ECC but for the rest 4/8/16/whatever.  And then
>>> informing the kernel (and anything else) that "partitions" N need this
>>> format and the rest need that.
>>
>> As long as U-Boot provides separate commands, or a "nandecc" command
>> that allows to switch between ECC scheme, and select the ECC scheme
>> expected by the ROM code when flashing the SPL, and then the ECC scheme
>> expected by the SPL and the kernel to flash U-Boot itself, the kernel
>> image, and the various filesystem images, then it's all fine, we can
>> leave with different ECC schemes used for different things on the NAND
>> flash.
>>
> Yes, at-least OMAP3 arch u-boot should still supports 'nandecc'.
> The infrastructure is still in place, however the command 'nandecc' is
> deprecated in newer versions.
> References in mainline u-boot: 
> arch/arm/cpu/armv7/omap3/board.c  @@do_switch_ecc()
> driver/mtd/nand/omap_gpmc.c @@omap_nand_switch_ecc()
> 
> So with minor hacks, you should be able to bring-back 'nandecc'.

Right, on OMAP3 (and related) we have the issue of ROM only doing 1bit
ECC, but being used with parts that require more, so what I said above
is important.  OMAP4/am335x/later ship with ROM that groks at least
BCH16.  With my U-Boot hat on, I really don't want to encourage people
to come up with designs that require on the fly switching because..

> But for all these, images need to be flashed from u-boot. As kernel
> cannot switch ecc-schemes on-the-fly.

Exactly.  The kernel hasn't, and I get the feeling won't, support this
case of needing different ECC schemes for different areas of the NAND,
so we'll continue to be in the position of the Linux for flashing
everything but bootloader or custom hacks to the kernel.

-- 
Tom
