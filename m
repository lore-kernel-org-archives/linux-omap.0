From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 05/26] gpio/omap: handle save/restore context in GPIO driver
Date: Mon, 26 Sep 2011 16:22:31 -0700
Message-ID: <87lita7utk.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:33298 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752327Ab1IZXWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 19:22:36 -0400
Received: by mail-yi0-f50.google.com with SMTP id 25so4819889yib.9
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 16:22:35 -0700 (PDT)
In-Reply-To: <1315918979-26173-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 13 Sep 2011 18:32:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

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
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 9f3a007..6c6b1a7 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -23,6 +23,7 @@
>  
>  #include <plat/omap_hwmod.h>
>  #include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
>  
>  #include "powerdomain.h"
>  
> @@ -63,7 +64,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  	pdata->bank_width = dev_attr->bank_width;
>  	pdata->dbck_flag = dev_attr->dbck_flag;
>  	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
> -
> +#ifdef CONFIG_PM
> +	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
> +#endif

no #ifdef please (c.f. "#ifdefs are ugly" in
Documentation/SubmittingPatches)

In this case, the existence of this API isn't dependent on CONFIG_PM, so
the #ifdef isn't right.

Kevin
