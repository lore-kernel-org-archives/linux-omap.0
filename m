From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 17/17] ARM: OMAP2+: Allow GPMC probe to complete even if CS mapping fails
Date: Fri, 8 Mar 2013 10:58:38 -0600
Message-ID: <1362761918-8696-18-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60127 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812Ab3CHQ7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 11:59:39 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

When the GPMC driver is probed, we call gpmc_mem_init() to see which
chip-selects have already been configured and enabled by the boot-loader
and allocate space for them. If we fail to allocate space for one
chip-select, then we return failure from the probe and the GPMC driver
will not be available.

Rather than render the GPMC useless for all GPMC devices, if we fail to
allocate space for one chip-select print a warning and disable the
chip-select. This way other GPMC clients can still be used.

There is no downside to this approach, because all GPMC clients need to
request a chip-select before they can use the GPMC and on requesting a
chip-select, if memory has not already been reserved for the chip-select
then it will be.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c79f80e..70b5489 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -785,9 +785,9 @@ static void gpmc_mem_exit(void)
 
 }
 
-static int gpmc_mem_init(void)
+static void gpmc_mem_init(void)
 {
-	int cs, rc;
+	int cs;
 
 	/*
 	 * The first 1MB of GPMC address space is typically mapped to
@@ -804,16 +804,12 @@ static int gpmc_mem_init(void)
 		if (!gpmc_cs_mem_enabled(cs))
 			continue;
 		gpmc_cs_get_memconf(cs, &base, &size);
-		rc = gpmc_cs_insert_mem(cs, base, size);
-		if (IS_ERR_VALUE(rc)) {
-			while (--cs >= 0)
-				if (gpmc_cs_mem_enabled(cs))
-					gpmc_cs_delete_mem(cs);
-			return rc;
+		if (gpmc_cs_insert_mem(cs, base, size)) {
+			pr_warn("%s: disabling cs %d mapped at 0x%x-0x%x\n",
+				__func__, cs, base, base + size);
+			gpmc_cs_disable_mem(cs);
 		}
 	}
-
-	return 0;
 }
 
 static u32 gpmc_round_ps_to_sync_clk(u32 time_ps, u32 sync_clk)
@@ -1618,13 +1614,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	dev_info(gpmc_dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
 		 GPMC_REVISION_MINOR(l));
 
-	rc = gpmc_mem_init();
-	if (IS_ERR_VALUE(rc)) {
-		clk_disable_unprepare(gpmc_l3_clk);
-		clk_put(gpmc_l3_clk);
-		dev_err(gpmc_dev, "failed to reserve memory\n");
-		return rc;
-	}
+	gpmc_mem_init();
 
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
-- 
1.7.10.4

