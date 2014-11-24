From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Allow multiple MUSB glue layers to be built in
Date: Mon, 24 Nov 2014 11:04:58 -0800
Message-ID: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19680 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbaKXTHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 14:07:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi all,

I noticed MUSB did not work for me as loadable modules and it was
because of the iffdeffery that breaks things with multiple glue
layers enabled as loadable modules.

I've set up function pointers for the PIO functions that now allow
building in multiple glue layers as modules or built-in.

Note that this series still does not sort out the DMA related issues,
I have a series in works for that too. But that will take some more
debugging.

So far this has been tested to work on omap3, am335x and tusb6010.

Regards,

Tony


Tony Lindgren (8):
  usb: musb: Add function pointers for IO access functions
  usb: musb: Populate new IO functions for tusb6010
  usb: musb: Populate new IO functions for blackfin
  usb: musb: Change to use new IO access
  usb: musb: Change end point selection to use new IO access
  usb: musb: Pass fifo_mode in platform data
  usb: musb: Allow multiple glue layers to be built in
  usb: musb: Use IS_ENABLED for tusb6010

 drivers/usb/musb/Kconfig     |   5 +-
 drivers/usb/musb/am35x.c     |   4 +-
 drivers/usb/musb/blackfin.c  |  48 ++++++++++-
 drivers/usb/musb/da8xx.c     |   2 +
 drivers/usb/musb/jz4740.c    |   2 +
 drivers/usb/musb/musb_core.c | 199 ++++++++++++++++++++++++++++++++++++-------
 drivers/usb/musb/musb_core.h |  86 ++++++++++---------
 drivers/usb/musb/musb_dsps.c |   1 +
 drivers/usb/musb/musb_io.h   | 106 ++++++-----------------
 drivers/usb/musb/musb_regs.h |  26 ------
 drivers/usb/musb/musbhsdma.c |   7 +-
 drivers/usb/musb/tusb6010.c  |  58 ++++++++++++-
 drivers/usb/musb/ux500.c     |   2 +
 drivers/usb/musb/ux500_dma.c |   4 +-
 14 files changed, 356 insertions(+), 194 deletions(-)

-- 
2.1.3

