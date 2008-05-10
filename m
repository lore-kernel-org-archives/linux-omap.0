From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH v2] ARM: OMAP3: Check for L2 cache enabled
Date: Sat, 10 May 2008 20:41:15 +0200
Message-ID: <4825EC4B.1020903@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040805050302030809040905"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:60904 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYEJSlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 14:41:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1228763fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2008 11:41:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040805050302030809040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Enabling L2 cache of Cortex-A8 based OMAP3 has to be done by 
bootloader. Check if this is done and warn if not.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

----

Changes in v2: Fix a typo.

--------------040805050302030809040905
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
+arch_initcall(omap3_check_l2cache);
+#endif /* CONFIG_ARCH_OMAP3 */

--------------040805050302030809040905--
