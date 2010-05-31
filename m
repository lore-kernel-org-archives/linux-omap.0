From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 6/6] omap: move generic omap3 features to generic
Date: Mon, 31 May 2010 21:36:12 +0530
Message-ID: <AANLkTinHOZXk9pYeSfsBiejU7x1w-rA2MRtC4BBoKK0r@mail.gmail.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>
	<1274585799-16226-2-git-send-email-nm@ti.com>
	<1274585799-16226-3-git-send-email-nm@ti.com>
	<1274585799-16226-4-git-send-email-nm@ti.com>
	<1274585799-16226-5-git-send-email-nm@ti.com>
	<1274585799-16226-6-git-send-email-nm@ti.com>
	<1274585799-16226-7-git-send-email-nm@ti.com>
	<AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>
	<4BFE9C14.9040703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44142 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab0EaQNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 12:13:06 -0400
Received: by gye5 with SMTP id 5so373208gye.19
        for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 09:13:05 -0700 (PDT)
In-Reply-To: <4BFE9C14.9040703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Nishanth Menon <nm@ti.com> wrote:
> On 05/27/2010 01:24 PM, S, Venkatraman wrote:
>>
>> Nishanth Menon<nm@ti.com> =A0wrote:
>
> [..]
>>>
>>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>>> index 809e13a..01555b6 100644
>>> --- a/arch/arm/mach-omap2/id.c
>>> +++ b/arch/arm/mach-omap2/id.c
>>> @@ -161,7 +161,7 @@ static void __init omap24xx_check_revision(void=
)
>>> =A0#define OMAP3_CHECK_FEATURE(status,feat) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0if (((status& =A0OMAP3_ ##feat## _MASK) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> =A0OMAP3_ ##feat## _SHIFT) !=3D F=
EAT_ ##feat## _NONE) { =A0 \
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_ ##feat=
; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP_HAS_ ##feat; =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> =A0 =A0 =A0 =A0}
>>
>> "CHECK" sounds like a querying API, whereas the macro populates data=
=2E
>> Maybe UPDATE or SET ?
>>
> Depends on where you are looking at it from: overall it is checking t=
he
> status bits from OMAP and deciding what features it has - this is
> specifically important for 35xx series of processors. it is indeed a =
check
> in that sense. if you look at it from features variable, yeah it is u=
pdating
> it, but the idea of usage of the Macro is: check in status if feature=
 X is
> available.. which is what it does ;). btw, the intent of the current =
patch
> was not meant to rename CHECK_FEATURE as it was very OMAP3 specific ;=
)
>

It's ok.  I don't want to worry too much about the name.

>>> =A0static void __init omap3_check_features(void)
>>> @@ -310,20 +310,20 @@ static void __init omap3_cpuinfo(void)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>
> [...]
>
>>> +OMAP_HAS_FEATURE(, l2cache, L2CACHE)
>>> +OMAP_HAS_FEATURE(, sgx, SGX)
>>> +OMAP_HAS_FEATURE(, iva, IVA)
>>> +OMAP_HAS_FEATURE(, neon, NEON)
>>> +OMAP_HAS_FEATURE(, isp, ISP)
>>> +
>>> +/*
>>> =A0* Runtime detection of OMAP3 features
>>> =A0*/
>>> =A0extern u32 omap3_features;
>>>
>>> -#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
>>> -#define OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
>>> -#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
>>> -#define OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
>>> -#define OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
>>> =A0#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
>>>
>>> -OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
>>> -OMAP_HAS_FEATURE(3, sgx, SGX)
>>> -OMAP_HAS_FEATURE(3, iva, IVA)
>>> -OMAP_HAS_FEATURE(3, neon, NEON)
>>> -OMAP_HAS_FEATURE(3, isp, ISP)
>>> =A0OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
>>>
>>> =A0#endif
>>> --
>>
>> What about feature detection for OMAP2 and OMAP4 (similar to
>> omap3_check_features) ?
>> At least a dummy implementation with warning messages would be good,
>> so that they are not used without initialization.
>
> there is no need for warning messages, they will return as feature no=
t
> present. cpu.h is a common header and variable omap_features is in co=
mmon.c,
> the check_feature and id.c has not set that bit, the variable will re=
main 0,
> hence omap_has_sgx() will return 0 unless someone enables that for le=
ts say
> OMAP4 -> feel free to do it, as I mentioned in 0/6, this series was m=
eant
> solely to reorganize and provide an infrastructure for further develo=
pment.
>

I don't agree. The patch / series is about making them 'generic', where=
 generic
is, to the minimum, "making the features exposed for major silicon vers=
ions".
If they are not usable beyond OMAP3, it's not generic.

[Apologies for the delayed reply, seem to have a delayed delivery issue=
]
-Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
