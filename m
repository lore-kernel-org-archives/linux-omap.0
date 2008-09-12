From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Fri, 12 Sep 2008 15:10:24 +0300
Message-ID: <20080912121024.GG759@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23124 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYILMK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 08:10:59 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CCAnpH014312
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 15:10:56 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

hcd->regs should be initialized by ioremaping hcd->rsrc_start and
hcd->rsrc_len. Fix it for ehci-omap.c.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 8f122e5..a67533d 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -438,7 +438,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
        hcd->rsrc_start = dev->resource[0].start;
        hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
 
-       hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
+       hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 
        ehci = hcd_to_ehci(hcd);
        ehci->caps = hcd->regs;


-- 
balbi
