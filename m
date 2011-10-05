From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 05/11] OMAP2+: PM: provide mechanism to describe overall behavior of osc and PMIC.
Date: Wed, 5 Oct 2011 20:17:05 +0300
Message-ID: <1317835031-8201-6-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935137Ab1JERRg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:36 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHZwh017464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:35 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHZ3u003306
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:35 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

We currently have mechanisms in place to describe the PMIC per
rail, however we also need to configure the system for situations
such as OFF mode, where, oscillator switch off and on time, and
similar durations for PMIC also tends to play a major factor.
Introduce a few apis to OMAP2's pm framework to use these. OMAP1
does'nt seem to need this at the moment, hence not a OMAP generic
framework. The set functions are meant to be used by initialization
code.

The OMAP specific implementation would need to use this ofcourse.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h |   18 +++++++
 2 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 659e400..e130d92 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -24,6 +24,52 @@
 #include "clockdomain.h"
 #include "pm.h"
 
+/**
+ * struct omap2_pm_lp_description - Describe low power behavior of the system
+ * @oscillator_startup_time:	Time rounded up to uSec for the oscillator to
+ *				provide a stable clock from power on.
+ * @oscillator_shutdown_time:	Time rounded up to uSec for oscillator to safely
+ *				switch off.
+ * @pmic_startup_time:		Time rounded up to uSec for the PMIC to
+ *				provide be ready for operation from low power
+ *				state. Note: this is not the same as voltage
+ *				rampup time, instead, consider the PMIC to be
+ *				in lowest power state(say OFF), this is the time
+ *				required for it to become ready for it's DCDCs
+ *				or LDOs to start operation.
+ * @pmic_shutdown_time:		Time rounded up to uSec for the PMIC to
+ *				go to low power after the LDOs are pulled to
+ *				appropriate state. Note: this is not the same as
+ *				voltage rampdown time, instead, consider the
+ *				PMIC to have switched it's LDOs down, this is
+ *				time taken to reach it's lowest power state(say
+ *				sleep/OFF).
+ *
+ * With complex systems like OMAP, we need a generic description of system
+ * behavior beyond the normal description of device/peripheral operation
+ * which in conjunction with other parameters describe and control the low
+ * power operation of the device. This information tends to be specific
+ * to every board.
+ */
+struct omap2_pm_lp_description {
+	u32 oscillator_startup_time;
+	u32 oscillator_shutdown_time;
+	u32 pmic_startup_time;
+	u32 pmic_shutdown_time;
+};
+
+/*
+ * Setup time to be the max... we want to err towards the worst
+ * as default. rest of the system can populate these with more
+ * optimal values
+ */
+static struct omap2_pm_lp_description _pm_lp_desc = {
+	.oscillator_startup_time = ULONG_MAX,
+	.oscillator_shutdown_time = ULONG_MAX,
+	.pmic_startup_time = ULONG_MAX,
+	.pmic_shutdown_time = ULONG_MAX,
+};
+
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
@@ -56,6 +102,82 @@ struct device *omap4_get_dsp_device(void)
 }
 EXPORT_SYMBOL(omap4_get_dsp_device);
 
+/**
+ * omap_pm_get_pmic_lp_time() - retrieve the oscillator time
+ * @tstart:	pointer to startup time in uSec
+ * @tshut:	pointer to shutdown time in uSec
+ *
+ * if the pointers are invalid, returns error, else
+ * populates the tstart and tshut values with the currently
+ * stored values.
+ */
+int omap_pm_get_osc_lp_time(u32 *tstart, u32 *tshut)
+{
+	if (!tstart || !tshut)
+		return -EINVAL;
+
+	*tstart = _pm_lp_desc.oscillator_startup_time;
+	*tshut = _pm_lp_desc.oscillator_shutdown_time;
+
+	return 0;
+}
+
+/**
+ * omap_pm_get_pmic_lp_time() - retrieve the PMIC time
+ * @tstart:	pointer to startup time in uSec
+ * @tshut:	pointer to shutdown time in uSec
+ *
+ * if the pointers are invalid, returns error, else
+ * populates the tstart and tshut values with the currently
+ * stored values.
+ */
+int omap_pm_get_pmic_lp_time(u32 *tstart, u32 *tshut)
+{
+	if (!tstart || !tshut)
+		return -EINVAL;
+
+	*tstart = _pm_lp_desc.pmic_startup_time;
+	*tshut = _pm_lp_desc.pmic_shutdown_time;
+
+	return 0;
+}
+
+/**
+ * omap_pm_set_osc_lp_time() - setup the system oscillator time
+ * @tstart:	startup time rounded up to uSec
+ * @tshut:	shutdown time rounded up to uSec
+ *
+ * All boards do need an oscillator for the device to function.
+ * The startup and stop time of these oscillators vary. Populate
+ * from the board file to optimize the timing.
+ * This function is meant to be used at boot-time configuration.
+ *
+ * NOTE: This API is intended to be invoked from board file
+ */
+void __init omap_pm_set_osc_lp_time(u32 tstart, u32 tshut)
+{
+	_pm_lp_desc.oscillator_startup_time = tstart;
+	_pm_lp_desc.oscillator_shutdown_time = tshut;
+}
+
+/**
+ * omap_pm_set_pmic_lp_time() - setup the pmic low power time
+ * @tstart:	startup time rounded up to uSec
+ * @tshut:	shutdown time rounded up to uSec
+ *
+ * Store the time for PMIC to enter to lowest state supported.
+ * in the case of multiple PMIC on a platform, choose the one
+ * that ends the sequence for LP state such as OFF and starts
+ * the sequence such as wakeup from OFF - e.g. a PMIC that
+ * controls core-domain.
+ * This function is meant to be used at boot-time configuration.
+ */
+void __init omap_pm_set_pmic_lp_time(u32 tstart, u32 tshut)
+{
+	_pm_lp_desc.pmic_startup_time = tstart;
+	_pm_lp_desc.pmic_shutdown_time = tshut;
+}
+
 /* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
 static int _init_omap_device(char *name, struct device **new_dev)
 {
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index babac19..dcceb90 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -124,4 +124,22 @@ static inline int omap4_twl_init(void)
 }
 #endif
 
+#ifdef CONFIG_PM
+extern int omap_pm_get_osc_lp_time(u32 *tstart, u32 *tshut);
+extern int omap_pm_get_pmic_lp_time(u32 *tstart, u32 *tshut);
+extern void omap_pm_set_osc_lp_time(u32 tstart, u32 tshut);
+extern void omap_pm_set_pmic_lp_time(u32 tstart, u32 tshut);
+#else
+static inline int omap_pm_get_osc_lp_time(u32 *tstart, u32 *tshut)
+{
+	return -EINVAL;
+}
+static inline int omap_pm_get_pmic_lp_time(u32 *tstart, u32 *tshut)
+{
+	return -EINVAL;
+}
+static inline void omap_pm_set_osc_lp_time(u32 tstart, u32 tshut) { }
+static inline void omap_pm_set_pmic_lp_time(u32 tstart, u32 tshut) { }
+#endif
+
 #endif
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

