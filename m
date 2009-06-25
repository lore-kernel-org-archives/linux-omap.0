From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP3: Kconfig: remove duplicate board entries
Date: Thu, 25 Jun 2009 14:50:15 -0700
Message-ID: <1245966616-26804-2-git-send-email-khilman@deeprootsystems.com>
References: <1245966616-26804-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:62877 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZFYVuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:50:18 -0400
Received: by pxi28 with SMTP id 28so1283351pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:50:22 -0700 (PDT)
In-Reply-To: <1245966616-26804-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Remove some duplicate board entries created from a merge.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bfb36e2..225829e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -133,22 +133,10 @@ config MACH_OVERO
 	bool "Gumstix Overo board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP3EVM
-	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP_3430SDP
-	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config MACH_OMAP_ZOOM2
-	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-- 
1.6.3.2

