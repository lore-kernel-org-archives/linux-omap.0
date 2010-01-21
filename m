From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/7] musb patches
Date: Thu, 21 Jan 2010 15:33:51 +0200
Message-ID: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25876 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0AUNig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 08:38:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Greg,

please take these patches into your tree.

Ajay Kumar Gupta (1):
  usb: musb: Add context save and restore support

Felipe Balbi (6):
  usb: musb: get rid of omap_readl/writel
  usb: musb: we already tested for dyn_fifo
  usb: musb: deprecate what we don't use
  drivers: usb: musb: tusb6010: use resource_size
  usb: musb: unmap base if we can't probe
  usb: musb: only print info message if probe() is successful

 drivers/usb/musb/musb_core.c |  198 +++++++++++++++++++++++++++++++++++------
 drivers/usb/musb/musb_core.h |   39 ++++++++
 drivers/usb/musb/musb_regs.h |   90 +++++++++++++++++++
 drivers/usb/musb/omap2430.c  |   48 +++++++---
 drivers/usb/musb/omap2430.h  |   32 +++----
 drivers/usb/musb/tusb6010.c  |    2 +-
 include/linux/usb/musb.h     |   20 ++--
 7 files changed, 356 insertions(+), 73 deletions(-)

