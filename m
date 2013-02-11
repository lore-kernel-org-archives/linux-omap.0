From: Russ Dill <Russ.Dill@ti.com>
Subject: omap2_gpio_prepare_for_idle not functioning in suspend
Date: Sun, 10 Feb 2013 16:39:14 -0800
Message-ID: <CA+Bv8XaWKob_t-S7geuYZveVtxQNa2Bg2awRt49gZ0UQW3nK+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:65125 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3BKAjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 19:39:14 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so2362266qea.36
        for <linux-omap@vger.kernel.org>; Sun, 10 Feb 2013 16:39:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

After the gpio-omap runtime PM changes, I noticed that the
omap2_gpio_prepare_for_idle/omap2_gpio_resume_after_idle functions are
a NOP in the case of suspend.

void omap2_gpio_prepare_for_idle(int pwr_mode)
{
	struct gpio_bank *bank;

	list_for_each_entry(bank, &omap_gpio_list, node) {
		if (!bank->mod_usage)
			continue;

		bank->power_mode = pwr_mode;

		pm_runtime_put_sync_suspend(bank->dev);
	}
}

void omap2_gpio_resume_after_idle(void)
{
	struct gpio_bank *bank;

	list_for_each_entry(bank, &omap_gpio_list, node) {
		if (!bank->mod_usage)
			continue;

		pm_runtime_get_sync(bank->dev);
	}
}

(called from omap_pm_enter->omap3_pm_suspend->omap_sram_idle)

At the point that platform_suspend_ops.enter is called,
dpm_suspend_end has already been called which disables runtime_pm.
During a suspend/resume where power is lost to certain GPIO banks, the
context will not be restored.
