From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 00/16] usb patches accepted by Greg
Date: Tue, 19 Jan 2010 15:13:59 +0200
Message-ID: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36073 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab0ASNOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

Hi Tony,

the following patches have reached Greg's queue and will
be applied to mainline on next -rc. It would be nice to get
them in linux-omap before hand so people can start working
on top of those changes.

Ajay Kumar Gupta (5):
  USB: musb: Add new fifo table for a OMAP3 errata
  usb: musb: save dynfifo in musb struct
  usb: musb: Add 'extvbus' in musb_hdrc_platform_data
  usb: host: ehci: fix missing kfree in remove path also
  usb: host: ehci: adding regulator framework in ehci-omap.c driver.

Anand Gadiyar (2):
  usb: musb: hsdma: add wrapper for reading DMA count
  usb: musb: workaround MUSB DMA_INTR sometimes reads zero

Arnaud Mandy (1):
  usb: musb: handle irqs in the order dictated by programming guide

Bryan Wu (1):
  usb: musb: clean up commit 'workaround Blackfin FIFO anomalies'

Felipe Balbi (4):
  USB: musb: use resource_size()
  USB: musb: move two printk to dev_err
  USB: musb: move to sysfs_groups
  USB: musb: remove some of the never defined defines

Roel Kluin (1):
  USB: musb: don't dereference NULL tusb_dma in
    dma_controller_destroy()

Swaminathan S (2):
  usb: musb: workaround toggle bug when doing bulk transfer after isoc
  usb: musb: Fix cppi_channel_abort() function to handle Tx abort
    correctly

 drivers/usb/host/ehci-omap.c     |   37 ++++
 drivers/usb/musb/blackfin.c      |   28 ++--
 drivers/usb/musb/cppi_dma.c      |   33 +---
 drivers/usb/musb/musb_core.c     |  364 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_core.h     |   17 +--
 drivers/usb/musb/musb_host.c     |   24 +++
 drivers/usb/musb/musb_regs.h     |    5 +
 drivers/usb/musb/musbhsdma.c     |   25 +++-
 drivers/usb/musb/musbhsdma.h     |   17 ++
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 include/linux/usb/musb.h         |    3 +
 11 files changed, 316 insertions(+), 239 deletions(-)

