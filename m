From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 02/06][RFC] OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Fri, 29 May 2009 14:02:55 +0530
Message-ID: <1243585979-10921-2-git-send-email-rnayak@ti.com>
References: <1243585979-10921-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42372 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756987AbZE2IdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 04:33:06 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8X2HZ002690
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:33:08 -0500
In-Reply-To: <1243585979-10921-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds the offsets for new modules in PRM
and CM for OMAP4

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index cb1ae84..ab0dd8e 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -49,6 +49,28 @@
 #define OMAP3430_NEON_MOD				0xb00
 #define OMAP3430ES2_USBHOST_MOD				0xc00
 
+/* OMAP44XX specific module offsets */
+#define OMAP4430_OCP_SOCKET_MOD				0x0000
+#define OMAP4430_CKGEN_MOD				0x0100
+#define OMAP4430_MPU_MOD				0x0300
+#define OMAP4430_DSP_MOD				0x0400
+#define OMAP4430_ABE_MOD				0x0500
+#define OMAP4430_ALWAYS_ON_MOD				0x0600
+#define OMAP4430_CORE_MOD				0x0700
+#define OMAP4430_IVAHD_MOD				0x0F00
+#define OMAP4430_CAM_MOD				0x1000
+#define OMAP4430_DSS_MOD				0x1100
+#define OMAP4430_GFX_MOD				0x1200
+#define OMAP4430_L3INIT_MOD				0x1300
+#define OMAP4430_L4PER_MOD				0x1400
+#define OMAP4430_CEFUSE_MOD				0x1600
+#define OMAP4430_WKUP_MOD				0x1700
+#define OMAP4430_WKUP_CM_MOD				0x1800
+#define OMAP4430_EMU_MOD				0x1900
+#define OMAP4430_EMU_CM_MOD				0x1A00
+#define OMAP4430_DEVICE_MOD				0x1B00
+#define OMAP4430_RESTORE_MOD				0x1E00
+#define OMAP4430_INSTR_MOD				0x1F00
 
 /* 24XX register bits shared between CM & PRM registers */
 
-- 
1.5.4.7

