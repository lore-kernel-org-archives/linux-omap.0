From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Prepare for device-tree PMU support
Date: Fri, 14 Dec 2012 15:18:49 -0600
Message-ID: <1355519930-3851-2-git-send-email-jon-hunter@ti.com>
References: <1355519930-3851-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50792 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab2LNVTE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 16:19:04 -0500
In-Reply-To: <1355519930-3851-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

If device-tree is present, then do not create the PMU device from within
the OMAP specific PMU code. This is required to allow device-tree to
create the PMU device from the PMU device-tree node.

PMU is not currently supported for OMAP4430 (due to a dependency on
having a cross-trigger interface driver) and so ensure that this
indicated on boot with or without device-tree.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index eb78ae7..6e620eb 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -64,6 +64,15 @@ static int __init omap_init_pmu(void)
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
@@ -76,9 +85,6 @@ static int __init omap_init_pmu(void)
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

