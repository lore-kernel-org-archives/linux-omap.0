From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
Date: Mon, 19 Jul 2010 11:50:18 -0500
Message-ID: <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35774 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936408Ab0GSQjc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 12:39:32 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Simon Que <sque@ti.com>

Add HWSPINLCOK base address information in omap44xx.h

Signed-off-by: Simon Que <sque@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 76832d3..8016508 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -49,5 +49,10 @@
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
 
+#define OMAP4_MMU1_BASE			0x55082000
+#define OMAP4_MMU2_BASE			0x4A066000
+
+#define OMAP44XX_SPINLOCK_BASE		(L4_44XX_BASE + 0xF6000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.0

