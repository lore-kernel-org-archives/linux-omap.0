From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date: Mon, 02 Feb 2015 09:46:46 -0800
Message-ID: <20150202174646.421.52331@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org> <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
 <20150201221856.421.6151@quantum>
 <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
 <20150202161237.GG16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51617 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbbBBRqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 12:46:51 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so20140869igk.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2015 09:46:51 -0800 (PST)
In-Reply-To: <20150202161237.GG16250@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Emilio L??pez <emilio@elopez.com.ar>, Linux-sh list <linux-sh@vger.kernel.org>, Alex Elder <elder@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Matt Porter <mporter@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-m>

Quoting Tony Lindgren (2015-02-02 08:12:37)
> * Geert Uytterhoeven <geert@linux-m68k.org> [150202 00:03]:
> > On Sun, Feb 1, 2015 at 11:18 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > > Quoting Tomeu Vizoso (2015-01-31 10:36:22)
> > >> On 31 January 2015 at 02:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > >> > On 01/29, Stephen Boyd wrote:
> > >> >> On 01/29/15 05:31, Geert Uytterhoeven wrote:
> > >> >> > Hi Tomeu, Mike,
> > >> >> >
> > >> >> > On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
> > >> >> > <tomeu.vizoso@collabora.com> wrote:
> > >> >> >> --- a/drivers/clk/clk.c
> > >> >> >> +++ b/drivers/clk/clk.c
> > >> >> >> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
> > >> >> >>         return 1;
> > >> >> >>  }
> > >> >> >>
> > >> >> >> -static void clk_core_put(struct clk_core *core)
> > >> >> >> +void __clk_put(struct clk *clk)
> > >> >> >>  {
> > >> >> >>         struct module *owner;
> > >> >> >>
> > >> >> >> -       owner = core->owner;
> > >> >> >> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> > >> >> >> +               return;
> > >> >> >>
> > >> >> >>         clk_prepare_lock();
> > >> >> >> -       kref_put(&core->ref, __clk_release);
> > >> >> >> +
> > >> >> >> +       hlist_del(&clk->child_node);
> > >> >> >> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> > >> >> > At this point, clk->core->req_rate is still zero, causing
> > >> >> > cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
> > >> >> > e.g. on r8a7791:
> > >> >>
> > >> >> Hmm.. I wonder if we should assign core->req_rate to be the same as
> > >> >> core->rate during __clk_init()? That would make this call to
> > >> >> clk_core_set_rate_nolock() a nop in this case.
> > >> >>
> > >> >
> > >> > Here's a patch to do this
> > >> >
> > >> > ---8<----
> > >> > From: Stephen Boyd <sboyd@codeaurora.org>
> > >> > Subject: [PATCH] clk: Assign a requested rate by default
> > >> >
> > >> > We need to assign a requested rate here so that we avoid
> > >> > requesting a rate of 0 on clocks when we remove clock consumers.
> > >>
> > >> Hi, this looks good to me.
> > >>
> > >> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > >
> > > It seems to fix the total boot failure on OMAPs, and hopefully does the
> > > same for SH Mobile and others. I've squashed this into Tomeu's rate
> > > constraints patch to maintain bisect.
> > 
> > Yes, it fixes shmobile. .round_rate() is now called with a sane value of rate.
> 
> Looks like next-20150202 now produces tons of the following errors,
> these from omap4:

next-20150202 is the rolled-back changes from last Friday. I removed the
clock constraints patch and in doing so also rolled back the TI clock
driver migration and clk-private.h removal patches. Those are all back
in clk-next as of last night and it looks as though they missed being
pulled into todays linux-next by a matter of minutes :-/

> 
> [   10.568206] ------------[ cut here ]------------
> [   10.568206] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:925 clk_disable+0x28/0x34()
> [   10.568237] Modules linked in:
> [   10.568237] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> [   10.568237] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [   10.568267] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> [   10.568267] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> [   10.568267] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> [   10.568298] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> [   10.568298] [<c003eb68>] (warn_slowpath_null) from [<c04c1ffc>] (clk_disable+0x28/0x34)
> [   10.568328] [<c04c1ffc>] (clk_disable) from [<c0025b3c>] (_disable_clocks+0x18/0x68)
> [   10.568328] [<c0025b3c>] (_disable_clocks) from [<c0026f14>] (_idle+0x10c/0x214)
> [   10.568328] [<c0026f14>] (_idle) from [<c0855fac>] (_setup+0x338/0x410)
> [   10.568359] [<c0855fac>] (_setup) from [<c0027360>] (omap_hwmod_for_each+0x34/0x60)
> [   10.568359] [<c0027360>] (omap_hwmod_for_each) from [<c08563c4>] (__omap_hwmod_setup_all+0x30/0x40)
> [   10.568389] [<c08563c4>] (__omap_hwmod_setup_all) from [<c0008a04>] (do_one_initcall+0x80/0x1dc)
> [   10.568389] [<c0008a04>] (do_one_initcall) from [<c0848ea0>] (kernel_init_freeable+0x204/0x2d0)
> [   10.568420] [<c0848ea0>] (kernel_init_freeable) from [<c05cdab8>] (kernel_init+0x8/0xec)
> [   10.568420] [<c05cdab8>] (kernel_init) from [<c000e790>] (ret_from_fork+0x14/0x24)
> [   10.568420] ---[ end trace cb88537fdc8fa211 ]---

This looks like mis-matched enable/disable calls. We now have unique
struct clk pointers for every call to clk_get. I haven't yet looked
through the hwmod code but I have a feeling that we're doing something
like this:

	/* enable clock */
	my_clk = clk_get(...);
	clk_prepare_enable(my_clk);
	clk_put(my_clk);

	/* do some work */
	do_work();

	/* disable clock */
	my_clk = clk_get(...);
	clk_disable_unprepare(my_clk);
	clk_put(my_clk);

The above pattern no longer works since my_clk will be two different
unique pointers, but it really should be one stable pointer across the
whole usage of the clk. E.g:

	/* enable clock */
	my_clk = clk_get(...);
	clk_prepare_enable(my_clk);

	/* do some work */
	do_work();

	/* disable clock */
	clk_disable_unprepare(my_clk);
	clk_put(my_clk);

Again, I haven't looked through the code, so the above is just an
educated guess.

Anyways I am testing with an OMAP4460 Panda ES and I didn't see the
above. Is there a test you are running to get this?

> 
> 
> [   10.568450] ------------[ cut here ]------------
> [   10.568450] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/dpll3xxx.c:436 omap3_noncore_dpll_enable+0xdc/0
> x10c()
> [   10.568450] Modules linked in:
> [   10.568481] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> [   10.568481] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [   10.568481] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> [   10.568511] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> [   10.568511] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> [   10.568511] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> [   10.568542] [<c003eb68>] (warn_slowpath_null) from [<c0035800>] (omap3_noncore_dpll_enable+0xdc/0x10c)
> [   10.568542] [<c0035800>] (omap3_noncore_dpll_enable) from [<c04c0a10>] (clk_core_enable+0x60/0x9c)
> [   10.568572] [<c04c0a10>] (clk_core_enable) from [<c04c09f0>] (clk_core_enable+0x40/0x9c)
> [   10.568572] ---[ end trace cb88537fdc8fa212 ]---
> ...

This is the same issue discussed already in this thread[0]. Feedback
from Tero & Paul on how to handle it would be nice.

Please let me know if anything else breaks for you.

Regards,
Mike

> 
> Regards,
> 
> Tony
