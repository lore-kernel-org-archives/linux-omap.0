From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 16:09:52 -0800
Message-ID: <87tyj8kii7.fsf@deeprootsystems.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>
	<87aal1kktu.fsf@deeprootsystems.com> <4CEAFD00.4090200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0KWAJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 19:09:54 -0500
Received: by pwi7 with SMTP id 7so68405pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 16:09:54 -0800 (PST)
In-Reply-To: <4CEAFD00.4090200@ti.com> (Nishanth Menon's message of "Mon, 22
	Nov 2010 17:30:08 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 11/22/2010 05:19 PM:
>> Nishanth Menon<nm@ti.com>  writes:
>>
>>> This patch adds OPP tables for OMAP4. New file has been added to keep
>>> the OMAP4 opp tables and the registration of these tables with the
>>> generic opp framework by OMAP SoC OPP interface.
>>
>> [...]
>>
>>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>>> index 66e12be..48a553f 100644
>>> --- a/arch/arm/mach-omap2/opp.c
>>> +++ b/arch/arm/mach-omap2/opp.c
>>> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>>>
>>>   /* omap3 opps */
>>>   #include "opp3xxx_data.c"
>>> -
>>> +/* omap4 opps */
>>> +#include "opp4xxx_data.c"
>>
>> I'm not sure I like the including of C files.  Any reason you prefer
>> this to just adding them to the Makefile?  e.g. opp24xx_dta.c are
>> compiled in via Makefile and these two are included.
>
> I dont buy it. I am seeing us go around in circles for this:
> http://marc.info/?l=linux-omap&m=128986880406272&w=2
> a) we dont want others to use specifics implemented in opp.c in other
> files (e.g. board files)

not sure how this is prevented.

> b) we have many similar usage in linux kernel - so this usage is not
> first time.
> c) opp2xx usage is very different from opp3/4 usage

I'm not going to insist on one way or the other, just stating my
preference for not including C files from C files without good
justification.  You've stated your reasons, I guess Tony can decide.

Kevin




