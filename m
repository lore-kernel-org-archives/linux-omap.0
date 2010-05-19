From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/22] OMAP4: PRCM: Remove duplicate definition of base
	addresses
Date: Tue, 18 May 2010 20:18:53 -0600
Message-ID: <20100519021852.19716.18779.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39809 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab0ESCVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:01 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

CM1, CM2, PRM, SCRM and MPU_PRCM are already defined in omap44xx.h

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index ad1df56..995b7ed 100644
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
 


