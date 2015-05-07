From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer
 clock
Date: Thu, 7 May 2015 07:44:37 -0700
Message-ID: <20150507144437.GA15563@atomide.com>
References: <1430848941-27106-1-git-send-email-tony@atomide.com>
 <20150506053539.GA10871@codeaurora.org>
 <20150506145539.GI21061@atomide.com>
 <554AB1E3.2000304@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49701 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbbEGOok (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2015 10:44:40 -0400
Content-Disposition: inline
In-Reply-To: <554AB1E3.2000304@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

* Stephen Boyd <sboyd@codeaurora.org> [150506 17:30]:
> On 05/06/15 07:55, Tony Lindgren wrote:
> >> I don't think the coccinelle script was ever merged...
>
> > Oh OK, but the wrong comparisons in the kernel code got
> > fixed, right? 
> 
> Yes the ones that mattered were fixed.

OK thanks for confirming that.
 
> > Thanks here's an updated version with that.
> 
> Are you taking this through arm-soc?

Yes that's the plan.
 
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -298,7 +298,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
> >  	if (IS_ERR(src))
> >  		return PTR_ERR(src);
> >  
> > -	if (clk_get_parent(timer->fclk) != src) {
> > +	if (!clk_is_match(clk_get_parent(timer->fclk), src)) {
> >  		r = clk_set_parent(timer->fclk, src);
> 
> I also wonder why we can't just call clk_set_parent() and skip the "is
> the parent already src" check?
> 
> If there's a good reason for not just calling clk_set_parent() then it
> makes sense to do the clk_is_match() thing, and you can have my ack
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Good point. We've been unconditionally calling it anyways and
nobody has complained of any issues. So let's just remove the
check.

Regards,

Tony

8< ----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 May 2015 09:03:34 -0700
Subject: [PATCH] ARM: OMAP2+: Remove bogus struct clk comparison for timer
 clock

With recent changes to use determine_rate, the comparison of two
clocks won't work without clk_is_match that does __clk_get_hw
on the clocks first.

As we've been unconditionally already calling clk_set_parent
already because of the bogus comparison, let's just remove the
check as suggested by Stephen Boyd <sboyd@codeaurora.org>.

Cc: Michael Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -298,14 +298,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
-	if (clk_get_parent(timer->fclk) != src) {
-		r = clk_set_parent(timer->fclk, src);
-		if (r < 0) {
-			pr_warn("%s: %s cannot set source\n", __func__,
-				oh->name);
-			clk_put(src);
-			return r;
-		}
+	r = clk_set_parent(timer->fclk, src);
+	if (r < 0) {
+		pr_warn("%s: %s cannot set source\n", __func__, oh->name);
+		clk_put(src);
+		return r;
 	}
 
 	clk_put(src);
