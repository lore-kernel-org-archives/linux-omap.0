From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] ARM: OMAP2+: Fix support for multiple devices on a GPMC chip select
Date: Wed, 29 Oct 2014 17:29:03 -0700
Message-ID: <1414628948-30702-6-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52244 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757285AbaJ3Aae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:34 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

There are cases where we have multiple device instances
connected to a single GPMC chip select. For example, there
are four UARTs on the Zoom debug boards that all share a
single chip select and a GPIO interrupt.

We do have support for this already in theory, but it's broken
because we're bailing out if the chip select is already taken.

To be able to provide checks on the chip select usage, let's
add new struct gpmc_cs_data so we can start using already
registered device names for checks.

Later on we probably want to start using struct gpmc_cs_data
as a wrapper for all the GPMC chipselect related data.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c | 61 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5fa3755..2c5f348 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -118,6 +118,15 @@
  */
 #define	GPMC_NR_IRQ		2
 
+struct gpmc_cs_data {
+	const char *name;
+
+#define GPMC_CS_RESERVED	(1 << 0)
+	u32 flags;
+
+	struct resource mem;
+};
+
 struct gpmc_client_irq	{
 	unsigned		irq;
 	u32			bitmask;
@@ -155,10 +164,9 @@ static struct irq_chip gpmc_irq_chip;
 static int gpmc_irq_start;
 
 static struct resource	gpmc_mem_root;
-static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
+static struct gpmc_cs_data gpmc_cs[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 /* Define chip-selects as reserved by default until probe completes */
-static unsigned int gpmc_cs_map = ((1 << GPMC_CS_NUM) - 1);
 static unsigned int gpmc_cs_num = GPMC_CS_NUM;
 static unsigned int gpmc_nr_waitpins;
 static struct device *gpmc_dev;
@@ -460,13 +468,30 @@ static int gpmc_cs_mem_enabled(int cs)
 
 static void gpmc_cs_set_reserved(int cs, int reserved)
 {
-	gpmc_cs_map &= ~(1 << cs);
-	gpmc_cs_map |= (reserved ? 1 : 0) << cs;
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+
+	gpmc->flags |= GPMC_CS_RESERVED;
 }
 
 static bool gpmc_cs_reserved(int cs)
 {
-	return gpmc_cs_map & (1 << cs);
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+
+	return gpmc->flags & GPMC_CS_RESERVED;
+}
+
+static void gpmc_cs_set_name(int cs, const char *name)
+{
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+
+	gpmc->name = name;
+}
+
+const char *gpmc_cs_get_name(int cs)
+{
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+
+	return gpmc->name;
 }
 
 static unsigned long gpmc_mem_align(unsigned long size)
@@ -485,7 +510,8 @@ static unsigned long gpmc_mem_align(unsigned long size)
 
 static int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
 {
-	struct resource	*res = &gpmc_cs_mem[cs];
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+	struct resource *res = &gpmc->mem;
 	int r;
 
 	size = gpmc_mem_align(size);
@@ -500,7 +526,8 @@ static int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
 
 static int gpmc_cs_delete_mem(int cs)
 {
-	struct resource	*res = &gpmc_cs_mem[cs];
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+	struct resource *res = &gpmc->mem;
 	int r;
 
 	spin_lock(&gpmc_mem_lock);
@@ -557,7 +584,8 @@ static int gpmc_cs_remap(int cs, u32 base)
 
 int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 {
-	struct resource *res = &gpmc_cs_mem[cs];
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+	struct resource *res = &gpmc->mem;
 	int r = -1;
 
 	if (cs > gpmc_cs_num) {
@@ -597,7 +625,8 @@ EXPORT_SYMBOL(gpmc_cs_request);
 
 void gpmc_cs_free(int cs)
 {
-	struct resource	*res = &gpmc_cs_mem[cs];
+	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
+	struct resource *res = &gpmc->mem;
 
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
@@ -1511,6 +1540,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	struct gpmc_timings gpmc_t;
 	struct resource res;
 	unsigned long base;
+	const char *name;
 	int ret, cs;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
@@ -1525,11 +1555,21 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
+	/*
+	 * Check if we have multiple instances of the same device
+	 * on a single chip select. If so, use the already initialized
+	 * timings.
+	 */
+	name = gpmc_cs_get_name(cs);
+	if (name && child->name && of_node_cmp(child->name, name) == 0)
+			goto no_timings;
+
 	ret = gpmc_cs_request(cs, resource_size(&res), &base);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
 		return ret;
 	}
+	gpmc_cs_set_name(cs, child->name);
 
 	/*
 	 * For some GPMC devices we still need to rely on the bootloader
@@ -1708,9 +1748,6 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (gpmc_setup_irq() < 0)
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
-	/* Now the GPMC is initialised, unreserve the chip-selects */
-	gpmc_cs_map = 0;
-
 	if (!pdev->dev.of_node) {
 		gpmc_cs_num	 = GPMC_CS_NUM;
 		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
-- 
2.1.1

