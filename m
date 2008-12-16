From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP: move GP timer selection alongside other timer options
Date: Tue, 16 Dec 2008 10:34:08 -0800
Message-ID: <1229452450-22497-2-git-send-email-khilman@deeprootsystems.com>
References: <1229452450-22497-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f31.google.com ([209.85.219.31]:47421 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbYLPSeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:34:22 -0500
Received: by mail-ew0-f31.google.com with SMTP id 12so3425524ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 10:34:21 -0800 (PST)
In-Reply-To: <1229452450-22497-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig |   16 ----------------
 arch/arm/plat-omap/Kconfig  |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ca24a7a..0a86a88 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -132,19 +132,3 @@ config MACH_OVERO
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config OMAP_TICK_GPTIMER
-	int "GPTIMER used for system tick timer"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
-	range 1 12
-	default 1
-	help
-	  Linux uses one of the twelve on-board OMAP GPTIMER blocks to generate
-	  system tick interrupts.  The twelve GPTIMERs have slightly
-	  different powerdomain, source clock, and security properties
-	  (mostly documented in the OMAP3 TRMs) that can affect the selection
-	  of which GPTIMER to use.  The historical default is GPTIMER1.
-	  If CONFIG_OMAP_32K_TIMER is selected, Beagle may require GPTIMER12
-	  due to hardware sensitivity to glitches on the OMAP 32kHz clock
-	  input.
-
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 960c13f..c9e1396 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -214,6 +214,21 @@ config OMAP_32K_TIMER_HZ
 	  Kernel internal timer frequency should be a divisor of 32768,
 	  such as 64 or 128.
 
+config OMAP_TICK_GPTIMER
+	int "GPTIMER used for system tick timer"
+	depends on ARCH_OMAP2 || ARCH_OMAP3
+	range 1 12
+	default 1
+	help
+	  Linux uses one of the twelve on-board OMAP GPTIMER blocks to generate
+	  system tick interrupts.  The twelve GPTIMERs have slightly
+	  different powerdomain, source clock, and security properties
+	  (mostly documented in the OMAP3 TRMs) that can affect the selection
+	  of which GPTIMER to use.  The historical default is GPTIMER1.
+	  If CONFIG_OMAP_32K_TIMER is selected, Beagle may require GPTIMER12
+	  due to hardware sensitivity to glitches on the OMAP 32kHz clock
+	  input.
+
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
 	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
-- 
1.6.0.3

