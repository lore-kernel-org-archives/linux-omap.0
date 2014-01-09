From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] trivial omap big endian changes for v3.14 merge window
Date: Wed, 8 Jan 2014 17:21:40 -0800
Message-ID: <20140109012139.GK31323@atomide.com>
References: <20140109011940.GI31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10290 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAIBVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 20:21:45 -0500
Content-Disposition: inline
In-Reply-To: <20140109011940.GI31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:

  Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/be-signed

for you to fetch changes up to fc6ca98c81bf0ea8b46064915b5947b971594101:

  ARM: OMAP: debug-leds: raw read and write endian fix (2014-01-07 16:09:45 -0800)

----------------------------------------------------------------
Trivial search and replace of read and write functions to allow
further patches to make omaps work also in big endian mode.

----------------------------------------------------------------
Victor Kamensky (4):
      ARM: OMAP2+: raw read and write endian fix
      ARM: OMAP: dmtimer: raw read and write endian fix
      ARM: OMAP: counter-32k: raw read and write endian fix
      ARM: OMAP: debug-leds: raw read and write endian fix

 arch/arm/mach-omap2/board-flash.c         |  4 +--
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c   |  2 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c        |  8 +++---
 arch/arm/mach-omap2/clkt2xxx_sys.c        |  2 +-
 arch/arm/mach-omap2/clkt_clksel.c         | 10 ++++----
 arch/arm/mach-omap2/clkt_dpll.c           |  6 ++---
 arch/arm/mach-omap2/clkt_iclk.c           |  8 +++---
 arch/arm/mach-omap2/clock.c               | 16 ++++++------
 arch/arm/mach-omap2/clock36xx.c           |  6 ++---
 arch/arm/mach-omap2/cm2xxx_3xxx.h         |  4 +--
 arch/arm/mach-omap2/cm33xx.c              |  4 +--
 arch/arm/mach-omap2/cm3xxx.c              |  8 +++---
 arch/arm/mach-omap2/cm44xx.c              |  8 +++---
 arch/arm/mach-omap2/cminst44xx.c          |  4 +--
 arch/arm/mach-omap2/control.c             | 20 +++++++--------
 arch/arm/mach-omap2/dma.c                 |  4 +--
 arch/arm/mach-omap2/dpll3xxx.c            | 32 +++++++++++------------
 arch/arm/mach-omap2/dpll44xx.c            | 12 ++++-----
 arch/arm/mach-omap2/gpmc.c                |  8 +++---
 arch/arm/mach-omap2/id.c                  |  2 +-
 arch/arm/mach-omap2/irq.c                 |  4 +--
 arch/arm/mach-omap2/mux.c                 |  8 +++---
 arch/arm/mach-omap2/omap-hotplug.c        |  4 +--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 18 ++++++-------
 arch/arm/mach-omap2/omap-smp.c            |  4 +--
 arch/arm/mach-omap2/omap-wakeupgen.c      | 42 +++++++++++++++----------------
 arch/arm/mach-omap2/omap4-common.c        | 16 ++++++------
 arch/arm/mach-omap2/omap_hwmod.c          | 10 ++++----
 arch/arm/mach-omap2/omap_phy_internal.c   |  6 ++---
 arch/arm/mach-omap2/prcm_mpu44xx.c        |  4 +--
 arch/arm/mach-omap2/prm2xxx.h             |  2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |  4 +--
 arch/arm/mach-omap2/prm33xx.c             |  4 +--
 arch/arm/mach-omap2/prm3xxx.h             |  2 +-
 arch/arm/mach-omap2/prm44xx.c             |  4 +--
 arch/arm/mach-omap2/prminst44xx.c         |  4 +--
 arch/arm/mach-omap2/sdrc.h                |  8 +++---
 arch/arm/mach-omap2/sdrc2xxx.c            |  4 +--
 arch/arm/mach-omap2/sr_device.c           |  2 +-
 arch/arm/mach-omap2/sram.c                | 16 ++++++------
 arch/arm/mach-omap2/timer.c               |  8 +++---
 arch/arm/mach-omap2/vc.c                  |  4 +--
 arch/arm/mach-omap2/wd_timer.c            |  8 +++---
 arch/arm/plat-omap/counter_32k.c          |  6 ++---
 arch/arm/plat-omap/debug-leds.c           | 14 +++++------
 arch/arm/plat-omap/dmtimer.c              |  8 +++---
 arch/arm/plat-omap/include/plat/dmtimer.h | 16 ++++++------
 47 files changed, 199 insertions(+), 199 deletions(-)
