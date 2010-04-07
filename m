From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/6] omap4: Fix WDT Kconfig
Date: Wed,  7 Apr 2010 13:17:22 +0530
Message-ID: <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
References: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58949 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab0DGHrf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 03:47:35 -0400
In-Reply-To: <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Wim Van Sebroeck <wim@iguana.be>

This patch allows Watchdog timer to be selected for OMAP4 by fixing
Kconfig entry

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index bdcdbd5..ea5b269 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -199,10 +199,10 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
 	help
-	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog.  Say 'Y'
-	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog timer.
+	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog.  Say 'Y'
+	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog timer.
 
 config PNX4008_WATCHDOG
 	tristate "PNX4008 Watchdog"
-- 
1.6.0.4

