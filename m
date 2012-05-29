From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] usb: gadget: omap_udc: cleanup patches
Date: Tue, 29 May 2012 15:15:55 +0300
Message-ID: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33702 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423Ab2E2MRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 08:17:42 -0400
Received: by lban1 with SMTP id n1so2483702lba.38
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 05:17:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Here are a few cleanups for the omap_udc.c driver.

Compile tested only with omap1_defconfig + enabling omap_udc.

There's still a bunch that needs to change on that driver,
but this is a start, at least.

Once -rc1 is tagged, I'll queue these patches for v3.6 merge
window together with Tony's removal of OMAP2 support from
omap_udc [1]

[1] http://marc.info/?l=linux-usb&m=133762704531095&w=2

Felipe Balbi (6):
  usb: gadget: omap_udc: make checkpatch.pl happy
  usb: gadget: omap_udc: remove useless print
  usb: gadget: omap_udc: let it work as a module
  usb: gadget: omap_udc: remove possiblity of NULL pointer de-reference
  usb: gadget: omap_udc: kfree(NULL) is safe
  usb: gadget: omap_udc: use generic map/unmap routines

 drivers/usb/gadget/omap_udc.c |  290 ++++++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 148 deletions(-)

-- 
1.7.10.2

