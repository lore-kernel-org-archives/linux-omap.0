From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH 0/2] twl4030_codec cleanup
Date: Wed,  2 Mar 2011 15:24:04 +0200
Message-ID: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.ujfalusi@nokia.com, tony@atomide.com, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

This series of patches removes duplicate audio_mclk fields from
twl4030_codec driver.

The patches have been compiled on sound-2.6/for-2.6.39 branch.
I haven't tested them on any target board though.

Ilkka Koskinen (2):
  omap: Remove unnecessary twl4030_codec_audio settings from board
    files
  mfd: twl4030_codec: Remove unused and duplicate audio_mclk fields

 arch/arm/mach-omap2/board-3430sdp.c          |    4 +---
 arch/arm/mach-omap2/board-devkit8000.c       |    4 +---
 arch/arm/mach-omap2/board-igep0020.c         |    4 +---
 arch/arm/mach-omap2/board-omap3beagle.c      |    4 +---
 arch/arm/mach-omap2/board-omap3evm.c         |    4 +---
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 +---
 arch/arm/mach-omap2/board-omap3stalker.c     |    4 +---
 arch/arm/mach-omap2/board-omap3touchbook.c   |    4 +---
 arch/arm/mach-omap2/board-overo.c            |    4 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +---
 include/linux/i2c/twl.h                      |    2 --
 11 files changed, 10 insertions(+), 32 deletions(-)
