From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date: Thu, 29 Jan 2015 11:13:38 -0800
Message-ID: <54CA8662.7040008@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>	<1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com> <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mike Turquette <mturquette@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Manuel Lauss <manuel.lauss@gmail.com>, Alex Elder <elder@linaro.org>, Matt Porter <mporter@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Chao Xie <chao.xie@marvell.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 01/29/15 05:31, Geert Uytterhoeven wrote:
> Hi Tomeu, Mike,
>
> On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
>>         return 1;
>>  }
>>
>> -static void clk_core_put(struct clk_core *core)
>> +void __clk_put(struct clk *clk)
>>  {
>>         struct module *owner;
>>
>> -       owner = core->owner;
>> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> +               return;
>>
>>         clk_prepare_lock();
>> -       kref_put(&core->ref, __clk_release);
>> +
>> +       hlist_del(&clk->child_node);
>> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> At this point, clk->core->req_rate is still zero, causing
> cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
> e.g. on r8a7791:

Hmm.. I wonder if we should assign core->req_rate to be the same as
core->rate during __clk_init()? That would make this call to
clk_core_set_rate_nolock() a nop in this case.

>
> cpg_div6_clock_round_rate: clock sd2 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock sd1 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock mmc0 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock sd1 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock sd1 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock sd2 rate 0 parent_rate 780000000 div 1
> cpg_div6_clock_round_rate: clock sd2 rate 0 parent_rate 780000000 div 1
>
> and cpg_div6_clock_calc_div() is called to calculate
>
>         div = DIV_ROUND_CLOSEST(parent_rate, rate);
>
> Why was this call to clk_core_set_rate_nolock() in __clk_put() added?
> Before, there was no rate setting done at this point, and
> cpg_div6_clock_round_rate() was not called.

We need to call clk_core_set_rate_nolock() here to drop any min/max rate
request that this consumer has.

>
> Have the semantics changed? Should .round_rate() be ready to
> accept a "zero" rate, and use e.g. the current rate instead?

It seems like we've also exposed a bug in cpg_div6_clock_calc_div().
Technically any driver could have called clk_round_rate() with a zero
rate before this change and that would have caused the same division by
zero.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

