From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 09/14] omap: mcbsp: Move sidetone clock management to mach-omap2/mcbsp.c
Date: Wed, 31 Aug 2011 18:22:56 +0300
Message-ID: <1314804181-17260-10-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:53064 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756490Ab1HaPX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:23:27 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jhnikula@gmail.com>, Paul Wamsley <paul@pwsan.com>

From: Jarkko Nikula <jhnikula@gmail.com>

Active sidetone requires that McBSP interface clock doesn't idle and there
is no mechanism in hwmod to turn autoidling on/off in runtime. McBSP2 and 3
in OMAP34xx share their interface clock with McBSP sidetone module and
that interface clock must be active when the sidetone is operating.

Sidetone has its own autoidle bit which should keep the interface clock
active but it is broken. Putting the McBSP core to no-idle mode when the
sidetone is active is no good either since it results to higher power
consumption when using the threshold based DMA transfers.

For making the McBSP code more generic, move this sidetone clock management
with fixme comments to mach-omap2/mcbsp.c and pass pointer to it via
platform data.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Wamsley <paul@pwsan.com>
---
Yep, just moving fixme code around but at least it can be fixing now under
right architecture. Even if plat/mcbsp.c is moved out.
---
 arch/arm/mach-omap2/mcbsp.c             |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |   18 ++++--------------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 3c42adb..bc51424 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -27,6 +27,13 @@
 
 #include "control.h"
 
+/*
+ * FIXME: Find a mechanism to enable/disable runtime the McBSP ICLK autoidle.
+ * Sidetone needs non-gated ICLK and sidetone autoidle is broken.
+ */
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-34xx.h"
+
 /* McBSP internal signal muxing functions */
 
 void omap2_mcbsp1_mux_clkr_src(u8 mux)
@@ -102,6 +109,24 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 }
 EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
+static int omap3_enable_st_clock(unsigned int id, bool enable)
+{
+	unsigned int w;
+
+	/*
+	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
+	 * are enabled or sidetones start sounding ugly.
+	 */
+	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	if (enable)
+		w &= ~(1 << (id - 2));
+	else
+		w |= 1 << (id - 2);
+	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+
+	return 0;
+}
+
 struct omap_device_pm_latency omap2_mcbsp_latency[] = {
 	{
 		.deactivate_func = omap_device_idle_hwmods,
@@ -151,6 +176,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	if (oh->dev_attr) {
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
+		pdata->enable_st_clock = omap3_enable_st_clock;
 		count++;
 	}
 	od = omap_device_build_ss(name, id, oh_device, count, pdata,
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 648344a..e451a6e 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -321,6 +321,7 @@ struct omap_mcbsp_platform_data {
 	/* McBSP platform and instance specific features */
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
+	int (*enable_st_clock)(unsigned int, bool);
 };
 
 struct omap_mcbsp_st_data {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 3ad536e..e96d747 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -26,10 +26,6 @@
 #include <plat/mcbsp.h>
 #include <linux/pm_runtime.h>
 
-/* XXX These "sideways" includes are a sign that something is wrong */
-#include "../mach-omap2/cm2xxx_3xxx.h"
-#include "../mach-omap2/cm-regbits-34xx.h"
-
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
@@ -257,13 +253,8 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
 
-	/*
-	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
-	 * are enabled or sidetones start sounding ugly.
-	 */
-	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
-	w &= ~(1 << (mcbsp->id - 2));
-	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+	if (mcbsp->pdata->enable_st_clock)
+		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
 
 	/* Enable McBSP Sidetone */
 	w = MCBSP_READ(mcbsp, SSELCR);
@@ -284,9 +275,8 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
 
-	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
-	w |= 1 << (mcbsp->id - 2);
-	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+	if (mcbsp->pdata->enable_st_clock)
+		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
 }
 
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
-- 
1.7.5.4

