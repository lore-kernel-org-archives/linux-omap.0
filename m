From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] omap: Enable GPMC clock in gpmc_init
Date: Wed, 20 Jan 2010 16:39:29 -0600
Message-ID: <20100120223929.GA10739@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:51379 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab0ATWiO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 17:38:14 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Don't assume that gpmc_l3_clk is on, enable it before touching
configuration registers.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e86f5ca..dea72f3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -534,6 +534,8 @@ void __init gpmc_init(void)
 		BUG();
 	}
 
+	clk_enable(gpmc_l3_clk);
+
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 	/* Set smart idle mode and automatic L3 clock gating */
