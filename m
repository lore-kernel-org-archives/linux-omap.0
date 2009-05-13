From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] PM: OMAP3 SDRC: set FIXEDDELAY when disabling SDRC DLL
Date: Tue, 12 May 2009 19:39:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905121907430.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53787 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZEMBju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 21:39:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com


Correspondence with the TI OMAP hardware team indicates that
SDRC_DLLA_CTRL.FIXEDDELAY should be initialized to 0x0f.  This number
was apparently derived from process validation.  This is only used
when the SDRC DLL is unlocked (e.g., SDRC clock frequency less than
83MHz).

This patch has been queued into the omap-clock-testing branch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 487fa86..f41f8d9 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -41,8 +41,18 @@
 #define SDRC_UNLOCK_DLL			0x1
 
 /* SDRC_DLLA_CTRL bit settings */
+#define FIXEDDELAY_SHIFT		24
+#define FIXEDDELAY_MASK			(0xff << FIXEDDELAY_SHIFT)
 #define DLLIDLE_MASK			0x4
 
+/*
+ * SDRC_DLLA_CTRL default values: TI hardware team indicates that
+ * FIXEDDELAY should be initialized to 0xf.  This apparently was
+ * empirically determined during process testing, so no derivation
+ * was provided.
+ */
+#define FIXEDDELAY_DEFAULT		(0x0f << FIXEDDELAY_SHIFT)
+
 /* SDRC_DLLA_STATUS bit settings */
 #define LOCKSTATUS_MASK			0x4
 
@@ -103,6 +113,8 @@ return_to_sdram:
 unlock_dll:
 	ldr	r11, omap3_sdrc_dlla_ctrl
 	ldr	r12, [r11]
+	and	r12, r12, #FIXEDDELAY_MASK
+	orr	r12, r12, #FIXEDDELAY_DEFAULT
 	orr	r12, r12, #DLLIDLE_MASK
 	str	r12, [r11]		@ (no OCP barrier needed)
 	bx	lr
-- 
1.6.3.rc1.51.gea0b7

