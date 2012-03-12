From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] ARM: OMAP2+: resolve some warnings from sparse, cppcheck
Date: Mon, 12 Mar 2012 16:42:51 -0600
Message-ID: <20120312224006.4103.29464.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37679 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab2CLWnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 18:43:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello

This series resolves all of the current sparse warnings and many of
the meaningful cppcheck warnings in arch/arm/mach-omap2.

This series is also available from git://git.pwsan.com/linux-2.6 in the
branch 'sparse_cppcheck_fixes_3.4'.


- Paul

---

sparse_cppcheck_fixes_3.4
   text	   data	    bss	    dec	    hex	filename
6588152	 692980	5594140	12875272	 c47608	vmlinux.omap2plus_defconfig.orig
6588028	 692956	5594140	12875124	 c47574	vmlinux.omap2plus_defconfig

Paul Walmsley (5):
      ARM: OMAP2+: declare file-local functions as static
      ARM: OMAP2+: add includes for missing prototypes
      ARM: OMAP2+: GPMC: resolve type-conversion warning from sparse
      ARM: OMAP2+: fix 'using plain integer as NULL pointer' sparse warnings
      ARM: OMAP2+: clean up some cppcheck warnings


 arch/arm/mach-omap2/board-am3517evm.c        |    6 +-----
 arch/arm/mach-omap2/board-omap3evm.c         |    8 ++++----
 arch/arm/mach-omap2/board-omap4panda.c       |    8 ++++----
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++--
 arch/arm/mach-omap2/board-zoom-display.c     |    1 +
 arch/arm/mach-omap2/devices.c                |    3 +--
 arch/arm/mach-omap2/gpio.c                   |    4 ++--
 arch/arm/mach-omap2/gpmc-onenand.c           |    3 +--
 arch/arm/mach-omap2/gpmc.c                   |    3 +--
 arch/arm/mach-omap2/hsmmc.c                  |    2 +-
 arch/arm/mach-omap2/hwspinlock.c             |    2 +-
 arch/arm/mach-omap2/irq.c                    |    3 ++-
 arch/arm/mach-omap2/mcbsp.c                  |    2 +-
 arch/arm/mach-omap2/mux.c                    |    2 +-
 arch/arm/mach-omap2/omap-secure.c            |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                 |    3 ---
 arch/arm/mach-omap2/pm34xx.c                 |    4 +---
 arch/arm/mach-omap2/prm_common.c             |    4 +++-
 arch/arm/mach-omap2/serial.c                 |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c           |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h    |    4 ++--
 22 files changed, 33 insertions(+), 40 deletions(-)

