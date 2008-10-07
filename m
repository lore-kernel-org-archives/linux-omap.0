From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] kill warnings in gpmc
Date: Tue, 7 Oct 2008 16:04:11 +0300
Message-ID: <20081007130411.GX7437@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22301 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYJGNF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:05:26 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97D5Nlo011269
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 16:05:23 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

From: Felipe Balbi <felipe.balbi@nokia.com>

Trivial cleanup patch. Do not return values in void
functions

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3e0271..088a304 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -429,14 +429,14 @@ void __init gpmc_init(void)
        gpmc_l3_clk = clk_get(NULL, ck);
        if (IS_ERR(gpmc_l3_clk)) {
                printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-               return -ENODEV;
+               return;
        }
 
        gpmc_base = ioremap(l, SZ_4K);
        if (!gpmc_base) {
                clk_put(gpmc_l3_clk);
                printk(KERN_ERR "Could not get GPMC register memory\n");
-               return -ENOMEM;
+               return;
        }
 
        BUG_ON(IS_ERR(gpmc_l3_clk));


-- 
balbi
