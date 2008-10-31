From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] OMAP: Select right CPU_Vn automatically
Date: Fri, 31 Oct 2008 16:45:25 +0200
Message-ID: <1225464325-32208-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47656 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbYJaOpV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 10:45:21 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VEiVwK001722
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 09:45:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>

Prevents idiots like me from creating an uncompilable .config

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c730fa6..e57430b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -10,11 +10,13 @@ config ARCH_OMAP2420
 	depends on ARCH_OMAP24XX
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
+	select CPU_V6
 
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
 	select ARCH_OMAP_OTG
+	select CPU_V6
 
 config ARCH_OMAP34XX
 	bool "OMAP34xx Based System"
@@ -24,6 +26,7 @@ config ARCH_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select ARCH_OMAP_OTG
+	select CPU_V7
 
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
-- 
1.5.6.5

