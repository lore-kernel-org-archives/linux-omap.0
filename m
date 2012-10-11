From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: omap3 gpmc: irq-20 could not claim: err -2
Date: Thu, 11 Oct 2012 11:35:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1210111118540.25746@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:45285 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755562Ab2JKJfr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 05:35:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>, Mohammed Afzal <afzal@ti.com>
Cc: linux-omap@vger.kernel.org

Hello,

I'm getting the kernel log messages early in the bootup sequence (kernel 
3.6.1 mainline)
[    0.121337] GPMC revision 5.0
[    0.121582] gpmc: irq-20 could not claim: err -22

this is on beagleboard, which is calling omap_nand_flash_init(), so no 
omap_nand_platform_data specified in board file

NAND still works since it is operated in NAND_OMAP_PREFETCH_POLLED mode; 
however, I'd like to try NAND_OMAP_PREFETCH_IRQ to see if it brings any 
performance gains

just passing NAND_OMAP_PREFETCH_IRQ via gmpc_nand_init() hangs the kernel 
(I guess since the request_irq() failed earlier)

another question is dev_ready which also seems to depend on IRQ also

can you make any recommendation w.r.t NAND performance on OMAP?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
