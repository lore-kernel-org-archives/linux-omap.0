From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 03/10] OMAP4: PM: VC: allow channels to use cmdra reg
Date: Mon,  6 Jun 2011 21:16:06 -0500
Message-ID: <1307412972-25854-4-git-send-email-nm@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33614 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754812Ab1FGCQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:24 -0400
Received: by yia28 with SMTP id 28so1954114yia.34
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:22 -0700 (PDT)
In-Reply-To: <1307412972-25854-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

if volt_reg and cmd_reg are the same from PMIC configuration,
we can use the cmd reg by using racen - this is valid for
voltage commands, however, in most cases, we'd like to retain
voltage reg configuration as well for vfsm commands going thru
from h/w.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 0c0e416..6017c70 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -337,9 +337,13 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
-		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
+		vc->cfg_channel |= vc_cfg_bits->rac;
 	}
 
+	/* If voltage and cmd regs are same, we can use cmdra register */
+	if (vc->volt_reg_addr == vc->cmd_reg_addr)
+		vc->cfg_channel |= vc_cfg_bits->racen;
+
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
 	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
-- 
1.7.1

