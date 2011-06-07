From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 05/10] OMAP4: PM: VC: allow channels use of default channel cmd_reg_addr
Date: Mon,  6 Jun 2011 21:16:08 -0500
Message-ID: <1307412972-25854-6-git-send-email-nm@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35146 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655Ab1FGCQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:29 -0400
Received: by mail-yi0-f42.google.com with SMTP id 16so826635yie.15
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:29 -0700 (PDT)
In-Reply-To: <1307412972-25854-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

OMAP4's PRM_VC_CFG_CHANNEL register allows for flexibility of configuring
for various PMIC configurations. In combinations where we'd like to
use the default VC channel's cmd_reg address in a particular non-default
VC channel, we allow the use of USE_DEFAULT_CHANNEL_I2C_PARAM.

Since 0 is a valid register address, we need to increase the size of
reg storage for the flag. Depending on the PMIC and platform used,
this can be populated on the PMIC's datastructure and percolates to
VC's configuration.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c      |    8 +++++---
 arch/arm/mach-omap2/vc.h      |    2 +-
 arch/arm/mach-omap2/voltage.h |    4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 53a16cc..0af99c8 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -311,10 +311,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 
 	if ((vc->flags & OMAP_VC_CHANNEL_DEFAULT) &&
 		((vc->i2c_slave_addr == USE_DEFAULT_CHANNEL_I2C_PARAM) ||
+		(vc->cmd_reg_addr == USE_DEFAULT_CHANNEL_I2C_PARAM) ||
 		(vc->volt_reg_addr == USE_DEFAULT_CHANNEL_I2C_PARAM))) {
 		pr_err("%s: voltdm %s: default channel "
-			"bad config-sa=%2x vol=%2x?\n", __func__, voltdm->name,
-			vc->i2c_slave_addr, vc->volt_reg_addr);
+			"bad config-sa=%2x vol=%2x, cmd=%2x?\n", __func__,
+			voltdm->name, vc->i2c_slave_addr, vc->volt_reg_addr,
+			vc->cmd_reg_addr);
 		return;
 	}
 
@@ -336,7 +338,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		vc->cfg_channel |= vc_cfg_bits->rav;
 	}
 
-	if (vc->cmd_reg_addr) {
+	if (vc->cmd_reg_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 310368f..3b25d9c 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -79,7 +79,7 @@ struct omap_vc_channel {
 	/* channel state */
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
-	u8 cmd_reg_addr;
+	u16 cmd_reg_addr;
 	u8 cfg_channel;
 	u16 setup_time;
 	bool i2c_high_speed;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 75f3557..0a4232f 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -114,7 +114,7 @@ struct omap_volt_data {
  * channel is MPU, all other domains such as IVA/CORE, could optionally
  * link their i2c reg configuration to use MPU channel's configuration if
  * required. To do this, mark in the PMIC structure's
- * i2c_slave_addr, volt_reg_addr with this macro.
+ * i2c_slave_addr, volt_reg_addr,cmd_reg_addr with this macro.
  */
 #define USE_DEFAULT_CHANNEL_I2C_PARAM  0x8000
 
@@ -143,7 +143,7 @@ struct omap_voltdm_pmic {
 	u8 vp_timeout_us;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
-	u8 cmd_reg_addr;
+	u16 cmd_reg_addr;
 	bool i2c_high_speed;
 	u8 i2c_mcode;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
-- 
1.7.1

