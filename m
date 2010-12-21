From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 01/10] OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space struct
Date: Tue, 21 Dec 2010 13:10:21 +0530
Message-ID: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57427 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab0LUHl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:41:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

Adds a structure member 'name' to 'omap_hwmod_addr_space' structure
so that drivers can use platform_get_resource_byname() to get resource of
type 'IORESOURCE_MEM' by name.

Discussions related to this change can be found in the following url:
https://patchwork.kernel.org/patch/233211/

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e016cd9..d8caa86 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1865,6 +1865,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		os = oh->slaves[i];
 
 		for (j = 0; j < os->addr_cnt; j++) {
+			(res + r)->name = (os->addr + j)->name;
 			(res + r)->start = (os->addr + j)->pa_start;
 			(res + r)->end = (os->addr + j)->pa_end;
 			(res + r)->flags = IORESOURCE_MEM;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1871b5a..0b8a854 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -163,7 +163,8 @@ struct omap_hwmod_omap2_firewall {
 #define ADDR_TYPE_RT		(1 << 1)
 
 /**
- * struct omap_hwmod_addr_space - MPU address space handled by the hwmod
+ * struct omap_hwmod_addr_space - address space handled by the hwmod
+ * @name: name of the address space
  * @pa_start: starting physical address
  * @pa_end: ending physical address
  * @flags: (see omap_hwmod_addr_space.flags macros above)
@@ -172,6 +173,7 @@ struct omap_hwmod_omap2_firewall {
  * structure.  GPMC is one example.
  */
 struct omap_hwmod_addr_space {
+	const char *name;
 	u32 pa_start;
 	u32 pa_end;
 	u8 flags;
-- 
1.7.0.4

