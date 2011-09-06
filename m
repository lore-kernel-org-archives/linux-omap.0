From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 19/25] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Tue, 06 Sep 2011 16:53:00 -0700
Message-ID: <874o0pxm77.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-20-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:52140 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755355Ab1IFXxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 19:53:05 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so5314445gxk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 16:53:04 -0700 (PDT)
In-Reply-To: <1314798161-19523-20-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Cleanup  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
> by moving most of the stuff to *_runtime_suspend() and *_runtime_resume().

Why? 

(I know the answer, but it should be in the changelog.)

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Also, as pointed out in an earlier patch, now that this is moved out of
the idle path, where interrupts were known to be disabled, the register
accesses in the runtime PM callbacks need to be protected by the
spinlock just like they are in other parts of the driver.

[...]

> @@ -1305,9 +1316,14 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  				bank->base + bank->regs->fallingdetect);
>  	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
>  }
> +#else
> +#define omap_gpio_runtime_suspend NULL
> +#define omap_gpio_runtime_resume NULL
>  #endif
>  
>  static const struct dev_pm_ops gpio_pm_ops = {
> +	.runtime_suspend	= omap_gpio_runtime_suspend,
> +	.runtime_resume		= omap_gpio_runtime_resume,

Please use SET_RUNTIME_PM_OPS() (see <linux/pm.h.)

>  	.suspend		= omap_gpio_suspend,
>  	.resume			= omap_gpio_resume,
>  };

Kevin
