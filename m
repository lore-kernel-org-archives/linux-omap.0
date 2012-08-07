From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3] ARM: OMAP2+: cpu: Add am33xx device under cpu_class_is_omap2
Date: Tue, 7 Aug 2012 19:44:01 +0530
Message-ID: <1344348841-19868-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2HGOPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 10:15:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>

AM33XX device falls under omap2 class, so make cpu_class_is_omap2()
macro true by adding soc_is_am33xx() to existing list of cpu/soc
check.
This is required to unblock the basic boot support on AM335x platform.

Having done that, we still need to sort out properly from
common zImage point of view without having to maintain this
cpu/soc_is_xxx list.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
This patch is boot tested on BeagleBone
(using already accepted hwmod patches)

Changes from V2:
	- This change is dropped now, since it breaks common zImage support.

Changes from V1:
	- No code change, added detailed description for common zImage
	  support.

 arch/arm/plat-omap/include/plat/cpu.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 68b180e..bb5d08a 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -372,7 +372,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx() || soc_is_omap54xx())
+				cpu_is_omap44xx() || soc_is_omap54xx() || \
+				soc_is_am33xx())

 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
--
1.7.0.4

