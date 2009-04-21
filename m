From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for omap fixes, v2 (Re: [PATCH 00/11] Omap
	fixes for 2.6.30-rc1)
Date: Tue, 21 Apr 2009 08:55:06 -0700
Message-ID: <20090421155506.GE25864@atomide.com>
References: <20090414214638.9878.17987.stgit@localhost> <20090417012301.GB8316@atomide.com> <20090421045732.GA25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61980 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZDUPzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 11:55:15 -0400
Content-Disposition: inline
In-Reply-To: <20090421045732.GA25864@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090420 21:58]:
> * Tony Lindgren <tony@atomide.com> [090416 18:23]:
> > * Tony Lindgren <tony@atomide.com> [090414 14:48]:
> > > Hi all,
> > > 
> > > Here are some omap fixes for review.
> > 
> > Also merged in Paul's clock fixes posted here earlier.
> > 
> > Russell, here's the pull request for you.
> 
> I merged in Paul's updated patch "OMAP2/3 GPTIMER: allow system tick
> GPTIMER to be changed in board-*.c files".
> 
> The diff to earlier series and the updated pull request are attached.

FYI, there's also a compile fix for omap3 boards coming via the USB list:

http://marc.info/?l=linux-usb&m=124024994725512&w=2




> 
> Cheers,
> 
> Tony
> 

> Index: linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock24xx.h	2009-04-20 10:42:21.000000000 -0700
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h	2009-04-20 10:46:09.000000000 -0700
> @@ -625,8 +625,8 @@ static struct clk func_32k_ck = {
>  	.clkdm_name	= "wkup_clkdm",
>  };
>  
> -static struct clk secure_32k_fck = {
> -	.name		= "secure_32k_fck",
> +static struct clk secure_32k_ck = {
> +	.name		= "secure_32k_ck",
>  	.ops		= &clkops_null,
>  	.rate		= 32768,
>  	.flags		= RATE_FIXED,

> The following changes since commit 0882e8dd3aad33eca41696d463bb896e6c8817eb:
>   Linus Torvalds (1):
>         Linux 2.6.30-rc2
> 
> are available in the git repository at:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes
> 
> Arun KS (1):
>       OMAP1: clock: Typo fix for clock in omap1
> 
> Huang Weiyi (1):
>       ARM: OMAP3: remove duplicated #include
> 
> Jarkko Nikula (1):
>       ARM: OMAP2: Remove defines and resource init for OMAP24XX EAC
> 
> Kevin Hilman (2):
>       ARM: OMAP2/3: GPIO: do not attempt to wake-enable
>       OMAP: dmtimer: enable all timers to be wakeup events
> 
> Ladislav Michl (3):
>       ARM: OMAP: MMC: Remove unused power_pin
>       ARM: OMAP1: Simplify board-h2 MMC setup
>       ARM: OMAP1: Fix mmc_set_power GPIO usage
> 
> Paul Walmsley (4):
>       OMAP2xxx clock: init osc_ck, sys_ck internal lists early
>       OMAP2xxx clock: fix broken cpu_mask code
>       OMAP3 GPTIMER: fix GPTIMER12 IRQ
>       OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed in board-*.c files
> 
> Roel Kluin (1):
>       ARM: OMAP2: possible division by 0
> 
> Roger Quadros (2):
>       ARM: OMAP3: Fixed spurious IRQ issue for GPIO interrupts
>       ARM: OMAP3: Clean up spurious interrupt check logic
> 
> Santosh Shilimkar (1):
>       ARM: OMAP: Fix for possible race condition in omap_free_dma()
> 
> Sergio Aguirre (1):
>       OMAP3: clock: Camera module doesn't have IDLEST bit
> 
> Tony Lindgren (2):
>       ARM: OMAP: Remove old dead gpio expander code
>       Merge branch 'omap-clock-fixes' into omap-fixes
> 
>  arch/arm/mach-omap1/board-h2-mmc.c             |   14 +---
>  arch/arm/mach-omap1/board-h3-mmc.c             |    6 +-
>  arch/arm/mach-omap1/board-h3.c                 |  101 ------------------------
>  arch/arm/mach-omap1/board-nokia770.c           |    6 +-
>  arch/arm/mach-omap1/mcbsp.c                    |    4 +-
>  arch/arm/mach-omap2/board-h4.c                 |   95 ----------------------
>  arch/arm/mach-omap2/board-omap3beagle.c        |    4 +
>  arch/arm/mach-omap2/board-rx51.c               |    1 -
>  arch/arm/mach-omap2/clock24xx.c                |   15 ++--
>  arch/arm/mach-omap2/clock24xx.h                |   10 ++-
>  arch/arm/mach-omap2/clock34xx.h                |    7 +-
>  arch/arm/mach-omap2/devices.c                  |   33 --------
>  arch/arm/mach-omap2/irq.c                      |    4 +-
>  arch/arm/mach-omap2/timer-gp.c                 |   48 +++++++++++-
>  arch/arm/mach-omap2/usb-tusb6010.c             |    2 +-
>  arch/arm/plat-omap/dma.c                       |   13 ++--
>  arch/arm/plat-omap/dmtimer.c                   |   28 ++++---
>  arch/arm/plat-omap/gpio.c                      |   20 ++---
>  arch/arm/plat-omap/include/mach/dmtimer.h      |    2 +-
>  arch/arm/plat-omap/include/mach/eac.h          |  100 -----------------------
>  arch/arm/plat-omap/include/mach/gpioexpander.h |   35 --------
>  arch/arm/plat-omap/include/mach/irda.h         |    4 -
>  arch/arm/plat-omap/include/mach/mmc.h          |    1 -
>  arch/arm/plat-omap/include/mach/timer-gp.h     |   17 ++++
>  drivers/mmc/host/omap.c                        |    2 -
>  25 files changed, 128 insertions(+), 444 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/mach/eac.h
>  delete mode 100644 arch/arm/plat-omap/include/mach/gpioexpander.h
>  create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h

