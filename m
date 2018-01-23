From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Tue, 23 Jan 2018 11:25:05 +0200
Message-ID: <CAHp75VetRjLioS1zAubZshggKTiWJ-KJ+HjTSkoK=6LVP6SY2g@mail.gmail.com>
References: <1516575793-30526-1-git-send-email-david@lechnology.com>
 <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com> <d1426fbc-bc82-89cd-d08d-242b16d2c99d@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d1426fbc-bc82-89cd-d08d-242b16d2c99d@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 22, 2018 at 7:06 PM, David Lechner <david@lechnology.com> wrote:
> On 01/22/2018 08:49 AM, Andy Shevchenko wrote:
>> On Mon, Jan 22, 2018 at 1:03 AM, David Lechner <david@lechnology.com>
>> wrote:

>>> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
>>> multiple pins of different modules")

>> One line?

> One line is more important that wrapping to 75 chars?

It's *special* line, i.e. tag. Tag per line is a rule I know, did I
miss any new change to that?

>>> +                       byte_num = (pcs->bits_per_pin * pin) /
>>> BITS_PER_BYTE;
>>> +                       offset = (byte_num / mux_bytes) * mux_bytes;
>>> +                       pin_shift = pin % (pcs->width /
>>> pcs->bits_per_pin) *
>>> +                                   pcs->bits_per_pin;

>> Sounds like playing around pretty well defined macro and functions,
>> e.g. DIV_ROUND_UP(), round_up().

> I admit, I just copied existing code (which may be a reason to leave this
> the
> way it is).

Ah, fair enough.

>  But, I only see once place to do this:
>
>         offset = round_down(byte_num, mux_bytes);
>
> Did I miss another?

I meant that you may use macros to make code cleaner. Though, taking
above into consideration, it would be done as a separate patch later.

-- 
With Best Regards,
Andy Shevchenko
