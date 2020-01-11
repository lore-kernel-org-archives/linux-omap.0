From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
Date: Sat, 11 Jan 2020 11:58:22 +0530
Message-ID: <CA+G9fYvRNiFK54oiGt9hYP=RTfazf2E7rmnnkwP+ELMUYtJ7bQ@mail.gmail.com>
References: <20200106203700.21009-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, open list <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 7 Jan 2020 at 02:07, Tony Lindgren <tony@atomide.com> wrote:
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

Thanks for fixing this issue.
I have noticed arm BeagleBoard-X15 boot failed on linux next tree
(5.5.0-rc5-next-20200110).

[    6.157822] 8<--- cut here ---
[    6.160911] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    6.169120] pgd = 25d83e32
[    6.171903] [00000004] *pgd=80000080204003, *pmd=00000000
[    6.177358] Internal error: Oops: a06 [#1] SMP ARM
[    6.182179] Modules linked in:
[    6.185260] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.5.0-rc5-next-20200110 #1
[    6.192694] Hardware name: Generic DRA74X (Flattened Device Tree)
[    6.198832] PC is at omap_dm_timer_probe+0x48/0x310

- Naresh
