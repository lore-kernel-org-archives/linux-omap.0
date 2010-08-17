From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: Beagle: revision detection
Date: Tue, 17 Aug 2010 15:11:22 -0500
Message-ID: <AANLkTi=MK9cSik3CE46FUMYP=BpsNnM=eAr69Bh7PTcf@mail.gmail.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
	<20100817061022.GC12184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41517 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0HQULY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 16:11:24 -0400
Received: by eyg5 with SMTP id 5so2263473eyg.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 13:11:22 -0700 (PDT)
In-Reply-To: <20100817061022.GC12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

On Tue, Aug 17, 2010 at 1:10 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Robert Nelson <robertcnelson@gmail.com> [100816 17:29]:
>> Due to the omap3530 ES3.0 Silicon being used on both the
>> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx()
>> routines to differentiate the Beagle Boards.
>>
>> However gpio pins 171,172,173 where setup for this prupose, so
>> lets use them.
>>
>> Changes:
>> for older U-Boot's, use omap_mux_init_gpio()
>> keep Beagle Rev in board-omap3beagle.c
>>
>> Tested on Beagle Revisions: B5, C2, C4, and xMA
>
> Looks good, just one minor comment below.
>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> Cc: Jarkko Nikula <jhnikula@gmail.com>
>> ---
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 79 ++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 79 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach=
-omap2/board-omap3beagle.c
>> index 87969c7..01a288f 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -50,6 +50,84 @@
>>
>> =A0#define NAND_BLOCK_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0SZ_128K
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
>> +static u8 omap3_beagle_version;
>> +
>> +u8 get_omap3_beagle_rev(void)
>> +{
>> + =A0 =A0 return omap3_beagle_version;
>> +}
>
> Please make this static u8 get_omap3_beagle_rev().

Thanks Tony,

that's changed..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
