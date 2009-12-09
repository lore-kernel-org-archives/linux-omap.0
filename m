From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Few more omap patches for v2.6.33 merge window
Date: Tue, 08 Dec 2009 16:49:44 -0800
Message-ID: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63729 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966995AbZLIAtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:49:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few more patches that have been posted earlier to
linux-omap list but not yet posted to LAKML.

The series has few clean-up patches, updates Pandor board
file, adds omap7xx USB support and minimal support for
Always Innovating Touch Book.

Regards,

Tony


---

Cory Maccarrone (2):
      omap1: Add omap7xx USB support
      omap1: I2C mux and clocks for omap7xx

Grazvydas Ignotas (1):
      omap3: pandora: board file updates for .33

Gregoire Gentil (2):
      omap3: Board file of Always Innovating OMAP3-based Touch Book
      omap3: Defconfig file of Always Innovating OMAP3-based Touch Book

Janusz Krzysztofik (1):
      omap1: DMA: move LCD related code from plat-omap to mach-omap1

Ladislav Michl (3):
      omap: use smc91x_platdata to setup smc91x
      smc91x: remove OMAP specific bits
      omap1: Use gen_nand


 arch/arm/configs/omap3_touchbook_defconfig | 2431 ++++++++++++++++++++++++++++
 arch/arm/mach-omap1/Makefile               |    4 
 arch/arm/mach-omap1/board-fsample.c        |   60 +
 arch/arm/mach-omap1/board-h2.c             |   59 +
 arch/arm/mach-omap1/board-h3.c             |   66 +
 arch/arm/mach-omap1/board-htcherald.c      |   64 +
 arch/arm/mach-omap1/board-innovator.c      |   13 
 arch/arm/mach-omap1/board-osk.c            |   10 
 arch/arm/mach-omap1/board-perseus2.c       |   58 +
 arch/arm/mach-omap1/board-voiceblue.c      |   10 
 arch/arm/mach-omap1/clock.c                |    4 
 arch/arm/mach-omap1/i2c.c                  |   10 
 arch/arm/mach-omap1/include/mach/lcd_dma.h |   78 +
 arch/arm/mach-omap1/lcd_dma.c              |  447 +++++
 arch/arm/mach-omap1/mux.c                  |    8 
 arch/arm/mach-omap2/Kconfig                |    5 
 arch/arm/mach-omap2/Makefile               |    3 
 arch/arm/mach-omap2/board-apollon.c        |   10 
 arch/arm/mach-omap2/board-omap3pandora.c   |   26 
 arch/arm/mach-omap2/board-omap3touchbook.c |  572 +++++++
 arch/arm/mach-omap2/gpmc-smc91x.c          |    8 
 arch/arm/plat-omap/debug-devices.c         |   10 
 arch/arm/plat-omap/dma.c                   |  410 -----
 arch/arm/plat-omap/include/plat/dma.h      |   60 -
 arch/arm/plat-omap/include/plat/mux.h      |    6 
 arch/arm/plat-omap/usb.c                   |    8 
 drivers/net/smc91x.h                       |   15 
 27 files changed, 3900 insertions(+), 555 deletions(-)
 create mode 100644 arch/arm/configs/omap3_touchbook_defconfig
 create mode 100644 arch/arm/mach-omap1/include/mach/lcd_dma.h
 create mode 100644 arch/arm/mach-omap1/lcd_dma.c
 create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c

-- 
Signature
