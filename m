From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Add debobs Kconfig item
Date: Tue, 16 Sep 2008 14:24:40 +0300
Message-ID: <1221564280-7647-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1221564280-7647-1-git-send-email-peter.de-schrijver@nokia.com>
 <1221564280-7647-2-git-send-email-peter.de-schrijver@nokia.com>
 <1221564280-7647-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20965 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYIPLZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 07:25:04 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GBOfWq011269
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:25:01 +0300
In-Reply-To: <1221564280-7647-3-git-send-email-peter.de-schrijver@nokia.com>
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
index 43a679f..9d2f837 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -147,4 +147,12 @@ config OMAP3_OFF_MODE
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
index 398a872..828f834 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
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

