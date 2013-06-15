From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 0/8] ARM: OMAP: dma.h and legacy code removal
Date: Sat, 15 Jun 2013 11:31:01 +0300
Message-ID: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33786 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab3FOIbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi

This set gets rid off arch/arm/mach-omap1/dma.h and
arch/arm/mach-omap2/dma.h by removing duplicated definitions,
by using numeric values when setting hwmod and platform data and
by removing legacy stuff.

Most cleanup is done by the scripts in commit logs and
set has been build tested with omap1_defconfig and omap2plus_defconfig.

Jarkko Nikula (8):
  ARM: OMAP2+: Remove AES crypto device DMA channel definitions
  ARM: OMAP2+: Remove duplicated DMA channel definitions
  ARM: OMAP2+: hwmod: Remove remaining DMA channel definitions
  ARM: OMAP2+: Remove dma.h
  ARM: OMAP1: Remove McBSP DMA channel definitions
  ARM: OMAP1: Remove duplicated DMA channel definitions
  ARM: OMAP1: Remove legacy irda.h and irda setup from board files
  ARM: OMAP1: Remove dma.h

 arch/arm/mach-omap1/board-h2.c                     |   36 ------------
 arch/arm/mach-omap1/board-palmte.c                 |   31 ----------
 arch/arm/mach-omap1/board-palmtt.c                 |   30 ----------
 arch/arm/mach-omap1/board-palmz71.c                |   31 ----------
 arch/arm/mach-omap1/board-sx1.c                    |   36 ------------
 arch/arm/mach-omap1/devices.c                      |    9 ++-
 arch/arm/mach-omap1/dma.c                          |    2 -
 arch/arm/mach-omap1/dma.h                          |   42 --------------
 arch/arm/mach-omap1/include/mach/irda.h            |   33 -----------
 arch/arm/mach-omap1/lcd_dma.c                      |    2 -
 arch/arm/mach-omap1/mcbsp.c                        |   33 +++++------
 arch/arm/mach-omap2/devices.c                      |    1 -
 arch/arm/mach-omap2/dma.h                          |   61 --------------------
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   21 ++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   19 +++---
 15 files changed, 39 insertions(+), 348 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/dma.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/irda.h
 delete mode 100644 arch/arm/mach-omap2/dma.h

-- 
1.7.10.4

