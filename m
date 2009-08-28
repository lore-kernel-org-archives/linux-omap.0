From: ye janboe <janboe.ye@gmail.com>
Subject: Re: [PATCH] flush the function in sdram is not correct because sram
	is changed.
Date: Fri, 28 Aug 2009 17:10:38 +0800
Message-ID: <af3ea28a0908280210y6d478a1bm340c7766f744df90@mail.gmail.com>
References: <af3ea28a0908272256k1743b528pdfb3dcdb88848544@mail.gmail.com>
	 <alpine.DEB.2.00.0908280229100.15963@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:58081 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZH1JKg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:10:36 -0400
Received: by pxi4 with SMTP id 4so1839393pxi.21
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 02:10:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908280229100.15963@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

Hi, Paul

I resent the patch after fix the format issue.

Please help to review it.

Thanks

Janboe

2009/8/28 Paul Walmsley <paul@pwsan.com>:
> Hello janboe,
>
> On Fri, 28 Aug 2009, ye janboe wrote:
>
>> >From f10090bf307066f1317d7152c6f9a6f395007d4a Mon Sep 17 00:00:00 2=
001
>> From: janboe <janboe.ye@gmail.com>
>> Date: Fri, 28 Aug 2009 13:50:57 +0800
>> Subject: [PATCH] flush the function in sdram is not correct because
>> sram is changed.
>>
>> Signed-off-by: janboe <janboe.ye@gmail.com>
>
> The technical part of the patch makes sense, but the patch format nee=
ds
> to be changed.
>
> Your subject line should start with something like "[PATCH] OMAP SRAM=
:",
> and you should add a short patch description that describes the bug a=
nd
> why the patch does what it does to fix it.
>
> Also your post should not include the "From", "Date", and "Subject" l=
ines
> inside the E-mail. =A0You might wish to consider using 'git send-emai=
l' or
> at least 'git format-patch' if possible.
>
>
> - Paul
>
>> ---
>> =A0arch/arm/plat-omap/sram.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> index f2b0fa6..253fcf7 100644
>> --- a/arch/arm/plat-omap/sram.c
>> +++ b/arch/arm/plat-omap/sram.c
>> @@ -270,7 +270,7 @@ void * omap_sram_push(void * start, unsigned lon=
g size)
>> =A0 =A0 =A0 =A0 omap_sram_ceil -=3D size;
>> =A0 =A0 =A0 =A0 omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof=
(void *));
>> =A0 =A0 =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
>> - =A0 =A0 =A0 flush_icache_range((unsigned long)start, (unsigned lon=
g)(start + size));
>> + =A0 =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil, (uns=
igned
>> long)(omap_sram_ceil + size));
>>
>> =A0 =A0 =A0 =A0 return (void *)omap_sram_ceil;
>> =A0}
>> --
>> 1.6.3.3
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
