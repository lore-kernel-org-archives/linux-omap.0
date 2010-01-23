From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Remove un-used enums
Date: Fri, 22 Jan 2010 22:44:29 -0600
Message-ID: <1264221870-11178-2-git-send-email-omar.ramirez@ti.com>
References: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47300 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab0AWEeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 23:34:08 -0500
In-Reply-To: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>

From: Shivananda Hebbar <x0hebbar@ti.com>

This patch removes un-used enum definitions from bridge.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h |    8 --------
 drivers/dsp/bridge/hw/IPIAccInt.h              |   15 ---------------
 drivers/dsp/bridge/wmd/_tiomap.h               |   15 ---------------
 3 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
index 2e7fcf5..91db7a9 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmmdefs.h
@@ -105,14 +105,6 @@
 		CMM_DSPPA2PA = 4,	/* DSP Pa to GPP Pa */
 	} ;
 
-/*
- *  Used to "map" between device process virt addr and dsp addr.
- */
-	enum CMM_KERNMAPTYPE {
-		CMM_KERNVA2DSP = 0, /* Device process context to dsp address. */
-		CMM_DSP2KERNVA = 1, /* Dsp address to device process context. */
-	} ;
-
 	struct CMM_OBJECT;
 	struct CMM_XLATOROBJECT;
 
diff --git a/drivers/dsp/bridge/hw/IPIAccInt.h b/drivers/dsp/bridge/hw/IPIAccInt.h
index b88a58c..dde0ef0 100644
--- a/drivers/dsp/bridge/hw/IPIAccInt.h
+++ b/drivers/dsp/bridge/hw/IPIAccInt.h
@@ -22,20 +22,5 @@
 #define SYSC_IVA2BOOTADDR_OFFSET                0x400
 #define SYSC_IVA2BOOTADDR_MASK                 0xfffffc00
 
-
-/* The following represent the enumerated values for each bitfield */
-
-enum IPIIPI_SYSCONFIGAutoIdleE {
-	IPIIPI_SYSCONFIGAutoIdleclkfree = 0x0000,
-	IPIIPI_SYSCONFIGAutoIdleautoclkgate = 0x0001
-} ;
-
-enum IPIIPI_ENTRYElemSizeValueE {
-	IPIIPI_ENTRYElemSizeValueElemSz8b = 0x0000,
-	IPIIPI_ENTRYElemSizeValueElemSz16b = 0x0001,
-	IPIIPI_ENTRYElemSizeValueElemSz32b = 0x0002,
-	IPIIPI_ENTRYElemSizeValueReserved = 0x0003
-} ;
-
 #endif				/* _IPI_ACC_INT_H */
 /* EOF */
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 4627822..077e693 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -270,21 +270,6 @@ static const struct BPWR_Clk_t BPWR_Clks[] = {
 #define INTH_MASK_IT_REG_OFFSET         0x04	/* Mask Interrupt reg offset  */
 
 #define   DSP_MAILBOX1_INT              10
-
-/*
- *  INTH_InterruptKind_t
- *  Identify the kind of interrupt: either FIQ/IRQ
- */
-enum INTH_InterruptKind_t {
-	INTH_IRQ = 0,
-	INTH_FIQ = 1
-} ;
-
-enum INTH_SensitiveEdge_t {
-	FALLING_EDGE_SENSITIVE = 0,
-	LOW_LEVEL_SENSITIVE = 1
-} ;
-
 /*
  *  Bit definition of  Interrupt  Level  Registers
  */
-- 
1.6.2.4

