From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
Date: Tue, 1 Aug 2017 13:57:59 -0500
Message-ID: <b79f450d-f4a7-003d-4542-b5d5e4ab4483@linux.intel.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-gpio@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Ray Jui <rjui@broadcom.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, David Cohen <david.a.cohen@linux.intel.com>, Scott Branden <sbranden@broadcom.com>, linux-acpi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alexander Shiyan <shc_work@mail.ru>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, linux-tegra@vger.kernel.org, Joel Stanley <joel@jms.id.au>, linux-omap@vger.kernel.org, linux-arm-k
List-Id: linux-omap@vger.kernel.org

On 07/03/2017 10:53 PM, Masahiro Yamada wrote:
> Some of include directives in include/linux/gpio/driver.h are
> unneeded because the header does not need to know the content of
> struct device, irq_chip, etc.  Just declare they are structures.
> 
> On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
> turned out to be necessary for irq_flow_handler_t and spinlock_t,
> respectively.
> 
> Each driver should include what it needs without relying on what is
> implicitly included from <linux/gpio/driver.h>.  This will cut down
> unnecessary header parsing.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>   drivers/gpio/gpio-altera-a10sr.c |  2 ++
>   drivers/gpio/gpio-altera.c       |  3 +++

For the Altera GPIO files:

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
