From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] ARM: OMAP: remove clock files in arch/arm/plat-omap
Date: Thu, 27 Sep 2012 10:33:29 -0600
Message-ID: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46743 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2I0Qfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove clock-related header and C files from arch/arm/plat-omap.  The
intention is to support people working on the ARM single kernel image
project, since the 'plat' symlink will no longer be available for
OMAP-shared files.

Intended for 3.8 cleanup.

---
plat_clock_removal_cleanup_3.8
   text	   data	    bss	    dec	    hex	filename
5392024  346692  121276 5859992		 596a98 vmlinux.omap1_defconfig
7342851	 694332	5613708	13650891	 d04bcb	vmlinux.omap2plus_defconfig.orig
7342623	 694292	5613708	13650623	 d04abf	vmlinux.omap2plus_defconfig

Paul Walmsley (6):
      OMAPDSS: remove unnecessary plat/clock.h includes
      staging: tidspbridge: remove unnecessary include of <plat/clock.h>
      cpufreq: OMAP: remove unnecessary include of plat/clock.h
      ARM: OMAP: duplicate plat-omap/clock.c into mach-omap[12]/clock.c
      ARM: OMAP: remove plat/clock.h
      ARM: OMAP: clock: split plat/clkdev_omap.h into OMAP1/2 files


 arch/arm/mach-omap1/board-nokia770.c               |    2 
 arch/arm/mach-omap1/clock.c                        |  502 ++++++++++++++++++
 arch/arm/mach-omap1/clock.h                        |  178 +++++++
 arch/arm/mach-omap1/clock_data.c                   |   13 
 arch/arm/mach-omap1/opp_data.c                     |    2 
 arch/arm/mach-omap1/pm.c                           |    2 
 arch/arm/mach-omap2/clkt2xxx_apll.c                |    2 
 arch/arm/mach-omap2/clkt2xxx_dpll.c                |    2 
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |    2 
 arch/arm/mach-omap2/clkt2xxx_osc.c                 |    2 
 arch/arm/mach-omap2/clkt2xxx_sys.c                 |    2 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    2 
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    2 
 arch/arm/mach-omap2/clkt_clksel.c                  |    2 
 arch/arm/mach-omap2/clkt_dpll.c                    |    2 
 arch/arm/mach-omap2/clkt_iclk.c                    |    2 
 arch/arm/mach-omap2/clock.c                        |  519 +++++++++++++++++++
 arch/arm/mach-omap2/clock.h                        |  317 ++++++++++++
 arch/arm/mach-omap2/clock2420_data.c               |    4 
 arch/arm/mach-omap2/clock2430.c                    |    2 
 arch/arm/mach-omap2/clock2430_data.c               |    4 
 arch/arm/mach-omap2/clock2xxx.c                    |    2 
 arch/arm/mach-omap2/clock33xx_data.c               |    3 
 arch/arm/mach-omap2/clock34xx.c                    |    2 
 arch/arm/mach-omap2/clock3517.c                    |    2 
 arch/arm/mach-omap2/clock36xx.c                    |    2 
 arch/arm/mach-omap2/clock3xxx.c                    |    2 
 arch/arm/mach-omap2/clock3xxx_data.c               |    4 
 arch/arm/mach-omap2/clock44xx_data.c               |    4 
 arch/arm/mach-omap2/clockdomain.c                  |    2 
 arch/arm/mach-omap2/clockdomain.h                  |    2 
 arch/arm/mach-omap2/common.c                       |    2 
 arch/arm/mach-omap2/dpll3xxx.c                     |    2 
 arch/arm/mach-omap2/dpll44xx.c                     |    2 
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 
 arch/arm/mach-omap2/pm-debug.c                     |    2 
 arch/arm/mach-omap2/pm24xx.c                       |    2 
 arch/arm/mach-omap2/sdram-nokia.c                  |    2 
 arch/arm/mach-omap2/sdrc.c                         |    2 
 arch/arm/mach-omap2/sdrc2xxx.c                     |    2 
 arch/arm/plat-omap/Makefile                        |    2 
 arch/arm/plat-omap/clock.c                         |  544 --------------------
 arch/arm/plat-omap/counter_32k.c                   |    1 
 arch/arm/plat-omap/include/plat/clock.h            |  309 -----------
 arch/arm/plat-omap/omap_device.c                   |    1 
 drivers/cpufreq/omap-cpufreq.c                     |    1 
 .../tidspbridge/include/dspbridge/host_os.h        |    1 
 drivers/video/omap2/dss/dispc.c                    |    1 
 drivers/video/omap2/dss/dsi.c                      |    1 
 drivers/video/omap2/dss/dss.c                      |    1 
 50 files changed, 1536 insertions(+), 934 deletions(-)
 delete mode 100644 arch/arm/plat-omap/clock.c
 delete mode 100644 arch/arm/plat-omap/include/plat/clock.h

