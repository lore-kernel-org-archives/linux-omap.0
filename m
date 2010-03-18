From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] OMAP: Devkit8000: Add missing package selection
Date: Thu, 18 Mar 2010 14:17:43 +0100
Message-ID: <1268918263-22127-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab0CRNSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 09:18:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Add missing selection of CUS package.
Replace whitespace with tab.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8a3d1e..e776075 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -59,8 +59,9 @@ config MACH_OMAP3_BEAGLE
 	select OMAP_PACKAGE_CBB
 
 config MACH_DEVKIT8000
-        bool "DEVKIT8000 board"
-        depends on ARCH_OMAP3
+	bool "DEVKIT8000 board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CUS
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
-- 
1.6.4.4

