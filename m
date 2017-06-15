From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [GIT PULL] clk: ti: clkctrl support for 4.13 merge window
Date: Thu, 15 Jun 2017 11:12:36 +0300
Message-ID: <f8bff2f4-55ce-bee1-9362-28f4f90fad03@ti.com>
References: <6d66f78a-5d39-6396-c492-b79a687ce58a@ti.com>
 <20170614173237.GB20170@codeaurora.org>
 <ee8f9ff4-831c-1999-175e-12608a954cfb@ti.com>
 <20170614174910.GD20170@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170614174910.GD20170@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 14/06/17 20:49, Stephen Boyd wrote:
> On 06/14, Tero Kristo wrote:
>> On 14/06/17 20:32, Stephen Boyd wrote:
>>> On 06/08, Tero Kristo wrote:
>>>> Hi Stephen, Mike,
>>>>
>>>> This pull contains the v3 of the clkctrl base driver support posted
>>>> couple of weeks back, with Tony's acks added to patch #2 and #4.
>>>>
>>>> -Tero
>>>>
>>>
>>> drivers/clk/ti/clkctrl.c:252
>>> _ti_clkctrl_clk_register() warn: possible memory leak of 'clkctrl_clk'
>>> drivers/clk/ti/clkctrl.c:264
>>> _ti_clkctrl_clk_register() warn: possible memory leak of 'clkctrl_clk'
>>> drivers/clk/ti/clkctrl.c:466
>>> _ti_omap4_clkctrl_setup() warn: possible memory leak of 'clkctrl_clk'
>>> drivers/clk/ti/clkctrl.c:473
>>> _ti_omap4_clkctrl_setup() warn: possible memory leak of 'clkctrl_clk'
>>>
>>> Can these be silenced with some follow up patch? I'll hold off on
>>> the pull until you can take a look.
>>>
>>
>> What is the tool you use to get these?
>>
>> They seem like valid warnings though, some cleanup could be used for
>> the dynamic memory handling. I'll fix these tomorrow.
>>
> 
> I use smatch[1] although I don't always have the most up to date
> version.
> 
> [1] git://repo.or.cz/smatch.git
> 

Ok thanks, fixed and posted a new version of patch #2 of the series. 
Also force pushed this branch with the updated version in case you want 
to use this.

-Tero
