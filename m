From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 7/9] omap3: pm: remove VDDx_MIN/MAX macros
Date: Wed, 11 Nov 2009 23:45:19 -0600
Message-ID: <1258004721-7315-8-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
 <1258004721-7315-2-git-send-email-nm@ti.com>
 <1258004721-7315-3-git-send-email-nm@ti.com>
 <1258004721-7315-4-git-send-email-nm@ti.com>
 <1258004721-7315-5-git-send-email-nm@ti.com>
 <1258004721-7315-6-git-send-email-nm@ti.com>
 <1258004721-7315-7-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46676 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347AbZKLFpr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 00:45:47 -0500
In-Reply-To: <1258004721-7315-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Since accessor functions are used through out, we dont depend
on the predefined macros to know the limits of the opp table.
Hence, remove these.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 868e238..cc7cfae 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -104,10 +104,5 @@
 #define VDD2_OPP2	0x2
 #define VDD2_OPP3	0x3
 
-#define MIN_VDD1_OPP	VDD1_OPP1
-#define MAX_VDD1_OPP	VDD1_OPP5
-#define MIN_VDD2_OPP	VDD2_OPP1
-#define MAX_VDD2_OPP	VDD2_OPP3
-
 #endif /* __ASM_ARCH_OMAP34XX_H */
 
-- 
1.6.3.3

