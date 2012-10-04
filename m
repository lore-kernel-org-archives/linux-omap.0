From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 4/5] ARM: omap: vp: .get_voltage callback
Date: Wed, 3 Oct 2012 18:16:04 -0700
Message-ID: <1349313365-5262-5-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933233Ab2JDBQx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Oct 2012 21:16:53 -0400
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@linaro.org>

Implement the voltdm->get_voltage callback for the voltage processor
driver.  This reads the INITVOLTAGE field corresponding to each VP and
returns the voltage, after converting it from vsel format.

If INITVOLTAGE is zero (the reset value) then the caller must interpret
this as the PMIC running at the default power-on voltage.  In such a
case DT data for the PMIC is necessary to know the voltage.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/vp.c |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/vp.h |    1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index f95c1ba..63dc03e 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -9,6 +9,28 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 
+unsigned long omap_vp_get_init_voltage(struct voltagedomain *voltdm)
+{
+	struct omap_vp_instance *vp = voltdm->vp;
+	u32 vpconfig;
+	u8 vsel;
+	unsigned long volt;
+
+	/* sanity */
+	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv
+			|| !voltdm->read || !voltdm->write)
+		return 0;
+
+	vpconfig = voltdm->read(vp->vpconfig);
+	vpconfig &= vp->common->vpconfig_initvoltage_mask;
+
+	vsel = vpconfig >> __ffs(vp->common->vpconfig_initvoltage_mask);
+
+	volt = voltdm->pmic->vsel_to_uv(vsel);
+
+	return volt;
+}
+
 static u32 _vp_set_init_voltage(struct voltagedomain *voltdm, u32 volt)
 {
 	struct omap_vp_instance *vp = voltdm->vp;
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7c155d2..0747a78 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -120,6 +120,7 @@ extern struct omap_vp_instance omap4_vp_core;
 void omap_vp_init(struct voltagedomain *voltdm);
 void omap_vp_enable(struct voltagedomain *voltdm);
 void omap_vp_disable(struct voltagedomain *voltdm);
+unsigned long omap_vp_get_init_voltage(struct voltagedomain *voltdm);
 int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 			      unsigned long target_volt);
 int omap_vp_update_errorgain(struct voltagedomain *voltdm,
-- 
1.7.9.5

