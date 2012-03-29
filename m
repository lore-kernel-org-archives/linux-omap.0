From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 4/4] ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition
Date: Thu, 29 Mar 2012 15:31:57 +0530
Message-ID: <1333015317-11866-5-git-send-email-tarun.kanti@ti.com>
References: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab2C2KCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 06:02:16 -0400
In-Reply-To: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: olof@lixom.net, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since all references to OMAP_GPIO_IRQ macro are replaced now
with gpio_to_irq(), this can be removed altogether.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/include/plat/gpio.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 9e86ee0..d4df414 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -158,10 +158,6 @@
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
-#define OMAP_GPIO_IRQ(nr)	(OMAP_GPIO_IS_MPUIO(nr) ? \
-				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
-				 IH_GPIO_BASE + (nr))
-
 #define METHOD_MPUIO		0
 #define METHOD_GPIO_1510	1
 #define METHOD_GPIO_1610	2
-- 
1.7.0.4

