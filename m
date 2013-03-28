From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/28] OMAP: DSS related board file changes
Date: Thu, 28 Mar 2013 14:48:54 +0200
Message-ID: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55064 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab3C1Mtn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

So here are the DSS related board file changes for 3.10.

First there are a bunch of patches adding the Kconfig options so that only one
display device is created for a single video bus. Only Overo had more than two
displays on the same bus, but unfortunately there were multiple boards with a
setup that puts an LCD and DVI output on the same video bus.

So the ifdeffery is not very nice. But, as discussed, this is the best way
forward, and should be seen as a temporary solution until we get full DT
support.

Then the rest are converting the old omap_dss_device style displays to platform
devices. Only TFP410, generic-dpi-panel, HDMI and Taal drivers have been
converted yet, but those seem to form the bulk of the display options used.

This series can be found from:
git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/1-arch-dss

These patches depend on a few dss header file changes. These header file
changes can be found from:
git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers

If this series is applied without the relevant omapdss changes, everything
compiles and the boards boot, but the converted displays do not work. The same
happens if only the omapdss changes are applied, but not this series.

The related omapdss changes can be found from:
git://gitorious.org/linux-omap-dss2/linux.git 3.10/3-dss-dev-model

 Tomi

Archit Taneja (2):
  ARM: OMAP: Remove unnecessary platform callbacks for VENC devices
  ARM: OMAP: don't use reset_gpio from omap4_panda_dvi_device

Tomi Valkeinen (26):
  ARM: OMAP: Overo: Kconfig option for the display options
  ARM: OMAP: 3430SDP: Kconfig option for the display options
  ARM: OMAP: 4430SDP: Kconfig option for the display options
  ARM: OMAP: DEVKIT8000: Kconfig option for the display options
  ARM: OMAP: OMAP3EVM: Kconfig option for the display options
  ARM: OMAP: CM-T35: Kconfig option for the display options
  ARM: OMAP: AM3517EVM: Kconfig option for the display options
  ARM: OMAP: Panda: use new TFP410 platform driver
  ARM: OMAP: Panda & SDP: use new HDMI driver
  ARM: OMAP: 4430SDP: use new Taal driver
  ARM: OMAP: Beagle: use new TFP410 platform driver
  ARM: OMAP: Stalker: use new TFP410 platform driver
  ARM: OMAP: OMAP3EVM: use new TFP410 platform driver
  ARM: OMAP: IGEP0020: use new TFP410 platform driver
  ARM: OMAP: Devkit8000: use new TFP410 platform driver
  ARM: OMAP: CM-T35: use new TFP410 platform driver
  ARM: OMAP: AM3517EVM: use new TFP410 platform driver
  ARM: OMAP: 3430SDP: use new TFP410 platform driver
  ARM: OMAP: Overo: use new TFP410 platform driver
  ARM: OMAP: Overo: use new generic-dpi-panel platform driver
  ARM: OMAP: LDP: use new generic-dpi-panel platform driver
  ARM: OMAP: H4: use new generic-dpi-panel platform driver
  ARM: OMAP: Devkit8000: use new generic-dpi-panel platform driver
  ARM: OMAP: CM-T35: use new generic-dpi-panel platform driver
  ARM: OMAP: AM3517EVM: use new generic-dpi-panel platform driver
  ARM: OMAP: 2430SDP: use new generic-dpi-panel platform driver

 arch/arm/mach-omap2/Kconfig              |  100 ++++++++++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c      |   24 ++---
 arch/arm/mach-omap2/board-3430sdp.c      |   78 +++++++++-------
 arch/arm/mach-omap2/board-am3517evm.c    |   86 ++++++++---------
 arch/arm/mach-omap2/board-cm-t35.c       |  113 +++++++++++-----------
 arch/arm/mach-omap2/board-devkit8000.c   |  106 +++++++++++++--------
 arch/arm/mach-omap2/board-h4.c           |   24 ++---
 arch/arm/mach-omap2/board-igep0020.c     |   22 ++---
 arch/arm/mach-omap2/board-ldp.c          |   22 ++---
 arch/arm/mach-omap2/board-omap3beagle.c  |   25 ++---
 arch/arm/mach-omap2/board-omap3evm.c     |   70 +++++++-------
 arch/arm/mach-omap2/board-omap3stalker.c |   28 ++----
 arch/arm/mach-omap2/board-overo.c        |  149 ++++++++++++++++++------------
 arch/arm/mach-omap2/dss-common.c         |  125 ++++++++++++-------------
 14 files changed, 561 insertions(+), 411 deletions(-)

-- 
1.7.10.4

