From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Thu, 16 May 2013 11:34:20 +0200
Message-ID: <CAGGh5h2TWvf+N0gRxQQX8KHav4qwxa=BDHuYYa9f49rmQCKMUw@mail.gmail.com>
References: <1368684720-26763-1-git-send-email-pekon@ti.com>
	<1368684720-26763-3-git-send-email-pekon@ti.com>
	<CAGGh5h16kxdPRtPQ4vRzLA4iMxjTurPpdzBiEHaM9zb+y8fJBg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9C4EC5@DBDE04.ent.ti.com>
	<CAGGh5h3WGGRcQgpns7EOso1yqvrzKmCAbQo9XZoMyhv0Q1KT4Q@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9C4F04@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34369 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3EPJeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 05:34:21 -0400
Received: by mail-wg0-f44.google.com with SMTP id a12so315376wgh.11
        for <linux-omap@vger.kernel.org>; Thu, 16 May 2013 02:34:20 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C4F04@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>

2013/5/16 Gupta, Pekon <pekon@ti.com>:
>
>> 2013/5/16 Gupta, Pekon <pekon@ti.com>:
>> >> >
>> >>
>> >> OMAP_ECC_BCH4_CODE_HW_DETECTION_SW and
>> >> OMAP_ECC_BCH4_CODE_HW
>> >> seems to exist in the code, but are not in the changelog, and not=
 in
>> >> the device tree binding documentation.
>> >>
>> >
>> > Yes, I plan to omit them from code also, in next series as it does=
 not
>> > make sense to support both BCH4 and BCH8 at same time, when most
>> > users would opt for BCH8.
>> > Also, BCH4 was kept for legacy purposes, and was not tested on all
>> devices.
>> > Therefore I have purposely omitted it from documentation.
>> >
>>
>> We have shipped devices with BCH4 nand.  This would be a regression
>> for us.
>>
> [Pekon]: May I know the following details so that I can prioritize BC=
H4 testing
> - Which TI device have you productized ?

dm3730

> - Which kernel version you are using ? (Is it from mainline or SDK re=
lease)

3.6.11, currently moving to 3.9

> - Which BCH4 ECC implementation you are using ?
>         BCH4_HW (using both GPMC and ELM H/W engines)
>         BCH4_HW_DETECTION_SW (using GPMC H/W and bch.h S/W libraries)

I guess it is BCH4_HW_DETECTION_SW. Here is the relevant part of the
machine board file patch :

+static struct omap_nand_platform_data cydm_nand_data =3D {
+     .cs =3D 0,
+     .ecc_opt =3D OMAP_ECC_BCH4_CODE_HW,
+};



> - Is there a specific reason why        you opted for BCH4 instead of=
 BCH8 ?
>         (Though its only recent that OMAP_ECC_BCHx support is mainlin=
ed
>         But, BCH8 support was available in TI SDK releases from quite=
 sometime.)
>

No, I figured BCH4 was sufficient for my nand. In fact my previous ecc
scheme (1 bit hamming) was not
offering enough protection. I started investigating bch, and read that
while the ti dvsdk bch code
for computing the bch was ok, the error correction code was not, and
the new BCH4 scheme
resulted in all FF OOB data for an empty page, which was great. There
was no real reason for
choosing BCH4 over BCH8, but I thought the simpler the better.

> I'll try to see if I can help you here, but going forward its always =
recommended
> to use higher ECC schemes (like BCH8), so that flash's lifetime is ex=
tended on field.
>

>
>> Regards,
>> Jean-Philippe Fran=C3=A7ois.
>>
> with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
