From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: regression: Clock changes in next-20141205 break at least omap4
Date: Mon, 15 Dec 2014 18:31:28 -0700
Message-ID: <548F8B70.2060803@nvidia.com>
References: <20141205165539.GA30437@atomide.com>
 <5481F79D.4010504@codeaurora.org> <20141205183849.GB30437@atomide.com>
 <20141212194238.20398.33333@quantum>
 <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>
 <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>
 <20141216003834.GC23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11421 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaLPBba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2014 20:31:30 -0500
In-Reply-To: <20141216003834.GC23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, khilman@linaro.org

On 12/15/2014 05:38 PM, Tony Lindgren wrote:
> * Paul Walmsley <pwalmsley@nvidia.com> [141215 16:23]:
>> On 12/15/2014 03:02 PM, Mike Turquette wrote:
>>> Quoting Paul Walmsley (2014-12-12 15:28:32)
>>>> On Fri, 12 Dec 2014, Mike Turquette wrote:
>>>>
>>>>> Quoting Tony Lindgren (2014-12-05 10:38:49)
>>>>>> * Stephen Boyd <sboyd@codeaurora.org> [141205 10:23]:
>>>>>>> On 12/05/2014 08:55 AM, Tony Lindgren wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Looks like commit 646cafc6aa4d ("clk: Change clk_ops->determine_rate
>>>>>>>> to return a clk_hw as the best parent") breaks booting at least for
>>>>>>>> omap4.
>>>>>>> Do you get a compilation warning in arch/arm/mach-omap2/dpll3xxx.c ?
>>>>>> Yes so it seems.
>>>>>>
>>>>>>>  From what I can tell omap3_noncore_dpll_determine_rate() hasn't been
>>>>>>> updated to take a clk_hw pointer instead of clk pointer. It was there in
>>>>>>> the original patch and I'm not sure why Mike dropped that part while
>>>>>>> applying.
>>>>>> OK that makes sense, Mike should apply that part too. Note that also
>>>>>> include/linux/clk/ti.h needs changed accordingly for struct clk_hw,
>>>>>> which you probably had in your orignal patch too. Assuming that's there,
>>>>>> please feel free to add:
>>>>>>
>>>>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>>> I figured out what went wrong here. When I applied Tomeu's changes the
>>>>> OMAP stuff did not apply at all. In fact the .determine_rate callbacks
>>>>> did not exist in clk-next. Paul merged that stuff through his tree[0]. I
>>>>> don't know why I didn't follow up on that at the time.
>>>>>
>>>>> So we need to come up with a solution. Paul can take the OMAP portion of
>>>>> Tomeu's changes[1] for OMAP, but I believe compilation will be broken in
>>>>> his tree until it meets up with mine in linux-next. Or we could set up a
>>>>> shared immutable branch that provides the needed changes.
>>>>>
>>>>> I could either set up a shared branch that includes Tomeu's changes that
>>>>> Paul could merge (will require a rebase of the tip of my tree) or Paul
>>>>> could provide a shared branch of the changes to dpll3xxx.c and
>>>>> dpll4xxx.c that I could merge in.
>>>>>
>>>>> Or I could remove Tomeu's patches from my tree since we're right up
>>>>> against the merge window but I would rather not do that since he has
>>>>> worked tirelessly on this topic.
>>>>>
>>>>> [0] http://www.spinics.net/lists/arm-kernel/msg377288.html
>>>>> [1] https://lkml.org/lkml/2014/12/2/70
>>>> I don't think there's much that I can do at this point.  My tree is quite
>>>> topologically distant from Linus's tree (pjw/omap-pending ->
>>>> tmlind/linux-omap -> arm/arm-soc -> torvalds/linux).  So anything I do is
>>>> high-latency.  My pull request for Tero's patches was sent to Tony a month
>>>> ago.
>>> Paul,
>>>
>>> I identified the patch in your tree that is missing in mine and, with
>>> Tony's help, applied your for-v3.19/omap-a signed tag to my tree. With
>>> these 5 patches in place I have applied Tero's two patches from
>>> Friday[0].
>>>
>>> Paul & Tony, are you OK for me to take both of Tero's patches? I'm
>>> already taking stuff in late so it is no trouble for me to pick up "ARM:
>>> OMAP3: clock: fix boot breakage in legacy mode" while I'm at it.
>>>
>>> I'm going to let this get at least one cycle in linux-next before
>>> sending my PR late this week. Hopefully Kevin (Cc'd) can check on the
>>> omap boards in his autobuilder once my tree hits -next?
>>>
>>> Let me know if I missed anything. Thanks for the great teamwork, gang.
>>>
>>> [0] http://lkml.kernel.org/r/<1418390521-7541-1-git-send-email-t-kristo@ti.com>
>>>
>>> Regards,
>>> Mike
>> I think Tony's taking the second patch from Tero.
> If it applies to what Mike has now queued, please take that too Mike:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I just took a quick glance at Tero's second patch, and it looks like a 
hack to me.  Better to fix the problem in the core CCF code if 
possible.  I don't think there's any reason why a PLL couldn't have just 
one parent clock.  But I'm fine with merging it as a short-term fix if 
fixing the core code is difficult or risky.

- Paul
