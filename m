From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 07/14] ARM: OMAP: add support for oscillator setup
Date: Thu, 31 May 2012 16:55:43 +0300
Message-ID: <1338472550-20743-8-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33349 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091Ab2EaN4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 09:56:14 -0400
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This contains startup and shutdown times for the oscillator. By default
use ULONG_MAX. Oscillator setup is used for calculating and setting up
latencies for sleep modes that disable oscillator.

Based on a patch from Nishanth Menon <nm@ti.com>.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h |    8 ++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..05ec8ca 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -38,6 +38,36 @@ static struct omap_device_pm_latency *pm_lats;
  */
 int (*omap_pm_suspend)(void);
 
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
+void omap_pm_setup_oscillator(u32 tstart, u32 tshut)
+{
+	oscillator.startup_time = tstart;
+	oscillator.shutdown_time = tshut;
+}
+
+void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
+{
+	if (!tstart || !tshut)
+		return;
+
+	*tstart = oscillator.startup_time;
+	*tshut = oscillator.shutdown_time;
+}
+
 static int __init _init_omap_device(char *name)
 {
 	struct omap_hwmod *oh;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 312f2de..af1234c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -121,4 +121,12 @@ static inline int omap4_twl_init(void)
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

