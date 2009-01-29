From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap-fixes (Re: [PATCH 0/9] Omap fixes for
	2.6.29-rc series, also one arm generic fix)
Date: Thu, 29 Jan 2009 10:49:43 -0800
Message-ID: <20090129184943.GC7215@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128192126.GF23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51533 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbZA2Stt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 13:49:49 -0500
Content-Disposition: inline
In-Reply-To: <20090128192126.GF23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 11:21]:
> No other comments on 3,4,5,7 and 9.

Here's the pull request for you.

Tony

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename="pull.txt"
Content-Transfer-Encoding: 8bit

The following changes since commit 18e352e4a73465349711a9324767e1b2453383e2:
  Linus Torvalds (1):
        Linux 2.6.29-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Aaro Koskinen (1):
      ARM: OMAP: gptimer min_delta_ns corrected

Jarkko Nikula (1):
      ARM: OMAP: DMA: Fix uninitialized channel flags

Juha Yrjola (1):
      ARM: OMAP: Fix race in OMAP2/3 DMA IRQ handling

Kevin Hilman (1):
      ARM: OMAP: fix fault in enter_full_retention()

Stanley.Miao (1):
      ARM: OMAP: Fix McBSP spin_lock deadlock

Tony Lindgren (2):
      ARM: OMAP: Fix omap34xx revision detection for ES3.1
      ARM: OMAP: Fix hsmmc init, v2

김규원 (1):
      ARM: OMAP: Mask interrupts when disabling interrupts, v2

 arch/arm/mach-omap1/devices.c           |    2 +-
 arch/arm/mach-omap1/mcbsp.c             |   98 ++-------------------
 arch/arm/mach-omap2/devices.c           |   11 ++-
 arch/arm/mach-omap2/id.c                |    6 +-
 arch/arm/mach-omap2/irq.c               |    1 +
 arch/arm/mach-omap2/mcbsp.c             |  145 ++++++-------------------------
 arch/arm/mach-omap2/sleep24xx.S         |    3 +-
 arch/arm/mach-omap2/timer-gp.c          |    3 +-
 arch/arm/plat-omap/devices.c            |    7 +-
 arch/arm/plat-omap/dma.c                |    5 +-
 arch/arm/plat-omap/include/mach/cpu.h   |    1 +
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +-
 arch/arm/plat-omap/include/mach/mmc.h   |   10 ++-
 arch/arm/plat-omap/mcbsp.c              |   52 ++++++++---
 14 files changed, 109 insertions(+), 241 deletions(-)

--0eh6TmSyL6TZE2Uz--
