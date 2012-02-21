From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 13/14] arm: omap3: voltage: fix channel configuration
Date: Tue, 21 Feb 2012 16:04:57 +0200
Message-ID: <1329833098-19900-14-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49249 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428Ab2BUOGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:06:08 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
overlap with VDD2 and attempting to modify VDD1 voltage will actually change
VDD2 voltage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c          |    5 ++++-
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 49df835..a0023de 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -701,9 +701,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->smps_cmdra_reg);
-		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
+		vc->cfg_channel |= vc_cfg_bits->rac;
 	}
 
+	if (vc->cmd_reg_addr == vc->volt_reg_addr)
+		vc->cfg_channel |= vc_cfg_bits->racen;
+
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->on);
 	onlp_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->onlp);
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 0535e8e..75bc4aa 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -46,6 +46,7 @@ static struct omap_vc_common omap3_vc_common = {
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
+	.flags = OMAP_VC_CHANNEL_DEFAULT,
 	.common = &omap3_vc_common,
 	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
-- 
1.7.4.1

