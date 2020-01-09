From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
Date: Thu, 9 Jan 2020 12:42:37 +0100
Message-ID: <799dbdec-bfa2-e9d5-d541-b7ad7b04dd46@linaro.org>
References: <20200106203700.21009-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36201 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgAILmm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2020 06:42:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so7073032wru.3
        for <linux-omap@vger.kernel.org>; Thu, 09 Jan 2020 03:42:40 -0800 (PST)
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yangtao Li <tiny.windzz@gmail.com>

On 06/01/2020 21:37, Tony Lindgren wrote:
> Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
> platform_get_irq") caused a regression where we now try to access
> uninitialized data for timer:
> 
> drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
> drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> 
> On boot we now get:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> ...
> (omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
> (platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
> (really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)
> 
> Let's fix the issue by moving platform_get_irq to happen after timer has
> been allocated.
> 
> Fixes: 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied, thanks.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
