From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Add debobs Kconfig item
Date: Wed, 17 Sep 2008 18:02:29 +0300
Message-ID: <1221663749-26121-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
 <1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com>
 <1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24868 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYIQPHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 11:07:04 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8HF6WkW005955
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 10:07:01 -0500
In-Reply-To: <1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Kconfig  |   10 +++++++++-
 arch/arm/mach-omap2/Makefile |    3 +++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d0bbbf8..639af08 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -151,4 +151,12 @@ config OMAP3_OFF_MODE
 	depends on ARCH_OMAP3
 	default n
 	help
-	  Use off mode for powerdomains.
\ No newline at end of file
+	  Use off mode for powerdomains.
+
+config OMAP3_DEBOBS	
+	bool "OMAP 3430 Debug observability support"
+	depends on ARCH_OMAP3 && DEBUG_FS
+	default n
+	help
+	  Use ETK pads for debug observability
+
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 23fc127..88d3af0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -40,6 +40,9 @@ obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
 mailbox_mach-objs		:= mailbox.o
 mmu_mach-objs			:= mmu.o
 
+# Debobs
+obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
-- 
1.5.6.3

