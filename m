From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v9 3/3] clk: Add floor and ceiling constraints to clock rates
Date: Tue, 20 Jan 2015 14:04:10 +0100
Message-ID: <CAAObsKAUc9wrQ+uj-tmQA+HrnRjUD1qXRmytGV9WT0ySZ6VJpA@mail.gmail.com>
References: <1421688067-24426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421688067-24426-4-git-send-email-tomeu.vizoso@collabora.com> <20150120000019.GD27202@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150120000019.GD27202@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Manuel Lauss <manuel.lauss@gmail.com>, Alex Elder <elder@linaro.org>, Matt Porter <mporter@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bintian Wang <bintian.wang@huawei.com>, Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.i
List-Id: linux-omap@vger.kernel.org

On 20 January 2015 at 01:00, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/19, Tomeu Vizoso wrote:
>> Adds a way for clock consumers to set maximum and minimum rates. This can be
>> used for thermal drivers to set ceiling rates, or by misc. drivers to set
>> floor rates to assure a minimum performance level.
>>
>> Changes the signature of the determine_rate callback by adding the
>> parameters floor_rate and ceiling_rate.
>
> Commit text needs the s/floor/min and s/ceiling/max treatment
> too.
>
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index f2a1ff3..55b3124 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1026,6 +1051,28 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>>       else
>>               return clk->rate;
>>  }
>> +unsigned long __clk_determine_rate(struct clk_hw *hw,
>> +                                unsigned long rate,
>> +                                unsigned long min_rate,
>> +                                unsigned long max_rate)
>> +{
>> +     unsigned long parent_rate = 0;
>> +     struct clk_core *core = hw->core;
>> +     struct clk_hw *parent_hw;
>> +
>> +     if (!core->ops->determine_rate)
>> +             return 0;
>> +
>> +     if (core->parent) {
>> +             parent_rate = core->parent->rate;
>> +             parent_hw = core->parent->hw;
>> +     }
>> +
>> +     return core->ops->determine_rate(core->hw, rate,
>> +                                     min_rate, max_rate,
>> +                                     &parent_rate, &parent_hw);
>> +}
>> +EXPORT_SYMBOL_GPL(__clk_determine_rate);
>
> Maybe I misled you with the API name. I was thinking more along
> the lines of clk_round_rate() and this new function ending up
> calling clk_core_round_rate(), but clk_round_rate() would call it
> with whatever range the clock is constrained to while this new
> function would allow driver authors to specify the range. It
> should be easy enough to add min/max to clk_core_round_rate()
> given that it's a private API in this file.

Yeah, I wasn't sure whether it made sense for __clk_determine_rate to
have the fallbacks because any caller would need to have checked that
the clock implementation supports determine_rate and is aware of the
rate constraints.

As long as people don't get confused, I'm fine with any of the possibilities.

Regards,

Tomeu

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
