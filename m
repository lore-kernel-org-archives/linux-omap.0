From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap-clock-fixes branch available
Date: Fri, 10 Apr 2009 12:22:00 -0700
Message-ID: <20090410192200.GB8345@atomide.com>
References: <alpine.DEB.2.00.0904092111240.15126@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61978 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502AbZDJTWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 15:22:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0904092111240.15126@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090409 20:12]:
> 
> Hello Tony et al.,
> 
> Please pull this omap-clock-fixes branch.  Once rmk gets back from his 
> holiday, these will be posted to linux-arm-kernel.

Thanks, I've pulled it into l-o master.

Tony

> 
> 
> - Paul
> 
> 
> The following changes since commit 15f7176eb1cccec0a332541285ee752b935c1c85:
>   Linus Torvalds (1):
>         Merge git://git.kernel.org/.../davem/net-2.6
> 
> are available in the git repository at:
> 
>   git://git.pwsan.com/linux-2.6 omap-clock-fixes
> 
> Kevin Hilman (1):
>       OMAP: dmtimer: enable all timers to be wakeup events
> 
> Paul Walmsley (4):
>       OMAP2xxx clock: init osc_ck, sys_ck internal lists early
>       OMAP2xxx clock: fix broken cpu_mask code
>       OMAP3 GPTIMER: fix GPTIMER12 IRQ
>       OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed in board-*.c files
> 
> Sergio Aguirre (1):
>       OMAP3: clock: Camera module doesn't have IDLEST bit
> 
>  arch/arm/mach-omap2/board-omap3beagle.c    |    4 ++
>  arch/arm/mach-omap2/clock24xx.c            |   15 +++-----
>  arch/arm/mach-omap2/clock24xx.h            |   10 +++++-
>  arch/arm/mach-omap2/clock34xx.h            |    7 ++--
>  arch/arm/mach-omap2/timer-gp.c             |   48 ++++++++++++++++++++++++++--
>  arch/arm/plat-omap/dmtimer.c               |   28 ++++++++++------
>  arch/arm/plat-omap/include/mach/dmtimer.h  |    2 +-
>  arch/arm/plat-omap/include/mach/timer-gp.h |   17 ++++++++++
>  8 files changed, 102 insertions(+), 29 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h
