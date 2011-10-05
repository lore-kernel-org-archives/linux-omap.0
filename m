From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 07/11] omap3+: vp: use new vp_params for calculating vddmin and vddmax
Date: Wed, 5 Oct 2011 20:17:07 +0300
Message-ID: <1317835031-8201-8-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935151Ab1JERRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:38 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHbt6017467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHbJF003313
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHaDX001745
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Now we select the vddmin and vddmax values based on both pmic and
voltage processor data, this allows usage of different power ICs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vp.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 16cb6d4..fd3f43c 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -53,8 +53,12 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vddmax);
+	vddmin = voltdm->vp_param->vddmin > voltdm->pmic->vp_vddmin ?
+		voltdm->vp_param->vddmin : voltdm->pmic->vp_vddmin;
+	vddmax = voltdm->vp_param->vddmax < voltdm->pmic->vp_vddmax ?
+		voltdm->vp_param->vddmax : voltdm->pmic->vp_vddmax;
+	vddmin = voltdm->pmic->uv_to_vsel(vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(vddmax);
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

