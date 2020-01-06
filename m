From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
Date: Mon, 6 Jan 2020 13:07:32 -0800
Message-ID: <CAOesGMiNbyUXwPFsG-ipTn-xfEs+A2hG8Q8MTcSLz5794GCv0g@mail.gmail.com>
References: <20200106203700.21009-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 6, 2020 at 12:37 PM Tony Lindgren <tony@atomide.com> wrote:
>
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

Acked-by: Olof Johansson <olof@lixom.net>

> ---
>
> I did not notice simlar issue with other patches in the series, but
> please do double check Yangtao.

Yeah, this even seems to be caught at build (but our builds have been
so noisy with warnings lately that they're hard to spot):

/build/drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
/build/drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may
be used uninitialized in this function [-Wmaybe-uninitialized]
  798 |  timer->irq = platform_get_irq(pdev, 0);
      |  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~


-Olof
