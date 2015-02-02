From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date: Mon, 2 Feb 2015 08:59:57 +0100
Message-ID: <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
	<1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
	<CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
	<54CA8662.7040008@codeaurora.org>
	<20150131013158.GA4323@codeaurora.org>
	<CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
	<20150201221856.421.6151@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150201221856.421.6151@quantum>
Sender: linux-doc-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Emilio L??pez <emilio@elopez.com.ar>, Linux-sh list <linux-sh@vger.kernel.org>, Alex Elder <elder@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Matt Porter <mporter@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@>
List-Id: linux-omap@vger.kernel.org

On Sun, Feb 1, 2015 at 11:18 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Tomeu Vizoso (2015-01-31 10:36:22)
>> On 31 January 2015 at 02:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 01/29, Stephen Boyd wrote:
>> >> On 01/29/15 05:31, Geert Uytterhoeven wrote:
>> >> > Hi Tomeu, Mike,
>> >> >
>> >> > On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
>> >> > <tomeu.vizoso@collabora.com> wrote:
>> >> >> --- a/drivers/clk/clk.c
>> >> >> +++ b/drivers/clk/clk.c
>> >> >> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
>> >> >>         return 1;
>> >> >>  }
>> >> >>
>> >> >> -static void clk_core_put(struct clk_core *core)
>> >> >> +void __clk_put(struct clk *clk)
>> >> >>  {
>> >> >>         struct module *owner;
>> >> >>
>> >> >> -       owner = core->owner;
>> >> >> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> >> >> +               return;
>> >> >>
>> >> >>         clk_prepare_lock();
>> >> >> -       kref_put(&core->ref, __clk_release);
>> >> >> +
>> >> >> +       hlist_del(&clk->child_node);
>> >> >> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
>> >> > At this point, clk->core->req_rate is still zero, causing
>> >> > cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
>> >> > e.g. on r8a7791:
>> >>
>> >> Hmm.. I wonder if we should assign core->req_rate to be the same as
>> >> core->rate during __clk_init()? That would make this call to
>> >> clk_core_set_rate_nolock() a nop in this case.
>> >>
>> >
>> > Here's a patch to do this
>> >
>> > ---8<----
>> > From: Stephen Boyd <sboyd@codeaurora.org>
>> > Subject: [PATCH] clk: Assign a requested rate by default
>> >
>> > We need to assign a requested rate here so that we avoid
>> > requesting a rate of 0 on clocks when we remove clock consumers.
>>
>> Hi, this looks good to me.
>>
>> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> It seems to fix the total boot failure on OMAPs, and hopefully does the
> same for SH Mobile and others. I've squashed this into Tomeu's rate
> constraints patch to maintain bisect.

Yes, it fixes shmobile. .round_rate() is now called with a sane value of rate.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
