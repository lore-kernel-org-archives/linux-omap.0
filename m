From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 00/10] OMAP: Adding Smartreflex and Voltage driver support
Date: Mon, 20 Dec 2010 17:05:27 -0800
Message-ID: <877hf45414.fsf@deeprootsystems.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34362 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560Ab0LUBFb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 20:05:31 -0500
Received: by iyi12 with SMTP id 12so2699312iyi.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 17:05:31 -0800 (PST)
In-Reply-To: <1292864357-13939-1-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Mon, 20 Dec 2010 22:29:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch series introduces smartreflex and voltage driver support
> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
> control for real-time voltage adjustments.

Thanks Thara, these are looking good for 2.6.38.

Tony, unless there are major objections, I'll be queuing these two SR
series for 2.6.38.  They have dependencies on Paul's integration branch
so will wait 'til that stabilizies before sending pull request.

Kevin


> Originally all the functionalities introduced in this patch
> were present in arch/arm/mach-omap2/smartreflex.c file in Kevin's
> pm tree. This patch series does a major rewrite of this file
> and introduces a separate voltage driver. Major contributors
> to the original driver are
>
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
> This patch series is against pm-core branch of Kevin Hilman's 
> OMAP PM tree with the following additional patch applied.
> 	https://patchwork.kernel.org/patch/421351/
>
> The entire series with the dependencies are available at
>         http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
>         head: kevin-pm-sr
>
> This patch series has been tested on OMAP3430 SDP with omap2plus_defconfig
> with the following menuconfig options enabled.
> System type -> TI OMAP Implementations -> Smartreflex Support
> System type -> TI OMAP Implementations ->
>                 Class 3 mode of Smartreflex Implementation
>
> Major Changes in v6
> 	-Rebased to pm-core branch of Kevin Hilman's OMAP PM tree.
>
> Major Changes in v5
> 	- Rebased to k.org 2.6.37-rc3
> 	- Rebased to Nishant Menon's latest opp patches
> 	- Voltage pmic info structure extended to include a
> 		vast set of PMIC dependent parameters.
> 	- Smartreflex software n-target values support
> 		removed from the kernel. Instead n-target
> 		values are exposed as debugfs entries which can
> 		be written into by the user if needed.
> 	- Introduced a new file arch/arm/mach-omap2/omap_twl.c
> 		for specifying OMAP and TWL related info for
> 		the voltage layer.
> 	- Remove default enabling of smartreflex autocompensation
> 		during boot on OMAP3430 ES3.1 chips. Instead
> 		an API is provided that can be called from
> 		board files in case autocompensation needs
> 		to be enabled during boot up itself.
> 	- Other review comments on v4
>
> Thara Gopinath (10):
>   OMAP3: PM: Adding voltage driver support.
>   OMAP: Introduce voltage domain information in the hwmod structures
>   OMAP3: PM: Adding smartreflex driver support.
>   OMAP3: PM: Adding smartreflex device file.
>   OMAP3: PM: Adding smartreflex hwmod data
>   OMAP3: PM: Adding smartreflex class3 driver
>   OMAP3: PM: Adding T2 enabling of smartreflex support
>   OMAP3: PM: Register TWL4030 pmic info with the voltage driver.
>   OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
>   OMAP3: PM: Program correct init voltages for VDD1 and VDD2
>
>  arch/arm/mach-omap2/Makefile                  |    7 +-
>  arch/arm/mach-omap2/control.h                 |   17 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  176 ++++
>  arch/arm/mach-omap2/omap_twl.c                |  111 +++
>  arch/arm/mach-omap2/pm.c                      |   90 ++
>  arch/arm/mach-omap2/pm.h                      |   23 +
>  arch/arm/mach-omap2/smartreflex-class3.c      |   59 ++
>  arch/arm/mach-omap2/smartreflex.c             | 1025 ++++++++++++++++++++
>  arch/arm/mach-omap2/sr_device.c               |  131 +++
>  arch/arm/mach-omap2/voltage.c                 | 1292 +++++++++++++++++++++++++
>  arch/arm/plat-omap/Kconfig                    |   31 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    5 +
>  arch/arm/plat-omap/include/plat/smartreflex.h |  245 +++++
>  arch/arm/plat-omap/include/plat/voltage.h     |  134 +++
>  drivers/mfd/twl-core.c                        |   13 +
>  include/linux/i2c/twl.h                       |   11 +
>  16 files changed, 3369 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap_twl.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
