From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc6+misc] MMC: regulator utilities
Date: Sun, 8 Mar 2009 12:34:25 -0800
Message-ID: <200903081334.26465.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200903031918.07443.david-b@pacbell.net> <20090308145951.0fdd607a@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n23.bullet.mail.mud.yahoo.com ([68.142.206.162]:42831 "HELO
	n23.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753479AbZCHUea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Mar 2009 16:34:30 -0400
In-Reply-To: <20090308145951.0fdd607a@mjolnir.ossman.eu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sunday 08 March 2009, Pierre Ossman wrote:
> Looks good. Now what should I do with it? Merge it in the next window
> good enough?

Well, after testing the previously-untested call ... here's
another update.

Since these depend on new calls in the regulator framework,
it can't merge until after they merge (in the next window).
Least hassle for you would be if this merges through the
regulator framework (with your ack), I suspect.

- Dave


======== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Glue between MMC and regulator stacks ... verified with
some OMAP3 boards using adjustable and configured-as-fixed
regulators on several MMC controllers.

These calls are intended to be used by MMC host adapters
using at least one regulator per host.  Examples include
slots with regulators supporting multiple voltages and
ones using multiple voltage rails (e.g. DAT4..DAT7 using a
separate supply, or a split rail chip like certain SDIO
WLAN or eMMC solutions).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Changes since previous version:  simplified set_ocr() calling
convention, fixed an off-by-100mA error in that code, and don't
set voltage on regulators that don't need (and may disallow) it.

 drivers/mmc/core/core.c  |  100 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 ++
 2 files changed, 105 insertions(+)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -21,6 +21,7 @@
 #include <linux/leds.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -523,6 +524,105 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min,
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+#ifdef CONFIG_REGULATOR
+
+/**
+ * mmc_regulator_get_ocrmask - return mask of supported voltages
+ * @supply: regulator to use
+ *
+ * This returns either a negative errno, or a mask of voltages that
+ * can be provided to MMC/SD/SDIO devices using the specified voltage
+ * regulator.  This would normally be called before registering the
+ * MMC host adapter.
+ */
+int mmc_regulator_get_ocrmask(struct regulator *supply)
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
+ * @vdd_bit: zero for power off, else a bit number (host->ios.vdd)
+ * @supply: regulator to use
+ *
+ * Returns zero on success, else negative errno.
+ *
+ * MMC host drivers may use this to enable or disable a regulator using
+ * a particular supply voltage.  This would normally be called from the
+ * set_ios() method.
+ */
+int mmc_regulator_set_ocr(struct regulator *supply, unsigned short vdd_bit)
+{
+	int			result = 0;
+	int			min_uV, max_uV;
+	int			enabled;
+
+	enabled = regulator_is_enabled(supply);
+	if (enabled < 0)
+		return enabled;
+
+	if (vdd_bit) {
+		int		tmp;
+		int		voltage;
+
+		/* REVISIT mmc_vddrange_to_ocrmask() may have set some
+		 * bits this regulator doesn't quite support ... don't
+		 * be too picky, most cards and regulators are OK with
+		 * a 0.1V range goof (it's a small error percentage).
+		 */
+		tmp = vdd_bit - ilog2(MMC_VDD_165_195);
+		if (tmp == 0) {
+			min_uV = 1650 * 1000;
+			max_uV = 1950 * 1000;
+		} else {
+			min_uV = 1900 * 1000 + tmp * 100 * 1000;
+			max_uV = min_uV + 100 * 1000;
+		}
+
+		/* avoid needless changes to this voltage; the regulator
+		 * might not allow this operation
+		 */
+		voltage = regulator_get_voltage(supply);
+		if (voltage < 0)
+			result = voltage;
+		else if (voltage < min_uV || voltage > max_uV)
+			result = regulator_set_voltage(supply, min_uV, max_uV);
+		else
+			result = 0;
+
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
+int mmc_regulator_get_ocrmask(struct regulator *supply);
+int mmc_regulator_set_ocr(struct regulator *supply, unsigned short vdd_bit);
+
 #endif
 




