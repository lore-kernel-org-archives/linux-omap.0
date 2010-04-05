From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Mon, 5 Apr 2010 09:48:27 +0530
Message-ID: <r2tce9ab5791004042118t81d5e892r46773f48c4da0ac0@mail.gmail.com>
References: <h2vd9ca78711004031033ved1c64az135e06fc43ca72de@mail.gmail.com>
	<w2yd9ca78711004032243y332ad5la6152f9b5def34b9@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:22394 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0DEESs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 00:18:48 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1257050qwh.37
        for <linux-omap@vger.kernel.org>; Sun, 04 Apr 2010 21:18:47 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D3C8B3F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Tar Gz <bsdraisefromhell@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

AFAIK, NAND support is currently missing for OMAP3430 LDP boards in LO.

-Vimal

On Sun, Apr 4, 2010 at 9:34 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote=
:
> Aldyth,
> 1. Do you mean that NAND boot is not working?
> 2. Does MMC/SD boot working? If yes, boot the platform from MMC/SD us=
ing the latest x-loade/ u-boot and flush the same binaries to NAND usin=
g the following commands.
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
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
