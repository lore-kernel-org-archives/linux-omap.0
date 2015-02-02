From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date: Mon, 2 Feb 2015 11:21:17 -0800
Message-ID: <20150202192116.GF9418@atomide.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org>
 <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
 <20150201221856.421.6151@quantum>
 <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
 <20150202161237.GG16250@atomide.com>
 <20150202174646.421.52331@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150202174646.421.52331@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Emilio L??pez <emilio@elopez.com.ar>, Linux-sh list <linux-sh@vger.kernel.org>, Alex Elder <elder@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Matt Porter <mporter@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf
List-Id: linux-omap@vger.kernel.org

* Mike Turquette <mturquette@linaro.org> [150202 09:50]:
> Quoting Tony Lindgren (2015-02-02 08:12:37)
> > 
> > [   10.568206] ------------[ cut here ]------------
> > [   10.568206] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:925 clk_disable+0x28/0x34()
> > [   10.568237] Modules linked in:
> > [   10.568237] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> > [   10.568237] Hardware name: Generic OMAP4 (Flattened Device Tree)
> > [   10.568267] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> > [   10.568267] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> > [   10.568267] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> > [   10.568298] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> > [   10.568298] [<c003eb68>] (warn_slowpath_null) from [<c04c1ffc>] (clk_disable+0x28/0x34)
> > [   10.568328] [<c04c1ffc>] (clk_disable) from [<c0025b3c>] (_disable_clocks+0x18/0x68)
> > [   10.568328] [<c0025b3c>] (_disable_clocks) from [<c0026f14>] (_idle+0x10c/0x214)
> > [   10.568328] [<c0026f14>] (_idle) from [<c0855fac>] (_setup+0x338/0x410)
> > [   10.568359] [<c0855fac>] (_setup) from [<c0027360>] (omap_hwmod_for_each+0x34/0x60)
> > [   10.568359] [<c0027360>] (omap_hwmod_for_each) from [<c08563c4>] (__omap_hwmod_setup_all+0x30/0x40)
> > [   10.568389] [<c08563c4>] (__omap_hwmod_setup_all) from [<c0008a04>] (do_one_initcall+0x80/0x1dc)
> > [   10.568389] [<c0008a04>] (do_one_initcall) from [<c0848ea0>] (kernel_init_freeable+0x204/0x2d0)
> > [   10.568420] [<c0848ea0>] (kernel_init_freeable) from [<c05cdab8>] (kernel_init+0x8/0xec)
> > [   10.568420] [<c05cdab8>] (kernel_init) from [<c000e790>] (ret_from_fork+0x14/0x24)
> > [   10.568420] ---[ end trace cb88537fdc8fa211 ]---

For reference, the above is line 992 in clk-next.

> This looks like mis-matched enable/disable calls. We now have unique
> struct clk pointers for every call to clk_get. I haven't yet looked
> through the hwmod code but I have a feeling that we're doing something
> like this:
> 
> 	/* enable clock */
> 	my_clk = clk_get(...);
> 	clk_prepare_enable(my_clk);
> 	clk_put(my_clk);
> 
> 	/* do some work */
> 	do_work();
> 
> 	/* disable clock */
> 	my_clk = clk_get(...);
> 	clk_disable_unprepare(my_clk);
> 	clk_put(my_clk);
> 
> The above pattern no longer works since my_clk will be two different
> unique pointers, but it really should be one stable pointer across the
> whole usage of the clk. E.g:
> 
> 	/* enable clock */
> 	my_clk = clk_get(...);
> 	clk_prepare_enable(my_clk);
> 
> 	/* do some work */
> 	do_work();
> 
> 	/* disable clock */
> 	clk_disable_unprepare(my_clk);
> 	clk_put(my_clk);
> 
> Again, I haven't looked through the code, so the above is just an
> educated guess.
> 
> Anyways I am testing with an OMAP4460 Panda ES and I didn't see the
> above. Is there a test you are running to get this?

Just booting 4430-sdp with omap2plus_defconfig. And git bisect
points to 59cf3fcf9baf ("clk: Make clk API return per-user struct
clk instances") as you already guessed.
 
> > [   10.568450] ------------[ cut here ]------------
> > [   10.568450] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/dpll3xxx.c:436 omap3_noncore_dpll_enable+0xdc/0
> > x10c()
> > [   10.568450] Modules linked in:
> > [   10.568481] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> > [   10.568481] Hardware name: Generic OMAP4 (Flattened Device Tree)
> > [   10.568481] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> > [   10.568511] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> > [   10.568511] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> > [   10.568511] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> > [   10.568542] [<c003eb68>] (warn_slowpath_null) from [<c0035800>] (omap3_noncore_dpll_enable+0xdc/0x10c)
> > [   10.568542] [<c0035800>] (omap3_noncore_dpll_enable) from [<c04c0a10>] (clk_core_enable+0x60/0x9c)
> > [   10.568572] [<c04c0a10>] (clk_core_enable) from [<c04c09f0>] (clk_core_enable+0x40/0x9c)
> > [   10.568572] ---[ end trace cb88537fdc8fa212 ]---
> > ...
> 
> This is the same issue discussed already in this thread[0]. Feedback
> from Tero & Paul on how to handle it would be nice.

Yes that one is a separate issue.
 
> Please let me know if anything else breaks for you.

Also off-idle on omap3 seems to be broken by commit 59cf3fcf9baf.

Regards,

Tony
