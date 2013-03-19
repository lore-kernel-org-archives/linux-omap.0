From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 10/11] ARM: OMAP2+: hwmod: extract module address space from DT blob
Date: Tue, 19 Mar 2013 19:00:56 +0530
Message-ID: <1363699857-5505-11-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681Ab3CSN3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:43 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

Patch adds the code for extracting the module ocp address space from device
tree blob in case the hwmod address space look up fails.

The idea is to remove the address space data from hwmod and extract it from
DT blob.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   45 +++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c2c798c..4501038 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,6 +138,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/system_misc.h>
 
@@ -2350,6 +2352,34 @@ static int _shutdown(struct omap_hwmod *oh)
 }
 
 /**
+ * of_dev_hwmod_lookup - look up needed hwmod from dt blob
+ * @np: struct device_node *
+ * @oh: struct omap_hwmod *
+ *
+ * Parse the dt blob and find out needed hwmod. Recursive function is
+ * implemented to take care hierarchical dt blob parsing.
+ * Return: The device node on success or NULL on failure.
+ */
+static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
+						struct omap_hwmod *oh)
+{
+	struct device_node *np0 = NULL, *np1 = NULL;
+	const char *p;
+
+	for_each_child_of_node(np, np0) {
+		if (of_find_property(np0, "ti,hwmods", NULL)) {
+			p = of_get_property(np0, "ti,hwmods", NULL);
+			if (!strcmp(p, oh->name))
+				return np0;
+			np1 = of_dev_hwmod_lookup(np0, oh);
+			if (np1)
+				return np1;
+		}
+	}
+	return NULL;
+}
+
+/**
  * _init_mpu_rt_base - populate the virtual address for a hwmod
  * @oh: struct omap_hwmod * to locate the virtual address
  *
@@ -2361,7 +2391,8 @@ static int _shutdown(struct omap_hwmod *oh)
 static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 {
 	struct omap_hwmod_addr_space *mem;
-	void __iomem *va_start;
+	void __iomem *va_start = NULL;
+	struct device_node *np;
 
 	if (!oh)
 		return;
@@ -2375,10 +2406,18 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 	if (!mem) {
 		pr_debug("omap_hwmod: %s: no MPU register target found\n",
 			 oh->name);
-		return;
+
+		/* Extract the IO space from device tree blob */
+		if (!of_have_populated_dt())
+			return;
+
+		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
+		if (np)
+			va_start = of_iomap(np, 0);
+	} else {
+		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
 
-	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	if (!va_start) {
 		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
 		return;
-- 
1.7.9.5

