From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH] kill warnings in gpmc
Date: Tue, 7 Oct 2008 18:43:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C62FBEF@dbde02.ent.ti.com>
References: <20081007130411.GX7437@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbYJGNNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:13:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> I had sent that fix for the same, though not merged in yet. :)
> 

Oops.. I forgot about V2 patch. :(

==Cut here==
From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Return type of gpmc_init() function is void. Also, the error values
returned by the function is not used by the caller. Hence it should
not be returning any value.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
---
Index: linux-omap-git/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/gpmc.c	2008-09-25 17:30:24.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/gpmc.c	2008-09-30 16:24:52.448034656 +0530
@@ -427,19 +427,10 @@ void __init gpmc_init(void)
 	}
 
 	gpmc_l3_clk = clk_get(NULL, ck);
-	if (IS_ERR(gpmc_l3_clk)) {
-		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-		return -ENODEV;
-	}
-
-	gpmc_base = ioremap(l, SZ_4K);
-	if (!gpmc_base) {
-		clk_put(gpmc_l3_clk);
-		printk(KERN_ERR "Could not get GPMC register memory\n");
-		return -ENOMEM;
-	}
-
 	BUG_ON(IS_ERR(gpmc_l3_clk));
+	
+	gpmc_base = ioremap(l, SZ_4K);
+	BUG_ON(!gpmc_base);
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);

