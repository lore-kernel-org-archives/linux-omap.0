From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 00/11] OMAP3: Adding Smartreflex and Voltage driver support
Date: Tue, 28 Sep 2010 17:31:46 -0700
Message-ID: <87eicd8k5p.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60255 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0I2Abu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 20:31:50 -0400
Received: by pwi1 with SMTP id 1so60781pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 17:31:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> From: thara gopinath <thara@ti.com>
>
> This patch series introduces smartreflex and voltage driver support
> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> control for real-time voltage adjustments.

[...]

> This patch series is based against origin/pm-core branch off
> Kevin's pm tree which in turn is based off lo-master.
> This series will apply against lo-master also but will
> break compilation due to lack of opp framework support
> on lo-master.
>
> This patch series has been tested on OMAP3430 SDP with the extra five patches
> from origin/cpufreq branch off Kevin's pm tree applied. This series
> has been tested with with omap3_defconfig with the following
> menuconfig options enabled.
> System type -> TI OMAP Implementations -> Smartreflex Support
> System type -> TI OMAP Implementations ->
> 		Class 3 mode of Smartreflex Implementation

Using the same baseline as you mention above (pm-core + pm-opp), I
applied this series (and the OMAP4 series) and tested on 34xx/n900 and
36xx/Zoom3 using omap2plus_defconfig and it booted ok.  (I also patched
the n900 board file to call sr_class3_init(), which you should include
as part of the series too.)

I then did some experiments, including updating the pm-sr branch to be
this latest series and testing with omap3_pm_defconfig.  With that, I
notcied that within a few seconds of reaching the shell, the system
rebooted.

I tracked this down to the fact that CONFIG_OMAP_WATCHDOG was not
enabled in omap3_pm_defconfig.  Enabling the watchdog, and it no longer
reboots.   /me confused

Using just the pm-sr branch by itself and omap2plus_defconfig, even with
the watchdog disabled, it doesn't reboot.

Do you have any ideas what else might be causing this reboot when using
the PM branch + omap3_pm_defconfig?

Kevin


> Thara Gopinath (11):
>   OMAP: PM: Export the main pm debugfs directory
>   OMAP3: PM: Adding voltage driver support for OMAP3
>   OMAP3: PM: Adding smartreflex driver support.
>   OMAP3: PM: Adding smartreflex device file.
>   OMAP3: PM: Adding smartreflex hwmod data
>   OMAP3: PM: Adding smartreflex class3 driver
>   OMAP3: PM: Adding T2 enabling of smartreflex support
>   OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
>   OMAP3: PM: Smartreflex Class3 initialization from board files.
>   OMAP3: PM: Program correct init voltages for VDD1 and VDD2
>   OMAP3: PM: Register TWL4030 pmic info with the voltage driver.
>
>  arch/arm/mach-omap2/Makefile                  |    5 +-
>  arch/arm/mach-omap2/board-3430sdp.c           |    2 +
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |    2 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  249 +++++
>  arch/arm/mach-omap2/pm-debug.c                |   18 +
>  arch/arm/mach-omap2/pm.c                      |   67 ++-
>  arch/arm/mach-omap2/pm.h                      |    1 +
>  arch/arm/mach-omap2/smartreflex-class3.c      |   61 ++
>  arch/arm/mach-omap2/smartreflex-class3.h      |   23 +
>  arch/arm/mach-omap2/smartreflex.c             | 1039 +++++++++++++++++++
>  arch/arm/mach-omap2/sr_device.c               |  174 ++++
>  arch/arm/mach-omap2/voltage.c                 | 1319 +++++++++++++++++++++++++
>  arch/arm/plat-omap/Kconfig                    |   41 +
>  arch/arm/plat-omap/include/plat/control.h     |   27 +
>  arch/arm/plat-omap/include/plat/smartreflex.h |  276 ++++++
>  arch/arm/plat-omap/include/plat/voltage.h     |  141 +++
>  arch/arm/plat-omap/opp_twl_tps.c              |   17 +
>  drivers/mfd/twl-core.c                        |    7 +-
>  drivers/mfd/twl4030-power.c                   |   29 +
>  include/linux/i2c/twl.h                       |    1 +
>  20 files changed, 3495 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h
>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
