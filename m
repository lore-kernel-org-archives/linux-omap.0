From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/8] ARM: OMAP: hwmod: extract module address space from DT blob
Date: Wed, 20 Feb 2013 21:08:54 +0530
Message-ID: <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935847Ab3BTPhr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:37:47 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Patch adds the code for extracting the module ocp address space from device
tree blob in case the hwmod address space look up fails.

The idea is to remove the address space data from hwmod and extract it from
DT blob.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..5aad348 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,6 +138,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/of.h>
 
 #include "clock.h"
 #include "omap_hwmod.h"
@@ -2336,6 +2337,11 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start;
+	struct device_node *np;
+	const void *reg_prop;
+	const char *p;
+	unsigned long start = 0, size = 0;
+
 
 	if (!oh)
 		return;
@@ -2349,10 +2355,33 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 	if (!mem) {
 		pr_debug("omap_hwmod: %s: no MPU register target found\n",
 			 oh->name);
+
+		/* Extract the IO space from device tree blob */
+		if (!of_have_populated_dt())
+			return;
+
+		for_each_child_of_node(of_find_node_by_name(NULL, "ocp"), np) {
+			if (of_find_property(np, "ti,hwmods", NULL)) {
+				p = of_get_property(np, "ti,hwmods", NULL);
+				if (!strcmp(p, oh->name)) {
+					reg_prop = of_get_property(np, "reg",
+									NULL);
+					start = of_read_number(reg_prop, 1);
+					size = of_read_number(reg_prop + 4, 1);
+				}
+			}
+		}
+	} else {
+		start = mem->pa_start;
+		size = mem->pa_end - mem->pa_start;
+	}
+
+	if (!start) {
+		pr_debug("omap_hwmod: %s: No address space found\n", oh->name);
 		return;
 	}
 
-	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	va_start = ioremap(start, size);
 	if (!va_start) {
 		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
 		return;
-- 
1.7.9.5

