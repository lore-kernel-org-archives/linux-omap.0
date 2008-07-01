From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/11] sdrc register defs
Date: Tue, 1 Jul 2008 19:46:15 +0530
Message-ID: <004101c8db85$05a34aa0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58710 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759391AbYGAOQW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EGFWs026426
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:21 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EG7up011322
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:14 +0530 (IST)
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
--- linux-omap-2.6.orig/arch/arm/mach-omap2/sram34xx.S	2008-05-30 09:48:07.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/sram34xx.S	2008-05-30 10:54:10.377835914 +0530
@@ -185,9 +185,9 @@ omap34xx_cm_iclken1_core:
 omap34xx_sdrc_rfr_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 omap34xx_sdrc_actim_ctrla:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
 omap34xx_sdrc_actim_ctrlb:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
 omap34xx_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap34xx_sdrc_dlla_ctrl:
Index: linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/sdrc.h	2008-05-30 09:48:15.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h	2008-05-30 10:54:19.223556769 +0530
@@ -19,15 +19,24 @@
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

