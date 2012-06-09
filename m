From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: cpu: Add am33xx device under cpu_class_is_omap2
Date: Sat, 9 Jun 2012 20:26:13 +0530
Message-ID: <1339253773-24088-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40603 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2FIO4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Jun 2012 10:56:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Newly added AM33XX device falls under omap2 class, so
make cpu_class_is_omap2() true for AM33XX
(Add soc_is_am33xx() check).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 14f050f..5e36564 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -375,7 +375,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+				cpu_is_omap44xx() || soc_is_am33xx())
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
-- 
1.7.0.4

