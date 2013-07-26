From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/21] ARM: OMAP2+: use new display drivers
Date: Fri, 26 Jul 2013 10:08:03 +0300
Message-ID: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3GZHJR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

The display drivers for new OMAP DSS driver model were merged in v3.11, but the
board files were not changed to use them. This series changes the board files
to take those new drivers into use.

There's mostly nothing special in the patches. One complication is with Overo
board file, which adds two panel devices, located in add-on boards, that use
the same GPIOs, meaning that the two panel devices cannot be probed at the same
time. The solution used here is to parse the kernel command line, and decide
the panel device to be added depending on the given default display.

The omap2plus_defconfig is changed to include a few most commonly used display
drivers as modules, and the old drivers are removed.

Note: The first patch in this series has been sent separately
(http://mid.gmane.org/1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com),
and is a fix for v3.11. It's included here as an another patch in the series
depends on it.

Tested on 4430SDP, Panda, Beagle, Beagle xM, Overo.

 Tomi

Tomi Valkeinen (21):
  ARM: OMAP: dss-common: fix Panda's DVI DDC channel
  ARM: OMAP2+: Remove legacy DSS initialization for omap4
  ARM: OMAP2+: Add selected display drivers to omap2plus_defconfig
  ARM: OMAP: dss-common: use new display drivers
  ARM: OMAP: 4430SDP: remove picodlp device data
  ARM: OMAP: overo: use new display drivers
  ARM: OMAP: rx51: use new display drivers
  ARM: OMAP: beagle: use new display drivers
  ARM: OMAP: devkit8000: use new display drivers
  ARM: OMAP: 2430SDP: use new display drivers
  ARM: OMAP: LDP: use new display drivers
  ARM: OMAP: omap3stalker: use new display drivers
  ARM: OMAP: igep0020: use new display drivers
  ARM: OMAP: cm-t35: use new display drivers
  ARM: OMAP: H4: use new display drivers
  ARM: OMAP: 3430SDP: use new display drivers
  ARM: OMAP: OMAP3EVM: use new display drivers
  ARM: OMAP: Pandora: use new display drivers
  ARM: OMAP: Zoom: use new display drivers
  ARM: OMAP: AM3517EVM: use new display drivers
  ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig

 arch/arm/configs/omap2plus_defconfig         |  12 +-
 arch/arm/mach-omap2/board-2430sdp.c          |  57 ++++---
 arch/arm/mach-omap2/board-3430sdp.c          |  83 +++++----
 arch/arm/mach-omap2/board-am3517evm.c        | 113 +++++++++----
 arch/arm/mach-omap2/board-cm-t35.c           | 100 +++++++----
 arch/arm/mach-omap2/board-devkit8000.c       |  96 +++++++----
 arch/arm/mach-omap2/board-h4.c               |  48 ++++--
 arch/arm/mach-omap2/board-igep0020.c         |  36 ++--
 arch/arm/mach-omap2/board-ldp.c              |  68 +++++---
 arch/arm/mach-omap2/board-omap3beagle.c      |  56 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |  87 ++++++----
 arch/arm/mach-omap2/board-omap3pandora.c     |  48 +++---
 arch/arm/mach-omap2/board-omap3stalker.c     |  61 ++++---
 arch/arm/mach-omap2/board-overo.c            | 160 +++++++++++-------
 arch/arm/mach-omap2/board-rx51-peripherals.c |  12 ++
 arch/arm/mach-omap2/board-rx51-video.c       |  35 ++--
 arch/arm/mach-omap2/board-zoom-display.c     |  30 ++--
 arch/arm/mach-omap2/dss-common.c             | 244 ++++++++++++---------------
 arch/arm/mach-omap2/dss-common.h             |   2 -
 19 files changed, 787 insertions(+), 561 deletions(-)

-- 
1.8.1.2

