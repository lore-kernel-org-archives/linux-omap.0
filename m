From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/4] usb: musb: support for suspend and resume
Date: Thu, 26 Sep 2013 15:08:58 +0200
Message-ID: <1380200942-28175-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:41298 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757067Ab3IZNJL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 09:09:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

I've been working on some patches that allow suspending and resuming
the musb-dsps platform. This was tested for host mode only.

With these patches applied, I can successfully bring an AM335x board
to suspend with a USB media connected, and access it again after
resume. Note that this currently only works with CONFIG_MUSB_PIO_ONLY
set. The cppi41 driver needs some more love to make this work. I'll
work on that next.

Thanks,
Daniel


Daniel Mack (4):
  usb: musb: move port reset to worker
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: conditionally restore and resume the context on resume
  usb: musb: dsps: add support for suspend and resume

 drivers/usb/musb/musb_core.c    | 24 +++++++++++++++++-
 drivers/usb/musb/musb_core.h    |  3 +++
 drivers/usb/musb/musb_dsps.c    | 54 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_host.c    |  2 ++
 drivers/usb/musb/musb_host.h    |  4 +++
 drivers/usb/musb/musb_virthub.c | 15 +++++++-----
 include/linux/usb/musb.h        |  1 +
 7 files changed, 96 insertions(+), 7 deletions(-)

-- 
1.8.3.1

