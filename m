From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 12/14] OMAP3630: DMA: Add work around for erratum i557
Date: Wed, 24 Nov 2010 18:21:48 +0530
Message-ID: <1290603110-14119-13-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40979 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab0KXMw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:52:57 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

DMA4 channel fails to continue with descriptor load when
pause bit is cleared through config port access while in
mstandby.

Work around: Software should configure DMA in no standby mode
or force standby before clearing the pause bit(CDPi[7]) using
mstandby mode control API's.

Applicable for all versions of OMAP3630 silicons.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/dma.c             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 290b40c..86c8d20 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -689,6 +689,17 @@ static u32 configure_dma_errata(void)
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		SET_DMA_ERRATA(DMA_ROMCODE_BUG);
 
+	/*
+	 * Erratum i557 - DMA4 channel fails to continue with descriptor load
+	 * when pause bit is cleared through config port access while in
+	 * standby.
+	 * Work around: Software should configure DMA in no standby mode or
+	 * Force standby before clearing the pause bit(CDPi[7]).
+	 * Applicable for all versions of OMAP3630 silicons.
+	 */
+	if (cpu_is_omap3630())
+		SET_DMA_ERRATA(DMA_ERRATA_i557);
+
 	return errata;
 }
 
@@ -1431,12 +1442,19 @@ int omap_resume_dma_sglist_transfers(int lch, int pauseafter)
 	 */
 	wmb();
 
+	if (IS_DMA_ERRATA(DMA_ERRATA_i557))
+		omap_device_require_no_mstandby(pd);
+
 	/* Clear pause bit in CDP */
 	l = dma_read(CDP, lch);
 	l &= ~(DMA_LIST_CDP_PAUSEMODE);
 	dma_write(l, CDP, lch);
 
 	omap_start_dma(lch);
+
+	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
+		omap_device_release_no_mstandby(pd);
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index fd378f6..e18603d 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -285,6 +285,7 @@
 #define DMA_ERRATA_i88			BIT(0x4)
 #define DMA_ERRATA_3_3			BIT(0x5)
 #define DMA_ROMCODE_BUG			BIT(0x6)
+#define DMA_ERRATA_i557			BIT(0x7)
 
 /* Attributes for OMAP DMA Contrller */
 #define DMA_LINKED_LCH			BIT(0x0)
-- 
1.7.1

