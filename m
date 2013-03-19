From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 10/18] ARM: OMAP2+: Add function to read GPMC settings from device-tree
Date: Tue, 19 Mar 2013 11:35:48 -0500
Message-ID: <1363710956-26773-11-git-send-email-jon-hunter@ti.com>
References: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60446 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932839Ab3CSQgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 12:36:38 -0400
In-Reply-To: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

Adds a function to read the various GPMC chip-select settings from
device-tree and store them in the gpmc_settings structure.

Update the GPMC device-tree binding documentation to describe these
options.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt |   23 ++++++++++++
 arch/arm/mach-omap2/gpmc.c                        |   40 +++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h                        |    2 ++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index 5ddb2e9..6fde1cf 100644
--- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -65,6 +65,29 @@ The following are only applicable to OMAP3+ and AM335x:
  - gpmc,wr-access
  - gpmc,wr-data-mux-bus
 
+GPMC chip-select settings properties for child nodes. All are optional.
+
+- gpmc,burst-length	Page/burst length. Must be 4, 8 or 16.
+- gpmc,burst-wrap	Enables wrap bursting
+- gpmc,burst-read	Enables read page/burst mode
+- gpmc,burst-write	Enables write page/burst mode
+- gpmc,device-nand	Device is NAND
+- gpmc,device-width	Total width of device(s) connected to a GPMC
+			chip-select in bytes. The GPMC supports 8-bit
+			and 16-bit devices and so this property must be
+			1 or 2.
+- gpmc,mux-add-data	Address and data multiplexing configuration.
+			Valid values are 1 for address-address-data
+			multiplexing mode and 2 for address-data
+			multiplexing mode.
+- gpmc,sync-read	Enables synchronous read. Defaults to asynchronous
+			is this is not set.
+- gpmc,sync-write	Enables synchronous writes. Defaults to asynchronous
+			is this is not set.
+- gpmc,wait-pin		Wait-pin used by client. Must be less than
+			"gpmc,num-waitpins".
+- gpmc,wait-on-read	Enables wait monitoring on reads.
+- gpmc,wait-on-write	Enables wait monitoring on writes.
 
 Example for an AM33xx board:
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b22771b..85231b3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1187,6 +1187,46 @@ static struct of_device_id gpmc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
 
+/**
+ * gpmc_read_settings_dt - read gpmc settings from device-tree
+ * @np:		pointer to device-tree node for a gpmc child device
+ * @p:		pointer to gpmc settings structure
+ *
+ * Reads the GPMC settings for a GPMC child device from device-tree and
+ * stores them in the GPMC settings structure passed. The GPMC settings
+ * structure is initialised to zero by this function and so any
+ * previously stored settings will be cleared.
+ */
+void gpmc_read_settings_dt(struct device_node *np, struct gpmc_settings *p)
+{
+	memset(p, 0, sizeof(struct gpmc_settings));
+
+	p->sync_read = of_property_read_bool(np, "gpmc,sync-read");
+	p->sync_write = of_property_read_bool(np, "gpmc,sync-write");
+	p->device_nand = of_property_read_bool(np, "gpmc,device-nand");
+	of_property_read_u32(np, "gpmc,device-width", &p->device_width);
+	of_property_read_u32(np, "gpmc,mux-add-data", &p->mux_add_data);
+
+	if (!of_property_read_u32(np, "gpmc,burst-length", &p->burst_len)) {
+		p->burst_wrap = of_property_read_bool(np, "gpmc,burst-wrap");
+		p->burst_read = of_property_read_bool(np, "gpmc,burst-read");
+		p->burst_write = of_property_read_bool(np, "gpmc,burst-write");
+		if (!p->burst_read && !p->burst_write)
+			pr_warn("%s: page/burst-length set but not used!\n",
+				__func__);
+	}
+
+	if (!of_property_read_u32(np, "gpmc,wait-pin", &p->wait_pin)) {
+		p->wait_on_read = of_property_read_bool(np,
+							"gpmc,wait-on-read");
+		p->wait_on_write = of_property_read_bool(np,
+							 "gpmc,wait-on-write");
+		if (!p->wait_on_read && !p->wait_on_write)
+			pr_warn("%s: read/write wait monitoring not enabled!\n",
+				__func__);
+	}
+}
+
 static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 						struct gpmc_timings *gpmc_t)
 {
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 87d2a22..707f6d5 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -225,5 +225,7 @@ extern void gpmc_cs_free(int cs);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
 extern int gpmc_configure(int cmd, int wval);
+extern void gpmc_read_settings_dt(struct device_node *np,
+				  struct gpmc_settings *p);
 
 #endif
-- 
1.7.10.4

