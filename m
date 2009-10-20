From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Tue, 20 Oct 2009 17:26:25 -0500
Message-ID: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbZJTW2d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 18:28:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KMScHQ018022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 17:28:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r-woodruff2@ti.com, Vikram Pandita <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>

Add bits for future expansion of omap_chip_id type field.
This is needed to accomodate 3630ES1 chip id which is bit10

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Menon, Nishanth <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7cb0556..922bf1c 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -45,7 +45,7 @@ int omap_type(void);
 
 struct omap_chip_id {
 	u8 oc;
-	u8 type;
+	u32 type;
 };
 
 #define OMAP_CHIP_INIT(x)	{ .oc = x }
-- 
1.6.5.rc1.19.g8426

