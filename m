From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/12] omap3: pm: TWL4030 power scripts and workaround for TWL errata 27
Date: Tue, 01 Mar 2011 14:24:01 -0800
Message-ID: <8739n6h43i.fsf@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55938 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756134Ab1CAWYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:24:05 -0500
Received: by mail-gx0-f172.google.com with SMTP id 5so3045581gxk.17
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 14:24:04 -0800 (PST)
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Fri, 18 Feb 2011 22:38:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Patch series for TWL4030 power scripts and workaround for TWL errata 27.
>
> Changes for implementing TWL4030 power scripts recommended by hardware team.
> Introduced a new TWL4030 power script file, which can be used by different
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, modified the
> TWL4030 power script and voltage controller setuptime.
> Workaround for TWL4030 errata 27 & 28 is required for
> Si version less than or equal to TWL5030 ES1.1.
>
> TWL4030 script changes rebased on Kevin's PM tree in pm branch.

What is the dependency on my PM branch?

It looks like this can be based on mainline or l-o master.

Kevin

> Changes in v7:
> 	changes to fix Nishanth Menon's comments
> 		i) Added the TWL4030 Errata 27 fix
>   
> 	split the first patch in v6
> 		i)  fix for twl4030 script load
> 		ii) correct the warning print during script loading
>
> 	Added new patch files
> 		i) pmic_info struct cleanup
> 		ii) changing sys_off signal polarity
>
> 	Updated the change logs
>
> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enabled in suspend path.
> 	Tested with suspend/resume script, which will test system suspend in a loop.
> 	Tested for more than 1000 iterations.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> Lesly A M (12):
>   omap3: pm: Fix for the TRITON sleep/wakeup sequence
>   omap3: pm: Correct the warning print during script loading
>   omap3: pm: cleanup pmic_info structure
>   omap3: pm: Using separate clk/volt setup_time for RET and OFF states
>   omap3630: pm: Adding voltage controller data
>   omap3: pm: Correcting the sys_offmode signal polarity
>   omap3: pm: Re-programing the setup time based on CORE target state
>   omap3: pm: TWL4030 power scripts for OMAP3 boards
>   omap3: pm: TWL5030 version checking
>   mfd: TWL4030: changes for TRITON Errata 27 workaround
>   omap3430: Updating the board file to use TWL4030 scripts
>   omap3630: Updating the board file to use TWL4030 scripts
>
>  arch/arm/mach-omap2/Makefile                 |   12 +-
>  arch/arm/mach-omap2/board-3430sdp.c          |    3 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
>  arch/arm/mach-omap2/omap_twl.c               |  369 +++++++++++++++++++++++---
>  arch/arm/mach-omap2/pm34xx.c                 |   15 +-
>  arch/arm/mach-omap2/twl4030.c                |  261 ++++++++++++++++++
>  arch/arm/mach-omap2/twl4030.h                |   21 ++
>  arch/arm/mach-omap2/voltage.c                |  167 +++++++++---
>  arch/arm/plat-omap/include/plat/voltage.h    |   49 +++-
>  drivers/mfd/twl-core.c                       |   50 ++++
>  drivers/mfd/twl4030-power.c                  |   79 ++++++-
>  include/linux/i2c/twl.h                      |   45 +++-
>  12 files changed, 961 insertions(+), 112 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/twl4030.c
>  create mode 100644 arch/arm/mach-omap2/twl4030.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
