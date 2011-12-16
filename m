From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: EHCI/OHCI: convert to runtime PM
Date: Fri, 16 Dec 2011 04:51:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160447440.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33747 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1LPLvz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 06:51:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

This series converts the USB EHCI/OHCI code to use runtime PM.  It has 
multiple hwmods for its omap_device, but Keshava & Partha have promised to 
post patches to solve that problem for the 3.4 merge window.

This series has a dependency on the "hwmod_data_devel_3.3" branch, which 
in turn depends on the "hwmod_data_fixes_3.2rc" branch.

- Paul

The following changes since commit 3e47dc6a2ee54ea8b566729f75e9fdb5dfe078b6:

  ARM: OMAP3+: hwmod data: Add the default clockactivity for I2C (2011-12-16 01:34:46 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 usbhost_runtime_pm_14_devel_3.3

Keshava Munegowda (4):
      ARM: OMAP: USB: register hwmods of usbhs
      ARM: OMAP: USB: device name change for the clk names of usbhs
      ARM: OMAP: USBHOST: Replace usbhs core driver APIs by Runtime pm APIs
      MFD: OMAP: USB: Runtime PM support

 arch/arm/mach-omap2/clock3xxx_data.c  |   26 +-
 arch/arm/mach-omap2/clock44xx_data.c  |   10 +-
 arch/arm/mach-omap2/usb-host.c        |  100 ++---
 arch/arm/plat-omap/include/plat/usb.h |    3 -
 drivers/mfd/omap-usb-host.c           |  755 +++++++++++++--------------------
 drivers/usb/host/ehci-omap.c          |   17 +-
 drivers/usb/host/ohci-omap3.c         |   18 +-
 7 files changed, 369 insertions(+), 560 deletions(-)
