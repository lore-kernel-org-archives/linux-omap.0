From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/8] ARM: OMAP5: Update SAR memory layout for WakeupGen
Date: Wed, 20 Feb 2013 20:57:12 +0530
Message-ID: <1361374034-21831-7-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53699 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935544Ab3BTP0C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:26:02 -0500
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP5 es2 WakeupGen SAR register layout offset have changed.
Update the layout accordingly.

Reported-by: Menon, Nishanth <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index e170fe8..9374175 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -48,13 +48,13 @@
 #define SAR_BACKUP_STATUS_WAKEUPGEN		0x10
 
 /* WakeUpGen save restore offset from OMAP54XX_SAR_RAM_BASE */
-#define OMAP5_WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x8d4)
-#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU0	(SAR_BANK3_OFFSET + 0x8e8)
-#define OMAP5_WAKEUPGENENB_OFFSET_CPU1		(SAR_BANK3_OFFSET + 0x8fc)
-#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU1	(SAR_BANK3_OFFSET + 0x910)
-#define OMAP5_AUXCOREBOOT0_OFFSET		(SAR_BANK3_OFFSET + 0x924)
-#define OMAP5_AUXCOREBOOT1_OFFSET		(SAR_BANK3_OFFSET + 0x928)
-#define OMAP5_AMBA_IF_MODE_OFFSET		(SAR_BANK3_OFFSET + 0x92c)
+#define OMAP5_WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x9dc)
+#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU0	(SAR_BANK3_OFFSET + 0x9f0)
+#define OMAP5_WAKEUPGENENB_OFFSET_CPU1		(SAR_BANK3_OFFSET + 0xa04)
+#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU1	(SAR_BANK3_OFFSET + 0xa18)
+#define OMAP5_AUXCOREBOOT0_OFFSET		(SAR_BANK3_OFFSET + 0xa2c)
+#define OMAP5_AUXCOREBOOT1_OFFSET		(SAR_BANK3_OFFSET + 0x930)
+#define OMAP5_AMBA_IF_MODE_OFFSET		(SAR_BANK3_OFFSET + 0xa34)
 #define OMAP5_SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x800)
 
 #endif
-- 
1.7.9.5

