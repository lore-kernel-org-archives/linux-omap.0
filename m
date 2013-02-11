From: Kevin Hilman <khilman@linaro.org>
Subject: Re: omap2_gpio_prepare_for_idle not functioning in suspend
Date: Mon, 11 Feb 2013 07:29:46 -0800
Message-ID: <87pq06yil1.fsf@linaro.org>
References: <CA+Bv8XaWKob_t-S7geuYZveVtxQNa2Bg2awRt49gZ0UQW3nK+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37550 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758Ab3BKP3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 10:29:50 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so3076777pad.6
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 07:29:49 -0800 (PST)
In-Reply-To: <CA+Bv8XaWKob_t-S7geuYZveVtxQNa2Bg2awRt49gZ0UQW3nK+g@mail.gmail.com>
	(Russ Dill's message of "Sun, 10 Feb 2013 16:39:14 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Russ,

Russ Dill <Russ.Dill@ti.com> writes:

> After the gpio-omap runtime PM changes, I noticed that the
> omap2_gpio_prepare_for_idle/omap2_gpio_resume_after_idle functions are
> a NOP in the case of suspend.
>
> void omap2_gpio_prepare_for_idle(int pwr_mode)
> {
> 	struct gpio_bank *bank;
>
> 	list_for_each_entry(bank, &omap_gpio_list, node) {
> 		if (!bank->mod_usage)
> 			continue;
>
> 		bank->power_mode = pwr_mode;
>
> 		pm_runtime_put_sync_suspend(bank->dev);
> 	}
> }
>
> void omap2_gpio_resume_after_idle(void)
> {
> 	struct gpio_bank *bank;
>
> 	list_for_each_entry(bank, &omap_gpio_list, node) {
> 		if (!bank->mod_usage)
> 			continue;
>
> 		pm_runtime_get_sync(bank->dev);
> 	}
> }
>
> (called from omap_pm_enter->omap3_pm_suspend->omap_sram_idle)
>
> At the point that platform_suspend_ops.enter is called,
> dpm_suspend_end has already been called which disables runtime_pm.
> During a suspend/resume where power is lost to certain GPIO banks, the
> context will not be restored.

Did you actually observe context not being restored, or is this an
observation by looking at the code?

The PM domain layer (implemented in omap_device) is supposed to be
handling the case where runtime PM has been disabled by the PM core.
Specifically, check the 'noirq' hooks in the omap_device PM domain.
These check whether omap_devices are runtime_suspended, and
runtime_suspends them if they are not.   Then during resume, the
resume_noirq hook will runtime resume them if they were "forcibly"
runtime suspended during the noirq phase.

That being said, there may have been some recent PM core changes that
have caused this not to work anymore, so I'd be very curious exactly how
to reproduce this.

Thanks,

Kevin
