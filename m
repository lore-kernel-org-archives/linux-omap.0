From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: gpmc: get number of useable GPMC chip-selects via DT
Date: Fri, 31 May 2013 17:31:30 +0530
Message-ID: <1370001691-29320-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35570 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756254Ab3EaMBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 08:01:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jgchunter@gmail.com>, "Gupta, Pekon" <pekon@ti.com>

From: "Gupta, Pekon" <pekon@ti.com>

This patch enables usage of DT property 'gpmc,num-cs' as already documented in
Documentation/devicetree/bindings/bus/ti-gpmc.txt

Though GPMC hardware supports upto 8 chip-selects, but all chip-selects may
not be available for use because:
- chip-select pin may not be bonded out at SoC device boundary.
- chip-select pin-mux may conflict with other pins usage.
- board level constrains.

gpmc,num-cs allows user to configure maximum number of GPMC chip-selects
available for use on any given platform. This ensures:
- GPMC child nodes having chip-selects within allowed range are only probed.
- And un-used GPMC chip-selects remain blocked.(may be for security reasons).

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6c4da12..490bca8 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -155,6 +155,7 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 /* Define chip-selects as reserved by default until probe completes */
 static unsigned int gpmc_cs_map = ((1 << GPMC_CS_NUM) - 1);
+static unsigned int gpmc_cs_num = GPMC_CS_NUM;
 static unsigned int gpmc_nr_waitpins;
 static struct device *gpmc_dev;
 static int gpmc_irq;
@@ -521,8 +522,10 @@ static int gpmc_cs_remap(int cs, u32 base)
 	int ret;
 	u32 old_base, size;
 
-	if (cs > GPMC_CS_NUM)
+	if (cs > gpmc_cs_num) {
+		pr_err("%s: requested chip-select is disabled\n", __func__);
 		return -ENODEV;
+	}
 	gpmc_cs_get_memconf(cs, &old_base, &size);
 	if (base == old_base)
 		return 0;
@@ -545,9 +548,10 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	struct resource *res = &gpmc_cs_mem[cs];
 	int r = -1;
 
-	if (cs > GPMC_CS_NUM)
+	if (cs > gpmc_cs_num) {
+		pr_err("%s: requested chip-select is disabled\n", __func__);
 		return -ENODEV;
-
+	}
 	size = gpmc_mem_align(size);
 	if (size > (1 << GPMC_SECTION_SHIFT))
 		return -ENOMEM;
@@ -582,7 +586,7 @@ EXPORT_SYMBOL(gpmc_cs_request);
 void gpmc_cs_free(int cs)
 {
 	spin_lock(&gpmc_mem_lock);
-	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
+	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
 		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
 		spin_unlock(&gpmc_mem_lock);
@@ -777,7 +781,7 @@ static void gpmc_mem_exit(void)
 {
 	int cs;
 
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+	for (cs = 0; cs < gpmc_cs_num; cs++) {
 		if (!gpmc_cs_mem_enabled(cs))
 			continue;
 		gpmc_cs_delete_mem(cs);
@@ -798,7 +802,7 @@ static void gpmc_mem_init(void)
 	gpmc_mem_root.end = GPMC_MEM_END;
 
 	/* Reserve all regions that has been set up by bootloader */
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+	for (cs = 0; cs < gpmc_cs_num; cs++) {
 		u32 base, size;
 
 		if (!gpmc_cs_mem_enabled(cs))
@@ -1513,6 +1517,20 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 	if (!of_id)
 		return 0;
 
+	ret = of_property_read_u32(pdev->dev.of_node, "gpmc,num-cs",
+				   &gpmc_cs_num);
+	if (ret < 0) {
+		pr_err("%s: number of chip-selects not defined\n", __func__);
+		return ret;
+	} else if (gpmc_cs_num < 1) {
+		pr_err("%s: all chip-selects are disabled\n", __func__);
+		return -EINVAL;
+	} else if (gpmc_cs_num > GPMC_CS_NUM) {
+		pr_err("%s: number of supported chip-selects cannot be > %d\n",
+					 __func__, GPMC_CS_NUM);
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(pdev->dev.of_node, "gpmc,num-waitpins",
 				   &gpmc_nr_waitpins);
 	if (ret < 0) {
@@ -1610,8 +1628,10 @@ static int gpmc_probe(struct platform_device *pdev)
 	/* Now the GPMC is initialised, unreserve the chip-selects */
 	gpmc_cs_map = 0;
 
-	if (!pdev->dev.of_node)
+	if (!pdev->dev.of_node) {
+		gpmc_cs_num	 = GPMC_CS_NUM;
 		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
+	}
 
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
@@ -1715,7 +1735,7 @@ void omap3_gpmc_save_context(void)
 	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
 	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
 	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
-	for (i = 0; i < GPMC_CS_NUM; i++) {
+	for (i = 0; i < gpmc_cs_num; i++) {
 		gpmc_context.cs_context[i].is_valid = gpmc_cs_mem_enabled(i);
 		if (gpmc_context.cs_context[i].is_valid) {
 			gpmc_context.cs_context[i].config1 =
@@ -1747,7 +1767,7 @@ void omap3_gpmc_restore_context(void)
 	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_context.prefetch_config1);
 	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_context.prefetch_config2);
 	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_context.prefetch_control);
-	for (i = 0; i < GPMC_CS_NUM; i++) {
+	for (i = 0; i < gpmc_cs_num; i++) {
 		if (gpmc_context.cs_context[i].is_valid) {
 			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
 				gpmc_context.cs_context[i].config1);
-- 
1.8.1

