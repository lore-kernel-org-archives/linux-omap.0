From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer
 clock
Date: Wed, 06 May 2015 17:29:23 -0700
Message-ID: <554AB1E3.2000304@codeaurora.org>
References: <1430848941-27106-1-git-send-email-tony@atomide.com> <20150506053539.GA10871@codeaurora.org> <20150506145539.GI21061@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47016 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbEGA3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 20:29:25 -0400
In-Reply-To: <20150506145539.GI21061@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On 05/06/15 07:55, Tony Lindgren wrote:
> * Stephen Boyd <sboyd@codeaurora.org> [150505 22:36]:
>> On 05/05, Tony Lindgren wrote:
>>> With recent changes to use determine_rate, the comparison of two
>>> clocks won't work without doing __clk_get_hw on the clocks
>>> first.
>>>
>>> Cc: Michael Turquette <mturquette@linaro.org>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Tero Kristo <t-kristo@ti.com>
>>> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>>
>>> Found one more of these, the coccinelle scripts do not seem
>>> to match this?
>> I don't think the coccinelle script was ever merged...
> Oh OK, but the wrong comparisons in the kernel code got
> fixed, right? 

Yes the ones that mattered were fixed.

>>> @@ -298,7 +299,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>>>  	if (IS_ERR(src))
>>>  		return PTR_ERR(src);
>>>  
>>> -	if (clk_get_parent(timer->fclk) != src) {
>>> +	if (__clk_get_hw(clk_get_parent(timer->fclk)) != __clk_get_hw(src)) {
>> Please use clk_is_match() instead so we can find these instances
>> with an easy grep.
> Thanks here's an updated version with that.

Are you taking this through arm-soc?

> Regards,
>
> Tony
>
> 8< -----------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 5 May 2015 09:03:34 -0700
> Subject: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer clock
>
> With recent changes to use determine_rate, the comparison of two
> clocks won't work without clk_is_match that does __clk_get_hw
> on the clocks first.
>
> Cc: Michael Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -298,7 +298,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(src))
>  		return PTR_ERR(src);
>  
> -	if (clk_get_parent(timer->fclk) != src) {
> +	if (!clk_is_match(clk_get_parent(timer->fclk), src)) {
>  		r = clk_set_parent(timer->fclk, src);

I also wonder why we can't just call clk_set_parent() and skip the "is
the parent already src" check?

If there's a good reason for not just calling clk_set_parent() then it
makes sense to do the clk_is_match() thing, and you can have my ack

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

