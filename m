From: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP2: use 'int' instead of 'unsigned' for variable
 'gpmc_irq_start'
Date: Thu, 22 Aug 2013 16:59:56 +0800
Message-ID: <5215D30C.1070500@gmail.com>
References: <521479B4.8030604@asianux.com> <20130822071402.GQ7656@atomide.com> <5215C12D.5020807@asianux.com> <5215C209.3080606@asianux.com> <20130822075731.GT7656@atomide.com> <5215C555.9060902@asianux.com> <20130822083206.GU7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49487 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3HVJBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 05:01:03 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1613747pdi.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Aug 2013 02:01:02 -0700 (PDT)
In-Reply-To: <20130822083206.GU7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chen Gang <gang.chen@asianux.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/22/2013 04:32 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130822 01:10]:
>> On 08/22/2013 03:57 PM, Tony Lindgren wrote:
>>> * Chen Gang <gang.chen@asianux.com> [130822 00:55]:
>>>> 'gpmc_irq_start' is mostly used as 'int', and for a variable, do not
>>>> suggest to only use 'unsigned' as its type, so use 'int' instead of
>>>> 'unsigned' for variable 'gpmc_irq_start'.
>>>>
>>>> Also it will fix the related issue (dummy the real world failure):
>>>>
>>>>   arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>>>
>>>
>>> Thanks applying into omap-for-v3.12/fixes-non-critical.
>>>
>>
>> Thank you too.
>>
>> Hmm... excuse me, I am not quite familiar with the omap version trees,
>> so may have a doubt: "it seems this is a real bug, is it suitable to
>> belong to fixes-none-critical tree ?"
> 
> For the -rc cycle we try to limit the patches to oopses and regressions,
> especially this close to v3.11 being tagged.
> 

Really necessary.

> It seems the bug has been there for quite some time, and that we don't
> seem to have oopses or other failures reporting this. So it seems there's
> no reason for urgency to have it merged into the current -rc series.
> 

I guess so too (I only find it by compiling).


> If you (or somebody else) strongly feels that it should be in applied
> to the current -rc series as a fix instead of during the merge window,
> then please let me know the failing cases with logs showing what
> happens.
> 

Hmm... for urgent bugs, the reporters really need supply the failing
cases with logs showing what happens.

Bugs can be sort of by urgent priority (e.g. this bug is not urgent).
but for most of bugs may cause critical issue which depends on the using
environments, and can be 'imagined' by us.

Hmm... I guess: for our case, what your meaning is "fixes-none-urgent",
not "fixes-none-critical", is it correct ?  :-)


Thanks.

> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Chen Gang
