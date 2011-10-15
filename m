From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: Runtime PM/hwmod conversion for HS USBHOST
Date: Sat, 15 Oct 2011 00:32:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110150030410.19504@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49300 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1JOGcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Oct 2011 02:32:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 usbhost_runtime_pm_14_devel_3.2

Benoit Cousson (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP4

Keshava Munegowda (5):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP3
      ARM: OMAP: USB: register hwmods of usbhs
      ARM: OMAP: USB: device name change for the clk names of usbhs
      ARM: OMAP: USBHOST: Replace usbhs core driver APIs by Runtime pm APIs
      MFD: OMAP: USB: Runtime PM support

 arch/arm/mach-omap2/clock3xxx_data.c       |   26 +-
 arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  208 ++++++++-
 arch/arm/mach-omap2/usb-host.c             |  100 ++---
 arch/arm/plat-omap/include/plat/usb.h      |    3 -
 drivers/mfd/omap-usb-host.c                |  755 +++++++++++-----------------
 drivers/usb/host/ehci-omap.c               |   17 +-
 drivers/usb/host/ohci-omap3.c              |   18 +-
 9 files changed, 797 insertions(+), 561 deletions(-)


- Paul
