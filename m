From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: Smart Reflex pm patches causes a kernel panic
Date: Tue, 19 May 2009 15:04:29 +0300
Message-ID: <4A12A04D.1060109@nokia.com>
References: <95B5E119-3C65-4739-A8BA-B66486850DD4@mac.com> <1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com> <4A129CA9.5090804@nokia.com> <A580CA19-FD4B-4A4B-BF38-FC53444FC012@mac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020801090206040008080705"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42979 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZESMFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 08:05:23 -0400
In-Reply-To: <A580CA19-FD4B-4A4B-BF38-FC53444FC012@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020801090206040008080705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ext Elvis Dowson wrote:
> Thanks for the info, Roger! I'll wait for that patch!
> 
> Elvis
> 
>>
>> Currently Smartreflex (SR) is dependent on SRF to get OPP levels. Just 
>> make sure you select CONFIG_OMAP_PM_SRF when using SR. OR you can 
>> disable Smartreflex till this issue is fixed.
>>
>> I am working on a patch that will make Smartreflex independent of SRF. 
>> I will post this soon.
> 

Elvis,

Can you please try and verify if the problem goes away with the attached patch.
Thanks.

-roger

--------------020801090206040008080705
Content-Type: text/x-patch;
 name="0001-OMAP3-PM-Make-Smartreflex-driver-independent-of-SR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-OMAP3-PM-Make-Smartreflex-driver-independent-of-SR.patc";
 filename*1="h"

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Tue, 19 May 2009 14:15:56 +0300
Subject: [PATCH] OMAP3: PM: Make Smartreflex driver independent of SRF

This removes Smartreflex driver's dependency on SRF layer to get
OPPs for VDD1 and VDD2. Now Smartreflex is usable irrespective of the
underlying PM layer.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   74 ++++++++++++++++++++++++++++++++-----
 1 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b032366..b66d237 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -143,6 +143,57 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
 		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT));
 }
 
+/* determine the current OPP from the frequency
+ * we need to give this function last element of OPP rate table
+ * and the frequency
+ */
+static u16 get_opp(struct omap_opp *opp_freq_table,
+					unsigned long freq)
+{
+	struct omap_opp *prcm_config;
+
+	prcm_config = opp_freq_table;
+
+	if (prcm_config->rate <= freq)
+		return prcm_config->opp_id; /* Return the Highest OPP */
+	for (; prcm_config->rate; prcm_config--)
+		if (prcm_config->rate < freq)
+			return (prcm_config+1)->opp_id;
+		else if (prcm_config->rate == freq)
+			return prcm_config->opp_id;
+	/* Return the least OPP */
+	return (prcm_config+1)->opp_id;
+}
+
+static u16 get_vdd1_opp(void)
+{
+	u16 opp;
+	struct clk *clk;
+
+	clk = clk_get(NULL, "dpll1_ck");
+
+	if (clk == NULL || IS_ERR(clk) || mpu_opps == NULL)
+		return 0;
+
+	opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
+	return opp;
+}
+
+static u16 get_vdd2_opp(void)
+{
+	u16 opp;
+	struct clk *clk;
+
+	clk = clk_get(NULL, "dpll3_m2_ck");
+
+	if (clk == NULL || IS_ERR(clk) || l3_opps == NULL)
+		return 0;
+
+	opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
+	return opp;
+}
+
+
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *sys_ck;
@@ -248,13 +299,15 @@ static void sr_configure_vp(int srid)
 {
 	u32 vpconfig;
 	u32 vsel;
+	u32 target_opp_no;
 
 	if (srid == SR1) {
-		if (!omap_pm_vdd1_get_opp())
+		target_opp_no = get_vdd1_opp();
+		if (!target_opp_no)
 			/* Assume Nominal OPP as current OPP unknown */
 			vsel = mpu_opps[VDD1_OPP3].vsel;
 		else
-			vsel = mpu_opps[omap_pm_vdd1_get_opp()].vsel;
+			vsel = mpu_opps[target_opp_no].vsel;
 
 		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
 			PRM_VP1_CONFIG_ERRORGAIN |
@@ -295,11 +348,12 @@ static void sr_configure_vp(int srid)
 				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 
 	} else if (srid == SR2) {
-		if (!omap_pm_vdd2_get_opp())
+		target_opp_no = get_vdd2_opp();
+		if (!target_opp_no)
 			/* Assume Nominal OPP */
 			vsel = l3_opps[VDD2_OPP3].vsel;
 		else
-			vsel = l3_opps[omap_pm_vdd2_get_opp()].vsel;
+			vsel = l3_opps[target_opp_no].vsel;
 
 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
 			PRM_VP2_CONFIG_ERRORGAIN |
@@ -397,7 +451,7 @@ static int sr_reset_voltage(int srid)
 	u32 vc_bypass_value;
 
 	if (srid == SR1) {
-		target_opp_no = omap_pm_vdd1_get_opp();
+		target_opp_no = get_vdd1_opp();
 		if (!target_opp_no) {
 			pr_info("Current OPP unknown: Cannot reset voltage\n");
 			return 1;
@@ -405,7 +459,7 @@ static int sr_reset_voltage(int srid)
 		vsel = mpu_opps[target_opp_no].vsel;
 		reg_addr = R_VDD1_SR_CONTROL;
 	} else if (srid == SR2) {
-		target_opp_no = omap_pm_vdd2_get_opp();
+		target_opp_no = get_vdd2_opp();
 		if (!target_opp_no) {
 			pr_info("Current OPP unknown: Cannot reset voltage\n");
 			return 1;
@@ -641,9 +695,9 @@ void enable_smartreflex(int srid)
 			sr_clk_enable(sr);
 
 			if (srid == SR1)
-				target_opp_no = omap_pm_vdd1_get_opp();
+				target_opp_no = get_vdd1_opp();
 			else if (srid == SR2)
-				target_opp_no = omap_pm_vdd2_get_opp();
+				target_opp_no = get_vdd2_opp();
 
 			if (!target_opp_no) {
 				pr_info("Current OPP unknown \
@@ -786,7 +840,7 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
 	if (value == 0) {
 		sr_stop_vddautocomap(SR1);
 	} else {
-		u32 current_vdd1opp_no = omap_pm_vdd1_get_opp();
+		u32 current_vdd1opp_no = get_vdd1_opp();
 		if (!current_vdd1opp_no) {
 			pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
 			return -EINVAL;
@@ -826,7 +880,7 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
 	if (value == 0) {
 		sr_stop_vddautocomap(SR2);
 	} else {
-		u32 current_vdd2opp_no = omap_pm_vdd2_get_opp();
+		u32 current_vdd2opp_no = get_vdd2_opp();
 		if (!current_vdd2opp_no) {
 			pr_err("sr_vdd2_autocomp: Current VDD2 opp unknown\n");
 			return -EINVAL;
-- 
1.6.0.4


--------------020801090206040008080705--
