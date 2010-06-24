From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] OMAP3: Adding Smartreflex and Voltage driver support
Date: Thu, 24 Jun 2010 16:25:18 -0700
Message-ID: <878w64xbc1.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40240 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0FXXZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:25:24 -0400
Received: by pxi8 with SMTP id 8so431896pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:25:23 -0700 (PDT)
In-Reply-To: <1275150748-15386-1-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Sat, 29 May 2010 22:02:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch series introduces smartreflex and voltage driver support
> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> control for real-time voltage adjustments.
>
> Originally all the functionalities introduced in this patch
> were present in arch/arm/mach-omap2/smartreflex.c file in Kevin's
> pm tree. This patch series does a major rewrite of this file
> and introduces a separate voltage driver. Major contributors
> to the original driver are

I just noticed that one thing missing from this series compared to what
was in the previous PM branch is the disable/enable of SR in the idle
path, so SR is not getting exercised during idle anymore in the current
PM branch.

Could you rememdy that please with another patch on top of this series
(the new pm-sr branch?)

Kevin


> Eduardo Valentin (1):
>       OMAP3: PM: SmartReflex: Fix scheduled while atomic problem
>
> Kalle Jokiniemi (1):
>       OMAP3: PM: SmartReflex driver integration
>
> Kevin Hilman (2):
>       temp: SR: IO_ADDRESS conversion
>       OMAP: SR: OPP interfaces removed from OMAP PM layer
>
> Nishanth Menon (1):
>       omap3: pm: sr: replace get_opp with freq_to_opp
>
> Paul Walmsley (2):
>       OMAP SR: use opp_find_opp_by_opp_id()
>       OMAP SR: use OPP API for OPP ID, remove direct access
>
> Phil Carmody (2):
>       OMAP3: PM: Don't do unnecessary searches in omap_sr_vdd*_autocomp_store
>       OMAP3: PM: Early exit on invalid parameters
>
> Rajendra Nayak (9):
>       OMAP3: SR: Fix init voltage on OPP change
>       OMAP3: SR: Update VDD1/2 voltages at boot
>       OMAP3: SR: Use sysclk for SR CLKLENGTH calc
>       OMAP3: SR: Reset voltage level on SR disable
>       OMAP3: SR: Replace printk's with pr_* calls
>       OMAP3: SR: Remove redundant defines
>       OMAP3: SR: Fix SR driver to check for omap-pm return values
>       OMAP3: PM: Put optimal SMPS stabilization delay
>       OMAP3: SR: Wait for VP idle before a VP disable
>
> Roger Quadros (4):
>       OMAP3: PM: Fix Smartreflex when used with PM_NOOP layer
>       OMAP3: PM: Make Smartreflex driver independent of SRF
>       OMAP3: PM: Do not Enable SmartReflex if OPP tables not defined
>       OMAP3: PM: Smartreflex: Fix VDD2 OPP determining logic
>
> Romit Dasgupta (1):
>       omap: pm: SR: use enum for OPP types
>
> Teerth Reddy (1):
>       OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE
>
> Tero Kristo (1):
>       Smartreflex: Avoid unnecessary spam
>
>
> This patch series is based against origin/opp branch off
> Kevin's pm tree which in turn is based off lo-master.
> This series will apply against lo-master also but will
> break compilation due to lack of opp framework support
> on lo-master.
>
> This patch series has been tested on OMAP3430 SDP,
> OMAP3630 SDP and ZOOM3 with the following menuconfig
> options enabled.
> System type -> TI OMAP Implementations -> Smartreflex Support
> System type -> TI OMAP Implementations ->
> 		Class 3 mode of Smartreflex Implementation
> Device Drivers -> Multifunction device drivers ->
> 		Support power resources on TWL4030 family chips
>
> Thara Gopinath (8):
>   OMAP3: PM: Adding voltage driver support for OMAP3
>   OMAP3: PM: Adding smartreflex driver support.
>   OMAP3: PM: Adding smartreflex device file.
>   OMAP3: PM: Adding smartreflex hwmod data
>   OMAP3: PM: Adding smartreflex class3 driver
>   OMAP3: PM: Adding T2 enabling of smartreflex support
>   OMAP: PM: Allowing an early init of pm debugfs driver.
>   OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
>
>  arch/arm/mach-omap2/Makefile                  |    5 +-
>  arch/arm/mach-omap2/board-3430sdp.c           |    2 +
>  arch/arm/mach-omap2/board-3630sdp.c           |    2 +
>  arch/arm/mach-omap2/board-zoom3.c             |    2 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  209 +++++-
>  arch/arm/mach-omap2/pm-debug.c                |   18 +-
>  arch/arm/mach-omap2/smartreflex-class3.c      |   62 ++
>  arch/arm/mach-omap2/smartreflex-class3.h      |   23 +
>  arch/arm/mach-omap2/smartreflex.c             |  969 ++++++++++++++++++++
>  arch/arm/mach-omap2/sr_device.c               |  177 ++++
>  arch/arm/mach-omap2/voltage.c                 | 1199 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.h                 |  126 +++
>  arch/arm/plat-omap/Kconfig                    |   41 +
>  arch/arm/plat-omap/include/plat/control.h     |   27 +
>  arch/arm/plat-omap/include/plat/smartreflex.h |  273 ++++++
>  drivers/mfd/twl-core.c                        |    7 +-
>  drivers/mfd/twl4030-power.c                   |   29 +
>  include/linux/i2c/twl.h                       |    1 +
>  18 files changed, 3166 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h
>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/mach-omap2/voltage.h
>  create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
