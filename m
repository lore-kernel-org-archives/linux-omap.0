From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/9] ARM: OMAP2+: Prepare for device-tree PMU support
Date: Fri, 8 Mar 2013 11:27:25 -0600
Message-ID: <1362763654-9660-2-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49621 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759468Ab3CHR1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:27:51 -0500
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

If device-tree is present, then do not create the PMU device from within
the OMAP specific PMU code. This is required to allow device-tree to
create the PMU device from the PMU device-tree node.

PMU is not currently supported for OMAP4430 (due to a dependency on
having a cross-trigger interface driver) and so ensure that this
indicated on boot with or without device-tree.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pmu.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 9debf82..9ace8ea 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -11,6 +11,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/of.h>
+
 #include <asm/pmu.h>
 
 #include "soc.h"
@@ -63,6 +65,15 @@ static int __init omap_init_pmu(void)
 	unsigned oh_num;
 	char **oh_names;
 
+	/* XXX Remove this check when the CTI driver is available */
+	if (cpu_is_omap443x()) {
+		pr_info("ARM PMU: not yet supported on OMAP4430 due to missing CTI driver\n");
+		return 0;
+	}
+
+	if (of_have_populated_dt())
+		return 0;
+
 	/*
 	 * To create an ARM-PMU device the following HWMODs
 	 * are required for the various OMAP2+ devices.
@@ -75,9 +86,6 @@ static int __init omap_init_pmu(void)
 	if (cpu_is_omap443x()) {
 		oh_num = ARRAY_SIZE(omap4430_pmu_oh_names);
 		oh_names = omap4430_pmu_oh_names;
-		/* XXX Remove the next two lines when CTI driver available */
-		pr_info("ARM PMU: not yet supported on OMAP4430 due to missing CTI driver\n");
-		return 0;
 	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
 		oh_names = omap3_pmu_oh_names;
-- 
1.7.10.4

