From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 04/10] ARM: OMAP4430: Create PMU device via HWMOD
Date: Thu, 7 Jun 2012 16:22:06 -0500
Message-ID: <1339104132-26885-5-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab2FGVXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 17:23:02 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Ming Lei <ming.lei@canonical.com>

For OMAP4430 PMU events are routed to the CPU via the cross trigger interface
(CTI) because there are no dedicated interrupts. In order to route the PMU
events via the CTI IRQs, the following modules must be enabled:

        l3_instr, l3_main_3, debugss

Therefore, build the arm-pmu device via these three HWMODs.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |   46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 329e00c..b3b9306 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -48,10 +48,56 @@ static int __init omap2_init_pmu(void)
 	return 0;
 }
 
+/*
+ * omap4430_init_pmu - creates and registers PMU platform device
+ *
+ * Uses OMAP HWMOD framework to create and register an ARM PMU device.
+ * Only supports OMAP4430 devices that require PMU interrupts to be
+ * routed to the interrupt controller via the coresight cross trigger
+ * interface (CTI). To route the interrpts via the coresight CTI module,
+ * the OMAP modules L3_MAIN_3, L3_INSTR and DEBUGSS need to be active.
+ */
+static int __init omap4430_init_pmu(void)
+{
+	int id = -1;
+	struct omap_hwmod *oh[3];
+	char *oh_name;
+	char *dev_name = "arm-pmu";
+
+	oh_name = "l3_main_3";
+	oh[0] = omap_hwmod_lookup(oh_name);
+	if (!oh[0]) {
+		pr_err("Could not look up %s hwmod\n", oh_name);
+		return -ENODEV;
+	}
+	oh_name = "l3_instr";
+	oh[1] = omap_hwmod_lookup(oh_name);
+	if (!oh[1]) {
+		pr_err("Could not look up %s hwmod\n", oh_name);
+		return -ENODEV;
+	}
+	oh_name = "debugss";
+	oh[2] = omap_hwmod_lookup(oh_name);
+	if (!oh[2]) {
+		pr_err("Could not look up %s hwmod\n", oh_name);
+		return -ENODEV;
+	}
+
+	omap_pmu_dev = omap_device_build_ss(dev_name, id, oh, 3, NULL,
+				0, NULL, 0, 0);
+	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
+				dev_name);
+
+	return 0;
+}
+
 static int __init omap_init_pmu(void)
 {
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return omap2_init_pmu();
+	if (cpu_is_omap443x())
+		return omap4430_init_pmu();
 
 	return 0;
 }
-- 
1.7.9.5

