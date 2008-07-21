From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Add SYSOFFMODE option.
Date: Mon, 21 Jul 2008 19:02:04 +0300
Message-ID: <1216656125-5800-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
 <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61858 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYGUQCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 12:02:37 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6LG2Isl025738
	for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2008 11:02:34 -0500
In-Reply-To: <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/plat-omap/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index d7b34ff..6f891b7 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -73,6 +73,12 @@ config OMAP_SMARTREFLEX
 	  compensation for VDD1 and VDD2, user must write 1 to
 	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
 
+config OMAP_SYSOFFMODE
+        bool "OFF mode support"
+	depends on ARCH_OMAP34XX
+	help
+	  Say Y if you want to allow OMAP to enter OFF mode.
+
 config OMAP_SMARTREFLEX_TESTING
 	bool "Smartreflex testing support"
 	depends on OMAP_SMARTREFLEX
-- 
1.5.3.4

