From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 2/2] OMAP3: PM: Configure CPUidle
 latencies/thresholds from board file
Date: Fri, 16 Oct 2009 11:53:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A46D26A@dbde02.ent.ti.com>
References: <1255618130-14005-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51784 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbZJPGYl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 02:24:41 -0400
In-Reply-To: <1255618130-14005-2-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>

I missed updating omap_init_power_states() to look into cpuidle_params_table
at init, as part of this patch. Will send a fixed patch shortly.
Thanks to Thara for catching this.

>-----Original Message-----
>From: Nayak, Rajendra 
>Sent: Thursday, October 15, 2009 8:19 PM
>To: linux-omap@vger.kernel.org
>Cc: khilman@deeprootsystems.com; Nayak, Rajendra
>Subject: [PATCH v2 2/2] OMAP3: PM: Configure CPUidle 
>latencies/thresholds from board file
>
>The CPUidle C state latencies and thresholds are dependent
>on various board specific details.
>This patch makes it possible to configure these values from the
>respective board files.
>
>omap3_pm_init_cpuidle() can now be optionally called from board
>files to pass board specific cpuidle parameters.
>If the board files do not use this function to pass the params
>default values are used which might cause higher consumption
>dur to wrong state selection by the governor.
>
>This patch only updates the 3430sdp board files to use
>omap3_pm_init_cpuidle().
>
>Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>---
> arch/arm/mach-omap2/board-3430sdp.c |   19 +++++++++++++++
> arch/arm/mach-omap2/cpuidle34xx.c   |   42 
>+++++++++++++++++++++++++++++++++++
> arch/arm/mach-omap2/pm.h            |    8 ++++++
> 3 files changed, 69 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/board-3430sdp.c 
>b/arch/arm/mach-omap2/board-3430sdp.c
>index 0f1975c..d2b2f8f 100644
>--- a/arch/arm/mach-omap2/board-3430sdp.c
>+++ b/arch/arm/mach-omap2/board-3430sdp.c
>@@ -73,6 +73,24 @@ static struct prm_setup_vc omap3_setuptime_table = {
> 	.vdd1_off = 0x00,
> };
> 
>+/* FIXME: These values need to be updated based on more 
>profiling on 3430sdp*/
>+static struct cpuidle_params omap3_cpuidle_params_table[] = {
>+	/* C1 */
>+	{2, 2, 5},
>+	/* C2 */
>+	{10, 10, 30},
>+	/* C3 */
>+	{50, 50, 300},
>+	/* C4 */
>+	{1500, 1800, 4000},
>+	/* C5 */
>+	{2500, 7500, 12000},
>+	/* C6 */
>+	{3000, 8500, 15000},
>+	/* C7 */
>+	{10000, 30000, 300000},
>+};
>+
> static int board_keymap[] = {
> 	KEY(0, 0, KEY_LEFT),
> 	KEY(0, 1, KEY_RIGHT),
>@@ -203,6 +221,7 @@ static void __init omap_3430sdp_init_irq(void)
> 	omap_board_config = sdp3430_config;
> 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
> 	omap3_pm_init_vc(&omap3_setuptime_table);
>+	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, 
>omap3_mpu_rate_table,
> 			     omap3_dsp_rate_table, omap3_l3_rate_table);
> 	omap_init_irq();
>diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
>b/arch/arm/mach-omap2/cpuidle34xx.c
>index c44a942..f5d8f55 100644
>--- a/arch/arm/mach-omap2/cpuidle34xx.c
>+++ b/arch/arm/mach-omap2/cpuidle34xx.c
>@@ -60,6 +60,30 @@ struct omap3_processor_cx 
>omap3_power_states[OMAP3_MAX_STATES];
> struct omap3_processor_cx current_cx_state;
> struct powerdomain *mpu_pd, *core_pd, *per_pd;
> 
>+/*
>+ * The latencies/thresholds for various C states have
>+ * to be configured from the respective board files.
>+ * These are some default values (which might not provide
>+ * the best power savings) used on boards which do not
>+ * pass these details from the board file.
>+ */
>+static struct cpuidle_params cpuidle_params_table[] = {
>+	/* C1 */
>+	{2, 2, 5},
>+	/* C2 */
>+	{10, 10, 30},
>+	/* C3 */
>+	{50, 50, 300},
>+	/* C4 */
>+	{1500, 1800, 4000},
>+	/* C5 */
>+	{2500, 7500, 12000},
>+	/* C6 */
>+	{3000, 8500, 15000},
>+	/* C7 */
>+	{10000, 30000, 300000},
>+};
>+
> static int omap3_idle_bm_check(void)
> {
> 	if (!omap3_can_sleep())
>@@ -165,6 +189,24 @@ static int omap3_enter_idle_bm(struct 
>cpuidle_device *dev,
> 
> DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> 
>+void omap3_pm_init_cpuidle(struct cpuidle_params 
>*cpuidle_board_params)
>+{
>+	int i;
>+
>+	if (!cpuidle_board_params)
>+		return;
>+
>+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
>+		cpuidle_params_table[i].sleep_latency =
>+			cpuidle_board_params[i].sleep_latency;
>+		cpuidle_params_table[i].wake_latency =
>+			cpuidle_board_params[i].wake_latency;
>+		cpuidle_params_table[i].threshold =
>+			cpuidle_board_params[i].threshold;
>+	}
>+	return;
>+}
>+
> /* omap3_init_power_states - Initialises the OMAP3 specific C states.
>  *
>  * Below is the desciption of each C state.
>diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>index ca673c5..0b814ab 100644
>--- a/arch/arm/mach-omap2/pm.h
>+++ b/arch/arm/mach-omap2/pm.h
>@@ -41,7 +41,15 @@ struct prm_setup_vc {
> 	u16 vdd1_ret;
> 	u16 vdd1_off;
> };
>+
>+struct cpuidle_params {
>+	u32 sleep_latency;
>+	u32 wake_latency;
>+	u32 threshold;
>+};
>+
> extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
>+extern void omap3_pm_init_cpuidle(struct cpuidle_params 
>*cpuidle_board_params);
> 
> extern int resource_set_opp_level(int res, u32 target_level, 
>int flags);
> extern int resource_access_opp_lock(int res, int delta);
>-- 
>1.5.4.7
>
>