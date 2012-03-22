From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to context.irqenable1
Date: Thu, 22 Mar 2012 16:09:07 -0700
Message-ID: <87vclw44j0.fsf@ti.com>
References: <1332393130-10636-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:49381 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758440Ab2CVXJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 19:09:09 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy12so2112829pbc.38
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 16:09:08 -0700 (PDT)
In-Reply-To: <1332393130-10636-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 22 Mar 2012 10:42:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In _enable_gpio_irqbank() when bank->regs->set_irqenable is TRUE,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. In order to ensure the same is
> stored in context.irqenable1, we must avoid overwriting it with
> gpio_mask at the end of the function. Instead, update irqenable1
> appropriately by OR'ing with gpio_mask.
> For the case where bank->regs->set_irqenable is FALSE, irqenable1
> can be directly overwritten with 'l' which holds correct computed
> value.
>
>         if (bank->regs->set_irqenable) {
>                 reg += bank->regs->set_irqenable;
>                 l = gpio_mask;
>         } else {
>                 reg += bank->regs->irqenable;
>                 l = __raw_readl(reg);
>                 if (bank->regs->irqenable_inv)
>                         l &= ~gpio_mask;
>                 else
>                         l |= gpio_mask;
>         }
>
> Make similar change for _disable_gpio_irqbank().
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Updated change log as per Kevin's suggestion.


Thanks for the update.  I've queued the updated version of this series,
and sent pull request to Grant.

Thanks Tarun,

Kevin

