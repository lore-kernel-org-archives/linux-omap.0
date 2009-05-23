From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: [PATCH] Select PWL4030_CORE for boards which need twl4030_i2c_* functions.
Date: Sat, 23 May 2009 16:39:24 +0300
Message-ID: <1243085964-31024-1-git-send-email-ihar.hrachyshka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:62958 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZEWNjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 09:39:39 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so380128fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 06:39:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>

This fixes compilation for the following machines: MACH_OMAP_2430SDP,
MACH_OMAP_LDP, MACH_OMAP2EVM, MACH_OMAP_3430SDP, MACH_OMAP3EVM,
MACH_OMAP3_BEAGLE, MACH_OVERO, MACH_OMAP3_PANDORA, when PWL4030_CORE is not
enabled.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 27750f5..cffd979 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,34 +105,42 @@ config MACH_OMAP_APOLLON
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
+	select TWL4030_CORE
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config MACH_OMAP2EVM 
 	bool "OMAP 2530 EVM board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	select TWL4030_CORE
 
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config MACH_OVERO
 	bool "Gumstix Overo board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select TWL4030_CORE
 
 config OMAP_TICK_GPTIMER
 	int "GPTIMER used for system tick timer"
-- 
1.6.3.1

