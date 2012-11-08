From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Fri, 9 Nov 2012 00:34:52 +0530
Message-ID: <509C0254.4080603@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50814 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab2KHTE7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 14:04:59 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@linaro.org>



On 11/8/2012 6:42 AM, Mike Turquette wrote:
> From: Mike Turquette <mturquette@linaro.org>
> 
> Hi all,
> 
> This series is based on top of Paul's PRM/CM clean-up work.  It is a
> refresh of the patches Rajendra sent out a while back[1], with the
> addition of several fixes for PM regressions[2] across several
> platforms.
> 
> I have tested on OMAP4430 Panda including PRCM diffing against pre-CCF
> patches (delta is zero) and also suspend/resume.
> 
> I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
> appears sane.  However Panda-ES never comes back from suspend/resume.
> This problem exists on the PRM/CM branch I based on and was not
> introduced by this series.  I am investigating that independently of
> this series.
> 
> Anyone wanting to pull the work can find it at:
> git://git.linaro.org/people/mturquette/linux.git clk-omap-3.8
> 
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/78771
> [2] http://article.gmane.org/gmane.linux.ports.arm.omap/84015
> 
> Mike Turquette (3):
>   ARM: OMAP4: clock: Convert to common clk
>   ARM: OMAP2+: clock: remove unnecessary declarations
>   ARM: OMAP2+: clock: Cleanup !CONFIG_COMMON_CLK parts
> 
> Paul Walmsley (7):
>   ARM: OMAP2xxx: clock: add APLL rate recalculation functions
>   ARM: OMAP2+: clock: add OMAP CCF convenience macros to
>     mach-omap2/clock.h
>   ARM: AM33XX: clock: add clock data in common clock format
>   ARM: OMAP44xx: clock: drop obsolete clock data
>   ARM: OMAP3xxx: clk: drop obsolete clock data
>   ARM: AM33xx: clock: drop obsolete clock data
>   ARM: OMAP2xxx: clock: drop obsolete clock data
> 
> Rajendra Nayak (15):
>   ARM: OMAP: clock: Nuke plat/clock.c & reuse struct clk as clk_hw_omap
>   ARM: OMAP: hwmod: Fix up hwmod based clkdm accesses
>   ARM: OMAP3: clock: Convert to common clk
>   ARM: OMAP2: clock: Convert to common clk
>   ARM: OMAP: clock: list all clk_hw_omap clks to enable/disable
>     autoidle
>   ARM: OMAP: clock: Define a function to enable clocks at init
>   ARM: OMAP: clock: Get rid of some clkdm assocations within clks
>   ARM: OMAP4: clock: Add 44xx data using common struct clk
>   ARM: OMAP3: clock: Add 3xxx data using common struct clk
>   ARM: omap2: clock: Add 24xx data using common struct clk
>   ARM: OMAP: clock: Switch to COMMON clk
>   ARM: OMAP: hwmod: Cleanup !CONFIG_COMMON_CLK parts
>   ARM: OMAP4: clock: Cleanup !CONFIG_COMMON_CLK parts
>   ARM: omap3: clock: Cleanup !CONFIG_COMMON_CLK parts
>   ARM: omap2: clock: Cleanup !CONFIG_COMMON_CLK parts
> 
> Vaibhav Hiremath (1):
>   ARM: OMAP2+: hwmod: Invoke init_clkdm before other init functions
> 
>  arch/arm/mach-omap2/Kconfig                  |    5 +
>  arch/arm/mach-omap2/Makefile                 |   10 +-
>  arch/arm/mach-omap2/cclock2420_data.c        | 1959 ++++++++++++++
>  arch/arm/mach-omap2/cclock2430_data.c        | 2073 +++++++++++++++
>  arch/arm/mach-omap2/cclock33xx_data.c        |  961 +++++++
>  arch/arm/mach-omap2/cclock3xxx_data.c        | 3595 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/cclock44xx_data.c        | 1991 ++++++++++++++
>  arch/arm/mach-omap2/clkt2xxx_apll.c          |   66 +-
>  arch/arm/mach-omap2/clkt2xxx_dpll.c          |    8 +-
>  arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   12 +-
>  arch/arm/mach-omap2/clkt2xxx_osc.c           |   13 +-
>  arch/arm/mach-omap2/clkt2xxx_sys.c           |    7 +-
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   11 +-
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    8 +-
>  arch/arm/mach-omap2/clkt_clksel.c            |  194 +-
>  arch/arm/mach-omap2/clkt_dpll.c              |   28 +-
>  arch/arm/mach-omap2/clkt_iclk.c              |   31 +-
>  arch/arm/mach-omap2/clock.c                  |  845 ++----
>  arch/arm/mach-omap2/clock.h                  |  356 ++-
>  arch/arm/mach-omap2/clock2420_data.c         | 1986 --------------
>  arch/arm/mach-omap2/clock2430.c              |    8 +-
>  arch/arm/mach-omap2/clock2430_data.c         | 2085 ---------------
>  arch/arm/mach-omap2/clock2xxx.c              |    1 +
>  arch/arm/mach-omap2/clock2xxx.h              |   47 +-
>  arch/arm/mach-omap2/clock33xx_data.c         | 1107 --------
>  arch/arm/mach-omap2/clock34xx.c              |   51 +-
>  arch/arm/mach-omap2/clock3517.c              |   24 +-
>  arch/arm/mach-omap2/clock36xx.c              |   22 +-
>  arch/arm/mach-omap2/clock36xx.h              |    2 +-
>  arch/arm/mach-omap2/clock3xxx.c              |    6 +-
>  arch/arm/mach-omap2/clock3xxx.h              |    6 +-
>  arch/arm/mach-omap2/clock3xxx_data.c         | 3613 --------------------------
>  arch/arm/mach-omap2/clock44xx_data.c         | 3398 ------------------------
>  arch/arm/mach-omap2/clock_common_data.c      |   22 +-
>  arch/arm/mach-omap2/cm-regbits-24xx.h        |    5 +
>  arch/arm/mach-omap2/cm-regbits-34xx.h        |   31 +
>  arch/arm/mach-omap2/cm2xxx_3xxx.h            |    1 +
>  arch/arm/mach-omap2/dpll3xxx.c               |  226 +-
>  arch/arm/mach-omap2/dpll44xx.c               |   21 +-
>  arch/arm/mach-omap2/io.c                     |   25 +
>  arch/arm/mach-omap2/omap_hwmod.c             |   63 +-
>  arch/arm/mach-omap2/pm24xx.c                 |    4 +-
>  arch/arm/mach-omap2/prm-regbits-24xx.h       |    2 +
>  arch/arm/mach-omap2/prm-regbits-34xx.h       |    1 +
>  arch/arm/mach-omap2/prm2xxx_3xxx.h           |    1 +
>  arch/arm/mach-omap2/scrm44xx.h               |    2 +
>  46 files changed, 11539 insertions(+), 13394 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/cclock2420_data.c
>  create mode 100644 arch/arm/mach-omap2/cclock2430_data.c
>  create mode 100644 arch/arm/mach-omap2/cclock33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/cclock3xxx_data.c
>  create mode 100644 arch/arm/mach-omap2/cclock44xx_data.c
>  delete mode 100644 arch/arm/mach-omap2/clock2420_data.c
>  delete mode 100644 arch/arm/mach-omap2/clock2430_data.c
>  delete mode 100644 arch/arm/mach-omap2/clock33xx_data.c
>  delete mode 100644 arch/arm/mach-omap2/clock3xxx_data.c
>  delete mode 100644 arch/arm/mach-omap2/clock44xx_data.c
> 


Thanks Mike for the patches.
Just boot tested it on BeagleBone Platform, and it is booting up fine
for me without any issues. Also I did some basic clk_rate check, and it
came out well.

Anyway, I will try to review it tomorrow (if time permits).

Thanks,
Vaibhav


