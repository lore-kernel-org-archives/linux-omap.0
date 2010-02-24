From: Thara Gopinath <thara@ti.com>
Subject: [PATCH V2] OMAP: HWMOD: Bug fixes in hwmod structure definitions
Date: Wed, 24 Feb 2010 10:51:26 +0530
Message-ID: <1266988886-12548-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab0BXFVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 00:21:32 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1O5LTsj013738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 23:21:31 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch corrects the width of sysc_flags in hwmod sysconfig structure
where the values to be stored to this variable exceed the current
field width.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 921990e..aad5948 100644
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
 
-- 
1.5.4.7

