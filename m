From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [RFC][HACK]DSPBRIDGE: Get clock handles using clk_get_sys
Date: Wed, 19 Aug 2009 19:07:16 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530425A86577@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40692 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbZHTAHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 20:07:21 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7K07IHJ013444
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 19:07:23 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n7K07IFO012983
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 19:07:18 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n7K07I77012760
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 19:07:18 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

Hi,

Does anyone now if there is a cleaner way to enable/disable mcbsp clocks using 2.6.31 clock framework?

---

Replace previous id field used to reference clocks with the same
name by placing the device name associated with them. To use this
scheme the clocks handles need to be requested using clk_get_sys
function.

As McBSP clocks are the only ones used by bridge that have a device
associated with them, the names are hard coded in our own clock
module and clock handles are requested on behalf of mcbsp driver
for the dsp to use.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/clk.c |  114 ++++++++++++++++++-------------------
 1 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index ff2ceea..1953a46 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -63,39 +63,39 @@ typedef volatile unsigned long  REG_UWORD32;
 struct SERVICES_Clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
-	int id;
+	const char *dev;
 };
 
 /* The row order of the below array needs to match with the clock enumerations
  * 'SERVICES_ClkId' provided in the header file.. any changes in the
  * enumerations needs to be fixed in the array as well */
 static struct SERVICES_Clk_t SERVICES_Clks[] = {
-	{NULL, "iva2_ck", -1},
-	{NULL, "mailboxes_ick", -1},
-	{NULL, "gpt5_fck", -1},
-	{NULL, "gpt5_ick", -1},
-	{NULL, "gpt6_fck", -1},
-	{NULL, "gpt6_ick", -1},
-	{NULL, "gpt7_fck", -1},
-	{NULL, "gpt7_ick", -1},
-	{NULL, "gpt8_fck", -1},
-	{NULL, "gpt8_ick", -1},
-	{NULL, "wdt_fck", 3},
-	{NULL, "wdt_ick", 3},
-	{NULL, "mcbsp_fck", 1},
-	{NULL, "mcbsp_ick", 1},
-	{NULL, "mcbsp_fck", 2},
-	{NULL, "mcbsp_ick", 2},
-	{NULL, "mcbsp_fck", 3},
-	{NULL, "mcbsp_ick", 3},
-	{NULL, "mcbsp_fck", 4},
-	{NULL, "mcbsp_ick", 4},
-	{NULL, "mcbsp_fck", 5},
-	{NULL, "mcbsp_ick", 5},
-	{NULL, "ssi_ssr_sst_fck", -1},
-	{NULL, "ssi_ick", -1},
-	{NULL, "omap_32k_fck", -1},
-	{NULL, "sys_ck", -1},
+	{NULL, "iva2_ck", NULL},
+	{NULL, "mailboxes_ick", NULL},
+	{NULL, "gpt5_fck", NULL},
+	{NULL, "gpt5_ick", NULL},
+	{NULL, "gpt6_fck", NULL},
+	{NULL, "gpt6_ick", NULL},
+	{NULL, "gpt7_fck", NULL},
+	{NULL, "gpt7_ick", NULL},
+	{NULL, "gpt8_fck", NULL},
+	{NULL, "gpt8_ick", NULL},
+	{NULL, "wdt3_fck", NULL},
+	{NULL, "wdt3_ick", NULL},
+	{NULL, "fck", "omap-mcbsp.1"},
+	{NULL, "ick", "omap-mcbsp.1"},
+	{NULL, "fck", "omap-mcbsp.2"},
+	{NULL, "ick", "omap-mcbsp.2"},
+	{NULL, "fck", "omap-mcbsp.3"},
+	{NULL, "ick", "omap-mcbsp.3"},
+	{NULL, "fck", "omap-mcbsp.4"},
+	{NULL, "ick", "omap-mcbsp.4"},
+	{NULL, "fck", "omap-mcbsp.5"},
+	{NULL, "ick", "omap-mcbsp.5"},
+	{NULL, "ssi_ssr_sst_fck", NULL},
+	{NULL, "ssi_ick", NULL},
+	{NULL, "omap_32k_fck", NULL},
+	{NULL, "sys_ck", NULL},
 	{NULL, ""}
 };
 
@@ -148,24 +148,22 @@ bool CLK_Init(void)
 	/* Get the clock handles from base port and store locally */
 	while (i < SERVICESCLK_NOT_DEFINED) {
 		/* get the handle from BP */
-		dspbridge_device.id = SERVICES_Clks[i].id;
-
-		clk_handle = clk_get(&dspbridge_device.dev,
+		clk_handle = clk_get_sys(SERVICES_Clks[i].dev,
 			     SERVICES_Clks[i].clk_name);
 
 		if (!clk_handle) {
 			GT_2trace(CLK_debugMask, GT_7CLASS,
 				  "CLK_Init: failed to get Clk handle %s, "
-				  "CLK dev id = %d\n",
+				  "CLK dev id = %s\n",
 				  SERVICES_Clks[i].clk_name,
-				  SERVICES_Clks[i].id);
+				  SERVICES_Clks[i].dev);
 			/* should we fail here?? */
 		} else {
 			GT_2trace(CLK_debugMask, GT_7CLASS,
 				  "CLK_Init: PASS and Clk handle %s, "
-				  "CLK dev id = %d\n",
+				  "CLK dev id = %s\n",
 				  SERVICES_Clks[i].clk_name,
-				  SERVICES_Clks[i].id);
+				  SERVICES_Clks[i].dev);
 		}
 		SERVICES_Clks[i].clk_handle = clk_handle;
 		i++;
@@ -187,8 +185,8 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
-		"CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
+		"CLK dev id = %s\n", SERVICES_Clks[clk_id].clk_name,
+		SERVICES_Clks[clk_id].dev);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
@@ -196,15 +194,15 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 			/* Success ? */
 		} else {
 			pr_err("CLK_Enable: failed to Enable CLK %s, "
-					"CLK dev id = %d\n",
+					"CLK dev id = %s\n",
 					SERVICES_Clks[clk_id].clk_name,
-					SERVICES_Clks[clk_id].id);
+					SERVICES_Clks[clk_id].dev);
 			status = DSP_EFAIL;
 		}
 	} else {
-		pr_err("CLK_Enable: failed to get CLK %s, CLK dev id = %d\n",
+		pr_err("CLK_Enable: failed to get CLK %s, CLK dev id = %s\n",
 					SERVICES_Clks[clk_id].clk_name,
-					SERVICES_Clks[clk_id].id);
+					SERVICES_Clks[clk_id].dev);
 		status = DSP_EFAIL;
 	}
 	/* The SSI module need to configured not to have the Forced idle for
@@ -233,16 +231,16 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK %s, "
-		"CLK dev id = %d is setting to 32KHz \n",
+		"CLK dev id = %s is setting to 32KHz \n",
 		SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
+		SERVICES_Clks[clk_id].dev);
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (!(clk_set_parent(pClk, pClkParent) == 0x0)) {
 		       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Set_32KHz: "
-				"Failed to set to 32KHz %s, CLK dev id = %d\n",
+				"Failed to set to 32KHz %s, CLK dev id = %s\n",
 				SERVICES_Clks[clk_id].clk_name,
-				SERVICES_Clks[clk_id].id);
+				SERVICES_Clks[clk_id].dev);
 			status = DSP_EFAIL;
 		}
 	}
@@ -263,22 +261,22 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Disable: CLK %s, "
-		"CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
+		"CLK dev id = %s\n", SERVICES_Clks[clk_id].clk_name,
+		SERVICES_Clks[clk_id].dev);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 
 	clkUseCnt = CLK_Get_UseCnt(clk_id);
 	if (clkUseCnt == -1) {
 		pr_err("CLK_Disable: failed to get CLK Use count for CLK %s,"
-				"CLK dev id = %d\n",
+				"CLK dev id = %s\n",
 				SERVICES_Clks[clk_id].clk_name,
-				SERVICES_Clks[clk_id].id);
+				SERVICES_Clks[clk_id].dev);
 	} else if (clkUseCnt == 0) {
 		GT_2trace(CLK_debugMask, GT_4CLASS, "CLK_Disable: CLK %s,"
-				"CLK dev id= %d is already disabled\n",
+				"CLK dev id= %s is already disabled\n",
 				SERVICES_Clks[clk_id].clk_name,
-				SERVICES_Clks[clk_id].id);
+				SERVICES_Clks[clk_id].dev);
 		return status;
 	}
 	if (clk_id == SERVICESCLK_ssi_ick)
@@ -288,9 +286,9 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 			clk_disable(pClk);
 		} else {
 			pr_err("CLK_Disable: failed to get CLK %s,"
-					"CLK dev id = %d\n",
+					"CLK dev id = %s\n",
 					SERVICES_Clks[clk_id].clk_name,
-					SERVICES_Clks[clk_id].id);
+					SERVICES_Clks[clk_id].dev);
 			status = DSP_EFAIL;
 		}
 	return status;
@@ -313,8 +311,8 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 	*speedKhz = 0x0;
 
 	GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_GetRate: CLK %s, "
-		"CLK dev Id = %d \n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
+		"CLK dev Id = %s \n", SERVICES_Clks[clk_id].clk_name,
+		SERVICES_Clks[clk_id].dev);
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		clkSpeedHz = clk_get_rate(pClk);
@@ -325,8 +323,8 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 	} else {
 		GT_2trace(CLK_debugMask, GT_7CLASS,
 			 "CLK_GetRate: failed to get CLK %s, "
-			 "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
-			 SERVICES_Clks[clk_id].id);
+			 "CLK dev Id = %s\n", SERVICES_Clks[clk_id].clk_name,
+			 SERVICES_Clks[clk_id].dev);
 		status = DSP_EFAIL;
 	}
 	return status;
@@ -346,8 +344,8 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 	} else {
 		GT_2trace(CLK_debugMask, GT_7CLASS,
 			 "CLK_GetRate: failed to get CLK %s, "
-			 "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
-			 SERVICES_Clks[clk_id].id);
+			 "CLK dev Id = %s\n", SERVICES_Clks[clk_id].clk_name,
+			 SERVICES_Clks[clk_id].dev);
 		status = DSP_EFAIL;
 	}
 	return useCount;
-- 
1.6.2.4

