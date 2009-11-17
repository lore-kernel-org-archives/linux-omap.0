From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/12] omap: zoom2: update defconfig for LL_DEBUG_NONE
Date: Mon, 16 Nov 2009 16:03:21 -0800
Message-ID: <20091117000320.GY3684@atomide.com>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51561 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbZKQADQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 19:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

One more..

Tony

>From 18db1c90bf4022db95fb908cdd390e94798851ba Mon Sep 17 00:00:00 2001
From: vikram pandita <vikram.pandita@ti.com>
Date: Fri, 13 Nov 2009 17:37:35 -0800
Subject: [PATCH] omap: zoom2: update defconfig for LL_DEBUG_NONE

Update DEBUG_LL for zoom2 board as CONFIG_OMAP_LL_DEBUG_NONE

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index a32d126..eef9362 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -202,7 +202,8 @@ CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_LL_DEBUG_NONE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
 
