From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/13] omap updates for 2.6.36 merge window
Date: Thu, 08 Jul 2010 16:54:17 +0300
Message-ID: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55073 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab0GHNyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap updates for the upcoming merge window.

Regards,

Tony

---

Cory Maccarrone (1):
      omap1: omap7xx clocks, mux, serial fixes

Grazvydas Ignotas (1):
      omap: mux: fix multipath gpio handling

Kan-Ru Chen (3):
      omap: Add new interface omap_get_die_id
      omap: Use omap_get_die_id() to get the DIE ids
      omap: Devkit8000: Use DIE id to initialize dm9000 MAC address

Mike Rapoport (1):
      omap3: introduce omap3_map_io

Nishanth Menon (1):
      omap2/3: id: fix sparse warning

Samu Onkalo (1):
      omap: dma: Support for prefetch in destination synchronizedtransfer

Sergio Aguirre (1):
      omap3: Unify omap2_set_globals_3[43,6x]x functions

Steve Sakoman (1):
      omap: Overo: Fix support for second ethernet port

Tony Lindgren (2):
      omap: Add back UART MDR1 check into uncompress.h
      omap2: Fix GPIO numbers and smc91x for 2430sdp

stanley.miao (1):
      OMAP3: AM3505/3517 do not have IO wakeup capability


 arch/arm/mach-omap1/clock_data.c             |   20 ++++++++++
 arch/arm/mach-omap1/mux.c                    |    4 ++
 arch/arm/mach-omap1/serial.c                 |    7 ++++
 arch/arm/mach-omap2/board-2430sdp.c          |    6 +--
 arch/arm/mach-omap2/board-3430sdp.c          |    8 +---
 arch/arm/mach-omap2/board-3630sdp.c          |    8 +---
 arch/arm/mach-omap2/board-am3517evm.c        |    8 +---
 arch/arm/mach-omap2/board-cm-t35.c           |    8 +---
 arch/arm/mach-omap2/board-devkit8000.c       |   22 ++++++++---
 arch/arm/mach-omap2/board-igep0020.c         |    8 +---
 arch/arm/mach-omap2/board-ldp.c              |    8 +---
 arch/arm/mach-omap2/board-omap3beagle.c      |    8 +---
 arch/arm/mach-omap2/board-omap3evm.c         |    8 +---
 arch/arm/mach-omap2/board-omap3pandora.c     |    8 +---
 arch/arm/mach-omap2/board-omap3stalker.c     |    8 +---
 arch/arm/mach-omap2/board-omap3touchbook.c   |    8 +---
 arch/arm/mach-omap2/board-overo.c            |   50 +++++++++++++++++++++-----
 arch/arm/mach-omap2/board-rx51.c             |    2 +
 arch/arm/mach-omap2/board-zoom2.c            |    8 +---
 arch/arm/mach-omap2/board-zoom3.c            |    8 +---
 arch/arm/mach-omap2/id.c                     |   36 ++++++++++++-------
 arch/arm/mach-omap2/include/mach/id.h        |   22 +++++++++++
 arch/arm/mach-omap2/mux.c                    |   38 ++++++++++----------
 arch/arm/mach-omap2/pm34xx.c                 |    7 ++--
 arch/arm/plat-omap/common.c                  |   10 +++--
 arch/arm/plat-omap/dma.c                     |   11 ++++--
 arch/arm/plat-omap/gpio.c                    |    4 ++
 arch/arm/plat-omap/include/plat/common.h     |    5 ++-
 arch/arm/plat-omap/include/plat/cpu.h        |    2 +
 arch/arm/plat-omap/include/plat/dma.h        |    1 +
 arch/arm/plat-omap/include/plat/mux.h        |    4 ++
 arch/arm/plat-omap/include/plat/uncompress.h |    6 +++
 32 files changed, 202 insertions(+), 159 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/id.h

-- 
Signature
