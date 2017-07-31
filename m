From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] gpio: drop unnecessary includes from include/linux/gpio/driver.h
Date: Mon, 31 Jul 2017 15:48:34 +0200
Message-ID: <CACRpkdaxgxaXV8XjLTzu68JqjyeZ8Jr2YMR3L46wm3zmnMrPsg@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com> <1499162760.22624.246.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499162760.22624.246.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, William Breathitt Gray <vilhelm.gray-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <lin>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 4, 2017 at 12:06 PM, Andy Shevchenko
<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Tue, 2017-07-04 at 12:53 +0900, Masahiro Yamada wrote:
>> Some of include directives in include/linux/gpio/driver.h are
>> unneeded because the header does not need to know the content of
>> struct device, irq_chip, etc.  Just declare they are structures.
>>
>> On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
>> turned out to be necessary for irq_flow_handler_t and spinlock_t,
>> respectively.
>>
>> Each driver should include what it needs without relying on what is
>> implicitly included from <linux/gpio/driver.h>.  This will cut down
>> unnecessary header parsing.
>
> If Linus is okay with the following proposal I would rather go with it,
> i.e. logical split the series to
>
> 1. Fix IRQ related headers inclusion
> 2. Fix pinconf-generic.h inclusion
> 3. Fix OF headers inclusion (btw, of_gpio.h is not enough there?)

That works fine with me, but also one big patch actually, I do not
want to make it too much work to refactor obviously incorrect things.

As soon as we have rough consensus on this and the build robot
are happy I will apply it to GPIO and also pull it into the pinctrl
subsystem.

Yours,
Linus Walleij
