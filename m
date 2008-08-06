From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/11] sdrc register defs
Date: Wed, 6 Aug 2008 18:44:32 +0530 (IST)
Message-ID: <43340.192.168.10.89.1218028472.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:51970 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbYHFNOj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:14:39 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DEY1O017872
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:14:39 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DEUa5007717
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:14:32 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds some missing sdrc register definitions

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/sram34xx.S   |    4 ++--
 include/asm-arm/arch-omap/sdrc.h |   13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/sram34xx.S
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/sram34xx.S	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/sram34xx.S	2008-08-06 18:10:18.000000000
+0530
@@ -165,9 +165,9 @@ omap3_cm_iclken1_core:
 omap3_sdrc_rfr_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 omap3_sdrc_actim_ctrla:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
 omap3_sdrc_actim_ctrlb:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
 omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
Index: linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/sdrc.h	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h	2008-08-06
18:10:18.000000000 +0530
@@ -21,15 +21,24 @@
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */

 #define SDRC_SYSCONFIG		0x010
+#define SDRC_CS_CFG		0x040
+#define SDRC_SHARING		0x044
+#define SDRC_ERR_TYPE		0x04C
 #define SDRC_DLLA_CTRL		0x060
 #define SDRC_DLLA_STATUS	0x064
 #define SDRC_DLLB_CTRL		0x068
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
+#define SDRC_MCFG_0		0x080
 #define SDRC_MR_0		0x084
-#define SDRC_ACTIM_CTRL_A	0x09c
-#define SDRC_ACTIM_CTRL_B	0x0a0
+#define SDRC_ACTIM_CTRL_A_0	0x09c
+#define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
+#define SDRC_MCFG_1		0x0B0
+#define SDRC_MR_1		0x0B4
+#define SDRC_ACTIM_CTRL_A_1	0x0C4
+#define SDRC_ACTIM_CTRL_B_1	0x0C8
+#define SDRC_RFR_CTRL_1		0x0D4

 /*
  * These values represent the number of memory clock cycles between


