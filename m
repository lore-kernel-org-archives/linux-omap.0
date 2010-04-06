From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Wed, 7 Apr 2010 02:41:17 +0700
Message-ID: <o2nd9ca78711004061241w5fe76cfcp79ca3670beff758@mail.gmail.com>
References: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
	 <w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
	 <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
	 <r2tce9ab5791004042118t81d5e892r46773f48c4da0ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50090 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab0DFTlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 15:41:18 -0400
Received: by vws13 with SMTP id 13so109724vws.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 12:41:17 -0700 (PDT)
In-Reply-To: <r2tce9ab5791004042118t81d5e892r46773f48c4da0ac0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

if NAND support is currently missing for OMAP3430 LDP,,how i boot my
ldp again like before?...any idea?

best regards,
Aldyth M

On 4/5/10, Vimal Singh <vimal.newwork@gmail.com> wrote:
> AFAIK, NAND support is currently missing for OMAP3430 LDP boards in L=
O.
>
> -Vimal
>
> On Sun, Apr 4, 2010 at 9:34 PM, Ghorai, Sukumar <s-ghorai@ti.com> wro=
te:
>> Aldyth,
>> 1. Do you mean that NAND boot is not working?
>> 2. Does MMC/SD boot working? If yes, boot the platform from MMC/SD u=
sing
>> the latest x-loade/ u-boot and flush the same binaries to NAND using=
 the
>> following commands.
>> mmcinit 0
>> nand unlock 80000 80000
>> nand erase 80000 80000
>> fatload mmc 0 80000000 u-boot.bin
>> nand write.i 80000000 80000 ${filesize}
>>
>> nand unlock 0 80000
>> nand erase 0 80000
>> fatload mmc 0 80000000 MLO
>> nand write.i 80000000 0 ${filesize}
>>
>> Regards,
>> Ghorai
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Tar Gz
>>> Sent: 2010-04-04 11:13
>>> To: linux-omap
>>> Subject: [ASK] OMAP 3430 LDP Trouble
>>>
>>> Hi all,
>>> i'm sorry if my english too bad
>>>
>>> I try to porting linux to omap 3430 LDP..but my board have trouble
>>> after i running this command:
>>>
>>> nand ecc sw
>>> nand unlock 80000 80000
>>> nand erase 80000 80000
>>>
>>> nand ecc hw
>>> nand unlock 0 80000
>>> nand erase 0 80000
>>>
>>> and if i try to turn on my board, BT led [blue led] always on and m=
y
>>> minicom can't show anything...and i forget to setting the enviromen=
t
>>> variable mmcinit..
>>>
>>> my question is, how to make my board can run normally like before?
>>>
>>> best regards,
>>> Aldyth M
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
