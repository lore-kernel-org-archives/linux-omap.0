From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 2/2] ARM: OMAP2+: Add device-tree support for 32kHz counter
Date: Thu, 25 Oct 2012 14:24:15 -0500
Message-ID: <1351193055-12488-3-git-send-email-jon-hunter@ti.com>
References: <1351193055-12488-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60307 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935110Ab2JYTYj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 15:24:39 -0400
In-Reply-To: <1351193055-12488-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

For OMAP devices, the 32kHz counter is the default clock-source for the kernel.
However, this is not the only possible clock-source the kernel can use for OMAP
devices.

When booting with device-tree, if the 32kHz counter is the desired clock-source
for the kernel, then parse the device-tree blob to ensure that the counter is
present and if so map memory for the counter using the device-tree of_iomap()
function so we are no longer reliant on the OMAP HWMOD framework to do this for
us.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 92447cd..0758bae 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -159,6 +159,11 @@ static struct of_device_id omap_timer_match[] __initdata = {
 	{ }
 };
 
+static struct of_device_id omap_counter_match[] __initdata = {
+	{ .compatible = "ti,omap-counter32k", },
+	{ }
+};
+
 /**
  * omap_get_timer_dt - get a timer using device-tree
  * @match	- device-tree match structure for matching a device type
@@ -377,11 +382,26 @@ static u32 notrace dmtimer_read_sched_clock(void)
 static int __init omap2_sync32k_clocksource_init(void)
 {
 	int ret;
+	struct device_node *np = NULL;
 	struct omap_hwmod *oh;
 	void __iomem *vbase;
 	const char *oh_name = "counter_32k";
 
 	/*
+	 * If device-tree is present, then search the DT blob
+	 * to see if the 32kHz counter is supported.
+	 */
+	if (of_have_populated_dt()) {
+		np = omap_get_timer_dt(omap_counter_match, NULL);
+		if (!np)
+			return -ENODEV;
+
+		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+		if (!oh_name)
+			return -ENODEV;
+	}
+
+	/*
 	 * First check hwmod data is available for sync32k counter
 	 */
 	oh = omap_hwmod_lookup(oh_name);
@@ -390,7 +410,13 @@ static int __init omap2_sync32k_clocksource_init(void)
 
 	omap_hwmod_setup_one(oh_name);
 
-	vbase = omap_hwmod_get_mpu_rt_va(oh);
+	if (np) {
+		vbase = of_iomap(np, 0);
+		of_node_put(np);
+	} else {
+		vbase = omap_hwmod_get_mpu_rt_va(oh);
+	}
+
 	if (!vbase) {
 		pr_warn("%s: failed to get counter_32k resource\n", __func__);
 		return -ENXIO;
-- 
1.7.9.5

