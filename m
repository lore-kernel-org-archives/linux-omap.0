From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 09/13] gpio/omap: remove suspend/resume callbacks
Date: Wed, 07 Mar 2012 13:01:41 +0100
Message-ID: <4F574E25.6010702@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> <1331118963-26364-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55239 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754385Ab2CGMBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:01:47 -0500
Received: by mail-gx0-f175.google.com with SMTP id y3so2652008ggc.6
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:01:46 -0800 (PST)
In-Reply-To: <1331118963-26364-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 07 March 2012 12:15 PM, Tarun Kanti DebBarma wrote:
> Both omap_gpio_suspend() and omap_gpio_resume() does programming
> of wakeup_en register.
> _gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
> _gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
> 
> This is redundant in omap_gpio_suspend() because wakeup_en
> register automatically gets initialized in _set_gpio_wakeup()
> and set_gpio_trigger() while being called either from
> chip.irq_set_wake() or chip.irq_set_type().
> 
> This is redundant in omap_gpio_resume() because wakeup_en
s/This is/This is also

> register is programmed in omap_gpio_restore_context() called
> which is called from runtime resume callback.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
