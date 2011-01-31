From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space struct
Date: Mon, 31 Jan 2011 20:20:25 +0530
Message-ID: <1296485437-12806-2-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48382 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab1AaOzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 09:55:18 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
The drivers can use platform_get_resource_byname() to get resource of
type 'IORESOURCE_MEM' by name so that it need not rely on the order to get
the proper resource.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 709543a..7bd4900 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1898,6 +1898,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		os = oh->slaves[i];
 
 		for (j = 0; j < os->addr_cnt; j++) {
+			(res + r)->name = (os->addr + j)->name;
 			(res + r)->start = (os->addr + j)->pa_start;
 			(res + r)->end = (os->addr + j)->pa_end;
 			(res + r)->flags = IORESOURCE_MEM;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 76f0274..85899a7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -178,7 +178,8 @@ struct omap_hwmod_omap2_firewall {
 #define ADDR_TYPE_RT		(1 << 1)
 
 /**
- * struct omap_hwmod_addr_space - MPU address space handled by the hwmod
+ * struct omap_hwmod_addr_space - address space handled by the hwmod
+ * @name: name of the address space
  * @pa_start: starting physical address
  * @pa_end: ending physical address
  * @flags: (see omap_hwmod_addr_space.flags macros above)
@@ -187,6 +188,7 @@ struct omap_hwmod_omap2_firewall {
  * structure.  GPMC is one example.
  */
 struct omap_hwmod_addr_space {
+	const char *name;
 	u32 pa_start;
 	u32 pa_end;
 	u8 flags;
-- 
1.7.0.4

