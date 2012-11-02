From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: [PATCH] OMAP2: Fix a typo - replace regist with register.
Date: Fri, 2 Nov 2012 23:45:45 +0900
Message-ID: <201211021445.qA2EjjI5005838@94.43.138.210.xn.2iij.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 94.43.138.210.xn.2iij.net ([210.138.43.94]:42805 "EHLO
	94.43.138.210.xn.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2KBOzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 10:55:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
---
 arch/arm/mach-omap2/control.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a89e825..5e6886e 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -233,7 +233,7 @@
 #define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
 #define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
 
-/* 34xx GENERAL_WKUP regist offsets */
+/* 34xx GENERAL_WKUP register offsets */
 #define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
 						0x008 + (i))
 #define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
-- 
1.7.9.5

