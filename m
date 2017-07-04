From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from include/linux/gpio/driver.h
Date: Tue, 4 Jul 2017 19:39:28 +0900
Message-ID: <CAK7LNASmcg5CZ5OSBxakZ2LZgDe1F3RDEtvJ5F9Tk29pXrbQxg@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com> <1499162760.22624.246.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1499162760.22624.246.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Ray Jui <rjui@broadcom.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, David Cohen <david.a.cohen@linux.intel.com>, Scott Branden <sbranden@broadcom.com>, linux-acpi@vger.kernel.org, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alexander Shiyan <shc_work@mail.ru>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, linux-tegra@vger.kernel.org, Joel Stanley <joel@jms.id.au>, linux-omap@vger.kernel.
List-Id: linux-omap@vger.kernel.org

2017-07-04 19:06 GMT+09:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
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

Maybe
  4.  Fix (platform_)device inclusion


But, I do not see much sense to touch headers multiple times.



-- 
Best Regards
Masahiro Yamada
