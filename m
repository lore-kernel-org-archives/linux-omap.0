From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 2/9] omap4: prcm: Fix the CPUx clockdomain offsets
Date: Fri,  4 Feb 2011 15:28:57 +0530
Message-ID: <1296813544-25170-3-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab1BDJ7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:19 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
domain control register

Fix the same.

The autogen scripts is fixed thanks to Benoit Cousson

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 729a644..3300ff6 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -38,8 +38,8 @@
 #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
 
 /* PRCM_MPU clockdomain register offsets (from instance start) */
-#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0000
-#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0000
+#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
 
 
 /*
-- 
1.6.0.4

