From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Add debobs Kconfig item
Date: Wed,  1 Oct 2008 18:11:13 +0300
Message-ID: <1222873873-31760-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1222873873-31760-1-git-send-email-peter.de-schrijver@nokia.com>
 <1222873873-31760-2-git-send-email-peter.de-schrijver@nokia.com>
 <1222873873-31760-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36120 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYJAPLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 11:11:41 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m91FBKKm015698
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 18:11:38 +0300
In-Reply-To: <1222873873-31760-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 arch/arm/plat-omap/Kconfig   |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e18da0c..a30d5ff 100644
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
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 960c13f..ebcfd27 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -205,6 +205,13 @@ config OMAP_32K_TIMER
 
 endchoice
 
+config OMAP3_DEBOBS	
+	bool "OMAP 3430 Debug observability support"
+	depends on ARCH_OMAP3 && DEBUG_FS
+	default n
+	help
+	  Use ETK pads for debug observability
+
 config OMAP_32K_TIMER_HZ
        int "Kernel internal timer frequency for 32KHz timer"
        range 32 1024
-- 
1.5.6.3

