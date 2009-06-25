From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with different Power
 IC
Date: Thu, 25 Jun 2009 12:25:58 -0700
Message-ID: <4A43CF46.60706@android.com>
References: <B00E06E2766C2744B022DE9BAF3C59D5465B7B@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:58937 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbZFYT0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 15:26:00 -0400
Received: by pzk27 with SMTP id 27so1545980pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 12:26:03 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D5465B7B@zmy16exm69.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

Wang Sawsd-A24013 wrote:
>> -----Original Message-----
>> From: Mike Chan [mailto:mike@android.com]=20
>> Sent: 2009=C4=EA6=D4=C225=C8=D5 9:25
>> To: Wang Sawsd-A24013
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with=20
>> different Power IC
>>
>> Wang Sawsd-A24013 wrote:
>>    =20
>>> From c1aba8ba7af3ddd16346d95795bda71e65baa4d0 Mon Sep 17=20
>>>      =20
>> 00:00:00 2001
>>    =20
>>> From: Chunqiu Wang <cqwang@motorola.com>
>>> Date: Wed, 24 Jun 2009 06:48:52 +0800
>>> Subject: [PATCH] Support OMAP3 VC adaptation with different Power I=
C
>>>
>>> Current OMAP SmartReflex driver only supports TI Triton
>>> Power IC, add a callback to make it possible to use
>>> different PowerIC and use different settings to
>>> configure OMAP3 Voltage Controller for DVFS
>>>
>>> Board file can setup a new function to have different settings
>>> on SR to configure their Power IC for voltage scaling
>>>
>>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>>> ---
>>>  arch/arm/mach-omap2/smartreflex.c |   13 +++++++++++++
>>>  arch/arm/mach-omap2/smartreflex.h |    4 ++++
>>>  arch/arm/plat-omap/Kconfig        |    2 +-
>>>  3 files changed, 18 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>>> b/arch/arm/mach-omap2/smartreflex.c
>>> index 9d462e3..bacf602 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -52,6 +52,8 @@ struct omap_sr {
>>> =20
>>>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>>> =20
>>> +static omap3_voltagescale_vcbypass_t omap3_volscale_vcbypass_fun;
>>>  =20
>>>      =20
>> Perhaps use
>> static int (*omap3_volscale_vcbypass_fun) (u32, u32, u8, u8);
>>
>> This gets rid of the compiler warning on incompatible pointer=20
>> types when=20
>> you register a function via omap3_voltagescale_vcbypass_setup().
>>
>> -- Mike
>>    =20
> Thanks Mike, but we do not see the warnning with the original
> Code, note this patch is slightly different with the one we sent
> To you based on K29, this new patch have four parameters
> Sinc some change has been made in the
> sr_voltagescale_vcbypass to add two more parameters.
>
> Is your warnning caused by this?
>
>  =20

This patch stand-alone doesn't give me any warnings. Its only when you
hook into this from your board file. Might be the compiler I'm using.
I used this patch + modified version of the patches you sent me before
to get the two working. (Yes, 4 params).

-- MIke
> Thanks,
> Chunqiu
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
