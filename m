From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 08/14] ARM: OMAP3+: vp: use new vp_params for calculating vddmin and vddmax
Date: Thu, 31 May 2012 16:55:44 +0300
Message-ID: <1338472550-20743-9-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53684 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758172Ab2EaN4P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 09:56:15 -0400
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Now we select the vddmin and vddmax values based on both pmic and
voltage processor data, this allows usage of different power ICs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index c585dfb..c9277c3 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -58,8 +58,10 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmax);
+	vddmin = max(voltdm->vp_param->vddmin, voltdm->pmic->vddmin);
+	vddmax = min(voltdm->vp_param->vddmax, voltdm->pmic->vddmax);
+	vddmin = voltdm->pmic->uv_to_vsel(vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(vddmax);
 
 	waittime = DIV_ROUND_UP(voltdm->pmic->step_size * sys_clk_rate,
 				1000 * voltdm->pmic->slew_rate);
-- 
1.7.4.1

