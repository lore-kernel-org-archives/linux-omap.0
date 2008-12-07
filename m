From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Omap MMC init updates and new controller for 2.6.29 merge
	window
Date: Sun, 07 Dec 2008 13:45:13 -0800
Message-ID: <20081207213617.10456.43951.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58768 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYLGVpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2008 16:45:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi Pierre & Russell,

This series contains a better platform init for omap MMC as discussed earlier
on the linux-omap mailing list. The last patch in the series adds support for
a newer omap MMC controller available on 2430 and 34xx omaps.

The first four patches should get merged via Russell. The last one adding
the new controller depends on comments from Pierre, so I can separate
that out if desired.

The third patch in the series depends on the "Omap3 updates for 2.6.29
merge window" series for the changes to Pandora board support.

Comments welcome as always!

Regards,

Tony

---

Kevin Hilman (1):
      omap mmc: force MMC module reset on boot

Madhusudhan Chikkature (1):
      omap mmc: Add new omap hsmmc controller for 2430 and 34xx

Tony Lindgren (3):
      omap mmc: Add low-level initialization for hsmmc controller
      omap mmc: Add better MMC low-level init
      omap mmc: Remove broken MMC init code


 arch/arm/mach-omap1/board-h2-mmc.c         |   89 +-
 arch/arm/mach-omap1/board-h2.c             |   25 -
 arch/arm/mach-omap1/board-h3-mmc.c         |  100 +-
 arch/arm/mach-omap1/board-h3.c             |   10 
 arch/arm/mach-omap1/board-innovator.c      |   50 +
 arch/arm/mach-omap1/board-nokia770.c       |   74 +-
 arch/arm/mach-omap1/board-palmte.c         |    1 
 arch/arm/mach-omap1/board-palmz71.c        |   11 
 arch/arm/mach-omap1/board-sx1-mmc.c        |   80 --
 arch/arm/mach-omap1/board-sx1.c            |   10 
 arch/arm/mach-omap1/board-voiceblue.c      |   10 
 arch/arm/mach-omap1/clock.h                |    3 
 arch/arm/mach-omap1/devices.c              |   90 ++
 arch/arm/mach-omap2/Makefile               |   15 
 arch/arm/mach-omap2/board-2430sdp.c        |   48 +
 arch/arm/mach-omap2/board-apollon.c        |   11 
 arch/arm/mach-omap2/board-generic.c        |   11 
 arch/arm/mach-omap2/board-h4.c             |   11 
 arch/arm/mach-omap2/board-ldp.c            |   40 +
 arch/arm/mach-omap2/board-omap3beagle.c    |   90 ++
 arch/arm/mach-omap2/board-omap3pandora.c   |   32 +
 arch/arm/mach-omap2/board-overo.c          |   43 +
 arch/arm/mach-omap2/clock24xx.h            |    9 
 arch/arm/mach-omap2/clock34xx.h            |   10 
 arch/arm/mach-omap2/devices.c              |  169 ++++
 arch/arm/mach-omap2/mmc-twl4030.c          |  408 +++++++++
 arch/arm/mach-omap2/mmc-twl4030.h          |   29 +
 arch/arm/plat-omap/devices.c               |  225 +----
 arch/arm/plat-omap/include/mach/board-h2.h |    6 
 arch/arm/plat-omap/include/mach/board.h    |   22 
 arch/arm/plat-omap/include/mach/control.h  |   17 
 arch/arm/plat-omap/include/mach/mmc.h      |   74 ++
 drivers/mmc/host/Kconfig                   |   11 
 drivers/mmc/host/Makefile                  |    1 
 drivers/mmc/host/omap.c                    |    7 
 drivers/mmc/host/omap_hsmmc.c              | 1242 ++++++++++++++++++++++++++++
 36 files changed, 2536 insertions(+), 548 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mmc-twl4030.c
 create mode 100644 arch/arm/mach-omap2/mmc-twl4030.h
 create mode 100644 drivers/mmc/host/omap_hsmmc.c

-- 
Signature
