From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 01/13] OMAP: hwmod: allow hwmod to provide address space accessible from SDMA
Date: Thu, 24 Feb 2011 15:16:45 +0530
Message-ID: <1298540817-15874-2-git-send-email-kishon@ti.com>
References: <1298540817-15874-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38840 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357Ab1BXJwY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 04:52:24 -0500
In-Reply-To: <1298540817-15874-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Adds support for resource API to get address space info other than just MPU.
The drivers can now use platform_get_resource_byname() to get resource of
type 'IORESOURCE_MEM' by name.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d6b8d2e..d72ae5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1919,6 +1919,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		os = oh->slaves[i];
 
 		for (j = 0; j < os->addr_cnt; j++) {
+			(res + r)->name = (os->addr + j)->name;
 			(res + r)->start = (os->addr + j)->pa_start;
 			(res + r)->end = (os->addr + j)->pa_end;
 			(res + r)->flags = IORESOURCE_MEM;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index e50a19a..2b54852 100644
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

