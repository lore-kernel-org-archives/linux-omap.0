From: Felipe Balbi <balbi@ti.com>
Subject: [GIT PULL] OMAP USB Patches for 2.6.39
Date: Fri, 18 Feb 2011 14:11:45 +0200
Message-ID: <20110218121145.GB11151@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35464 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754207Ab1BRMLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 07:11:51 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Greg,

Here are the patches I have for the next merge window.

The outstanding feature is the introduction of pm_runtime
support for the OMAP glue layer for MUSB.

These patches have been tested on omap4430 with g_zero
+ testusb overnight and no problems have come from those.

These are on top of greg/usb-next, if you want me to rebase
on top of another commit, please let me know about it and I'll
do it quickly.

Thanks, pull request below.

The following changes since commit 04b31c776f34d127b422da92899272a0b8cda21d:

  usb: isp1362-hcd: use bitmap_clear() and bitmap_set() (2011-02-17 11:00:24 -0800)

are available in the git repository at:
  git://gitorious.org/usb/usb.git for-next

Felipe Balbi (4):
      usb: musb: do not error out if Kconfig doesn't match board mode
      usb: musb: gadget: beautify usb_gadget_probe_driver()/usb_gadget_unregister_driver
      usb: musb: gadget: do not poke with gadget's list_head
      usb: otg: notifier: switch to atomic notifier

Hema HK (8):
      usb: musb: Using runtime pm APIs for musb.
      usb: otg: enable regulator only on cable/device connect
      usb: otg: Remove one unnecessary I2C read request.
      usb: otg: OMAP4430: Add phy_suspend function pointer to twl4030_usb_data
      usb: otg: OMAP4430: Introducing suspend function for power management
      usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
      usb: otg: TWL6030 Save the last event in otg_transceiver
      usb: musb: OMAP4430: Fix usb device detection if connected during boot

 arch/arm/mach-omap2/board-4430sdp.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/omap_phy_internal.c |   22 +++-
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 drivers/usb/musb/musb_core.c            |   25 ----
 drivers/usb/musb/musb_core.h            |    6 +-
 drivers/usb/musb/musb_gadget.c          |  191 +++++++++++++++++--------------
 drivers/usb/musb/musb_gadget.h          |    7 +-
 drivers/usb/musb/musb_gadget_ep0.c      |   24 +++--
 drivers/usb/musb/omap2430.c             |  134 ++++++++++++----------
 drivers/usb/otg/ab8500-usb.c            |    6 +-
 drivers/usb/otg/nop-usb-xceiv.c         |    2 +-
 drivers/usb/otg/twl4030-usb.c           |    6 +-
 drivers/usb/otg/twl6030-usb.c           |   56 ++++++----
 include/linux/i2c/twl.h                 |    2 +
 include/linux/usb/otg.h                 |    7 +-
 16 files changed, 260 insertions(+), 231 deletions(-)

-- 
balbi
