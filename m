From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP: HWMOD: Bug fixes in hwmod structure definitions
Date: Thu, 18 Feb 2010 14:32:35 +0530
Message-ID: <1266483755-22878-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab0BRJCm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 04:02:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch corrects the width of some variables in hwmod structures
where the values to be stored in these variables exceed the current
field width.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 921990e..06a7f20 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -258,7 +258,7 @@ struct omap_hwmod_sysconfig {
 	u16 sysc_offs;
 	u16 syss_offs;
 	u8 idlemodes;
-	u8 sysc_flags;
+	u16 sysc_flags;
 	u8 clockact;
 };
 
@@ -280,9 +280,9 @@ struct omap_hwmod_sysconfig {
 struct omap_hwmod_omap2_prcm {
 	s16 module_offs;
 	u8 prcm_reg_id;
-	u8 module_bit;
+	u32 module_bit;
 	u8 idlest_reg_id;
-	u8 idlest_idle_bit;
+	u32 idlest_idle_bit;
 	u8 idlest_stdby_bit;
 };
 
-- 
1.5.4.7

