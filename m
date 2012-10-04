From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 3/5] ARM: omap: vc: .get_voltage callback
Date: Wed, 3 Oct 2012 18:16:03 -0700
Message-ID: <1349313365-5262-4-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab2JDBQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 21:16:51 -0400
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@linaro.org>

Implement the voltdm->get_voltage callback for the voltage controller
driver.  This reads the DATA field corresponding to each VC and returns
the voltage, after converting it from vsel format.

If DATA is zero (the reset value) then the caller must interpret this as
the PMIC running at the default power-on voltage.  In such a case DT
data for the PMIC is necessary to know the voltage.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/vc.c |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/vc.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 2bcac64..90a9ea6 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -101,6 +101,27 @@ static int omap_vc_config_channel(struct voltagedomain *voltdm)
 }
 
 /* Voltage scale and accessory APIs */
+unsigned long omap_vc_get_bypass_data(struct voltagedomain *voltdm)
+{
+	struct omap_vc_channel *vc = voltdm->vc;
+	u32 vc_bypass_value;
+	u8 vsel;
+	unsigned long volt;
+
+	/* sanity */
+	if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv ||
+			!voltdm->read || !voltdm->write)
+		return 0;
+
+	vc_bypass_value = voltdm->read(vc->common->bypass_val_reg);
+	vc_bypass_value &= vc->common->data_mask;
+	vsel = vc_bypass_value >> __ffs(vc->common->data_mask);
+
+	volt = voltdm->pmic->vsel_to_uv(vsel);
+
+	return volt;
+}
+
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
 		      u8 *target_vsel, u8 *current_vsel)
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 84a61b1..e7d4719 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -112,6 +112,7 @@ extern struct omap_vc_channel omap4_vc_iva;
 extern struct omap_vc_channel omap4_vc_core;
 
 void omap_vc_init_channel(struct voltagedomain *voltdm);
+unsigned long omap_vc_get_bypass_data(struct voltagedomain *voltdm);
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
 		      u8 *target_vsel, u8 *current_vsel);
-- 
1.7.9.5

