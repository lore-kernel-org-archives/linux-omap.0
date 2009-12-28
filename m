From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/8] musb patches
Date: Mon, 28 Dec 2009 13:09:42 +0200
Message-ID: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50201 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbZL1LLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:11:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Tony,

the following are few cleanups for the usb-musb.c
file. Another patch will go through Greg getting rid
of omap_readl/omap_writel.

For ease, these patches are also available at:

git://gitorious.org/usb/usb.git for-tony

. Boot tested on RX-51
. Compile tested with all defconfigs that have USB_MUSB_SOC=y

Felipe Balbi (8):
  arm: omap: musb: remove unused data
  arm: omap: musb: we can use clk framework
  arm: omap: musb: remove unused soft_con field
  arm: omap: musb: remove unused dma data
  arm: omap: musb: ioremap only what's ours
  arm: omap: musb: pass power to usb_musb_init
  arm: omap: musb: pass board mode to usb_musb_init
  arm: omap: musb: remove unnecessary return

 arch/arm/mach-omap2/board-2430sdp.c          |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    3 +-
 arch/arm/mach-omap2/board-igep0020.c         |    3 +-
 arch/arm/mach-omap2/board-ldp.c              |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    3 +-
 arch/arm/mach-omap2/board-overo.c            |    3 +-
 arch/arm/mach-omap2/board-rx51.c             |    3 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +-
 arch/arm/mach-omap2/usb-musb.c               |   87 +++-----------------------
 arch/arm/plat-omap/include/plat/usb.h        |    3 +-
 14 files changed, 34 insertions(+), 92 deletions(-)

