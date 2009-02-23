From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 18/23] arm: omap: make usb base defines follow trm
Date: Mon, 23 Feb 2009 20:55:30 +0200
Message-ID: <1235415335-17408-19-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43031 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZBWS7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:59:40 -0500
In-Reply-To: <1235415335-17408-18-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Use names closer to what TRM says and define each
block separately so we don't have to use magic constants
anylonger.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 arch/arm/mach-omap2/usb-ehci.c             |    4 ++--
 arch/arm/plat-omap/include/mach/omap34xx.h |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 30e1ad6..6c1a46f 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -30,8 +30,8 @@
 
 static struct resource ehci_resources[] = {
 	[0] = {
-		.start   = OMAP34XX_HSUSB_HOST_BASE + 0x800,
-		.end     = OMAP34XX_HSUSB_HOST_BASE + 0x800 + SZ_1K - 1,
+		.start   = OMAP34XX_EHCI_BASE,
+		.end     = OMAP34XX_EHCI_BASE + SZ_1K - 1,
 		.flags   = IORESOURCE_MEM,
 	},
 	[1] = {         /* general IRQ */
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 27a1e45..53630dc 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -51,8 +51,10 @@
 #define OMAP34XX_IC_BASE	0x48200000
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
 #define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
-#define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
 #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
+#define OMAP34XX_UHH_CONFIG_BASE	(L4_34XX_BASE + 0x64000)
+#define OMAP34XX_OHCI_BASE	(L4_34XX_BASE + 0x64400)
+#define OMAP34XX_EHCI_BASE	(L4_34XX_BASE + 0x64800)
 #define OMAP34XX_SR1_BASE	0x480C9000
 #define OMAP34XX_SR2_BASE	0x480CB000
 
-- 
1.6.1.3

