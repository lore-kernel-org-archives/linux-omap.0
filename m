From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: "advanced" LED controllers
Date: Wed, 25 Feb 2015 18:06:07 +0900
Message-ID: <CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com>
References: <20150219211424.GN13603@saruman.tx.rr.com> <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 25, 2015 at 5:25 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> CC linux-gpio, as this looks like the LED equivalent of bulk gpio?

Indeed. The LED core could implement something similar to
gpiod_set_array() to allow several LEDs to be set in one call. If the
controller supports it, it would then set all the LEDs at once,
otherwise the core would apply the values serially.

In leds-gpio.c, this multiple LED setting could be implemented by a
single call to gpiod_set_array() and the right thing would happen.

>
> On Thu, Feb 19, 2015 at 10:14 PM, Felipe Balbi <balbi@ti.com> wrote:
>> Do we have support for LED controllers which can handle patterns of
>> different kinds ? I mean, currently, if we have an LED controller such
>> as TPIC2810 [1] which can control 8 different leds and each LED
>> corresponds to one bit on register 0x44, we could control leds by just
>> "playing" a wave file on the controller and create easy patterns with
>> that.
>>
>> AFAICT, in linux today we would have to register each of the 8 LEDs as a
>> different LED and have driver magic to write the proper bits on register
>> 0x44, that seems a bit overkill, specially when we want to make
>> patterns: instead of writing 0xff we would have to write 0x80, 0x40,
>> 0x20, 0x10, 0x08, 0x04, 0x02, 0x01 separately and have the driver cache
>> the previous results so we don't end up switching off other LEDs.
>>
>> IOW, what could be handled with a single write, currently needs 8.
>>
>> I wonder if there's any work happening to support these slightly more
>> inteligent LED engines.
>>
>> regards
>>
>> [1] http://www.ti.com/product/tpic2810
>>
>> ps: tpic2810 is probably the simplest example, lp551, lp5523 and others
>> have even more advanced pattern engines which can even handle RGB leds.
>>
>> Currently the driver loads patterns as if it was a firmware blob and
>> registers each of R, G and B components as separate LEDs. Each component
>> also has its own brightness controls (something tpic2810 doesn't have,
>> it's either on or off).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
