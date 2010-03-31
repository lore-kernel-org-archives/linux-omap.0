From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/8 RFC] OMAP: GPIO: Split OMAP1 and OMAP2PLUS
Date: Wed, 31 Mar 2010 17:53:51 +0530
Message-ID: <1270038239-1090-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420Ab0CaMTd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch series is in preparation to adapt GPIO to HWMOD FW.
It creates OMAP architecture specific gpio files to handle
SoC specific gpio_init. The common plat-omap/gpio.c handles all
common GPIO APIs.

OMAP2PLUS GPIO module is implemented as early platform device and
OMAP1 GPIO is still handled in old way via gpio_init from board files.

Save/restore context, gpio_prepare_for_retention and
gpio_resume_after_retention APIs are also handled in plat-omap layer.
These APIs are currently not used in OMAP1, but still they might
become common for different OMAP architectures in the future.
Hence they are handled in plat-omap layer. If they need to be moved
to mach-omap2 layer, additional patches may be sent during
next version of this patch series.

This patch series is generated on top of linux-omap-2.6 branch: master
and tested on 3430SDP, 4430SDP & zoom3.

Charulatha V (8):
  OMAP:GPIO:Move architecture specific macros to specific header
  OMAP2PLUS:GPIO:Move gpio_init from board files to init_common_hw
  OMAP3:GPIO:Add support for early platform gpio device
  OMAP2:GPIO:Add support for early platform gpio device
  OMAP4:GPIO:Add support for early platform gpio device
  OMAP2PLUS:GPIO:Add OMAP2PLUS specific gpio support
  OMAP1:GPIO:Support for OMAP1 specific gpio
  OMAP:GPIO:Common platform code for all OMAPs

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/gpio.c                 |  404 ++++++
 arch/arm/mach-omap1/include/mach/gpio.h    |   88 ++
 arch/arm/mach-omap2/Makefile               |    7 +-
 arch/arm/mach-omap2/board-2430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    3 +-
 arch/arm/mach-omap2/board-apollon.c        |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    3 +-
 arch/arm/mach-omap2/board-generic.c        |    2 +-
 arch/arm/mach-omap2/board-h4.c             |    3 +-
 arch/arm/mach-omap2/board-igep0020.c       |    3 +-
 arch/arm/mach-omap2/board-ldp.c            |    3 +-
 arch/arm/mach-omap2/board-n8x0.c           |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    3 +-
 arch/arm/mach-omap2/board-overo.c          |    3 +-
 arch/arm/mach-omap2/board-rx51.c           |    3 +-
 arch/arm/mach-omap2/board-zoom2.c          |    3 +-
 arch/arm/mach-omap2/board-zoom3.c          |    3 +-
 arch/arm/mach-omap2/gpio.c                 |   36 +
 arch/arm/mach-omap2/gpio2xxx.c             |  472 +++++++
 arch/arm/mach-omap2/gpio3xxx.c             |  351 ++++++
 arch/arm/mach-omap2/gpio44xx.c             |  350 ++++++
 arch/arm/mach-omap2/include/mach/gpio.h    |  114 ++
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/plat-omap/gpio.c                  | 1827 ++++++----------------------
 arch/arm/plat-omap/include/plat/gpio.h     |  180 +++-
 33 files changed, 2360 insertions(+), 1535 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio.c
 create mode 100644 arch/arm/mach-omap2/gpio.c
 create mode 100644 arch/arm/mach-omap2/gpio2xxx.c
 create mode 100644 arch/arm/mach-omap2/gpio3xxx.c
 create mode 100644 arch/arm/mach-omap2/gpio44xx.c

