From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [patch-2.6.35-rc3+ 0/8] musb patches
Date: Thu, 17 Jun 2010 16:10:33 +0530
Message-ID: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55631 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759735Ab0FQKk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 06:40:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Ajay Kumar Gupta <ajay.gupta@ti.com>

Greg,

These are reviewed and non-controversial musb bugfix patches. Sanity have
been tested on OMAP3EVM for Host-MSC, HID, audio, video class and
device-CDC class.

Thanks,
Ajay

Ajay Kumar Gupta (1):
  musb: fix compilation warning in host only mode

Anand Gadiyar (1):
  musb: Kill board specific pinmux from driver file

Hema HK (1):
  usb: musb: Enable the maximum supported burst mode for DMA

Jon Povey (1):
  USB: musb: suppress warning about unused flags

Maulik Mankad (1):
  usb: musb: Fix suspend interrupt issue in device mode

Mike Frysinger (1):
  usb: musb: fix Blackfin ulpi stubs

Sergei Shtylyov (2):
  musb_core: make disconnect and suspend interrupts work again
  MUSB: make non-OMAP platforms build with CONFIG_PM=y

 drivers/usb/musb/cppi_dma.c  |    2 +-
 drivers/usb/musb/musb_core.c |   23 ++++++++---------------
 drivers/usb/musb/musb_core.h |    6 ++++--
 drivers/usb/musb/musbhsdma.c |   13 ++-----------
 drivers/usb/musb/omap2430.c  |    6 ------
 5 files changed, 15 insertions(+), 35 deletions(-)

