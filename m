From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 04/17] ARM: OMAP2+: Add function for configuring GPMC settings
Date: Fri, 8 Mar 2013 10:58:25 -0600
Message-ID: <1362761918-8696-5-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934352Ab3CHQ7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 11:59:19 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

The GPMC has various different configuration options such as bus-width,
synchronous or asychronous mode selection, burst mode options etc.
Currently, there is no common function for configuring these options and
various devices set these options by either programming the GPMC CONFIG1
register directly or by calling gpmc_cs_configure() to set some of the
options.

Add a new function for configuring all of the GPMC options. Having a common
function for configuring this options will simplify code and ease the
migration to device-tree.

Also add a new capability flag to detect devices that support the
address-address-data multiplexing mode.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |  100 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h |    6 +++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 38c7f50..1b81ca1 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -107,6 +107,7 @@
 
 #define	GPMC_HAS_WR_ACCESS		0x1
 #define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
+#define	GPMC_HAS_MUX_AAD		0x4
 
 #define GPMC_NR_WAITPINS		4
 
@@ -1129,6 +1130,90 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 	return 0;
 }
 
+/**
+ * gpmc_cs_program_settings - programs non-timing related settings
+ * @cs:		GPMC chip-select to program
+ * @p:		pointer to GPMC settings structure
+ *
+ * Programs non-timing related settings for a GPMC chip-select, such as
+ * bus-width, burst configuration, etc. Function should be called once
+ * for each chip-select that is being used and must be called before
+ * calling gpmc_cs_set_timings() as timing parameters in the CONFIG1
+ * register will be initialised to zero by this function. Returns 0 on
+ * success and appropriate negative error code on failure.
+ */
+int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
+{
+	u32 config1;
+
+	if ((!p->device_width) || (p->device_width > GPMC_DEVWIDTH_16BIT)) {
+		pr_err("%s: invalid width %d!", __func__, p->device_width);
+		return -EINVAL;
+	}
+
+	/* Address-data multiplexing not supported for NAND devices */
+	if (p->device_nand && p->mux_add_data) {
+		pr_err("%s: invalid configuration!\n", __func__);
+		return -EINVAL;
+	}
+
+	if ((p->mux_add_data > GPMC_MUX_AD) ||
+	    ((p->mux_add_data == GPMC_MUX_AAD) &&
+	     !(gpmc_capability & GPMC_HAS_MUX_AAD))) {
+		pr_err("%s: invalid multiplex configuration!\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Page/burst mode supports lengths of 4, 8 and 16 bytes */
+	if (p->burst_read || p->burst_write) {
+		switch (p->burst_len) {
+		case GPMC_BURST_4:
+		case GPMC_BURST_8:
+		case GPMC_BURST_16:
+			break;
+		default:
+			pr_err("%s: invalid page/burst-length (%d)\n",
+			       __func__, p->burst_len);
+			return -EINVAL;
+		}
+	}
+
+	if ((p->wait_on_read || p->wait_on_write) &&
+	    (p->wait_pin > gpmc_nr_waitpins)) {
+		pr_err("%s: invalid wait-pin (%d)\n", __func__, p->wait_pin);
+		return -EINVAL;
+	}
+
+	config1 = GPMC_CONFIG1_DEVICESIZE((p->device_width - 1));
+
+	if (p->sync_read)
+		config1 |= GPMC_CONFIG1_READTYPE_SYNC;
+	if (p->sync_write)
+		config1 |= GPMC_CONFIG1_WRITETYPE_SYNC;
+	if (p->wait_on_read)
+		config1 |= GPMC_CONFIG1_WAIT_READ_MON;
+	if (p->wait_on_write)
+		config1 |= GPMC_CONFIG1_WAIT_WRITE_MON;
+	if (p->wait_on_read || p->wait_on_write)
+		config1 |= GPMC_CONFIG1_WAIT_PIN_SEL(p->wait_pin);
+	if (p->device_nand)
+		config1	|= GPMC_CONFIG1_DEVICETYPE(GPMC_DEVICETYPE_NAND);
+	if (p->mux_add_data)
+		config1	|= GPMC_CONFIG1_MUXTYPE(p->mux_add_data);
+	if (p->burst_read)
+		config1 |= GPMC_CONFIG1_READMULTIPLE_SUPP;
+	if (p->burst_write)
+		config1 |= GPMC_CONFIG1_WRITEMULTIPLE_SUPP;
+	if (p->burst_read || p->burst_write) {
+		config1 |= GPMC_CONFIG1_PAGE_LEN(p->burst_len >> 3);
+		config1 |= p->burst_wrap ? GPMC_CONFIG1_WRAPBURST_SUPP : 0;
+	}
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, config1);
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static struct of_device_id gpmc_dt_ids[] = {
 	{ .compatible = "ti,omap2420-gpmc" },
@@ -1375,8 +1460,23 @@ static int gpmc_probe(struct platform_device *pdev)
 	gpmc_dev = &pdev->dev;
 
 	l = gpmc_read_reg(GPMC_REVISION);
+
+	/*
+	 * FIXME: Once device-tree migration is complete the below flags
+	 * should be populated based upon the device-tree compatible
+	 * string. For now just use the IP revision. OMAP3+ devices have
+	 * the wr_access and wr_data_mux_bus register fields. OMAP4+
+	 * devices support the addr-addr-data multiplex protocol.
+	 *
+	 * GPMC IP revisions:
+	 * - OMAP24xx			= 2.0
+	 * - OMAP3xxx			= 5.0
+	 * - OMAP44xx/54xx/AM335x	= 6.0
+	 */
 	if (GPMC_REVISION_MAJOR(l) > 0x4)
 		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;
+	if (GPMC_REVISION_MAJOR(l) > 0x5)
+		gpmc_capability |= GPMC_HAS_MUX_AAD;
 	dev_info(gpmc_dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
 		 GPMC_REVISION_MINOR(l));
 
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 39e4e04..ce6ae21 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -76,6 +76,11 @@
 #define GPMC_IRQ_FIFOEVENTENABLE	0x01
 #define GPMC_IRQ_COUNT_EVENT		0x02
 
+#define GPMC_BURST_4			4	/* 4 word burst */
+#define GPMC_BURST_8			8	/* 8 word burst */
+#define GPMC_BURST_16			16	/* 16 word burst */
+#define GPMC_DEVWIDTH_8BIT		1	/* 8-bit device width */
+#define GPMC_DEVWIDTH_16BIT		2	/* 16-bit device width */
 #define GPMC_MUX_AAD			1	/* Addr-Addr-Data multiplex */
 #define GPMC_MUX_AD			2	/* Addr-Data multiplex */
 
@@ -217,6 +222,7 @@ extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern int gpmc_calc_divider(unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern void omap3_gpmc_save_context(void);
-- 
1.7.10.4

