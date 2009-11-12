From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] omap: introduce OMAP_LL_DEBUG_NONE DEBUG_LL config
Date: Wed, 11 Nov 2009 19:02:19 -0800
Message-ID: <20091112030219.5159.99104.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53254 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760042AbZKLDCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:02:14 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: vikram pandita <vikram.pandita@ti.com>

Zoom2/Zoom3 kind of boards do not use omap uarts for console.
These use external debug board for console.

So these boards should not have "Uncompressing Kernel...."
log put on omap uarts.

By interoducing OMAP_LL_DEBUG_NONE option,
unnecessary writes to omap uarts is avoided.

In future, the DEBUG_LL interface will be enhanced
to use external debug board.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

