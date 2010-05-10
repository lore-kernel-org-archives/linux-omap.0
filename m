From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/5] OMAP4: PRCM: Remove duplicate definition of base addresses
Date: Mon, 10 May 2010 22:31:56 +0200
Message-ID: <1273523518-17758-4-git-send-email-b-cousson@ti.com>
References: <1273523518-17758-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52849 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab0EJUcJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 May 2010 16:32:09 -0400
In-Reply-To: <1273523518-17758-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

CM1, CM2, PRM, SCRM and MPU_PRCM are already defined in omap44xx.h

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index a131aa7..64d1027 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -119,14 +119,6 @@
 #define OMAP4430_PRCM_MPU_CPU0_MOD		0x0400
 #define OMAP4430_PRCM_MPU_CPU1_MOD		0x0800
 
-/* Base Addresses for the OMAP4 */
-
-#define OMAP4430_CM1_BASE		0x4a004000
-#define OMAP4430_CM2_BASE		0x4a008000
-#define OMAP4430_PRM_BASE		0x4a306000
-#define OMAP4430_SCRM_BASE		0x4a30a000
-#define OMAP4430_CHIRONSS_BASE		0x48243000
-
 
 /* 24XX register bits shared between CM & PRM registers */
 
-- 
1.6.1.3

