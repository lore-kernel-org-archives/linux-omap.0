From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 07/21] ARM: OMAP: add support for oscillator setup
Date: Tue, 25 Sep 2012 19:33:39 +0300
Message-ID: <1348590833-12335-8-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758004Ab2IYQeS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:34:18 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
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
index dfe702b..b98439c 100644
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
index bee3911..583b40f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -136,4 +136,12 @@ static inline int omap4_twl_init(void)
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

