From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v2][PATCH 1/5] ARM: OMAP3630: PRCM: Add UART4 control bits
Date: Fri, 26 Feb 2010 09:53:08 -0600
Message-ID: <1267199592-2245-2-git-send-email-saaguirre@ti.com>
References: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39900 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965194Ab0BZPxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 10:53:06 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1QFr3MD032435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 09:53:03 -0600
In-Reply-To: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This bits are exclusive of omap 36xx family of chips.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 90f603d..c4e7bcb 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -390,6 +390,8 @@
 #define OMAP3430_EN_MPU_SHIFT				1
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+#define OMAP3630_EN_UART4				(1 << 18)
+#define OMAP3630_EN_UART4_SHIFT				18
 #define OMAP3430_EN_GPIO6				(1 << 17)
 #define OMAP3430_EN_GPIO6_SHIFT				17
 #define OMAP3430_EN_GPIO5				(1 << 16)
@@ -430,6 +432,8 @@
 #define OMAP3430_EN_MCBSP2_SHIFT			0
 
 /* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3630_ST_UART4_SHIFT				18
+#define OMAP3630_ST_UART4_MASK				(1 << 18)
 #define OMAP3430_ST_GPIO6_SHIFT				17
 #define OMAP3430_ST_GPIO6_MASK				(1 << 17)
 #define OMAP3430_ST_GPIO5_SHIFT				16
-- 
1.6.3.3

