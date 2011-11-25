From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 14/15] omap3: voltage: fix channel configuration
Date: Fri, 25 Nov 2011 17:49:47 +0200
Message-ID: <1322236188-19456-15-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1KYPuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 10:50:20 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoJoL006367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:19 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFoJ5a003868
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:19 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoJQI018026
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:19 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
overlap with VDD2 and attempting to modify VDD1 voltage will actually change
VDD2 voltage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c          |    5 ++++-
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index ec74c68..94fda64 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -581,9 +581,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
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
 	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->on);
 	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->onlp);
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index cfe348e..0136ad5 100644
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

