From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: "advanced" LED controllers
Date: Tue, 3 Mar 2015 17:15:29 +0900
Message-ID: <CAAVeFuK9eGO2TN+tgDyN8EFzEhgHOy5YCch+LaqS9PNaQXQ4Qg@mail.gmail.com>
References: <20150219211424.GN13603@saruman.tx.rr.com> <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
 <CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com> <20150302092111.GA19233@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302092111.GA19233@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 2, 2015 at 6:21 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2015-02-25 18:06:07, Alexandre Courbot wrote:
>> On Wed, Feb 25, 2015 at 5:25 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > CC linux-gpio, as this looks like the LED equivalent of bulk gpio?
>>
>> Indeed. The LED core could implement something similar to
>> gpiod_set_array() to allow several LEDs to be set in one call. If the
>> controller supports it, it would then set all the LEDs at once,
>> otherwise the core would apply the values serially.
>>
>> In leds-gpio.c, this multiple LED setting could be implemented by a
>> single call to gpiod_set_array() and the right thing would happen.
>
> Actually, there are two issues: some controlles can set all LEDs at
> once, and some can program pwm level smoothly using given program (and
> handle multiple leds in the process).

In any case, that would be handled at the controller level and should
work with a function similar to gpiod_set_array(), wouldn't it?
