From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Sun, 22 May 2011 08:28:53 +0200
Message-ID: <20110522062853.GA15292@game.jcrosoft.org>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 64.mail-out.ovh.net ([91.121.185.65]:34353 "HELO
	64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750895Ab1EVGkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 May 2011 02:40:37 -0400
Content-Disposition: inline
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

On 17:14 Fri 20 May     , Kevin Hilman wrote:
> Start moving SoC-specific register handling out of the driver by passing
> in register offsets in via platform data.
> 
> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
> 
> Applies on top of Tony's for-next branch (which include's the generic
> IRQ chip work from tglx) and the OMAP GPIO driver move to
> drivers/gpio.
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
looks good

Best Regards,
J.
