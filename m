From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 12 Aug 2010 07:09:48 -0500
Message-ID: <AANLkTi=poP7JeWTogx95C9-K=ZvcGiN2nKYd7+wpG0GQ@mail.gmail.com>
References: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
	<20100812120040.GD6629@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47436 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759069Ab0HLMJu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 08:09:50 -0400
Received: by ewy23 with SMTP id 23so571047ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 05:09:48 -0700 (PDT)
In-Reply-To: <20100812120040.GD6629@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

On Thu, Aug 12, 2010 at 7:00 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Robert Nelson <robertcnelson@gmail.com> [100812 02:30]:
>> Due to the omap3530 ES3.0 Silicon being used on both the
>> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx()
>> routines to differentiate the Beagle Boards.
>>
>> However gpio pins 171,172,173 where setup for this prupose, so
>> lets use them.
>
> <snip>
>
>> --- a/arch/arm/plat-omap/include/plat/board.h
>> +++ b/arch/arm/plat-omap/include/plat/board.h
>> @@ -26,6 +26,22 @@ enum {
>> =A0 =A0 =A0 OMAP3EVM_BOARD_GEN_2, =A0 =A0 =A0 =A0 =A0 /* EVM Rev >=3D=
 Rev E */
>> =A0};
>>
>> +/*
>> + * OMAP3 Beagle revision
>> + * Run time detection of Beagle revision is done by reading GPIO.
>> + * GPIO ID -
>> + * =A0 AXBX =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 1 1
>> + * =A0 C1_3 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 1 0
>> + * =A0 C4 =A0 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 0 1
>> + * =A0 XM =A0 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 0 0 0
>> + */
>> +enum {
>> + =A0 =A0 OMAP3BEAGLE_BOARD_AXBX =3D 0,
>> + =A0 =A0 OMAP3BEAGLE_BOARD_C1_3,
>> + =A0 =A0 OMAP3BEAGLE_BOARD_C4,
>> + =A0 =A0 OMAP3BEAGLE_BOARD_XM,
>> +};
>> +
>> =A0/* Different peripheral ids */
>> =A0#define OMAP_TAG_CLOCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4f01
>> =A0#define OMAP_TAG_LCD =A0 =A0 =A0 =A0 0x4f05
>> @@ -173,4 +189,11 @@ u8 get_omap3_evm_rev(void);
>> =A0#else
>> =A0#define get_omap3_evm_rev() (-EINVAL)
>> =A0#endif
>> +
>> +/* Beagle revision */
>> +#if defined(CONFIG_MACH_OMAP3_BEAGLE)
>> +u8 get_omap3_beagle_rev(void);
>> +#else
>> +#define get_omap3_beagle_rev() (-EINVAL)
>> +#endif
>> =A0#endif
>

(Crap re cc-ing group)

Thanks Tony

> You should be able to keep this all in board-omap3beagle.c,
> no need for the header. If this header is needed somewhere
> else, chances are that something is wrong.
>

Yeah, I can do that instead, i don't see it really leaving board-omap3b=
eagle.c..

I was using the existing "get_omap3_evm_rev" routines as an
inspiration and reference..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
