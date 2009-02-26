From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Thu, 26 Feb 2009 13:48:30 -0800
Message-ID: <200902261348.30617.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <20090226202055.GE8595@sirena.org.uk> <200902261312.42720.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:37728 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754982AbZBZWkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:40:07 -0500
In-Reply-To: <200902261312.42720.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Add optional glue between MMC and regulator stacks, using a new
regulator interface to learn what voltages are available.

This is intended to be selected and driven by MMC host adapters.
It only handles reusable parts of the regulator-to-MMC glue; the
adapter drivers will have access to details that affect how this
is used.  Examples include when to use multiple voltage rails or
configure (internal or external) level shifters.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Changes from previous version:  adapter must select this, and
callers now pass in the regulator.  mmc_regulator_set_ocr()
is still not tested, mmc_regulator_get_ocrmask() passed sanity
testing.

Pierre:  Mark may have a need for this soonish.  The omap_hsmmc
code will want it at some point.

 drivers/mmc/core/Kconfig |    7 +++
 drivers/mmc/core/core.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 ++
 3 files changed, 96 insertions(+)

--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -14,3 +14,10 @@ config MMC_UNSAFE_RESUME
 	  This option is usually just for embedded systems which use
 	  a MMC/SD card for rootfs. Most people should say N here.
 
+config MMC_REGULATOR
+	bool
+	depends on REGULATOR
+	help
+	  Select this if your MMC host adapter driver wants helper
+	  utilities for accessing power rails.
+
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -21,6 +21,7 @@
 #include <linux/leds.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -523,6 +524,89 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min,
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+#ifdef CONFIG_MMC_REGULATOR
+
+/**
+ * mmc_regulator_get_ocrmask - return mask of supported voltages
+ * @host: mmc host whose supply will be consulted
+ * @supply: regulator to use
+ *
+ * This returns either a negative errno, or a mask of voltages that
+ * can be provided to MMC/SD/SDIO devices using the specified voltage
+ * regulator.  This would normally be called before registering the
+ * MMC host adapter.
+ */
+int mmc_regulator_get_ocrmask(struct mmc_host *host, struct regulator *supply)
+{
+	int			result = 0;
+	int			count;
+	int			i;
+
+	count = regulator_count_voltages(supply);
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+		int		vdd_uV;
+		int		vdd_mV;
+
+		vdd_uV = regulator_list_voltage(supply, i);
+		if (vdd_uV <= 0)
+			continue;
+
+		vdd_mV = vdd_uV / 1000;
+		result |= mmc_vddrange_to_ocrmask(vdd_mV, vdd_mV);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(mmc_regulator_get_ocrmask);
+
+/**
+ * mmc_regulator_set_ocr - set regulator to match host->ios voltage
+ * @host: mmc host whose supply voltage will be changed
+ * @supply: regulator to use
+ *
+ * MMC host drivers may use this to enable or disable a regulator using
+ * a particular supply voltage.  This would normally be called from the
+ * set_ios() method.
+ */
+int mmc_regulator_set_ocr(struct mmc_host *host, struct regulator *supply)
+{
+	int			result = 0;
+	int			min_mV, max_mV;
+	int			enabled;
+
+	enabled = regulator_is_enabled(supply);
+	if (enabled < 0)
+		return enabled;
+
+	if (host->ios.vdd) {
+		int		tmp;
+
+		tmp = host->ios.vdd - ilog2(MMC_VDD_165_195);
+		if (tmp == 0) {
+			min_mV = 1650;
+			max_mV = 1950;
+		} else {
+			min_mV = 2000 + tmp * 100;
+			max_mV = min_mV + 100;
+		}
+
+		result = regulator_set_voltage(supply,
+				min_mV * 1000, max_mV * 1000);
+		if (result == 0 && !enabled)
+			result = regulator_enable(supply);
+	} else if (enabled) {
+		result = regulator_disable(supply);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(mmc_regulator_set_ocr);
+
+#endif
+
 /*
  * Mask off any voltages we don't support and select
  * the lowest voltage
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -192,5 +192,10 @@ static inline void mmc_signal_sdio_irq(s
 	wake_up_process(host->sdio_irq_thread);
 }
 
+struct regulator;
+
+int mmc_regulator_get_ocrmask(struct mmc_host *host, struct regulator *supply);
+int mmc_regulator_set_ocr(struct mmc_host *host, struct regulator *supply);
+
 #endif
 
