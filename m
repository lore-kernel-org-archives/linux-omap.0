From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 09:23:16 -0800
Message-ID: <87fx5qrvnf.fsf@deeprootsystems.com>
References: <1264657260-12310-1-git-send-email-nm@ti.com>
	<4B6134EB.8040202@ti.com>
	<74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E22B41EC@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA9E76853B4@dnce01.ent.ti.com>
	<0C997DD87CC88A4F86C897F52650B52B02807801@MOLSON.mpc-data.co.uk>
	<4B61AAB2.6050003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:50276 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab0A1RXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:23:23 -0500
Received: by fxm20 with SMTP id 20so915625fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:23:21 -0800 (PST)
In-Reply-To: <4B61AAB2.6050003@ti.com> (Nishanth Menon's message of "Thu\, 28 Jan 2010 09\:18\:10 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Andrew Murray <amurray@mpc-data.co.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "Dasgupta, Romit" <romit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Hi,
> Thanks for all the comments.
> Andrew Murray had written, on 01/28/2010 08:00 AM, the following:
>>> From: Cousson, Benoit [mailto:b-cousson@ti.com]
>>> Sent: 28 January 2010 13:48
>>> To: Dasgupta, Romit; Menon, Nishanth
>>> Cc: linux-omap; Andrew Murray; Kevin Hilman
>>> Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
>>
>>> I don't want to keep it. I just want to document it in order to
>> explain
>>> why the code is not aligned with the public doc.
>>>
>>> Andrew did ask the question so the answer might be useful for others
>> as
>>> well, hence a small comment on top of the CORE OPP list.
>>>
>>> Benoit
>>
>> I agree. 
>>
>> I don't think it matters if the OPP 'OMAP_OPP_DEF' is there or not.
>> Though as the OPPs differ to the hardware descriptions it should be
>> documented - perhaps as suggested, by a comment.
>>
>> It is confusing when validating the power management software support -
>> and the best place to look for the rationale is in the code. 
>>
>> Andrew Murray
> I did consider removing it, till i did a git grep...
>> $ git grep VDD2_OPP
>> arch/arm/mach-omap2/pm34xx.c:   resource_lock_opp(VDD2_OPP);
>> arch/arm/mach-omap2/pm34xx.c:   resource_unlock_opp(VDD2_OPP);
>> arch/arm/mach-omap2/resource34xx.c:     } else if (res == VDD2_OPP) {
>> arch/arm/mach-omap2/resource34xx.c:     else if (res == VDD2_OPP)
>> arch/arm/mach-omap2/resource34xx.c:             ret = resource_set_opp_level(VDD2_OPP, target_level, 0);
>> arch/arm/mach-omap2/smartreflex.c:                      target_opp_no = VDD2_OPP3;
> Grrrr... SR is going to break if I were to do that OR my patch can
> renumber them.
>
>> arch/arm/mach-omap2/smartreflex.c:      } else if (vdd == VDD2_OPP) {
>> arch/arm/mach-omap2/smartreflex.c:              else if (vdd == VDD2_OPP)
>> arch/arm/mach-omap2/smartreflex.h:#define PRCM_VDD2_OPP1                (OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
>> arch/arm/mach-omap2/smartreflex.h:#define PRCM_VDD2_OPP2                (OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
>> arch/arm/mach-omap2/smartreflex.h:#define PRCM_VDD2_OPP3                (OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
>> arch/arm/mach-omap2/smartreflex.h:#define PRCM_NO_VDD2_OPPS     3
>> arch/arm/plat-omap/include/plat/omap34xx.h:#define VDD2_OPP     0x2
>> arch/arm/plat-omap/include/plat/omap34xx.h:#define VDD2_OPP1    0x1
>> arch/arm/plat-omap/include/plat/omap34xx.h:#define VDD2_OPP2    0x2
>> arch/arm/plat-omap/include/plat/omap34xx.h:#define VDD2_OPP3    0x3
> All these should go away as well.. I missed these in my pm-wip-opp
> patchset..
>
> Do we want to do this now(DISCLAIMER: I am not volunteering{yet} ;) )?
> OR do we want to wait till the current planned SR/SRF cleanups are
> complete?

I suggest that for now we just add the value back as your original patch,
and add a comment as suggested by Benoit as well.  After the SR rework
is done, we can remove the OPP and leave the comment.

Kevin
