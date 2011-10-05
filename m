From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 02/11] omap: voltage: add definitions for omap_vp_param and omap_vc_param
Date: Wed, 5 Oct 2011 20:17:02 +0300
Message-ID: <1317835031-8201-3-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935085Ab1JERRd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHW9J019513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:32 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHWEt003288
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:32 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHVKT001674
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:32 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These are used to contain omap specific minimum and maximum voltages
for domains, and also operating voltages for different power modes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 1577c2f..92cbc67 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -70,6 +70,8 @@ struct voltagedomain {
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
 	struct omap_voltdm_pmic *pmic;
+	struct omap_vp_param *vp_param;
+	struct omap_vc_param *vc_param;
 
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
@@ -137,10 +139,6 @@ struct omap_volt_data {
 struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
 	u16 volt_setup_time;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
@@ -157,6 +155,18 @@ struct omap_voltdm_pmic {
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
 
+struct omap_vp_param {
+	u32 vddmax;
+	u32 vddmin;
+};
+
+struct omap_vc_param {
+	u32 on;
+	u32 onlp;
+	u32 ret;
+	u32 off;
+};
+
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

