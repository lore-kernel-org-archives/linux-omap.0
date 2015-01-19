From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RESEND v8 1/2] clk: Make clk API return per-user struct
 clk instances
Date: Mon, 19 Jan 2015 10:40:04 -0800
Message-ID: <54BD4F84.1010501@codeaurora.org>
References: <1421071809-17402-1-git-send-email-tomeu.vizoso@collabora.com> <1421071809-17402-2-git-send-email-tomeu.vizoso@collabora.com> <20150117010238.GA27202@codeaurora.org> <CAAObsKAc6kqgBdWpAvAc2fDW42jNtT1hCD_uL8ums0hHCTXgng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKAc6kqgBdWpAvAc2fDW42jNtT1hCD_uL8ums0hHCTXgng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 01/19/2015 01:55 AM, Tomeu Vizoso wrote:
> On 17 January 2015 at 02:02, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 01/12, Tomeu Vizoso wrote:
>>
>>> +}
>>>  EXPORT_SYMBOL_GPL(__clk_get_rate);
>>>
>>> @@ -630,7 +656,12 @@ out:
>>>       return !!ret;
>>>  }
>>>
>>> -bool __clk_is_enabled(struct clk *clk)
>>> +bool __clk_is_prepared(struct clk *clk)
>>> +{
>>> +     return clk_core_is_prepared(clk->core);
>> Oops. clk can be NULL here. Return false if so. Or drop the
>> function entirely? It looks like it may become unused.
> Are you thinking of anything specific that the alchemy arch can do
> instead of calling __clk_is_prepared?
>
>

Ah I missed that one. Bad grep.

>>> +}
>>>  EXPORT_SYMBOL_GPL(__clk_is_enabled);
>>>
>>> @@ -762,7 +805,12 @@ void __clk_unprepare(struct clk *clk)
>>>       if (clk->ops->unprepare)
>>>               clk->ops->unprepare(clk->hw);
>>>
>>> -     __clk_unprepare(clk->parent);
>>> +     clk_core_unprepare(clk->parent);
>>> +}
>>> +
>>> +void __clk_unprepare(struct clk *clk)
>>> +{
>>> +     clk_core_unprepare(clk->core);
>> OOps. clk can be NULL here. Bail early if so.
> Actually, looks like nobody is using __clk_prepare nor __clk_unprepare
> so I'm removing these.
>

Ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
