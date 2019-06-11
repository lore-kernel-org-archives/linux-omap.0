From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-next 00/20]  gpio: gpio-omap: set of fixes and big
 clean-up
Date: Tue, 11 Jun 2019 00:37:20 -0700
Message-ID: <20190611073720.GB5447@atomide.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [190610 10:11]:
> Hi Linus, Russell, Tony, All,
> 
> This series contains set of patches from Russell King which were circulated
> internally for quite some time already and I fill it's reasonable to move
> future discussion upstream (and also avoid rebasing).
> Fisrt two patches are fixes and the rest are big, great clean up
> from Russell King.
> 
> Personally, I like this clean up and refactoring very much and don't want
> it to be lost.

Adding Aaro to Cc too hopefully for more testing. Yes this is very nice
and behaves for my idle test cases. I've also boot tested omap1 osk and
it still works just fine for NFSroot.

FYI, after this series, the only issue I'm aware of still remaining
is the lost edge wake-up interrupts for L4 PER idle that I posted a WIP
fix as "[PATCH] gpio: gpio-omap: Fix lost edge wake-up interrupts".
But that one still needs a bit more work and is a separate fix from this
series.

So for this whole series, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>



> Code can be found at:
>  git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git
> branch:
>  lkml-next-gpio-clean-up
> 
> Russell King (20):
>   gpio: gpio-omap: ensure irq is enabled before wakeup
>   gpio: gpio-omap: fix lack of irqstatus_raw0 for OMAP4
>   gpio: gpio-omap: remove remainder of list management
>   gpio: gpio-omap: clean up edge interrupt handling
>   gpio: gpio-omap: remove irq_ack method
>   gpio: gpio-omap: move omap_gpio_request() and omap_gpio_free()
>   gpio: gpio-omap: simplify omap_gpio_get_direction()
>   gpio: gpio-omap: simplify get() method
>   gpio: gpio-omap: simplify get_multiple()
>   gpio: gpio-omap: simplify set_multiple()
>   gpio: gpio-omap: simplify bank->level_mask
>   gpio: gpio-omap: simplify read-modify-write
>   gpio: gpio-omap: simplify omap_toggle_gpio_edge_triggering()
>   gpio: gpio-omap: simplify omap_set_gpio_irqenable()
>   gpio: gpio-omap: remove dataout variation in context handling
>   gpio: gpio-omap: clean up omap_gpio_restore_context()
>   gpio: gpio-omap: constify register tables
>   gpio: gpio-omap: clean up wakeup handling
>   gpio: gpio-omap: irq_startup() must not return error codes
>   gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()
> 
>  drivers/gpio/gpio-omap.c                | 497 ++++++++----------------
>  include/linux/platform_data/gpio-omap.h |   2 +-
>  2 files changed, 161 insertions(+), 338 deletions(-)
> 
> -- 
> 2.17.1
> 
