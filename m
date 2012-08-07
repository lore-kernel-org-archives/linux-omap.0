From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: AM33XX: board-generic: Add of_dev_auxdata to fix dev_id for CAN module
Date: Tue, 7 Aug 2012 19:07:16 +0530
Message-ID: <1344346636-28072-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54569 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2HGOQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 10:16:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

If the module requires only one clocksource to function, then
driver can very well call clk_get() api with "con_id = NULL",

       clk = clk_get(dev, NULL);

And platform code should respect this and return valid clk handle.
That means, now the clk_get() api would rely on dev_id, and platform
code should either have clk node with matching dev_id (with con_id=NULL)
or return dummy clk node.

With DT support, we can fix the dev_id for particular module
using "struct of_dev_auxdata" to satisfy above clk framework requirement.

In case of AM33XX, we required this for the DCAN module, so this
patch adds "of_dev_auxdata" for both DCAN_0/1 instances.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
This patch is boot tested on BeagleBone platform, and checked for
clk_get() return value in d_can module driver.

 arch/arm/mach-omap2/board-generic.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 6f93a20..c9b7903 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,11 +37,27 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };

+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate(). Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name OR to satisfy NULL con_id requirement from driver.
+ */
+static const struct of_dev_auxdata am33xx_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, "d_can.0", NULL),
+	OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, "d_can.1", NULL),
+	{ },
+};
+
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);

-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	if (of_machine_is_compatible("ti,am33xx"))
+		of_platform_populate(NULL, omap_dt_match_table,
+				am33xx_auxdata_lookup, NULL);
+	else
+		of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }

 #ifdef CONFIG_SOC_OMAP2420
--
1.7.0.4

