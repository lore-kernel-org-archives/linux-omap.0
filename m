From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 0/5] usb: musb_dsps: support for suspend and resume
Date: Fri, 18 Oct 2013 11:39:30 +0200
Message-ID: <1382089175-13487-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:39427 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3JRJjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 05:39:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

v3 of my musb_dsps suspend patches.

With these patches applied, I can successfully bring an AM335x board
to suspend with a USB media connected, and access it again after
resume.

This works for both PIO mode and CPPI41 enabled configurations,
together with Sebasitian's and my cppi41 patches recently posted.

Felipe, this work was rebased and now applies cleanly on top of
your current 'next' branch. IOW, on top of "usb: musb: cppi41: allow
to defer probing if DMA isn't yet available".


Thanks,
Daniel

v2 -> v3
	* dropped "usb: musb: move port reset to worker" which is
	  not crucial for this series.
	* added another cosmetic cleanup patch (#5)

Daniel Mack (5):
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: conditionally save and restore the context on suspend
  usb: musb: dsps: add {tx,rx}_mode to wrapper
  usb: musb: dsps: add support for suspend and resume
  usb: musb: dsps: indentation and whitespace fixes

 drivers/usb/musb/musb_core.c    | 17 +++++++-
 drivers/usb/musb/musb_core.h    |  1 +
 drivers/usb/musb/musb_dsps.c    | 86 +++++++++++++++++++++++++++++++++++------
 drivers/usb/musb/musb_host.c    |  2 +
 drivers/usb/musb/musb_host.h    |  4 ++
 drivers/usb/musb/musb_virthub.c |  4 +-
 include/linux/usb/musb.h        |  1 +
 7 files changed, 100 insertions(+), 15 deletions(-)

-- 
1.8.3.1

