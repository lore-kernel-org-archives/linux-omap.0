From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] arm: omap: timer cleanups
Date: Fri, 16 Oct 2015 13:40:59 -0700
Message-ID: <20151016204058.GE24370@atomide.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [151016 09:27]:
> Hi Tony,
> 
> Here's the a series of timer cleanups (and a new 32k clocksource driver
> which is safe to apply during v4.3 merge window. We're only missing,
> now, two changes to enable TWD timer for AM437x.
> 
> All patches are also available in a branch which you can pull should you
> choose. Pull request below.
> 
> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> 
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git for-tony
> 
> for you to fetch changes up to bf4c94490aa4491cca758d633c0e641a4419c920:
> 
>   arm: omap2: timer: limit hwmod usage to non-DT boots (2015-10-16 11:06:24 -0500)

Great! I'm pulling this into omap-for-v4.4/soc and then assuming no
issues in Linux next we'll hopefully have it in for v4.4.

Regards,

Tony


> ----------------------------------------------------------------
> Felipe Balbi (11):
>       arm: omap2: timer: always define omap4_local_timer_init
>       arm: omap2: timer: get rid of obfuscating macros
>       arm: omap2: timer: add a gptimer argument to sync32k_timer_init()
>       arm: omap2: timer: remove __omap_gptimer_init()
>       arm: omap2: timer: provide generic sync32k_timer_init function
>       arm: omap2: timer: move realtime_counter_init() around
>       arm: omap2: timer: always call clocksource_of_init() when DT
>       arm: omap2: timer: rename omap_sync32k_timer_init()
>       clocksource: add TI 32.768 Hz counter driver
>       arm: omap2+: select 32k clocksource driver
>       arm: omap2: timer: limit hwmod usage to non-DT boots
> 
>  arch/arm/mach-omap2/Kconfig         |   1 +
>  arch/arm/mach-omap2/board-generic.c |  10 +--
>  arch/arm/mach-omap2/board-ldp.c     |   2 +-
>  arch/arm/mach-omap2/board-rx51.c    |   2 +-
>  arch/arm/mach-omap2/common.h        |   3 +-
>  arch/arm/mach-omap2/timer.c         | 162 ++++++++++++++++--------------------
>  drivers/clocksource/Kconfig         |   7 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-ti-32k.c  | 126 ++++++++++++++++++++++++++++
>  9 files changed, 215 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/clocksource/timer-ti-32k.c
> 
> -- 
> 2.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
