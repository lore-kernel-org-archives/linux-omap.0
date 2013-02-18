From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix broken gpmc support
Date: Mon, 18 Feb 2013 07:57:39 -0600
Message-ID: <1361195859-5949-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872Ab3BRN56 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 08:57:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Philip Avinash <avinashphilip@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Jon Hunter <jon-hunter@ti.com>

Commit "ARM: OMAP2+: Prevent potential crash if GPMC probe fails" added
code to ensure that GPMC chip-selects could not be requested until the
device probe was successful. The chip-selects should have been
unreserved at the end of the probe function, but the code to unreserve
them appears to have ended up in the gpmc_calc_timings() function and
hence, this is causing problems requesting chip-selects. Fix this merge
error by unreserving the chip-selects at the end of the probe, but
before we call the gpmc child probe functions (for device-tree) which
request a chip-select.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Philip Avinash <avinashphilip@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
---

Tony, GPMC support is completely broken in linux-next without this fix
and a few people now are reporting this problem. Can we get this fix
merged?

Thanks
Jon

 arch/arm/mach-omap2/gpmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1adb2d4..1e8bcb4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1125,9 +1125,6 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 	/* TODO: remove, see function definition */
 	gpmc_convert_ps_to_ns(gpmc_t);
 
-	/* Now the GPMC is initialised, unreserve the chip-selects */
-	gpmc_cs_map = 0;
-
 	return 0;
 }
 
@@ -1388,6 +1385,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
+	/* Now the GPMC is initialised, unreserve the chip-selects */
+	gpmc_cs_map = 0;
+
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
 		clk_disable_unprepare(gpmc_l3_clk);
-- 
1.7.10.4

