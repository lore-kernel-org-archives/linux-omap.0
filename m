From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 1/5] ARM: omap: vc: replace data_shift with data_mask
Date: Wed, 3 Oct 2012 18:16:01 -0700
Message-ID: <1349313365-5262-2-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933227Ab2JDBQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 21:16:52 -0400
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

From: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/vc.c          |    2 +-
 arch/arm/mach-omap2/vc.h          |    2 +-
 arch/arm/mach-omap2/vc3xxx_data.c |    2 +-
 arch/arm/mach-omap2/vc44xx_data.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 84da34f..2bcac64 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -171,7 +171,7 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 
 	vc_valid = vc->common->valid;
 	vc_bypass_val_reg = vc->common->bypass_val_reg;
-	vc_bypass_value = (target_vsel << vc->common->data_shift) |
+	vc_bypass_value = (target_vsel << __ffs(vc->common->data_mask)) |
 		(vc->volt_reg_addr << vc->common->regaddr_shift) |
 		(vc->i2c_slave_addr << vc->common->slaveaddr_shift);
 
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 478bf6b..84a61b1 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -43,8 +43,8 @@ struct voltagedomain;
 struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
+	u32 data_mask;
 	u8 bypass_val_reg;
-	u8 data_shift;
 	u8 slaveaddr_shift;
 	u8 regaddr_shift;
 	u8 cmd_on_shift;
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 5d8eaf3..2b35e82 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -31,7 +31,7 @@
  */
 static struct omap_vc_common omap3_vc_common = {
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
-	.data_shift	 = OMAP3430_DATA_SHIFT,
+	.data_mask	 = OMAP3430_DATA_MASK,
 	.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT,
 	.regaddr_shift	 = OMAP3430_REGADDR_SHIFT,
 	.valid		 = OMAP3430_VALID_MASK,
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index d70b930..598edc9 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -32,7 +32,7 @@
  */
 static const struct omap_vc_common omap4_vc_common = {
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
-	.data_shift = OMAP4430_DATA_SHIFT,
+	.data_mask = OMAP4430_DATA_MASK,
 	.slaveaddr_shift = OMAP4430_SLAVEADDR_SHIFT,
 	.regaddr_shift = OMAP4430_REGADDR_SHIFT,
 	.valid = OMAP4430_VALID_MASK,
-- 
1.7.9.5

