From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Thu, 17 Dec 2009 08:10:29 -0800
Message-ID: <87tyvp60p6.fsf@deeprootsystems.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
	<1260594031-17268-1-git-send-email-nm@ti.com>
	<87pr6eadx3.fsf@deeprootsystems.com>
	<873a3aa6lt.fsf@deeprootsystems.com> <4B29A401.1050001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65125 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111AbZLQQKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 11:10:32 -0500
Received: by pwj9 with SMTP id 9so1365527pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 08:10:31 -0800 (PST)
In-Reply-To: <4B29A401.1050001@ti.com> (Nishanth Menon's message of "Thu\, 17 Dec 2009 08\:52\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> Kevin Hilman said the following on 12/17/2009 04:07 AM:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>   
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>     
>>>> Hi,
>>>> Thanks for all the comments. Here are the *changed* patches since V5
>>>>
>>>> What changed in V5:
>>>> * review comment incorporated
>>>> * vsel is deprecated now
>>>> * I seem to have hit a checkpatch.pl bug as in
>>>> http://lkml.org/lkml/2009/12/11/573, made me check the usage
>>>>   of __deprecated for struct params, and used it in a
>>>>   consistent manner to functions..
>>>> * More warnings added to build :( (deprecated ones ofcourse)
>>>> * removed OMAP_OPP_DEF_TERMINATOR
>>>> * 3430 and 3630 patches changed as a result
>>>>       
>> [...]
>>
>>   
>>> To facilitate the ongoing discussions on OPP rework, and to have a
>>> common base, this series is available as a branch in my linux-omap-pm
>>> repo[1].
>>>
>>> The branch is called 'pm-wip-opp' and I have rebased onto the PM
>>> branch I pushed today.
>>>     
>>
>>   
> Thanks Kevin.
>
>> I forgot to mention that I've also pushed the patch for removing OPP
>> interface from the OMAP PM layer[1] to the work-in-progress OPP
>> branch.
>>
>> Kevin
>>
>> [1] http://marc.info/?l=linux-omap&m=125917007423545&w=2
>>   
> Reg [1]
> What is the point of having
> void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> struct omap_sdrc_params *sdrc_cs1,
> struct omap_opp *mpu_opps,
> struct omap_opp *dsp_opps,
> struct omap_opp *l3_opps)
>
> Why have mpu_opps, dsp_opps and l3_opps anymore? those parameters are
> unused anymore. the patch should have changed omap2_init_common_hw and
> related board calls - am I right?

Yes, I'm in the process cleaning that up.

Once I get some of that cleanup done, I plan to rebase your OPP V5 and
include it in the PM branch.

Kevin
