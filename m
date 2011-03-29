From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Tue, 29 Mar 2011 12:25:11 +0530
Message-ID: <4D91824F.8020702@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com> <4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com> <4D8711A5.6070301@ti.com> <alpine.DEB.2.00.1103281036060.26455@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49013 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab1C2Gz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 02:55:26 -0400
Received: by gwj16 with SMTP id 16so1776063gwj.37
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 23:55:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103281036060.26455@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

<snip>...
>>> Well after the UART timeouts expired, I do not see any powerdomains
>>> transitioning from ON.
>>>
>>> What's even more strange is that the same thing is working fine on all
>>> the other OMAP3 platforms I tested: 3430/n900, 3630/zoom3 and even a
>>> different 3530-based platform, the OMAP3EVM.
>>
>> I tried to reproduce this on a Beagle rev C3, but I don't seem
>> to be seeing this issue. I was able to hit OFF mode in both
>> suspend and idle.
>>
>> I also tried removing autodeps completely on OMAP3 and ran
>> into some issues/aborts with GPIO restore path with
>> OFF mode enabled.
>>
>> Besides these, debugging some McBSP related crashes showed
>> up another issue with this patch.
>> Since the clockdomain is programmed back to HW_AUTO (if supported)
>> in the clock framework, this happens *before* waiting for the
>> module to become accessible. (On OMAP4, the check to make sure
>> the module is accessible happens in the hwmod framework, unlike
>> in older OMAP's, where it was part of the clock framework)
>>
>> So instead of implementing the recommended sequence of
>> -1- Force clkdm to SW_WKUP
>> -2- Configure desired module mode to "enable" or "auto"
>> -3- Wait for the desired module idle status to be FUNC
>> -4- Program clkdm in HW_AUTO(if supported)
>>
>> ..it was actually implementing the wrong sequence as below
>> -1- Force clkdm to SW_WKUP
>> -2- Configure desired module mode to "enable" or "auto"
>> -3- Program clkdm in HW_AUTO(if supported)
>> -4- Wait for the desired module idle status to be FUNC
>
> Hmmm, right now OMAP4 only appears to be forcing the clkdm to SW_WKUP if
> the clockdomain is in software-supervised mode
> (clockdomain44xx.c:omap4_clkdm_clk_enable()).  Doesn't seem like that
> follows either sequence?

Yes, the current implementation only forces it to SW_WKUP
if the clockdomain is in software supervised mode which is
not correct.
Thats what this patch intended to fix, but like I said
the sequence followed in this patch was still not right.

>
>> This however was only a problem on OMAP4.
>>
>> Fixing this would require moving the clockdomain programming
>> back to HW_AUTO as part of the hwmod framework.
>
> In omap_hwmod.c:_enable(), what do you think about:
>
> 1. saving the current idle mode of the clockdomain,
>
> 2. forcing the clockdomain to software-supervised wakeup.
>
> 3. enabling clocks and waiting for the module as we currently do, then
>
> 4. switching the clockdomain's idle mode back to its original state?
>
> Seems like that would be a reasonable approach for the short term, at
> least for drivers that have been converted to PM runtime.

Ok, I'll try and get some RFC patches in these lines soon.

>
>> However this sequence is recommended even for optional clock enabling,
>> and hence might have to be handled at the clock framework as well.
>
> Might be worth finding out the reasoning behind this recommendation.  Is
> this only for optional clocks that are used for functional purposes, e.g.,
> for modules that use HWMOD_CONTROL_OPT_CLKS_IN_RESET ?

Ok, I'll try and dig some more details on this.

regards,
Rajendra
>
>> (Since optional clocks are still controlled by drivers using clock
>> framework directly).
>
> Yeah, if this really turns out to be needed, sounds like we'll have to
> tightly couple the hwmod code with the OMAP clock code :-( I'd suggest
> that we find out why this is recommended first.
>
>> Any suggestions on how to handle this without duplicating
>> much of this across clock and hwmod framework?
>
>
> - Paul

