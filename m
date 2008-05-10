From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP3: Check for L2 cache enabled
Date: Sat, 10 May 2008 09:45:24 +0200
Message-ID: <48255294.5020707@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000105080606080705080203"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:46918 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYEJHpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 03:45:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1087615fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2008 00:45:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105080606080705080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Enabling L2 cache of Cortex-A8 based OMAP3 has to be done by 
bootloader. Check if this is done and warn if not.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------000105080606080705080203
Content-Type: text/plain;
 name="omap3_l2cache_check_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap3_l2cache_check_patch.txt"

Index: linux-beagle/arch/arm/mach-omap2/id.c
===================================================================
--- linux-beagle.orig/arch/arm/mach-omap2/id.c
+++ linux-beagle/arch/arm/mach-omap2/id.c
@@ -267,3 +267,26 @@ void __init omap2_check_revision(void)
 
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+/*
+ * OMAP3 has L2 cache which has to be enabled by bootloader.
+ */
+static int __init omap3_check_l2cache(void)
+{
+	u32 val;
+
+	/* Get CP15 AUX register, bit 1 enabled indicates L2 cache is on */
+	asm volatile("mrc p15, 0, %0, c1, c0, 1":"=r" (val));
+
+	if ((val & 0x2) == 0) {
+		printk(KERN_WARNING "Warning: L2 cache not enabled. Check "
+		       "your bootloader. L2 off results in performance loss\n");
+	} else {
+		pr_info("OMAP3 L2 cache enabled");
+	}
+
+	return 0;
+}
+
+arch_initcall(omap3_check_l2cache_on);
+#endif /* CONFIG_ARCH_OMAP3 */

--------------000105080606080705080203--
