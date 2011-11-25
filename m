From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 06/15] omap3+: vp: use new vp_params for calculating vddmin and vddmax
Date: Fri, 25 Nov 2011 17:49:39 +0200
Message-ID: <1322236188-19456-7-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51399 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672Ab1KYPuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:08 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFo7ST005762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:07 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFo7TL003820
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:07 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo72Y017819
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:07 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Now we select the vddmin and vddmax values based on both pmic and
voltage processor data, this allows usage of different power ICs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 16cb6d4..ffb68d8 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -53,8 +53,10 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
+	vddmin = max(voltdm->vp_param->vddmin, voltdm->pmic->vp_vddmin);
+	vddmax = min(voltdm->vp_param->vddmax, voltdm->pmic->vp_vddmax);
+	vddmin = voltdm->pmic->uv_to_vsel(vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(vddmax);
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
-- 
1.7.4.1

