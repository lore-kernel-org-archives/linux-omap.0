From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from include/linux/gpio/driver.h
Date: Wed, 2 Aug 2017 10:19:32 +0900
Message-ID: <CAK7LNASoNWVxJCRneD1GFo41vw0+9oduzLq1Jep_f3ckABfA1A@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <1499162760.22624.246.camel@linux.intel.com> <CACRpkdaxgxaXV8XjLTzu68JqjyeZ8Jr2YMR3L46wm3zmnMrPsg@mail.gmail.com>
 <1501509867.29303.303.camel@linux.intel.com> <CACRpkdZ9q5vub3sQkA2xsQaZ+CGHeAp4RRueposnTPiHoFbSsA@mail.gmail.com>
 <CAHp75VeLwM8Q5vVLeeGz9hL8AWa2J47NTaeX0ogJk6v7y18diw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeLwM8Q5vVLeeGz9hL8AWa2J47NTaeX0ogJk6v7y18diw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Ray Jui <rjui@broadcom.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, David Cohen <david.a.cohen@linux.intel.com>, Scott Branden <sbranden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alexander Shiyan <shc_work@mail.ru>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi.

2017-08-01 20:04 GMT+09:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Tue, Aug 1, 2017 at 10:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Jul 31, 2017 at 4:04 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Mon, 2017-07-31 at 15:48 +0200, Linus Walleij wrote:
>>>> On Tue, Jul 4, 2017 at 12:06 PM, Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>
>>>> > If Linus is okay with the following proposal I would rather go with
>>>> > it,
>>>> > i.e. logical split the series to
>>>> >
>>>> > 1. Fix IRQ related headers inclusion
>>>> > 2. Fix pinconf-generic.h inclusion
>>>> > 3. Fix OF headers inclusion (btw, of_gpio.h is not enough there?)
>>>>
>>>> That works fine with me, but also one big patch actually, I do not
>>>> want to make it too much work to refactor obviously incorrect things.
>>>>
>>>> As soon as we have rough consensus on this and the build robot
>>>> are happy I will apply it to GPIO and also pull it into the pinctrl
>>>> subsystem.
>>>
>>> For me priorities like this:
>>> 1) it works after the patch being applied (no regressions);
>>> 2) it makes code cleaner at the end;
>>> 3) it is presented in logically split parts.
>>>
>>> So, as long as 1) and 2) are satisfied I can neglect on 3).
>>
>> We are in violent agreement :D
>
> What I would like to say is that is up to you after all :-)
> For me looks better to split.



I will split this into sensible chunks.


As I mentioned before, linux/gpio/driver.h is included from several sub-systems,
so I need at least two development cycles to finish this task.


Maybe,

[1] Send patches to subsystems (gpio, pinctrl, etc.) for v4.14
     (splitting into sensible chunks, like per-driver)
[2] Drop unneeded includes from linux/gpio/driver.h for v4.15




-- 
Best Regards
Masahiro Yamada
