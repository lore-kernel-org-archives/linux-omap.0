From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 21/21] OMAP: Add debug observablity (debobs) Kconfig item
Date: Wed,  4 Feb 2009 18:06:07 -0800
Message-ID: <1233799567-22250-22-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-16-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-17-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-18-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-19-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-20-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:25061 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762622AbZBECHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:51 -0500
Received: by el-out-1112.google.com with SMTP id b25so227elf.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:51 -0800 (PST)
In-Reply-To: <1233799567-22250-21-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 arch/arm/plat-omap/Kconfig   |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c69221c..f6ef434 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -32,6 +32,9 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+# Debug Observability
+obj-$(CONFIG_OMAP3_DEBOBS)		+= debobs.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e37a1a2..7808b40 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -158,6 +158,13 @@ config OMAP_32K_TIMER
 
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
1.6.1

