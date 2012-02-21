From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 06/14] arm: omap: add support for oscillator setup
Date: Tue, 21 Feb 2012 16:04:50 +0200
Message-ID: <1329833098-19900-7-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755406Ab2BUOF7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:59 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This contains startup and shutdown times for the oscillator. By default
use ULONG_MAX. Oscillator setup is used for calculating and setting up
latencies for sleep modes that disable oscillator.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h |    8 ++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..2402e8e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,6 +28,33 @@
 
 static struct omap_device_pm_latency *pm_lats;
 
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
+	*tstart = oscillator.startup_time;
+	*tshut = oscillator.shutdown_time;
+}
+
 static int _init_omap_device(char *name)
 {
 	struct omap_hwmod *oh;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index ec8f874..797d2da 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -141,4 +141,12 @@ static inline int omap4_twl_init(void)
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

