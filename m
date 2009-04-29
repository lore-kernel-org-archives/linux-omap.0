From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] RX51: Remove multiple definition of MACH_NOKIA_RX51 in Kconfig
Date: Wed, 29 Apr 2009 12:38:25 +0300
Message-ID: <1240997905-5199-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27732 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZD2JjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 05:39:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>

This patch prevents "Nokia RX-51 board" from being shown twice in
'System Type' within Menuconfig.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3a2214c..c7b05ac 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -140,7 +140,3 @@ config MACH_OMAP3_PANDORA
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config MACH_NOKIA_RX51
-	bool "Nokia RX-51 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-- 
1.6.0.4

