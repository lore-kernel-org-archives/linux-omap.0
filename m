From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/21] OMAP: Kconfig: move GP timer selection alongside other timer options
Date: Wed,  4 Feb 2009 18:05:50 -0800
Message-ID: <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:57993 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbZBECGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:06:42 -0500
Received: by yw-out-2324.google.com with SMTP id 9so61ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:06:41 -0800 (PST)
In-Reply-To: <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/plat-omap/Kconfig  |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3754b79..1085f04 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -58,4 +58,4 @@ config MACH_OVERO
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
\ No newline at end of file
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 91f8b8b..e37a1a2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -167,6 +167,21 @@ config OMAP_32K_TIMER_HZ
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
1.6.1

