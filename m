From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 06/13] OMAP: Disable Smartreflex across DVFS
Date: Fri, 21 Jan 2011 19:30:58 +0530
Message-ID: <1295618465-15234-7-git-send-email-vishwanath.bs@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33512 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab1AUN5p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 08:57:45 -0500
In-Reply-To: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Thara Gopinath <thara@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch disables smartreflex for a particular voltage
domain when the the voltage domain and the devices belonging
to it is being scaled and re-enables it back once the scaling
is done.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/dvfs.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-omap2/dvfs.c
index 05a9ce3..1e5492c 100755
--- a/arch/arm/mach-omap2/dvfs.c
+++ b/arch/arm/mach-omap2/dvfs.c
@@ -529,6 +529,9 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
 
 	curr_volt = omap_voltage_get_nom_volt(voltdm);
 
+	/* Disable smartreflex module across voltage and frequency scaling */
+	omap_sr_disable(voltdm);
+
 	if (curr_volt == volt) {
 		is_volt_scaled = 1;
 	} else if (curr_volt < volt) {
@@ -536,6 +539,7 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
 		if (ret) {
 			pr_warning("%s: Unable to scale the %s to %ld volt\n",
 						__func__, voltdm->name, volt);
+			omap_sr_enable(voltdm);
 			mutex_unlock(&dvfs_info->scaling_mutex);
 			return ret;
 		}
@@ -570,6 +574,9 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
 	if (!is_volt_scaled && !ret)
 		omap_voltage_scale_vdd(voltdm, volt);
 
+	/* Enable Smartreflex module */
+	omap_sr_enable(voltdm);
+
 	mutex_unlock(&dvfs_info->scaling_mutex);
 
 	/* calculate the voltages for dependent vdd's */
-- 
1.7.0.4

