From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 4/13] dmtimer: hwmod: OMAP: api to read omap_hwmod _clk
Date: Sat, 14 Aug 2010 21:08:03 +0530
Message-ID: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45269 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932728Ab0HNEiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:38:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch adds the omap_hwmod_get_clk() to access the _clk
field needed while setting clock sources of the timers.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   21 +++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod.c
 mode change 100644 => 100755 arch/arm/plat-omap/include/plat/omap_hwmod.h

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7f3c023..7188f0c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1759,6 +1759,27 @@ void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_get_clk - returns pointer to this module's struct clk
+ * @oh: struct omap_hwmod *
+ *
+ * Return the struct clk pointer associated with the OMAP module
+ * Returns NULL on error, or a struct clk * on success.
+ */
+struct clk *omap_hwmod_get_clk(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return NULL;
+
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return NULL;
+
+	if (oh->_state == _HWMOD_STATE_UNKNOWN)
+		return NULL;
+
+	return oh->_clk;
+}
+
+/**
  * omap_hwmod_add_initiator_dep - add sleepdep from @init_oh to @oh
  * @oh: struct omap_hwmod *
  * @init_oh: struct omap_hwmod * (initiator)
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6adbb63..a2b85a5
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -538,6 +538,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
 
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
 void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
+struct clk *omap_hwmod_get_clk(struct omap_hwmod *oh);
 
 int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
 				 struct omap_hwmod *init_oh);
-- 
1.6.0.4

