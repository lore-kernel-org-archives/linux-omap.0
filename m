From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 07/13] OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
Date: Fri,  1 Apr 2011 16:41:05 -0700
Message-ID: <1301701271-22096-8-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45757 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860Ab1DAXkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:51 -0400
Received: by iwr19 with SMTP id 19so5680656iwr.21
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:46 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The PMIC configurable variables should be isolated to VC initialization.
The rest of the VC functions (like VC bypass) should use the i2c slave address
and voltage register address fields from struct omap_vc_channel.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 7829861..3fdc3fb 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -91,7 +91,6 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 				 unsigned long target_volt)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
-	struct omap_vdd_info *vdd = voltdm->vdd;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
 	u8 target_vsel, current_vsel;
@@ -104,10 +103,8 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 	vc_valid = vc->common->valid;
 	vc_bypass_val_reg = vc->common->bypass_val_reg;
 	vc_bypass_value = (target_vsel << vc->common->data_shift) |
-			(vdd->pmic_info->volt_reg_addr <<
-			vc->common->regaddr_shift) |
-			(vdd->pmic_info->i2c_slave_addr <<
-			vc->common->slaveaddr_shift);
+		(vc->volt_reg_addr << vc->common->regaddr_shift) |
+		(vc->i2c_slave_addr << vc->common->slaveaddr_shift);
 
 	voltdm->write(vc_bypass_value, vc_bypass_val_reg);
 	voltdm->write(vc_bypass_value | vc_valid, vc_bypass_val_reg);
-- 
1.7.4

