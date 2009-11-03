From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/8] omap: DEBUG_LL: allow no omap uart configuration
Date: Tue,  3 Nov 2009 15:20:09 -0600
Message-ID: <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51582 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZKCVVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 16:21:11 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3LLGUA005194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 15:21:16 -0600
In-Reply-To: <1257283215-6448-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Zoom2/Zoom3 kind of boards do not use omap uarts
these boards should not have DEBUG_LL writing to omap uarts

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/Kconfig                   |    3 +++
 arch/arm/plat-omap/include/plat/uncompress.h |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..c912e0e 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -176,6 +176,9 @@ config OMAP_LL_DEBUG_UART2
 config OMAP_LL_DEBUG_UART3
 	bool "UART3"
 
+config OMAP_LL_DEBUG_NONE
+	bool "None"
+
 endchoice
 
 config OMAP_SERIAL_WAKE
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index e22f575..49b38f0 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -44,8 +44,10 @@ static void putc(int c)
 	uart = (volatile u8 *)(OMAP_UART3_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
 	uart = (volatile u8 *)(OMAP_UART2_BASE);
-#else
+#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
 	uart = (volatile u8 *)(OMAP_UART1_BASE);
+#elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
+	return;
 #endif
 
 #ifdef CONFIG_ARCH_OMAP1
-- 
1.6.5.1.69.g36942

