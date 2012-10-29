From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 00/13] ARM: OMAP: remove prcm.[ch]
Date: Mon, 29 Oct 2012 16:03:09 +0530
Message-ID: <508E5B65.2020800@ti.com>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2J2KdU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:33:20 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/26/2012 4:51 AM, Paul Walmsley wrote:
> Remove arch/arm/mach-omap2/prcm.c and
> arch/arm/plat-omap/include/plat/prcm.h.  This is in preparation for
> moving the PRM/CM code to drivers/, although to be fair, these files
> should have been removed a long time ago.
> 
> Intended for 3.8 cleanup.  Applies on top of the existing PRM/CM split
> cleanup series, and the WDTIMER cleanup series.
> 

Paul,

By any chance you have branch available with these patches, so that I
can validate them here at my end?

Thanks,
Vaibhav

> 
> - Paul
> 
> ---
> 
> omap2_prcm_cleanup_3.8
>    text	   data	    bss	    dec	    hex	filename
> 7521423	 696876	5613996	13832295	 d31067	vmlinux.omap2plus_defconfig.orig
> 7522239	 696612	5613996	13832847	 d3128f	vmlinux.omap2plus_defconfig
> 
> Paul Walmsley (13):
>       ARM: OMAP2+: common: remove mach-omap2/common.c and map_common_io code
>       ARM: OMAP2/3: PRM: add SoC reset functions (using the CORE DPLL method)
>       ARM: OMAP2xxx: clock: remove global 'dclk' variable
>       ARM: OMAP2xxx: clock: move virt_prcm_set code into clkt2xxx_virt_prcm_set.c
>       ARM: OMAP2+: PRCM: create SoC-specific chip restart functions
>       ARM: OMAP2+: board files: use SoC-specific system restart functions
>       ARM: OMAP2xxx: APLL/CM: convert to use omap2_cm_wait_module_ready()
>       ARM: OMAP2+: CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM functions
>       ARM: OMAP2+: PRCM: remove omap2_cm_wait_idlest()
>       ARM: OMAP2+: PRCM: split and relocate the PRM/CM globals setup
>       ARM: OMAP2+: PRCM: consolidate PRCM-related timeout macros
>       ARM: OMAP2+: hwmod: call to _omap4_disable_module() should use the SoC-specific call
>       ARM: OMAP2+: PRCM: remove obsolete prcm.[ch]
> 
> 
>  arch/arm/mach-omap1/reset.c                  |    2 
>  arch/arm/mach-omap2/Makefile                 |    9 +
>  arch/arm/mach-omap2/am33xx.h                 |    1 
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 
>  arch/arm/mach-omap2/board-3430sdp.c          |    2 
>  arch/arm/mach-omap2/board-3630sdp.c          |    2 
>  arch/arm/mach-omap2/board-4430sdp.c          |    2 
>  arch/arm/mach-omap2/board-am3517crane.c      |    2 
>  arch/arm/mach-omap2/board-am3517evm.c        |    2 
>  arch/arm/mach-omap2/board-apollon.c          |    2 
>  arch/arm/mach-omap2/board-cm-t35.c           |   18 +-
>  arch/arm/mach-omap2/board-cm-t3517.c         |    2 
>  arch/arm/mach-omap2/board-devkit8000.c       |    2 
>  arch/arm/mach-omap2/board-generic.c          |   10 +
>  arch/arm/mach-omap2/board-h4.c               |    2 
>  arch/arm/mach-omap2/board-igep0020.c         |    4 -
>  arch/arm/mach-omap2/board-ldp.c              |    2 
>  arch/arm/mach-omap2/board-n8x0.c             |    6 -
>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 
>  arch/arm/mach-omap2/board-omap3evm.c         |    2 
>  arch/arm/mach-omap2/board-omap3logic.c       |    4 -
>  arch/arm/mach-omap2/board-omap3pandora.c     |    2 
>  arch/arm/mach-omap2/board-omap3stalker.c     |    2 
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 
>  arch/arm/mach-omap2/board-omap4panda.c       |    2 
>  arch/arm/mach-omap2/board-overo.c            |    2 
>  arch/arm/mach-omap2/board-rm680.c            |    4 -
>  arch/arm/mach-omap2/board-rx51.c             |    2 
>  arch/arm/mach-omap2/board-ti8168evm.c        |    4 -
>  arch/arm/mach-omap2/board-zoom.c             |    4 -
>  arch/arm/mach-omap2/clkt2xxx_apll.c          |   57 ++-----
>  arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   36 ++++-
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   70 ++++++++-
>  arch/arm/mach-omap2/clkt_iclk.c              |    1 
>  arch/arm/mach-omap2/clock.c                  |   15 +-
>  arch/arm/mach-omap2/clock.h                  |   28 ----
>  arch/arm/mach-omap2/clock2420_data.c         |   26 +--
>  arch/arm/mach-omap2/clock2430_data.c         |   26 +--
>  arch/arm/mach-omap2/clock2xxx.c              |   16 --
>  arch/arm/mach-omap2/clock2xxx.h              |    9 +
>  arch/arm/mach-omap2/cm-regbits-24xx.h        |    2 
>  arch/arm/mach-omap2/cm.h                     |   20 ++-
>  arch/arm/mach-omap2/cm2xxx.c                 |  128 ++++++++++++++++
>  arch/arm/mach-omap2/cm2xxx.h                 |    4 +
>  arch/arm/mach-omap2/cm2xxx_3xxx.h            |    8 +
>  arch/arm/mach-omap2/cm3xxx.c                 |   66 ++++++++
>  arch/arm/mach-omap2/cm3xxx.h                 |    5 +
>  arch/arm/mach-omap2/cm_common.c              |   70 +++++++++
>  arch/arm/mach-omap2/cminst44xx.h             |    2 
>  arch/arm/mach-omap2/common.c                 |  202 --------------------------
>  arch/arm/mach-omap2/common.h                 |  111 ++------------
>  arch/arm/mach-omap2/control.c                |   10 +
>  arch/arm/mach-omap2/control.h                |    2 
>  arch/arm/mach-omap2/cpuidle34xx.c            |    1 
>  arch/arm/mach-omap2/display.c                |    2 
>  arch/arm/mach-omap2/hdq1w.c                  |    4 -
>  arch/arm/mach-omap2/i2c.c                    |    6 -
>  arch/arm/mach-omap2/id.c                     |    7 +
>  arch/arm/mach-omap2/io.c                     |   87 +++++++++--
>  arch/arm/mach-omap2/mcbsp.c                  |    2 
>  arch/arm/mach-omap2/msdi.c                   |    4 -
>  arch/arm/mach-omap2/omap2-restart.c          |   65 ++++++++
>  arch/arm/mach-omap2/omap3-restart.c          |   36 +++++
>  arch/arm/mach-omap2/omap4-common.c           |   18 ++
>  arch/arm/mach-omap2/omap_hwmod.c             |    8 -
>  arch/arm/mach-omap2/pm34xx.c                 |    1 
>  arch/arm/mach-omap2/powerdomain.c            |    2 
>  arch/arm/mach-omap2/prcm-common.h            |   22 ---
>  arch/arm/mach-omap2/prcm.c                   |  176 -----------------------
>  arch/arm/mach-omap2/prcm_mpu44xx.c           |   17 ++
>  arch/arm/mach-omap2/prcm_mpu44xx.h           |    9 +
>  arch/arm/mach-omap2/prm.h                    |   24 +++
>  arch/arm/mach-omap2/prm2xxx.c                |   15 ++
>  arch/arm/mach-omap2/prm2xxx.h                |    2 
>  arch/arm/mach-omap2/prm2xxx_3xxx.h           |    7 -
>  arch/arm/mach-omap2/prm3xxx.c                |   16 ++
>  arch/arm/mach-omap2/prm3xxx.h                |    2 
>  arch/arm/mach-omap2/prm44xx.c                |    1 
>  arch/arm/mach-omap2/prm_common.c             |   16 ++
>  arch/arm/mach-omap2/prminst44xx.h            |    2 
>  arch/arm/mach-omap2/sdrc.c                   |    8 -
>  arch/arm/mach-omap2/sdrc.h                   |    3 
>  arch/arm/mach-omap2/ti81xx.h                 |    9 +
>  arch/arm/mach-omap2/wd_timer.c               |    5 -
>  arch/arm/plat-omap/include/plat/prcm.h       |   36 -----
>  85 files changed, 827 insertions(+), 804 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/common.c
>  create mode 100644 arch/arm/mach-omap2/omap2-restart.c
>  create mode 100644 arch/arm/mach-omap2/omap3-restart.c
>  delete mode 100644 arch/arm/mach-omap2/prcm.c
>  delete mode 100644 arch/arm/plat-omap/include/plat/prcm.h
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
