From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Thu, 26 May 2011 21:24:39 -0600
Message-ID: <20110527032439.GK5032@ponder.secretlab.ca>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:59100 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1E0DYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 23:24:41 -0400
Received: by pxi16 with SMTP id 16so824921pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 20:24:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
> Start moving SoC-specific register handling out of the driver by passing
> in register offsets in via platform data.
> 
> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
> 
> Applies on top of Tony's for-next branch (which include's the generic
> IRQ chip work from tglx) and the OMAP GPIO driver move to
> drivers/gpio.

Hey Kevin,

If you've got a branch with this series in it and tested, then I'd be
happy to pull that instead of applying the patches myself.

g.

> 
> Charulatha V (1):
>   GPIO: OMAP: remove get_gpio_bank()
> 
> Kevin Hilman (13):
>   GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
>   GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
>   GPIO: OMAP: move bank width into struct gpio_bank
>   GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with
>     bank->width
>   GPIO: OMAP: replace get_gpio_index() by using bank width
>   GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
>   GPIO: OMAP: consolidate IRQ status handling, remove #ifdefs
>   GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
>   GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
>   GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
>   GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
>   GPIO: OMAP: debounce remove SoC specific registers, use pdata
>   GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only
>     once
> 
>  arch/arm/mach-omap1/gpio15xx.c         |   22 +
>  arch/arm/mach-omap1/gpio16xx.c         |   28 ++
>  arch/arm/mach-omap1/gpio7xx.c          |   27 ++
>  arch/arm/mach-omap2/gpio.c             |   32 ++
>  arch/arm/plat-omap/include/plat/gpio.h |   20 +
>  drivers/gpio/gpio_omap.c               |  723 +++++++-------------------------
>  6 files changed, 282 insertions(+), 570 deletions(-)
> 
> -- 
> 1.7.3.4
> 
