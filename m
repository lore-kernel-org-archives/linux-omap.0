From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 18/19] ARM: OMAP4460: wakeupgen: set GIC_CPU0 backup status flag always
Date: Fri, 20 Apr 2012 12:33:51 +0300
Message-ID: <1334914432-26456-19-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48179 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab2DTJev (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:51 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Without this, CPU0 will crash in the ROM code during wakeup from
device off. This patch also clears the GIC save area, to prevent
ROM code from writing garbage to the GIC registers during wakeup.
The actual GIC restore is done by kernel.

This bug fix applies only to OMAP4460, it is fixed on OMAP4470.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c   |   14 ++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index c7c4db4..30da299 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -447,10 +447,24 @@ int __init omap_wakeupgen_init(void)
 
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
 		sar_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
+		/* Clean GIC SAR area */
+		for (i = SAR_BACKUP_STATUS_OFFSET; i < WAKEUPGENENB_OFFSET_CPU0;
+			i += 4)
+			sar_writel(0, i, 0);
+
 		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU0_OFFSET, 0);
 		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU1_OFFSET, 0);
 		for (i = 0; i < max_spi_reg; i++)
 			sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);
+
+		/*
+		 * Set CPU0 GIC backup flag permanently for omap4460,
+		 * this is needed because of the ROM code bug that breaks
+		 * GIC during wakeup from device off
+		 */
+		if (cpu_is_omap446x())
+			__raw_writel(SAR_BACKUP_STATUS_GIC_CPU0,
+				     sar_base + SAR_BACKUP_STATUS_OFFSET);
 		iounmap(sar_base);
 		sar_base = NULL;
 	} else {
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 0056667..e621c51 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -88,6 +88,7 @@
 #define ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
 #define ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
 #define ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)
+#define SAR_BACKUP_STATUS_GIC_CPU0		0x1
 
 /* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
 #define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)
-- 
1.7.4.1

