From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: [Q] SW-ECC to HW-ECC (OMAP3)
Date: Fri, 5 Aug 2011 16:12:47 +0200
Message-ID: <CAACX+R2+Lpb6dBa_QEwh1m8KSW4--2ZofCGTepdk1=S4bp-HeQ@mail.gmail.com>
References: <CAACX+R3Gve=V4+AV17WONEkXpb9NwrLbUr7E2Ym6Qu-2URyiTA@mail.gmail.com>
	<CANOLnON=d_eF8dvNV8K16QbKq04-dd-sv=fx+yC8VAzw=Typqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44177 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab1HEOMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 10:12:48 -0400
Received: by gxk21 with SMTP id 21so1690709gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 07:12:47 -0700 (PDT)
In-Reply-To: <CANOLnON=d_eF8dvNV8K16QbKq04-dd-sv=fx+yC8VAzw=Typqg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

2011/8/5 Grazvydas Ignotas <notasas@gmail.com>:
> On Thu, Aug 4, 2011 at 1:55 PM, Arno Steffen
> <arno.steffen@googlemail.com> wrote:
>> While migrating from .33 to .37 kernel I found, that HW-ECC is used =
by default.
>> I found that this is set in omap2.c:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->ecc_opt =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D OMAP_ECC_HAMMING_CODE_HW;
>> Unfortunatly setting it back to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->ecc_opt =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D OMAP_ECC_HAMMING_CODE_DEFAULT;
>> doesn't prevent me from getting messages like:
>>
>> uncorrectable error :
>> uncorrectable error :
>> mtd->read(0xd18 bytes from 0x7eae8) returned ECC error
>>
>> So what else has to be set? I couldn't found it.
>
> swecc on .37 is broken (I'm not even sure hwecc works as I use swecc)=
,
> you need at least 2.6.39.1 to use that. It is possible to patch .37
> but I don't have list of needed parches, but maybe could get you that
> if you really need it (or look what changed under drivers/mtd between
> those versions yourself).
>
>> Other way maybe to keep it at HW-ECC. Is this significant faster tha=
n SW-ECC?
>> But howto get nandwrite (mtd-utils) or fw_setenv (uboot) to handle H=
W-ECC?
>> Do I have to use just the --noecc option?
>>
>> When using the fw_setenv command I get CRC errors in environment wit=
h next boot.
>
> Never tried hwecc so can't help you here.
>
>
> --
> Gra=C5=BEvydas
>

Thanks for this advice. I will check this.
Best regards
Arno
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
