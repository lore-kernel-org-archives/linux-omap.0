From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 17:46:05 +0100
Message-ID: <CABxcv=krCHKbn6yVHG1JN2qAPYtjhNWBCm-fcBZQ=3vheehivg@mail.gmail.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	<20131202160219.40286dc9@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
	<CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
	<20131202165103.726314d9@skate>
	<529CAEA3.2080808@ti.com>
	<20131202170606.2191fd89@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com>
	<CABxcv=nTQOW7JvCKqHwaX0CXPN6USs66jWUFthW=3CoajsHbPw@mail.gmail.com>
	<529CB44D.5020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:44318 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab3LBQqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 11:46:07 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so11181104wgh.33
        for <linux-omap@vger.kernel.org>; Mon, 02 Dec 2013 08:46:05 -0800 (PST)
In-Reply-To: <529CB44D.5020800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Enric Balletbo Serra <eballetbo@gmail.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

On Mon, Dec 2, 2013 at 5:24 PM, Tom Rini <trini@ti.com> wrote:
> On 12/02/2013 11:21 AM, Javier Martinez Canillas wrote:
>> Hi Pekon,
>>
>> On Mon, Dec 2, 2013 at 5:13 PM, Gupta, Pekon <pekon@ti.com> wrote:
>>>> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>>>>> On Mon, 2 Dec 2013 11:00:35 -0500, Tom Rini wrote:
>>>>
>>>>>>> Although the new ECC schema breaks the compatibility between the board
>>>>>>> files and new DT based kernel, I think we should use BCH8 scheme.
>>>>>>> Sorry, because I had not realized that this was configurable in
>>>>>>> u-boot, so I think, if Thomas is also agree, the better fix in that
>>>>>>> case is change CONFIG_NAND_OMAP_ECCSCHEME to
>>>>>>> OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
>>>>>>> discard this patch.
>>>>>>
>>>>>> I theoretically don't have anything against that, but if I do this
>>>>>> change in U-Boot, and then use U-Boot to reflash to NAND the SPL and
>>>>>> U-Boot itself, will the OMAP ROM code still be able to read the SPL
>>>>>> from NAND ? I'm not sure which ECC scheme does the OMAP ROM code
>>>>>> support, and how it detects (or not) which ECC scheme to use to read
>>>>>> the SPL.
>>>>>
>>>>> Yes, this brings us back to one of the old and long-standing problems.
>>>>> The ROM on these devices will generally speak one format and that means
>>>>> using NAND chips that say for the first block (or N blocks or whatever)
>>>>> you only need 1bit ECC but for the rest 4/8/16/whatever.  And then
>>>>> informing the kernel (and anything else) that "partitions" N need this
>>>>> format and the rest need that.
>>>>
>>>> As long as U-Boot provides separate commands, or a "nandecc" command
>>>> that allows to switch between ECC scheme, and select the ECC scheme
>>>> expected by the ROM code when flashing the SPL, and then the ECC scheme
>>>> expected by the SPL and the kernel to flash U-Boot itself, the kernel
>>>> image, and the various filesystem images, then it's all fine, we can
>>>> leave with different ECC schemes used for different things on the NAND
>>>> flash.
>>>>
>>
>> Yes, we used nandecc to write data on different mtd partitions for SPL
>> (nandecc hw) and the rootfs (nandecc hw bch8).
>>
>>> Yes, at-least OMAP3 arch u-boot should still supports 'nandecc'.
>>> The infrastructure is still in place, however the command 'nandecc' is
>>> deprecated in newer versions.
>>> References in mainline u-boot:
>>> arch/arm/cpu/armv7/omap3/board.c  @@do_switch_ecc()
>>> driver/mtd/nand/omap_gpmc.c @@omap_nand_switch_ecc()
>>>
>>
>> Why nandecc is being deprecated from u-boot? How are you supposed to
>> use a different ECC scheme then?
>
> We (I) had killed off all of the mainline users of the nandecc command,
> once everyone was using the same 1bit scheme layout.  None of the people
> that had mixed HAM1/BCH4 at the time wanted to work upstream on it.

I see, so.. what's the solution then :-)

We can push Enric's patch and change to HAM1 in the kernel so Thomas
(and others) can write everything from U-boot (SPL, rootfs, etc) but I
think is safer to use BCH8 since the NAND requires at least a 4-bit
ECC.

But doing that we can no longer write the SPL from neither U-Boot nor
the kernel. Yes, this can be made from user-space using ISEE's
writeloader utility and afair there is one from TI too written in C#
but this is not very convenient for users.

I believe Thomas is right and the correct approach is to change the
OMAP NAND and GPMC drivers to support a per MTD partition ECC scheme
but we need a temporal solution until someone implements this.

>
> --
> Tom

Thanks a lot and best regards,
Javier
