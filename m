From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Wed, 04 Feb 2015 15:26:19 -0800
Message-ID: <54D2AA9B.7010800@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D0F179.1040906@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/03/15 08:04, Quentin Lambert wrote:
> Hello,
> Julia asked me to have a look and see if I can help.
>
> I have found these three cases using Coccinnelle in the mach-omap2
> directory.
>
>
>
> ./arch/arm/mach-omap2/clkt_clksel.c
> @@ -67,7 +67,6 @@ static const struct clksel *_get_clksel_
>                 return NULL;
>
>         for (clks = clk->clksel; clks->parent; clks++)
>                 if (clks->parent == src_clk)

This probably needs to compare hw pointers again given that it's in the
clk-provider code. It would be nice if we could use indices instead though.

>                         break; /* Found the requested parent */
>
>         if (!clks->parent) {
> ./arch/arm/mach-omap2/dpll3xxx.c
> @@ -551,7 +549,6 @@ int omap3_noncore_dpll_set_rate(struct c
>         if (!dd)
>                 return -EINVAL;
>
>         if (__clk_get_parent(hw->clk) != dd->clk_ref)

This one is what this thread has started on about. Comparing hw pointers
is ok for now...

>                 return -EINVAL;
>
>         if (dd->last_rounded_rate == 0)
> ./arch/arm/mach-omap2/timer.c
> @@ -298,7 +298,6 @@ static int __init omap_dm_timer_init_one
>         if (IS_ERR(src))
>                 return PTR_ERR(src);
>
>         if (clk_get_parent(timer->fclk) != src) {

This one looks like an optimization. We can just always try to set the
parent and if it's already the current parent then the core should bail
out early without an error. So the fix would be to just remove the if
condition.

>                 r = clk_set_parent(timer->fclk, src);
>                 if (r < 0) {
>                         pr_warn("%s: %s cannot set source\n", __func__,
>
>
> Are they instances of your issue?

Yes these all look like instances of the problem.

> If you want me to I can enlarge the search to other directories.

Yes please do. And if you could share the coccinelle patch that would be
great. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
