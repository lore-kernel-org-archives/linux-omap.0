From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap clean-up for v3.20
Date: Fri, 16 Jan 2015 15:21:21 -0800
Message-ID: <30439.9910652593$1421450711@news.gmane.org>
References: <pull-1421450357-648499>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19515 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751134AbbAPXZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 18:25:04 -0500
In-Reply-To: <pull-1421450357-648499>
In-Reply-To: <pull-1421450357-648499>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/cleanup-pt1

for you to fetch changes up to ca662ee7b8a85c54c1cb9ef34b7c6b4f67933a7e:

  ARM: OMAP2+: Remove unused ti81xx platform init code (2015-01-14 17:21:00 -0800)

----------------------------------------------------------------
Clean-up for omaps to remove dead code found with cppcheck after
we've made several SoCs to boot in device tree only mode.

----------------------------------------------------------------
Rickard Strandqvist (10):
      ARM: OMAP2+: clkt2xxx_apll.c: Remove some unused functions
      ARM: OMAP2+: cm33xx.c: Remove some unused functions
      ARM: OMAP2+: dpll44xx.c: Remove unused function
      ARM: OMAP2+: omap_hwmod.c: Remove some unused functions
      ARM: OMAP2+: powerdomain.c: Remove some unused functions
      ARM: OMAP2+: voltage: Remove some unused functions
      ARM: OMAP2+: omap-pm-noop.c: Remove some unused functions
      ARM: OMAP1: irq.c: Remove unused function
      ARM: OMAP1: timer32k.c: Remove unused function
      ARM: OMAP: dma.c: Remove unused function

Tero Kristo (3):
      ARM: OMAP2: clock: remove unused apll code
      ARM: OMAP2: CM: remove unused PLL functions
      ARM: OMAP3+: PRM: remove prm_get_reset_sources declaration from headers

Tony Lindgren (1):
      ARM: OMAP2+: Remove unused ti81xx platform init code

 arch/arm/mach-omap1/irq.c               |   5 -
 arch/arm/mach-omap1/timer32k.c          |   5 -
 arch/arm/mach-omap2/Makefile            |   1 -
 arch/arm/mach-omap2/cclock3xxx_data.c   |   6 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c     | 142 -------------------
 arch/arm/mach-omap2/clock.h             |   1 -
 arch/arm/mach-omap2/clock2xxx.h         |  11 --
 arch/arm/mach-omap2/cm2xxx.c            |  10 --
 arch/arm/mach-omap2/cm2xxx.h            |   2 -
 arch/arm/mach-omap2/cm33xx.c            |  21 ---
 arch/arm/mach-omap2/dpll44xx.c          |  20 ---
 arch/arm/mach-omap2/omap-pm-noop.c      | 196 ---------------------------
 arch/arm/mach-omap2/omap-pm.h           | 192 --------------------------
 arch/arm/mach-omap2/omap_hwmod.c        | 232 --------------------------------
 arch/arm/mach-omap2/omap_hwmod.h        |  16 ---
 arch/arm/mach-omap2/omap_phy_internal.c |  35 -----
 arch/arm/mach-omap2/powerdomain.c       |  82 -----------
 arch/arm/mach-omap2/powerdomain.h       |   5 -
 arch/arm/mach-omap2/prm3xxx.h           |   1 -
 arch/arm/mach-omap2/prm44xx_54xx.h      |   1 -
 arch/arm/mach-omap2/usb-musb.c          |  12 +-
 arch/arm/mach-omap2/usb.h               |   2 -
 arch/arm/mach-omap2/voltage.c           | 110 ---------------
 arch/arm/mach-omap2/voltage.h           |  13 --
 arch/arm/plat-omap/dma.c                |   8 --
 25 files changed, 3 insertions(+), 1126 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c
