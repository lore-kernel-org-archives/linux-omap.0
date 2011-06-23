From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Thu, 23 Jun 2011 20:43:57 +0530
Message-ID: <4E035835.50405@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>	<20110620092341.357.14183.stgit@kaulin> <4DFF1558.4020509@ti.com>	<20110620094846.GG23145@atomide.com> <87oc1obnbw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57072 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759391Ab1FWPUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 11:20:21 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so1112177gxk.35
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 08:20:17 -0700 (PDT)
In-Reply-To: <87oc1obnbw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 6/23/2011 8:35 PM, Kevin Hilman wrote:
> Tony Lindgren<tony@atomide.com>  writes:
>
>> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110620 02:35]:
>>> On 6/20/2011 2:53 PM, Tony Lindgren wrote:
>>>> This removes the support for setting the wake-up timer for debugging.
>>>>
>>>> Later on we can reserve gptimer1 for PM code only and have similar
>>>> functionality.
>>>>
>>>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>>>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>>>> ---
>>>
>>> Kevin cleaned up this with a better patch.
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50015.html
>>>
>>> May be we can use that patch instead of this.
>>
>> The thing is that it's a omap specific debug interface.
>
> What's wrong with OMAP-specific debug interfaces?   We have plenty of
> them: clock, omap_mux and pm_debug.
>
>> I'd rather just get rid of it until there's some generic way
>> of doing it.
>
> Well, we won't have a truly generic way of doing it until we have a
> generic way of doing HW timers.
>
> The implementation is now mostly generic in the patch Santosh referened
> above in that the timer programming is now done as part of the
> clockevent code, and not external timer programming.
>
> So now, the only thing OMAP-specific is the debugfs file used to trigger
> it.
>
>> Maybe Kevin can just carry it along in the PM branch for now?
>
> I'd prefer to keep it in mainline as this is a very important feature
> for the PM functionality already in mainline.
>
I agree with Kevin and that's what have been saying from begining when
we decided to drop this feature. The new patch from Kevin is already
doing this in more generic way than that was before.

Regards
Santosh
