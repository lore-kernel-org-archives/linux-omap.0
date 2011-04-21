From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: powerdomain: fix typo: lose context --> loose context
Date: Thu, 21 Apr 2011 10:09:32 -0700
Message-ID: <87tydr1qgj.fsf@ti.com>
References: <1303345531-8435-1-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1104210851500.991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55854 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755177Ab1DURJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 13:09:37 -0400
Received: by mail-px0-f178.google.com with SMTP id 1so1351406pxi.9
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 10:09:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104210851500.991@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 21 Apr 2011 09:35:20 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Wed, 20 Apr 2011, Kevin Hilman wrote:
>
>> Before we get any users of this function, fix the name (and comments)
>> to use loose instead of lose.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Applies to v2.6.39-rc4
>> 
>>  arch/arm/mach-omap2/powerdomain.c |    6 +++---
>>  arch/arm/mach-omap2/powerdomain.h |    2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 9af0847..ec3423f 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -960,18 +960,18 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>>  }
>>  
>>  /**
>> - * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
>> + * pwrdm_can_ever_loose_context - can this powerdomain ever loose context?
>
> 'lose' is correct in this case,. It's derived from the idiom 'context 
> loss'.  more broadly, 'loose' implies a strong sense of agency on the part 
> of whatever is doing the 'loosing,' whereas 'lose' does not (it's the PRCM 
> that causes the powerdomain to lose context, not the powerdomain itself - 
> the powerdomain's logic/memory context is subject to the PRCM's whim)

After a dictionary lookup, I guess you're right.  I guess I've been
spelling that wrong for a while, and it seems I'm not the only one:

  http://www.elearnenglishlanguage.com/difficulties/looselose.html

Thanks for the English lesson.  ;)

Kevin
