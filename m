From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/10] OMAP3 SDRC: set FIXEDDELAY when disabling SDRC DLL
Date: Tue, 26 May 2009 16:12:35 -0600
Message-ID: <20090526221234.25381.63193.stgit@localhost.localdomain>
References: <20090526220517.25381.75976.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200AbZEZWWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 18:22:33 -0400
In-Reply-To: <20090526220517.25381.75976.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Correspondence with the TI OMAP hardware team indicates that
SDRC_DLLA_CTRL.FIXEDDELAY should be initialized to 0x0f.  This number
was apparently derived from process validation.  This is only used
when the SDRC DLL is unlocked (e.g., SDRC clock frequency less than
83MHz).

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


