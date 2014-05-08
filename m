From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 0/4] ARM: OMAP: raw read and write endian fix
Date: Thu, 8 May 2014 07:23:58 -0700
Message-ID: <20140508142357.GA26833@atomide.com>
References: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55186 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaEHOYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 10:24:04 -0400
Content-Disposition: inline
In-Reply-To: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Taras Kondratiuk <taras.kondratiuk@linaro.org> [140415 10:38]:
> This series does trivial replacement of __raw_xxx functions with xxx_relaxed
> endian-neutral variants in 'mach-omap2' and 'plat-omap' directories.
> Some code here most probably won't be used in BE mode (like debug-leds for
> OMAP1 boards), but changes are made anyway to remove __raw_xxx() functions
> completely and simplify future grep'ing for new __raw_xxx() entries.
> 
> This is a part of RFC series [1].
> It was missed in previous merge window [2].
> 
> Based on v3.15-rc1.

Thanks applying these into omap-for-v3.16/be.

Regards,

Tony
 
> [1] http://www.spinics.net/lists/linux-omap/msg99927.html
> [2] https://lkml.org/lkml/2014/4/2/292
> 
> Victor Kamensky (4):
>   ARM: OMAP2+: raw read and write endian fix
>   ARM: OMAP: dmtimer: raw read and write endian fix
>   ARM: OMAP: counter-32k: raw read and write endian fix
>   ARM: OMAP: debug-leds: raw read and write endian fix
> 
>  arch/arm/mach-omap2/board-flash.c         |    4 +--
>  arch/arm/mach-omap2/clkt2xxx_dpllcore.c   |    2 +-
>  arch/arm/mach-omap2/clkt2xxx_osc.c        |    8 +++---
>  arch/arm/mach-omap2/clkt2xxx_sys.c        |    2 +-
>  arch/arm/mach-omap2/cm2xxx_3xxx.h         |    4 +--
>  arch/arm/mach-omap2/cm33xx.c              |    4 +--
>  arch/arm/mach-omap2/cm3xxx.c              |    8 +++---
>  arch/arm/mach-omap2/cm44xx.c              |    8 +++---
>  arch/arm/mach-omap2/cminst44xx.c          |    4 +--
>  arch/arm/mach-omap2/control.c             |   20 +++++++-------
>  arch/arm/mach-omap2/dma.c                 |    4 +--
>  arch/arm/mach-omap2/gpmc.c                |    8 +++---
>  arch/arm/mach-omap2/id.c                  |    2 +-
>  arch/arm/mach-omap2/irq.c                 |    4 +--
>  arch/arm/mach-omap2/mux.c                 |    8 +++---
>  arch/arm/mach-omap2/omap-hotplug.c        |    4 +--
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   18 ++++++-------
>  arch/arm/mach-omap2/omap-smp.c            |    6 ++---
>  arch/arm/mach-omap2/omap-wakeupgen.c      |   42 ++++++++++++++---------------
>  arch/arm/mach-omap2/omap4-common.c        |   18 ++++++-------
>  arch/arm/mach-omap2/omap_hwmod.c          |   10 +++----
>  arch/arm/mach-omap2/omap_phy_internal.c   |    6 ++---
>  arch/arm/mach-omap2/prcm_mpu44xx.c        |    4 +--
>  arch/arm/mach-omap2/prm2xxx.h             |    2 +-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h        |    4 +--
>  arch/arm/mach-omap2/prm33xx.c             |    4 +--
>  arch/arm/mach-omap2/prm3xxx.h             |    2 +-
>  arch/arm/mach-omap2/prm44xx.c             |    4 +--
>  arch/arm/mach-omap2/prminst44xx.c         |    4 +--
>  arch/arm/mach-omap2/sdrc.h                |    8 +++---
>  arch/arm/mach-omap2/sdrc2xxx.c            |    4 +--
>  arch/arm/mach-omap2/sr_device.c           |    2 +-
>  arch/arm/mach-omap2/sram.c                |   16 +++++------
>  arch/arm/mach-omap2/timer.c               |    8 +++---
>  arch/arm/mach-omap2/vc.c                  |    4 +--
>  arch/arm/mach-omap2/wd_timer.c            |    8 +++---
>  arch/arm/plat-omap/counter_32k.c          |    6 ++---
>  arch/arm/plat-omap/debug-leds.c           |   14 +++++-----
>  arch/arm/plat-omap/dmtimer.c              |    8 +++---
>  arch/arm/plat-omap/include/plat/dmtimer.h |   16 +++++------
>  40 files changed, 156 insertions(+), 156 deletions(-)
> 
> -- 
> 1.7.9.5
> 
