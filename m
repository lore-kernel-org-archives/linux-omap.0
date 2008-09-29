From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH] gpmc: Remove compilation warning
Date: Mon, 29 Sep 2008 18:40:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C31912F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbYI2NK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:10:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "tony@atomide.com" <tony@atomide.com>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Return type of gpmc_init() function is void. Also, the error values
returned by the function is not used by the caller. Hence it should
not be returning any value.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
--
Index: linux-omap-git/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/gpmc.c	2008-09-25 17:30:24.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/gpmc.c	2008-09-29 18:26:40.845433948 +0530
@@ -427,16 +427,13 @@ void __init gpmc_init(void)
 	}
 
 	gpmc_l3_clk = clk_get(NULL, ck);
-	if (IS_ERR(gpmc_l3_clk)) {
+	if (IS_ERR(gpmc_l3_clk))
 		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-		return -ENODEV;
-	}
 
 	gpmc_base = ioremap(l, SZ_4K);
 	if (!gpmc_base) {
 		clk_put(gpmc_l3_clk);
 		printk(KERN_ERR "Could not get GPMC register memory\n");
-		return -ENOMEM;
 	}
 
 	BUG_ON(IS_ERR(gpmc_l3_clk));
--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

