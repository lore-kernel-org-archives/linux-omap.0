From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates
 for 3.10
Date: Mon, 1 Apr 2013 10:05:39 -0700
Message-ID: <20130401170539.GK10155@atomide.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15474 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759037Ab3DARFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 13:05:43 -0400
Content-Disposition: inline
In-Reply-To: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:43]:
> Tony,
> 
> Here is the pull request for OMAP5 data file patches which are on list from
> last merge window. As aligned on list, I have dropped clock data from the
> series. That means for the boot, one clock data patch needs to be applied.
> It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.
> 
> As discussed already on list, you will notice hwmod data loc has come down
> from ~6000 lines to ~2000 lines becasue of removal of iospace, irq, dma data
> as well as unused hwmods. Few hwmods for which dt conversion is pending are
> not added as well but those would add max ~400 loc in future.
> 
> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> 
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap5_data_files
> 
> for you to fetch changes up to 8a6a32e589a1a2a5a3fb8ebe8fc7426997bc6d89:
> 
>   ARM: OMAP5: Enable build and frameowrk initialisations (2013-03-19 14:09:11 +0530)

Paul, do you have any comments on these?

This branch should be queued separately because of the amount of
LOC it adds. But as you may have other PRCM related patches then it's
probably best that you queue it.

Regards,

Tony
 
> ----------------------------------------------------------------
> Benoit Cousson (7):
>       ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
>       ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
>       ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
>       ARM: OMAP5: SCRM: Add OMAP54XX header file.
>       ARM: OMAP2+: clockdomain data: Add OMAP54XX data and update the header
>       ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
>       ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data
> 
> Santosh Shilimkar (4):
>       ARM: OMAP5: hwmod_data: Fix UART sysc settings
>       ARM: OMAP5: hwmod-data: Add timer clock activity flags
>       ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
>       ARM: OMAP5: Enable build and frameowrk initialisations
> 
>  arch/arm/mach-omap2/Makefile                  |    4 +
>  arch/arm/mach-omap2/clockdomain.h             |    1 +
>  arch/arm/mach-omap2/clockdomains54xx_data.c   |  464 +++++
>  arch/arm/mach-omap2/cm-regbits-54xx.h         | 1737 ++++++++++++++++
>  arch/arm/mach-omap2/cm1_54xx.h                |  216 ++
>  arch/arm/mach-omap2/cm2_54xx.h                |  392 ++++
>  arch/arm/mach-omap2/io.c                      |    7 +
>  arch/arm/mach-omap2/omap_hwmod.h              |    1 +
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 2151 ++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h             |    1 +
>  arch/arm/mach-omap2/powerdomains54xx_data.c   |  331 +++
>  arch/arm/mach-omap2/prcm44xx.h                |    6 +
>  arch/arm/mach-omap2/prcm_mpu54xx.h            |   92 +
>  arch/arm/mach-omap2/prm-regbits-54xx.h        | 2701 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/prm54xx.h                 |  447 ++++
>  arch/arm/mach-omap2/scrm54xx.h                |  231 +++
>  arch/arm/mach-omap2/voltage.h                 |    1 +
>  arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +
>  18 files changed, 8885 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/clockdomains54xx_data.c
>  create mode 100644 arch/arm/mach-omap2/cm-regbits-54xx.h
>  create mode 100644 arch/arm/mach-omap2/cm1_54xx.h
>  create mode 100644 arch/arm/mach-omap2/cm2_54xx.h
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains54xx_data.c
>  create mode 100644 arch/arm/mach-omap2/prcm_mpu54xx.h
>  create mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
>  create mode 100644 arch/arm/mach-omap2/prm54xx.h
>  create mode 100644 arch/arm/mach-omap2/scrm54xx.h
>  create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c
