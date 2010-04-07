From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/6] omap4: Fix McBSP4 base address
Date: Wed,  7 Apr 2010 13:17:23 +0530
Message-ID: <1270626446-10841-4-git-send-email-santosh.shilimkar@ti.com>
References: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40103 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0DGHrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 03:47:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o377lTj1022656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 02:47:31 -0500
In-Reply-To: <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>

This patch fixes the McBSP4 base address for OMAP4

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 3974835..7de903d 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -59,7 +59,7 @@
 #define OMAP44XX_MCBSP1_BASE	0x49022000
 #define OMAP44XX_MCBSP2_BASE	0x49024000
 #define OMAP44XX_MCBSP3_BASE	0x49026000
-#define OMAP44XX_MCBSP4_BASE	0x48074000
+#define OMAP44XX_MCBSP4_BASE	0x48096000
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 
-- 
1.6.0.4

