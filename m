From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 05/15] omap: add support for oscillator setup
Date: Fri, 25 Nov 2011 17:49:38 +0200
Message-ID: <1322236188-19456-6-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab1KYPuH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:07 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFo6Rt005756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:06 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFo6ve003811
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:06 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo6b4017777
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:06 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

This contains startup and shutdown times for the oscillator. By default
use MAX_INT. Oscillator setup is used for calculating and setting up
latencies for sleep modes that disable oscillator.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h |    8 ++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d34fc52..b60bae7 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -31,6 +31,21 @@ static struct device *iva_dev;
 static struct device *l3_dev;
 static struct device *dsp_dev;
 
+/**
+ * struct omap2_oscillator - Describe the board main oscillator latencies
+ * @startup_time: oscillator startup latency
+ * @shutdown_time: oscillator shutdown latency
+ */
+struct omap2_oscillator {
+	u32 startup_time;
+	u32 shutdown_time;
+};
+
+static struct omap2_oscillator oscillator = {
+	.startup_time = ULONG_MAX,
+	.shutdown_time = ULONG_MAX,
+};
+
 struct device *omap2_get_mpuss_device(void)
 {
 	WARN_ON_ONCE(!mpu_dev);
@@ -56,6 +71,18 @@ struct device *omap4_get_dsp_device(void)
 }
 EXPORT_SYMBOL(omap4_get_dsp_device);
 
+void omap_pm_setup_oscillator(u32 tstart, u32 tshut)
+{
+	oscillator.startup_time = tstart;
+	oscillator.shutdown_time = tshut;
+}
+
+void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
+{
+	*tstart = oscillator.startup_time;
+	*tshut = oscillator.shutdown_time;
+}
+
 /* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
 static int _init_omap_device(char *name, struct device **new_dev)
 {
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..3bdb359 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -134,4 +134,12 @@ static inline int omap4_twl_init(void)
 }
 #endif
 
+#ifdef CONFIG_PM
+extern void omap_pm_setup_oscillator(u32 tstart, u32 tshut);
+extern void omap_pm_get_oscillator(u32 *tstart, u32 *tshut);
+#else
+static inline void omap_pm_setup_oscillator(u32 tstart, u32 tshut) { }
+static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) { }
+#endif
+
 #endif
-- 
1.7.4.1

