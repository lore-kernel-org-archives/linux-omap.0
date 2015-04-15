From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 14/35] ARM: OMAP2+: VC: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:01 +0300
Message-ID: <1429102402-5276-15-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbbDOMw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:52:56 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index be9ef83..c67bdc5 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -413,7 +413,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	voltdm->write(voltoffset, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
-static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
+static void omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
 	omap3_vc_init_pmic_signaling(voltdm);
 	omap3_set_off_timings(voltdm);
@@ -562,7 +562,7 @@ struct i2c_init_data {
 	u8 hsscll_12;
 };
 
-static const __initdata struct i2c_init_data omap4_i2c_timing_data[] = {
+static const struct i2c_init_data omap4_i2c_timing_data[] = {
 	{
 		.load = 50,
 		.loadbits = 0x3,
@@ -610,7 +610,7 @@ static const __initdata struct i2c_init_data omap4_i2c_timing_data[] = {
  * Pre-calculated values are provided in data tables, as it is not
  * too straightforward to calculate these runtime.
  */
-static void __init omap4_vc_i2c_timing_init(struct voltagedomain *voltdm)
+static void omap4_vc_i2c_timing_init(struct voltagedomain *voltdm)
 {
 	u32 capacitance;
 	u32 val;
@@ -690,7 +690,7 @@ static void __init omap4_vc_i2c_timing_init(struct voltagedomain *voltdm)
  * channel registers.  All other VC channels will use the
  * same configuration.
  */
-static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
+static void omap_vc_i2c_init(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 	static bool initialized;
@@ -761,7 +761,7 @@ void __init omap_pm_setup_sr_i2c_pcb_length(u32 mm)
 }
 #endif
 
-void __init omap_vc_init_channel(struct voltagedomain *voltdm)
+void omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 	u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
-- 
1.7.9.5

