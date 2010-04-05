From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Mon, 5 Apr 2010 11:06:34 +0700
Message-ID: <o2vd9ca78711004042106seceb181co2e2accd3be27a65a@mail.gmail.com>
References: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
	 <w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
	 <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58086 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab0DEEGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 00:06:35 -0400
Received: by vws13 with SMTP id 13so1233745vws.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Apr 2010 21:06:34 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On 4/4/10, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> Aldyth,
> 1. Do you mean that NAND boot is not working?
> 2. Does MMC/SD boot working? If yes, boot the platform from MMC/SD using the
> latest x-loade/ u-boot and flush the same binaries to NAND using the
> following commands.
> mmcinit 0
> nand unlock 80000 80000
> nand erase 80000 80000
> fatload mmc 0 80000000 u-boot.bin
> nand write.i 80000000 80000 ${filesize}
>
> nand unlock 0 80000
> nand erase 0 80000
> fatload mmc 0 80000000 MLO
> nand write.i 80000000 0 ${filesize}
>
> Regards,
> Ghorai
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tar Gz
>> Sent: 2010-04-04 11:13
>> To: linux-omap
>> Subject: [ASK] OMAP 3430 LDP Trouble
>>
>> Hi all,
>> i'm sorry if my english too bad
>>
>> I try to porting linux to omap 3430 LDP..but my board have trouble
>> after i running this command:
>>
>> nand ecc sw
>> nand unlock 80000 80000
>> nand erase 80000 80000
>>
>> nand ecc hw
>> nand unlock 0 80000
>> nand erase 0 80000
>>
>> and if i try to turn on my board, BT led [blue led] always on and my
>> minicom can't show anything...and i forget to setting the enviroment
>> variable mmcinit..
>>
>> my question is, how to make my board can run normally like before?
>>
>> best regards,
>> Aldyth M
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

but i can't enter prompt, my minincom can't show anything when i'm
turn on my board. I'm using latest u-boot and x-loader / MLO but still
can't booting and BT led [blue colour] always on. How solve my
problem?

best regards,
Aldyth M
