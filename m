From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 00/11] musb patches
Date: Wed, 24 Mar 2010 13:47:48 +0200
Message-ID: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45753 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab0CXLsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:48:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Greg,

the following patches are the fixes I have for you for next
-rc release.

Ajay Kumar Gupta (2):
  musb: fix power field to hold all possible values
  musb: save and restore missing bus control register

Dan Carpenter (1):
  musb: potential use after free

Sergei Shtylyov (8):
  MUSB: fix DaVinci glue layer dependency
  MUSB: Blackfin: don't fake blackfin_interrupt() result
  musb_core: don't touch 'musb->clock' in musb_free()
  musb_core: don't prevent disabling clock on driver unload
  MUSB: DaVinci: fix musb_platform_init() error cleanup path
  MUSB: OMAP: don't call clk_put()
  musb_core: don't call musb_platform_exit() twice
  musb_core: fix musb_init_controller() error cleanup path

 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 drivers/usb/musb/Kconfig              |    2 +-
 drivers/usb/musb/Makefile             |    2 +-
 drivers/usb/musb/blackfin.c           |    8 +---
 drivers/usb/musb/davinci.c            |    2 +
 drivers/usb/musb/musb_core.c          |   76 ++++++++++++++++++---------------
 drivers/usb/musb/musb_core.h          |    2 +-
 drivers/usb/musb/musb_host.c          |    1 +
 drivers/usb/musb/omap2430.c           |    3 -
 9 files changed, 50 insertions(+), 48 deletions(-)

