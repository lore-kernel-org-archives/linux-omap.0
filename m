From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH v2] gpmc: Remove compilation warning
Date: Tue, 30 Sep 2008 16:37:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E289@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C31912F@dbde02.ent.ti.com>
 <20080929131634.GJ13245@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43848 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbYI3LHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 07:07:36 -0400
In-Reply-To: <20080929131634.GJ13245@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Daniel Stone <daniel.stone@nokia.com>

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
