From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 00/11] musb patches
Date: Thu, 25 Mar 2010 13:25:17 +0200
Message-ID: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37475 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab0CYL0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Greg,

v2 of musb patches for next merge window.

Again, sorry for the mistake.

Ajay Kumar Gupta (1):
  musb: Add extvbus in musb_board_data

Anand Gadiyar (2):
  usb: musb: omap2430: remove unused define
  usb: musb: omap2430.c: remove unnecessary includes

Cliff Cai (1):
  USB: musb: support host/gadget role switching on Blackfin parts

Felipe Balbi (2):
  usb: musb: debugfs: musb_exit_debugfs() can be called on probe
  usb: musb: Makefile: remove unexistent config option

Heikki Krogerus (1):
  usb: musb: add ulpi access operations

Sergei Shtylyov (4):
  MUSB: OMAP: remove omap_vbus_power()
  MUSB: Blackfin: remove bfin_vbus_power()
  MUSB: OMAP: make musb_platform_suspend() 'static'
  MUSB: Blackfin: remove musb_platform_{suspend|resume}()

 arch/arm/mach-omap2/board-omap3evm.c  |    3 +
 arch/arm/mach-omap2/usb-musb.c        |    1 +
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/usb/musb/Makefile             |    6 --
 drivers/usb/musb/blackfin.c           |   86 ++++++++++++++++++++++--------
 drivers/usb/musb/musb_core.c          |   93 ++++++++++++++++++++++++++++++++-
 drivers/usb/musb/musb_debugfs.c       |    2 +-
 drivers/usb/musb/musb_regs.h          |   10 ++++
 drivers/usb/musb/omap2430.c           |   16 +-----
 9 files changed, 171 insertions(+), 47 deletions(-)

