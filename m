From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Tue, 23 Nov 2010 12:38:42 -0800
Message-ID: <87ipznepwt.fsf@deeprootsystems.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>
	<87aal1kktu.fsf@deeprootsystems.com> <4CEAFD00.4090200@ti.com>
	<87tyj8kii7.fsf@deeprootsystems.com> <4CEBDB7A.8010807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48814 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0KWUiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 15:38:46 -0500
Received: by gyb11 with SMTP id 11so2322110gyb.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 12:38:46 -0800 (PST)
In-Reply-To: <4CEBDB7A.8010807@ti.com> (Nishanth Menon's message of "Tue, 23
	Nov 2010 09:19:22 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 11/22/2010 06:09 PM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Kevin Hilman wrote, on 11/22/2010 05:19 PM:
>>>> Nishanth Menon<nm@ti.com>  writes:
>>>>
>>>>> This patch adds OPP tables for OMAP4. New file has been added to keep
>>>>> the OMAP4 opp tables and the registration of these tables with the
>>>>> generic opp framework by OMAP SoC OPP interface.
>>>> [...]
>>>>
>>>>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>>>>> index 66e12be..48a553f 100644
>>>>> --- a/arch/arm/mach-omap2/opp.c
>>>>> +++ b/arch/arm/mach-omap2/opp.c
>>>>> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>>>>>
>>>>>   /* omap3 opps */
>>>>>   #include "opp3xxx_data.c"
>>>>> -
>>>>> +/* omap4 opps */
>>>>> +#include "opp4xxx_data.c"
>>>> I'm not sure I like the including of C files.  Any reason you prefer
>>>> this to just adding them to the Makefile?  e.g. opp24xx_dta.c are
>>>> compiled in via Makefile and these two are included.
>>> I dont buy it. I am seeing us go around in circles for this:
>>> http://marc.info/?l=linux-omap&m=128986880406272&w=2
>>> a) we dont want others to use specifics implemented in opp.c in other
>>> files (e.g. board files)
>>
>> not sure how this is prevented.
> The approach is as follows:
> the #defines and struct definitions are in opp.c
> opp{3,4}xxx_data.c use the same - by itself wont build because they
> need the defines in opp.c
> that way, there is no possibility of clean hacks possible except to
> follow the current mechanism for a future omap silicon
>
> The main objective was to restrict the potential of board developers
> from hacking the default OPP table - which would be possible by
> exposing the headers for board files - which as Thomas rightly pointed
> out in the thread I pointed out,  opens up a possibility for board
> files to include them as well and re-instantiate the table again..

OK, then this falls into the "trick to make ugly hacks *really* ugly"
category.   I can live with that. :)

Kevin

>>
>>> b) we have many similar usage in linux kernel - so this usage is not
>>> first time.
>>> c) opp2xx usage is very different from opp3/4 usage
>>
>> I'm not going to insist on one way or the other, just stating my
>> preference for not including C files from C files without good
>> justification.  You've stated your reasons, I guess Tony can decide.
> okay by me - will post a v5 after seeing the final decision on that front :)
