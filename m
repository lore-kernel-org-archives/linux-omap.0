From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes for
 v3.4 merge window
Date: Wed, 15 Feb 2012 10:28:19 -0800
Message-ID: <20120215182355.18884.18682.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57184 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab2BOS2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 13:28:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series fixes up the issues noted by Russell on omap2_hsmmc_init()
where if TWL PMIC is compiled as a module we can't keep a bunch of
functions marked as __init like they should be. This series fixes
the issues by splitting omap2_hsmmc_init() into two functions.

One more patch is needed to sort out the remaining issue with
omap4 that has yet another luck based initialization for the
same issue..

Regards,

Tony

---

Ohad Ben-Cohen (1):
      ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

Tony Lindgren (2):
      ARM: OMAP2+: Split omap2_hsmmc_init() to properly support I2C GPIO pins
      ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux related functions as __init


 arch/arm/mach-omap2/board-2430sdp.c           |    2 
 arch/arm/mach-omap2/board-3430sdp.c           |    5 +
 arch/arm/mach-omap2/board-4430sdp.c           |    6 +
 arch/arm/mach-omap2/board-am3517evm.c         |    2 
 arch/arm/mach-omap2/board-cm-t35.c            |    6 +
 arch/arm/mach-omap2/board-devkit8000.c        |    4 +
 arch/arm/mach-omap2/board-flash.c             |    2 
 arch/arm/mach-omap2/board-igep0020.c          |    7 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 
 arch/arm/mach-omap2/board-omap3beagle.c       |   10 ++
 arch/arm/mach-omap2/board-omap3evm.c          |    8 +-
 arch/arm/mach-omap2/board-omap3logic.c        |    2 
 arch/arm/mach-omap2/board-omap3pandora.c      |    6 +
 arch/arm/mach-omap2/board-omap3stalker.c      |   15 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c    |   17 ++--
 arch/arm/mach-omap2/board-omap4panda.c        |    6 +
 arch/arm/mach-omap2/board-overo.c             |    5 +
 arch/arm/mach-omap2/board-rm680.c             |    2 
 arch/arm/mach-omap2/board-rx51-peripherals.c  |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    6 +
 arch/arm/mach-omap2/display.c                 |    8 +-
 arch/arm/mach-omap2/hsmmc.c                   |  111 ++++++++++++++++++-------
 arch/arm/mach-omap2/hsmmc.h                   |   12 ++-
 arch/arm/mach-omap2/mux.c                     |   22 ++---
 arch/arm/plat-omap/include/plat/omap_device.h |    7 ++
 arch/arm/plat-omap/omap_device.c              |   13 +--
 26 files changed, 192 insertions(+), 96 deletions(-)

-- 
Signature
