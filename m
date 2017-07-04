From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
Date: Tue, 4 Jul 2017 08:58:51 -0400
Message-ID: <20170704125851.GA20504@sophia>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ray Jui <rjui@broadcom.com>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, David Cohen <david.a.cohen@linux.intel.com>, Scott Branden <sbranden@broadcom.com>, linux-acpi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Alexander Shiyan <shc_work@mail.ru>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, linux-tegra@vger.kernel.org, Joel Stanley <joel@jms.id.au>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.o
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 04, 2017 at 12:53:34PM +0900, Masahiro Yamada wrote:
>Some of include directives in include/linux/gpio/driver.h are
>unneeded because the header does not need to know the content of
>struct device, irq_chip, etc.  Just declare they are structures.
>
>On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
>turned out to be necessary for irq_flow_handler_t and spinlock_t,
>respectively.
>
>Each driver should include what it needs without relying on what is
>implicitly included from <linux/gpio/driver.h>.  This will cut down
>unnecessary header parsing.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> drivers/gpio/gpio-104-dio-48e.c  |  1 +
> drivers/gpio/gpio-104-idi-48.c   |  1 +
> drivers/gpio/gpio-104-idio-16.c  |  1 +
> drivers/gpio/gpio-pci-idio-16.c  |  2 ++
> drivers/gpio/gpio-ws16c48.c      |  1 +

The changes to the above drivers look fine to me:

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

However, this patch as a whole does too many things; I'd like to see it
split-up logically similar to how Andy Shevchenko suggested in his
reply. That should allow ACKs by respective driver maintainers to be
accounted more properly.

William Breathitt Gray
