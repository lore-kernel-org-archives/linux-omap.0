From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH] gpio: drop unnecessary includes from include/linux/gpio/driver.h
Date: Wed, 5 Jul 2017 00:43:08 +0900
Message-ID: <CAK7LNATRrngmVFPDSKmUm3Td7RXnSZSPGNF9Ds_y+DU=i7mRag@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com> <20170704125851.GA20504@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170704125851.GA20504@sophia>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: William Breathitt Gray <vilhelm.gray-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Broadcom Kernel Feedback List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kerne>
List-Id: linux-omap@vger.kernel.org

2017-07-04 21:58 GMT+09:00 William Breathitt Gray <vilhelm.gray-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Tue, Jul 04, 2017 at 12:53:34PM +0900, Masahiro Yamada wrote:
>>Some of include directives in include/linux/gpio/driver.h are
>>unneeded because the header does not need to know the content of
>>struct device, irq_chip, etc.  Just declare they are structures.
>>
>>On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
>>turned out to be necessary for irq_flow_handler_t and spinlock_t,
>>respectively.
>>
>>Each driver should include what it needs without relying on what is
>>implicitly included from <linux/gpio/driver.h>.  This will cut down
>>unnecessary header parsing.
>>
>>Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
>>---
>>
>> drivers/gpio/gpio-104-dio-48e.c  |  1 +
>> drivers/gpio/gpio-104-idi-48.c   |  1 +
>> drivers/gpio/gpio-104-idio-16.c  |  1 +
>> drivers/gpio/gpio-pci-idio-16.c  |  2 ++
>> drivers/gpio/gpio-ws16c48.c      |  1 +
>
> The changes to the above drivers look fine to me:
>
> Acked-by: William Breathitt Gray <vilhelm.gray-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> However, this patch as a whole does too many things; I'd like to see it
> split-up logically similar to how Andy Shevchenko suggested in his
> reply. That should allow ACKs by respective driver maintainers to be
> accounted more properly.
>
> William Breathitt Gray


I was missing a very important thing.

<linux/gpio/driver.h> is used in various subsystems.

I tested only under drivers/gpio/, but
drivers/pinctrl/ is one of the biggest source of compile errors.

(Probably I will get reports from kbuild test robot.)


So, I need to think about how to merge this (if the basic idea of this is OK).

Maybe,

[1] Send patches to subsystems (gpio, pinctrl, etc.) for v4.14
[2] Drop unneeded includes from linux/gpio/driver.h for v4.15


-- 
Best Regards
Masahiro Yamada
