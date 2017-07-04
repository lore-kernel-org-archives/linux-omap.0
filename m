From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from include/linux/gpio/driver.h
Date: Tue, 4 Jul 2017 18:51:36 +0300
Message-ID: <CAHp75VcfDdSCoU=DZyF1BD0YX9KfmLnptnHU9fgBQY3g-NW7PQ@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <20170704125851.GA20504@sophia> <CAK7LNATRrngmVFPDSKmUm3Td7RXnSZSPGNF9Ds_y+DU=i7mRag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATRrngmVFPDSKmUm3Td7RXnSZSPGNF9Ds_y+DU=i7mRag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ray Jui <rjui@broadcom.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, David Cohen <david.a.cohen@linux.intel.com>, Scott Branden <sbranden@broadcom.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alexander Shiyan <shc_work@mail.ru>, Michal Simek <michal.simek@xilinx.com>, Kev
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 4, 2017 at 6:43 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-07-04 21:58 GMT+09:00 William Breathitt Gray <vilhelm.gray@gmail.com>:

> So, I need to think about how to merge this (if the basic idea of this is OK).
>
> Maybe,
>
> [1] Send patches to subsystems (gpio, pinctrl, etc.) for v4.14
> [2] Drop unneeded includes from linux/gpio/driver.h for v4.15

Perhaps, fixing users (drivers!) first. then frameworks / libraries,
at last header itself (in each case perhaps follow the split I
proposed earlier).

My wish is to get gpiolib-acpi patch completely separate from the bunch.

-- 
With Best Regards,
Andy Shevchenko
