From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 02/18] ARM: OMAP2+: Add variable to store number of GPMC waitpins
Date: Tue, 19 Mar 2013 11:35:40 -0500
Message-ID: <1363710956-26773-3-git-send-email-jon-hunter@ti.com>
References: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab3CSQgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 12:36:19 -0400
In-Reply-To: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

The GPMC has wait-pin signals that can be assigned to a chip-select
to monitor the ready signal of an external device. Add a variable to
indicate the total number of wait-pins for a given device. This will
allow us to detect if the wait-pin being selected is valid or not.

When booting with device-tree read the number of wait-pins from the
device-tree blob. When device-tree is not used set the number of
wait-pins to 4 which is valid for OMAP2-5 devices. Newer devices
that have less wait-pins (such as AM335x) only support booting with
device-tree and so hard-coding the wait-pin number when not using
device-tree is fine.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 586dba7..8833c34 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -108,6 +108,8 @@
 #define	GPMC_HAS_WR_ACCESS		0x1
 #define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
 
+#define GPMC_NR_WAITPINS		4
+
 /* XXX: Only NAND irq has been considered,currently these are the only ones used
  */
 #define	GPMC_NR_IRQ		2
@@ -153,6 +155,7 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 /* Define chip-selects as reserved by default until probe completes */
 static unsigned int gpmc_cs_map = ((1 << GPMC_CS_NUM) - 1);
+static unsigned int gpmc_nr_waitpins;
 static struct device *gpmc_dev;
 static int gpmc_irq;
 static resource_size_t phys_base, mem_size;
@@ -1294,6 +1297,13 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 	if (!of_id)
 		return 0;
 
+	ret = of_property_read_u32(pdev->dev.of_node, "gpmc,num-waitpins",
+				   &gpmc_nr_waitpins);
+	if (ret < 0) {
+		pr_err("%s: number of wait pins not found!\n", __func__);
+		return ret;
+	}
+
 	for_each_node_by_name(child, "nand") {
 		ret = gpmc_probe_nand_child(pdev, child);
 		if (ret < 0) {
@@ -1372,6 +1382,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	/* Now the GPMC is initialised, unreserve the chip-selects */
 	gpmc_cs_map = 0;
 
+	if (!pdev->dev.of_node)
+		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
+
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
 		clk_disable_unprepare(gpmc_l3_clk);
-- 
1.7.10.4

