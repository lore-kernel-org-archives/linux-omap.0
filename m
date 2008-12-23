From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2: fix recent build breakage
Date: Mon, 22 Dec 2008 23:28:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812222326580.3233@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYLWG2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:28:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Fix recent build breakage.  Boot-tested on N800.
    
  CC      arch/arm/mach-omap2/devices.o
arch/arm/mach-omap2/devices.c:110: error: 'OMAP34XX_MAILBOX_BASE' undeclared here (not in a function)
arch/arm/mach-omap2/devices.c:115: error: 'INT_34XX_MAIL_U0_MPU' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
    
Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 937fb18..d7e848e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -112,7 +112,7 @@ static struct resource omap3_mbox_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_34XX_MAIL_U0_MPU,
+		.start		= INT_24XX_MAIL_U0_MPU,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 2f82e28..27a1e45 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -56,6 +56,9 @@
 #define OMAP34XX_SR1_BASE	0x480C9000
 #define OMAP34XX_SR2_BASE	0x480CB000
 
+#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
+#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
+
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
@@ -63,8 +66,6 @@
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
-#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
 #endif
 
