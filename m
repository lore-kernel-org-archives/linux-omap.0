From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Tue, 5 Feb 2013 20:40:58 +0100
Message-ID: <CABxcv=ms0DOHL8ooktLi+_gQGvGOiKpNgx7gKnU5BUX1pWkAJQ@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
	<1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
	<CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
	<510F8F49.9020800@epfl.ch>
	<CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
	<51114003.9070405@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34180 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab3BETlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 14:41:00 -0500
Received: by mail-wi0-f170.google.com with SMTP id hm11so6077804wib.5
        for <linux-omap@vger.kernel.org>; Tue, 05 Feb 2013 11:40:58 -0800 (PST)
In-Reply-To: <51114003.9070405@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 5, 2013 at 6:23 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> Hi Javier,
>

Hi Florian,

> On 02/04/2013 12:57 PM, Javier Martinez Canillas wrote:
>
> [...]
>
>
>>
>> Yes, I saw on the list that Tony asked you too extend the GPMC DT
>> support. Flash support is on my TODO list too but I don't know if I'm
>> going to have time to work on this in the next few weeks.
>>
>> Since you are thinking to change the binding, there is something I
>> want to discuss with you.
>>
>> We have two different version for each IGEP board, one that uses NAND
>> memory and another that has OneNAND.
>>
>> With board files this is easy because the flash memory type is
>> hardcoded (in hardware) using sysboot pins [3]. So we check the
>> sysboot value and call board_nand_init() or board_onenand_init()
>> accordingly and pass the same static struct mtd_partition
>> igep_flash_partitions[] in both cases.
>>
>> But with DT this is a little bit trickier since you have to define
>> either a nand@0 or onenand@0 child node for the gpmc device node. So,
>> we will have to create lots of dts and dtsi to handle each combination
>> (IGEPv2 + NAND, IGEPv2 + OneNAND, IGEP COM + NAND, etc).
>>
>> I wonder if we could just have a generic gpmc-flash binding and maybe
>> use a "gpmc, flash_type" property or something like that to decide if
>> gpmc_onenand_init() or gpmc_nand_init() has to be called.
>>
>
> This boils down to the problem where you have an "if" statement in
> your board file, and I think no general solution exists.
>

Yes, this is a general issue since DT uses a declarative paradigm.

I was just pointing out that I found that particular issue with the flash
memory type on IGEP boards.

> In your suggestion, having a property will force you anyway to write
> distinct DT files to account for the two versions, so it won't really
> help if I understand correctly. We would need conditional
> section inside device trees, at least to test for simple parameters.
> Or a way to generate several DT blobs based on a single DT source file.
>

Well you will still need a different dtb for each <board,flash type> combination
but it could make your device trees smaller and simpler since you can define
your GPMC flash child node on a dtsi where you set all the partition and sizes
and export that device node to your boards dts that only set the
"gpmc, flash_type"
property to nand or onenand (assuming both your NAND and OneNAND version
have the same partition layout and sizes).

Otherwise you would have to define the complete onenand or nand child node
on your board dts having duplicated definition for your flash partition layouts.

> Another hackish solution would be to write a meta component, whose
> probe section would do your test. But this is just a stripped down version
> of the board file, far from being generic...
>

Yes, and that doesn't fit on the DT model too well. I still don't know what's
the best way to do it.

> I will think on it during my holidays :)
>

great, I hope you enjoy your holidays :-)

> Regards,
>
> Florian
>

Thanks a lot and best regards,
Javier
