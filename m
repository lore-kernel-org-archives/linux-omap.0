From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 18/18] GPIO: OMAP2+: Clean prepare_for_idle and resume_after_idle
Date: Thu, 16 Jun 2011 11:10:10 -0700
Message-ID: <87ips5lkal.fsf@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53582 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752687Ab1FPSKO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 14:10:14 -0400
Received: by mail-pz0-f44.google.com with SMTP id 5so1229489pzk.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 11:10:12 -0700 (PDT)
In-Reply-To: <1308111806-29152-9-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:53:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Simplify  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
> by moving most of the stuff to *_pm_runtime_suspend() and *_pm_runtime_resume().
> Also, omap_gpio_suspend() and omap_gpio_resume() optimized to operate per
> GPIO bank instead of operating on entire list every time.

This second part should be a separate patch.

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

[...]

>  
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +static void omap_gpio_save_context(struct gpio_bank *bank);
> +static void omap_gpio_restore_context(struct gpio_bank *bank);
> +#endif
> +
>  static int omap_gpio_pm_runtime_suspend(struct device *dev)
>  {
> +#ifdef CONFIG_ARCH_OMAP2PLUS

c.f. #ifdefs are ugly in Documentation/SubmittingPatches

Just wrap all of these funcions: runtime PM, save/restore context,
prepare/resume from idle inside the #ifdef.  Then have an else
clause with NULL versions of the runtime PM functions.

Kevin
