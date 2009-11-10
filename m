From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 2/8] omap: introduce OMAP_LL_DEBUG_NONE DEBUG_LL config
Date: Tue, 10 Nov 2009 16:47:23 -0600
Message-ID: <1257893249-15467-3-git-send-email-vikram.pandita@ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
 <1257893249-15467-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbZKJWsF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 17:48:05 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAAMmAOS008502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 16:48:10 -0600
In-Reply-To: <1257893249-15467-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Zoom2/Zoom3 kind of boards do not use omap uarts for console.
These use external debug board for console.

So these boards should not have "Uncompressing Kernel...."
log put on omap uarts.

By interoducing OMAP_LL_DEBUG_NONE option,
unnecessary writes to omap uarts is avoided.

In future, the DEBUG_LL interface will be enhanced
to use external debug board.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/Kconfig                   |    5 ++++-
 arch/arm/plat-omap/include/plat/uncompress.h |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..f348ddf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -165,7 +165,7 @@ config OMAP_DM_TIMER
 choice
 	prompt "Low-level debug console UART"
 	depends on ARCH_OMAP
-	default OMAP_LL_DEBUG_UART1
+	default OMAP_LL_DEBUG_NONE
 
 config OMAP_LL_DEBUG_UART1
 	bool "UART1"
@@ -176,6 +176,9 @@ config OMAP_LL_DEBUG_UART2
 config OMAP_LL_DEBUG_UART3
 	bool "UART3"
 
+config OMAP_LL_DEBUG_NONE
+	bool "None"
+
 endchoice
 
 config OMAP_SERIAL_WAKE
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index e22f575..13c305d 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -44,8 +44,12 @@ static void putc(int c)
 	uart = (volatile u8 *)(OMAP_UART3_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
 	uart = (volatile u8 *)(OMAP_UART2_BASE);
-#else
+#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
 	uart = (volatile u8 *)(OMAP_UART1_BASE);
+#elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
+	return;
+#else
+	return;
 #endif
 
 #ifdef CONFIG_ARCH_OMAP1
-- 
1.6.5.1.69.g36942

