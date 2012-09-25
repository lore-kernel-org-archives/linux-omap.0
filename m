From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 15/21] ARM: OMAP4: vc: fix channel configuration
Date: Tue, 25 Sep 2012 19:33:47 +0300
Message-ID: <1348590833-12335-16-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44045 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758042Ab2IYQe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:34:28 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

RACEN bit should only be set if the voltage and command register addresses
are the same.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 2ca00bc..a63c53a 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -695,9 +695,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
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
-- 
1.7.4.1

