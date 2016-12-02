From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Fri, 2 Dec 2016 14:08:30 +0100
Message-ID: <CACRpkdZUtqEUQbz7YqtLnYWdOmW4g4q4ikRuqfCwzf5kMR5JDg@mail.gmail.com>
References: <20161025210221.9150-1-tony@atomide.com> <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com> <20161114205243.GU7138@atomide.com>
 <20161114220824.GC4082@atomide.com> <20161115004703.GG4082@atomide.com>
 <CACRpkdZ=pifhHrH_-466f2x3Ev4GKW0CCnTj1hL5Hfpdj5p-1A@mail.gmail.com>
 <20161115154124.GI4082@atomide.com> <20161115170838.GK4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115170838.GK4082@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 15, 2016 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [161115 07:42]:
>> * Linus Walleij <linus.walleij@linaro.org> [161114 22:53]:
>> > On Tue, Nov 15, 2016 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > > 8< --------------------------------
>> > > From tony Mon Sep 17 00:00:00 2001
>> > > From: Tony Lindgren <tony@atomide.com>
>> > > Date: Tue, 25 Oct 2016 08:33:35 -0700
>> > > Subject: [PATCH] pinctrl: core: Use delayed work for hogs
>> > >
>> > > Having the pin control framework call pin controller functions
>> > > before it's probe has finished is not nice as the pin controller
>> > > device driver does not yet have struct pinctrl_dev handle.
>> > >
>> > > Let's fix this issue by adding deferred work for late init. This is
>> > > needed to be able to add pinctrl generic helper functions that expect
>> > > to know struct pinctrl_dev handle. Note that we now need to call
>> > > create_pinctrl() directly as we don't want to add the pin controller
>> > > to the list of controllers until the hogs are claimed. We also need
>> > > to pass the pinctrl_dev to the device tree parser functions as they
>> > > otherwise won't find the right controller at this point.
>> > >
>> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> >
>> > This looks a lot better!
>> >
>> > So if I understand correctly, we can guarantee that the delayed
>> > work will not execute until the device driver probe() has finished,
>> > and it *will* execute immediately after that?
>> >
>> > So:
>> > - Device driver probes
>> > - Delayed work is called
>> > - Next initcall
>> >
>> > I'm not 100% familiar with how delayed work works... :/
>>
>> Yeah well the delayed work gets scheduled for next jiffy but may
>> be pre-empted as it runs in process context.
>>
>> So in the worst case it could that we still may need to fix few
>> drivers to support -EPROBE_DEFER. I wonder if we should check for
>> hogs in probe already and only defer if hogs are defined?
>
> Below is a version using delayed_work only if pinctrl_dt_has_hogs().
>
> Not sure if testing only for pinctrl-0 is enough there though?

Sorry for the lack of attention to this patch set on my part. :(

Do you think you could resend these last 5 patches after the
release of v4.10-rc1 so we merge it early for the next cycle
and people get a chance to test and see if it works well for
everyone?

I'm worried about adding it to the tree this late in the kernel
cycle...

However I like the look of the series overall a lot.

Yours,
Linus Walleij
