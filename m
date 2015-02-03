From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Tue, 03 Feb 2015 17:04:09 +0100
Message-ID: <54D0F179.1040906@gmail.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38409 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbbBCQEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 11:04:01 -0500
In-Reply-To: <20150202225036.421.43421@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org

Hello,
Julia asked me to have a look and see if I can help.

On 02/02/2015 23:50, Mike Turquette wrote:
> Quoting Stephen Boyd (2015-02-02 14:35:59)
>> On 02/02/15 13:31, Julia Lawall wrote:
>>> On Mon, 2 Feb 2015, Stephen Boyd wrote:
>>>
>>>> Julia,
>>>>
>>>> Is there a way we can write a coccinelle script to check for this? The
>>>> goal being to find all drivers that are comparing struct clk pointers or
>>>> attempting to dereference them. There are probably other frameworks that
>>>> could use the same type of check (regulator, gpiod, reset, pwm, etc.).
>>>> Probably anything that has a get/put API.
>>> Comparing or dereferencing pointers of a particular type should be
>>> straightforward to check for.  Is there an example of how to use the
>>> parent_index value to fix the problem?
>>>
>> I'm not sure how to fix this case with parent_index values generically.
>> I imagine it would be highly specific to the surrounding code to the
>> point where we couldn't fix it automatically. For example, if it's a clk
>> consumer (not provider like in this case) using an index wouldn't be the
>> right fix. We would need some sort of clk API that we don't currently
>> have and I would wonder why clock consumers even care to compare such
>> pointers in the first place.
> Ack. Is there precedent for a "Don't do that" kind of response?
>
> Regards,
> Mike
>
>> -- 
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
I have found these three cases using Coccinnelle in the mach-omap2
directory.



./arch/arm/mach-omap2/clkt_clksel.c
@@ -67,7 +67,6 @@ static const struct clksel *_get_clksel_
                 return NULL;

         for (clks = clk->clksel; clks->parent; clks++)
                 if (clks->parent == src_clk)
                         break; /* Found the requested parent */

         if (!clks->parent) {
./arch/arm/mach-omap2/dpll3xxx.c
@@ -551,7 +549,6 @@ int omap3_noncore_dpll_set_rate(struct c
         if (!dd)
                 return -EINVAL;

         if (__clk_get_parent(hw->clk) != dd->clk_ref)
                 return -EINVAL;

         if (dd->last_rounded_rate == 0)
./arch/arm/mach-omap2/timer.c
@@ -298,7 +298,6 @@ static int __init omap_dm_timer_init_one
         if (IS_ERR(src))
                 return PTR_ERR(src);

         if (clk_get_parent(timer->fclk) != src) {
                 r = clk_set_parent(timer->fclk, src);
                 if (r < 0) {
                         pr_warn("%s: %s cannot set source\n", __func__,


Are they instances of your issue?
Do you have any suggestion on how to fix them?
If you want me to I can enlarge the search to other directories.


Quentin
