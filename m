From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 0/3] USB: MUSB: Provide Platform specific suspend/resume hooks
Date: Fri,  4 Sep 2009 18:04:30 -0500
Message-ID: <1252105470-18923-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53675 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934435AbZIDXKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 19:10:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, ajay.gupta@ti.com, gadiyar@ti.com, felipe.balbi@nokia.com, Vikram Pandita <vikram.pandita@ti.com>

Patch 1:
This patch series creates MUSB platform specific power hooks for different
MUSB platforms (OMAP/Blackfin/Davinci/TUSB)

Patch 2 and 3:
This fixes issues with musb omap file for xceivr pointer passing and clock
enable race

Series is tested for MUSB:OMAP on Zoom2 platform.

Vikram Pandita (3):
  USB: musb: All each platform to have power hooks
  USB: musb: omap: Fix wrong xceivr passing to twl4030
  USB: musb: omap: Enable MUSB clocks before xceiver resume

 drivers/usb/musb/blackfin.c  |   15 +++++++++++++++
 drivers/usb/musb/davinci.c   |   24 ++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |   15 +++------------
 drivers/usb/musb/omap2430.c  |   15 +++++++++------
 drivers/usb/musb/tusb6010.c  |   24 ++++++++++++++++++++++++
 include/linux/usb/musb.h     |    5 +++++
 6 files changed, 80 insertions(+), 18 deletions(-)

