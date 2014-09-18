From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap clean-up for v3.18 merge window
Date: Thu, 18 Sep 2014 13:11:03 -0700
Message-ID: <46275.3902109855$1411071129@news.gmane.org>
References: <pull-1411070912-460910>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25582 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756171AbaIRUL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 16:11:58 -0400
In-Reply-To: <pull-1411070912-460910>
In-Reply-To: <pull-1411070912-460910>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/cleanup-for-v3.18

for you to fetch changes up to 3d0cb73e9c85e60206ea9d5191bc0b9a0c4c8a99:

  arm: mach-omap2: Convert pr_warning to pr_warn (2014-09-18 09:53:57 -0700)

----------------------------------------------------------------
Clean-up for omaps for v3.18 merge window:

- Remove unused pieces of the legacy DMA API as we're moving to
  dmaengine API

- Search and replace to standardize on pr_warn instead of pr_warning

----------------------------------------------------------------
Joe Perches (1):
      arm: mach-omap2: Convert pr_warning to pr_warn

Tony Lindgren (1):
      ARM: OMAP: Remove unused pieces of legacy DMA API

 arch/arm/mach-omap2/display.c            |   2 +-
 arch/arm/mach-omap2/hdq1w.c              |   4 +-
 arch/arm/mach-omap2/i2c.c                |   2 +-
 arch/arm/mach-omap2/msdi.c               |   4 +-
 arch/arm/mach-omap2/mux.c                |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c         |  26 +-
 arch/arm/mach-omap2/pdata-quirks.c       |   4 +-
 arch/arm/mach-omap2/pm34xx.c             |   2 +-
 arch/arm/mach-omap2/smartreflex-class3.c |   4 +-
 arch/arm/mach-omap2/sr_device.c          |   2 +-
 arch/arm/mach-omap2/vc.c                 |   2 +-
 arch/arm/mach-omap2/voltage.c            |  22 +-
 arch/arm/mach-omap2/wd_timer.c           |   4 +-
 arch/arm/plat-omap/dma.c                 | 737 +------------------------------
 include/linux/omap-dma.h                 |  37 --
 15 files changed, 46 insertions(+), 808 deletions(-)
