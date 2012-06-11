From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all non-omap1 platforms
Date: Mon, 11 Jun 2012 18:52:54 +0530
Message-ID: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45086 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151Ab2FKNXD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 09:23:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

As omap1 and omap2 will never be compiled together, due to
different compiler flags, so we can simply make
cpu_class_is_omap2() = true, for all non-omap1 platforms.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 14f050f..6a42558 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -374,8 +374,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
-#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+#define cpu_class_is_omap2()	!cpu_class_is_omap1()
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
-- 
1.7.0.4

