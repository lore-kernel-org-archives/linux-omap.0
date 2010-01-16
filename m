From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] omap: Remove old DEBUG_LL serial port options
Date: Fri, 15 Jan 2010 17:35:18 -0800
Message-ID: <20100116013518.10065.41933.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59133 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758658Ab0APBfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:35:08 -0500
In-Reply-To: <20100116013205.10065.95921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These are no longer needed. Note that zoom boards
should now set their own function in uncompress.h
and debug-macro.S for the external UART.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Kconfig |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e2ea04a..484d6a9 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -141,25 +141,6 @@ config OMAP_DM_TIMER
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
-choice
-	prompt "Low-level debug console UART"
-	depends on ARCH_OMAP
-	default OMAP_LL_DEBUG_NONE
-
-config OMAP_LL_DEBUG_UART1
-	bool "UART1"
-
-config OMAP_LL_DEBUG_UART2
-	bool "UART2"
-
-config OMAP_LL_DEBUG_UART3
-	bool "UART3"
-
-config OMAP_LL_DEBUG_NONE
-	bool "None"
-
-endchoice
-
 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
 	depends on ARCH_OMAP1 && OMAP_MUX

