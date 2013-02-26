From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 04/14] ARM: OMAP2+: Add function for configuring GPMC settings
Date: Tue, 26 Feb 2013 11:30:31 -0600
Message-ID: <1361899842-30303-5-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797Ab3BZRbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 12:31:16 -0500
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

The GPMC has various different configuration options such as bus-width,
synchronous or asychronous mode selection, burst mode options etc.
Currently, there is no common function for configuring these options and
various devices set these options by either programming the GPMC CONFIG1
register directly or by calling gpmc_cs_configure() to set some of the
options.

Add a new function for configuring all of the GPMC options. Having a common
function for configuring this options will simplify code and ease the
migration to device-tree.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   65 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h |    6 ++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 465cac9..fb8dfd2 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1137,6 +1137,71 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 	return 0;
 }
 
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
+		config1	|= GPMC_CONFIG1_MUXADDDATA;
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
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 785e9ce..638f94a 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -73,6 +73,11 @@
 #define GPMC_IRQ_FIFOEVENTENABLE	0x01
 #define GPMC_IRQ_COUNT_EVENT		0x02
 
+#define GPMC_BURST_4			4
+#define GPMC_BURST_8			8
+#define GPMC_BURST_16			16
+#define GPMC_DEVWIDTH_8BIT		1
+#define GPMC_DEVWIDTH_16BIT		2
 
 /* bool type time settings */
 struct gpmc_bool_timings {
@@ -217,6 +222,7 @@ extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern u32 gpmc_cs_read_reg(int cs, int idx);
 extern int gpmc_calc_divider(unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
-- 
1.7.10.4

