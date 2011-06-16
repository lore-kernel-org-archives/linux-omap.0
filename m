From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 05/18] GPIO: OMAP: Handle save/restore ctx in GPIO driver
Date: Thu, 16 Jun 2011 09:34:53 -0700
Message-ID: <8739j9raz6.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49300 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281Ab1FPQfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:35:00 -0400
Received: by pva4 with SMTP id 4so150130pva.30
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:34:59 -0700 (PDT)
In-Reply-To: <1308111776-29130-4-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:52:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle() functions
> to handle save context & restore context respectively in the OMAP GPIO driver
> itself instead of calling these functions from pm specific files.
> For this, in gpio_prepare_for_idle(), call *_get_context_loss_count() and in
> gpio_resume_after_idle() call it again. If the count is different, do restore
> context. The workaround_enabled flag is no more required and is removed.
>
> Signed-off-by: Charulatha V <charu@ti.com>

[...]

> @@ -1396,8 +1399,12 @@ void omap2_gpio_resume_after_idle(void)
>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>  			clk_enable(bank->dbck);
>  
> -		if (!workaround_enabled)
> -			continue;
> +		if (bank->get_context_loss_count) {
> +			ctx_lost_cnt_after =
> +				bank->get_context_loss_count(bank->dev);
> +			if (ctx_lost_cnt_after != bank->ctx_loss_count)
> +				omap_gpio_restore_context(bank);
> +		}

Context should be also be restored if you cant know if it's been lost.
IOW, it should also be restored if !bank->get_context_loss_count.

>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
> @@ -1475,74 +1482,50 @@ void omap2_gpio_resume_after_idle(void)
>  			}
>  		}
>  	}
> -
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -void omap_gpio_save_context(void)
> +void omap_gpio_save_context(struct gpio_bank *bank)

Should also be made static.  Same for restore below.

Kevin
