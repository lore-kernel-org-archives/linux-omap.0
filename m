From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH v2 0/4] USB: OMAP: Tahvo USB support for 770
Date: Tue,  9 Apr 2013 22:51:24 +0300
Message-ID: <1365537088-23199-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34600 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935910Ab3DITvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 15:51:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Patches are currently based on top of Felipe's "next" branch
(git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git,
9b192de60b5a584ee4ed967fb6758773c75e4643). To make them work on 770,
some additional OMAP1 fixes are also needed which are already present
in 3.9-rc6 or queued for 3.10.

Test cases were roughly following:

	- CONFIG_TAHVO_USB_HOST_BY_DEFAULT
		- ohci-hcd, omap_udc, g_ether loaded as modules during boot
		- check host mode functionality after boot with USB keyboard
		- switch to peripheral mode and check functionality with ssh
		- switch back to host mode

	- !CONFIG_TAHVO_USB_HOST_BY_DEFAULT
		- ohci-hcd, omap_udc, g_ether loaded as modules during boot
		- check peripheral mode after boot with ssh
		- switch to host mode and check with USB keyboard
		- switch back to peripheral mode

	- other
		- check USB cable on/off detection (Tahvo vbus interrupt)

Changes since the first RFC
(http://marc.info/?l=linux-omap&m=136266725827698&w=2):

	- retu-mfd
		- use i2c address to detect retu vs. tahvo
	- phy-omap-otg
		- don't mess with isp1301_omap.c
		- move to drivers/usb/phy, rename omap-otg -> phy-omap-otg
	- phy-tahvo
		- drop illegal includes
		- move to drivers/usb/phy, rename tahvo-usb -> phy-tahvo
		- serialize vbus interrupt handling
		- delete dummy/unimplemented functions
		- drop peripheral/host only config
		- don't use OTG interrupt, not needed
		- don't write to OTG_SYSCON_1/2, this is handled by board code
		- move OTG CTRL handling to omap-otg

Please review and comment. Thanks,

A.

Aaro Koskinen (4):
  retu-mfd: support also Tahvo
  ARM: OMAP1: nokia770: enable Tahvo
  USB: OMAP: add omap-otg
  USB: OMAP: Tahvo USB transceiver driver

 arch/arm/mach-omap1/board-nokia770.c |   10 +
 drivers/mfd/Kconfig                  |    6 +-
 drivers/mfd/retu-mfd.c               |   85 ++++++-
 drivers/usb/phy/Kconfig              |   24 ++
 drivers/usb/phy/Makefile             |    2 +
 drivers/usb/phy/phy-omap-otg.c       |  126 ++++++++++
 drivers/usb/phy/phy-tahvo.c          |  429 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/retu.h             |    8 +-
 include/linux/usb/omap-otg.h         |   19 ++
 9 files changed, 695 insertions(+), 14 deletions(-)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/usb/omap-otg.h

-- 
1.7.10.4

