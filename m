From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [linux-omap only][PATCH] ARM: OMAP: Partial revert for EAC IO address changes
Date: Fri,  3 Apr 2009 08:37:03 +0300
Message-ID: <1238737024-14647-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45415 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZDCFgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 01:36:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n335aLL0002162
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 00:36:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This is partial revert for commit 3a02c1ae56a61c5249594553735ff32557e2e7ed
and only purpose is to sync these lines with mainline version and to have
common cleanup patch for both linux-omap and mainline.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/devices.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2568b0c..0bda713 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -369,12 +369,12 @@ static inline void omap_init_mcspi(void) {}
 
 #ifdef CONFIG_SND_OMAP24XX_EAC
 
-#define OMAP2_EAC_BASE			(L4_24XX_BASE + 0x90000)
+#define OMAP2_EAC_BASE			0x48090000
 
 static struct resource omap2_eac_resources[] = {
 	{
 		.start		= OMAP2_EAC_BASE,
-		.end		= OMAP2_EAC_BASE + 0xfff,
+		.end		= OMAP2_EAC_BASE + 0x109,
 		.flags		= IORESOURCE_MEM,
 	},
 };
-- 
1.6.2.1

