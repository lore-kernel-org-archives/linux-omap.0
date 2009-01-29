From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH] DSPBRIDGE: Fix for clock handles
Date: Wed, 28 Jan 2009 18:39:45 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA4D94@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44073 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbZA2Ajx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 19:39:53 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0T0dkvR017144
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 18:39:52 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0T0dkBv017330
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 18:39:46 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez <x00omar@ti.com>
Date: Wed, 28 Jan 2009 13:10:41 -0600
Subject: [PATCH] DSPBRIDGE: Fix for clock handles

Clock framework changes were returning wrong clock handles
for mcbsp which caused DASF codec to fail. This patch will
make bridge to request the clock based on the clock id.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/services/clk.c |  167 ++++++++++++++++++++-----------------
 1 files changed, 89 insertions(+), 78 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index b469509..225d14c 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -65,48 +65,42 @@ typedef volatile unsigned long  REG_UWORD32;
 struct SERVICES_Clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
+	int id;
 };
 
 /* The row order of the below array needs to match with the clock enumerations
  * 'SERVICES_ClkId' provided in the header file.. any changes in the
  * enumerations needs to be fixed in the array as well */
 static struct SERVICES_Clk_t SERVICES_Clks[] = {
-	{NULL, "iva2_ck"},
-	{NULL, "mailboxes_ick"},
-	{NULL, "gpt5_fck"},
-	{NULL, "gpt5_ick"},
-	{NULL, "gpt6_fck"},
-	{NULL, "gpt6_ick"},
-	{NULL, "gpt7_fck"},
-	{NULL, "gpt7_ick"},
-	{NULL, "gpt8_fck"},
-	{NULL, "gpt8_ick"},
-	{NULL, "wdt_fck"},
-	{NULL, "wdt_ick"},
-	{NULL, "mcbsp1_fck"},
-	{NULL, "mcbsp1_ick"},
-	{NULL, "mcbsp2_fck"},
-	{NULL, "mcbsp2_ick"},
-	{NULL, "mcbsp3_fck"},
-	{NULL, "mcbsp3_ick"},
-	{NULL, "mcbsp4_fck"},
-	{NULL, "mcbsp4_ick"},
-	{NULL, "mcbsp5_fck"},
-	{NULL, "mcbsp5_ick"},
-	{NULL, "ssi_ssr_sst_fck"},
-	{NULL, "ssi_ick"},
-	{NULL, "omap_32k_fck"},
-	{NULL, "sys_ck"},
+	{NULL, "iva2_ck", -1},
+	{NULL, "mailboxes_ick", -1},
+	{NULL, "gpt5_fck", -1},
+	{NULL, "gpt5_ick", -1},
+	{NULL, "gpt6_fck", -1},
+	{NULL, "gpt6_ick", -1},
+	{NULL, "gpt7_fck", -1},
+	{NULL, "gpt7_ick", -1},
+	{NULL, "gpt8_fck", -1},
+	{NULL, "gpt8_ick", -1},
+	{NULL, "wdt_fck", 3},
+	{NULL, "wdt_ick", 3},
+	{NULL, "mcbsp_fck", 1},
+	{NULL, "mcbsp_ick", 1},
+	{NULL, "mcbsp_fck", 2},
+	{NULL, "mcbsp_ick", 2},
+	{NULL, "mcbsp_fck", 3},
+	{NULL, "mcbsp_ick", 3},
+	{NULL, "mcbsp_fck", 4},
+	{NULL, "mcbsp_ick", 4},
+	{NULL, "mcbsp_fck", 5},
+	{NULL, "mcbsp_ick", 5},
+	{NULL, "ssi_ssr_sst_fck", -1},
+	{NULL, "ssi_ick", -1},
+	{NULL, "omap_32k_fck", -1},
+	{NULL, "sys_ck", -1},
 	{NULL, ""}
 };
 
-
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-extern struct platform_device dspbridge_device;
-#endif
-
-
-
 /* Generic TIMER object: */
 struct TIMER_OBJECT {
 	struct timer_list timer;
@@ -145,30 +139,35 @@ void CLK_Exit(void)
  */
 bool CLK_Init(void)
 {
+	static struct platform_device dspbridge_device;
 	struct clk *clk_handle;
 	int i = 0;
 	GT_create(&CLK_debugMask, "CK");	/* CK for CLK */
 	GT_0trace(CLK_debugMask, GT_5CLASS, "CLK_Init\n");
 
+	dspbridge_device.dev.bus = &platform_bus_type;
+
 	/* Get the clock handles from base port and store locally */
 	while (i < SERVICESCLK_NOT_DEFINED) {
 		/* get the handle from BP */
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+		dspbridge_device.id = SERVICES_Clks[i].id;
+
 		clk_handle = clk_get(&dspbridge_device.dev,
 			     SERVICES_Clks[i].clk_name);
-#else
-		clk_handle = clk_get(NULL, SERVICES_Clks[i].clk_name);
-#endif
 
 		if (!clk_handle) {
-			GT_1trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Init: failed to get Clk "
-				  "handle %s \n", SERVICES_Clks[i].clk_name);
+			GT_2trace(CLK_debugMask, GT_7CLASS,
+				  "CLK_Init: failed to get Clk handle %s, "
+				  "CLK dev id = %d\n",
+				  SERVICES_Clks[i].clk_name,
+				  SERVICES_Clks[i].id);
 			/* should we fail here?? */
 		} else {
-			GT_1trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Init: PASS and Clk handle"
-				  "%s \n", SERVICES_Clks[i].clk_name);
+			GT_2trace(CLK_debugMask, GT_7CLASS,
+				  "CLK_Init: PASS and Clk handle %s, "
+				  "CLK dev id = %d\n",
+				  SERVICES_Clks[i].clk_name,
+				  SERVICES_Clks[i].id);
 		}
 		SERVICES_Clks[i].clk_handle = clk_handle;
 		i++;
@@ -189,23 +188,27 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 	struct clk *pClk;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_1trace(CLK_debugMask, GT_6CLASS,
-		  "CLK_Enable: CLK Id = 0x%x \n", clk_id);
+	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
+		 "CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
+		 SERVICES_Clks[clk_id].id);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (clk_enable(pClk) == 0x0) {
 			/* Success ? */
 		} else {
-			GT_1trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Enable: failed to Enable "
-				  "CLK %s \n", SERVICES_Clks[clk_id].clk_name);
+			GT_2trace(CLK_debugMask, GT_7CLASS,
+				  "CLK_Enable: failed to Enable CLK %s, "
+				  "CLK dev id = %d\n",
+				  SERVICES_Clks[clk_id].clk_name,
+				  SERVICES_Clks[clk_id].id);
 			status = DSP_EFAIL;
 		}
 	} else {
-		GT_1trace(CLK_debugMask, GT_7CLASS,
-			  "CLK_Enable: failed to get "
-			  "CLK %s \n", SERVICES_Clks[clk_id].clk_name);
+		GT_2trace(CLK_debugMask, GT_7CLASS,
+			  "CLK_Enable: failed to get CLK %s, CLK dev id = %d\n",
+			  SERVICES_Clks[clk_id].clk_name,
+			  SERVICES_Clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	/* The SSI module need to configured not to have the Forced idle for
@@ -233,15 +236,17 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	pClkParent =  SERVICES_Clks[sys_32k_id].clk_handle;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_1trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK Id  = 0x%x is "
-		  "setting to 32KHz \n", clk_id);
+	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK %s, "
+		 "CLK dev id = %d is setting to 32KHz \n",
+		 SERVICES_Clks[clk_id].clk_name,
+		 SERVICES_Clks[clk_id].id);
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (!(clk_set_parent(pClk, pClkParent) == 0x0)) {
-			GT_1trace(CLK_debugMask, GT_7CLASS,
-				 "CLK_Set_32KHz: Failed to "
-				 "set to 32KHz %s \n",
-				 SERVICES_Clks[clk_id].clk_name);
+			GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Set_32KHz: "
+				 "Failed to set to 32KHz %s, CLK dev id = %d\n",
+				 SERVICES_Clks[clk_id].clk_name,
+				 SERVICES_Clks[clk_id].id);
 			status = DSP_EFAIL;
 		}
 	}
@@ -261,21 +266,23 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 	s32 clkUseCnt;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_1trace(CLK_debugMask, GT_6CLASS,
-		  "CLK_Disable: CLK Id = 0x%x \n", clk_id);
+	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Disable: CLK %s, "
+		 "CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
+		 SERVICES_Clks[clk_id].id);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 
 	clkUseCnt = CLK_Get_UseCnt(clk_id);
 	if (clkUseCnt == -1) {
-		GT_1trace(CLK_debugMask, GT_7CLASS,
-			  "CLK_Disable: failed to get "
-			  "CLK Use count for Clk %s \n",
-			  SERVICES_Clks[clk_id].clk_name);
+		GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: failed to "
+			 "get CLK Use count for CLK %s, CLK dev id = %d\n",
+			 SERVICES_Clks[clk_id].clk_name,
+			 SERVICES_Clks[clk_id].id);
 	} else if (clkUseCnt == 0) {
-		GT_1trace(CLK_debugMask, GT_7CLASS,
-			  "CLK_Disable:  Clk %s  is already"
-			  "disabled\n", SERVICES_Clks[clk_id].clk_name);
+		GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: CLK %s, "
+			 "CLK dev id= %d is already disabled\n",
+			 SERVICES_Clks[clk_id].clk_name,
+			 SERVICES_Clks[clk_id].id);
 		 return status;
 	}
 	if (clk_id == SERVICESCLK_ssi_ick)
@@ -284,9 +291,10 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 		if (pClk) {
 			clk_disable(pClk);
 		} else {
-			GT_1trace(CLK_debugMask, GT_7CLASS,
-				  "CLK_Disable: failed to get "
-				  "CLK %s \n", SERVICES_Clks[clk_id].clk_name);
+			GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: "
+				 "failed to get CLK %s, CLK dev id = %d\n",
+				 SERVICES_Clks[clk_id].clk_name,
+				 SERVICES_Clks[clk_id].id);
 			status = DSP_EFAIL;
 		}
 	return status;
@@ -308,19 +316,21 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	*speedKhz = 0x0;
 
-	GT_1trace(CLK_debugMask, GT_7CLASS,
-		  "CLK_GetRate: CLK Id = 0x%x \n", clk_id);
+	GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_GetRate: CLK %s, "
+		 "CLK dev Id = %d \n", SERVICES_Clks[clk_id].clk_name,
+		 SERVICES_Clks[clk_id].id);
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		clkSpeedHz = clk_get_rate(pClk);
 		*speedKhz = clkSpeedHz / 1000;
 		GT_2trace(CLK_debugMask, GT_6CLASS,
 			  "CLK_GetRate: clkSpeedHz = %d , "
-			  "speedinKhz=%d \n", clkSpeedHz, *speedKhz);
+			  "speedinKhz=%d\n", clkSpeedHz, *speedKhz);
 	} else {
-		GT_1trace(CLK_debugMask, GT_7CLASS,
-			  "CLK_GetRate: failed to get CLK %s\n",
-			  SERVICES_Clks[clk_id].clk_name);
+		GT_2trace(CLK_debugMask, GT_7CLASS,
+			  "CLK_GetRate: failed to get CLK %s, "
+			  "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
+			  SERVICES_Clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	return status;
@@ -338,9 +348,10 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 	if (pClk) {
 		useCount =  clk_get_usecount(pClk);
 	} else {
-		GT_1trace(CLK_debugMask, GT_7CLASS,
-			  "CLK_GetRate: failed to get "
-			  "CLK %s \n", SERVICES_Clks[clk_id].clk_name);
+		GT_2trace(CLK_debugMask, GT_7CLASS,
+			  "CLK_GetRate: failed to get CLK %s, "
+			  "CLK dev Id = %d\n", SERVICES_Clks[clk_id].clk_name,
+			  SERVICES_Clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	return useCount;
-- 
1.5.4.3
