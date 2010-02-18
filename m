From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/12] DSPBRIDGE: Change custom GT_trace for dev_dbg in services
Date: Thu, 18 Feb 2010 15:37:56 -0600
Message-ID: <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757891Ab0BRVZb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:31 -0500
In-Reply-To: <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove GT_Trace custom debugging mechanism and use dev_dbg.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c    |    3 +--
 drivers/dsp/bridge/services/clk.c    |    5 ++---
 drivers/dsp/bridge/services/regsup.c |   21 +++++++++------------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index d26f8b9..295ff11 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -205,8 +205,7 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 	}
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
-		GT_0trace(CFG_debugMask, GT_6CLASS,
-			  "CFG_GetHostResources Failed \n");
+		dev_dbg(bridge, "%s Failed, status 0x%x\n", __func__, status);
 #endif
 	return status;
 }
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index f8c417a..04d49bd 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -275,9 +275,8 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 	if (pClk) {
 		clkSpeedHz = clk_get_rate(pClk);
 		*speedKhz = clkSpeedHz / 1000;
-		GT_2trace(CLK_debugMask, GT_6CLASS,
-			  "CLK_GetRate: clkSpeedHz = %d , "
-			 "speedinKhz=%d\n", clkSpeedHz, *speedKhz);
+		dev_dbg(bridge, "%s: clkSpeedHz = %d, speedinKhz = %d\n",
+					__func__, clkSpeedHz, *speedKhz);
 	} else {
 		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
 						SERVICES_Clks[clk_id].clk_name,
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 0c77fb2..04f6b3a 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -105,12 +105,7 @@ DSP_STATUS regsupGetValue(char *valName, void *pBuf, u32 *dataSize)
 						(struct list_head *) rv);
 	}
 
-	if (DSP_SUCCEEDED(retVal)) {
-		GT_2trace(REG_debugMask, GT_2CLASS, "G %s DATA %x ", valName,
-			  *(u32 *)pBuf);
-	} else {
-		GT_1trace(REG_debugMask, GT_3CLASS, "G %s FAILED\n", valName);
-	}
+	dev_dbg(bridge, "REG: get %s, status = 0x%x\n", valName, retVal);
 
 	return retVal;
 }
@@ -125,9 +120,6 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 	DSP_STATUS retVal = DSP_EFAIL;
 	struct RegValue *rv = (struct RegValue *) LST_First(pRegKey);
 
-	GT_2trace(REG_debugMask, GT_2CLASS, "S %s DATA %x ", valName,
-		  *(u32 *)pBuf);
-
 	/*  Need to search through the entries looking for the right one.  */
 	while (rv) {
 		/*  See if the name matches.  */
@@ -171,6 +163,8 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 		}
 	}
 
+	dev_dbg(bridge, "REG: set %s, status = 0x%x", valName, retVal);
+
 	return retVal;
 }
 
@@ -203,9 +197,6 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 			*pdwValueSize = strlen(&(rv->name[dwKeyLen]));
 			strncpy(pstrValue, &(rv->name[dwKeyLen]),
 				    *pdwValueSize + 1);
-			GT_3trace(REG_debugMask, GT_2CLASS,
-				  "E Key %s, Value %s, Data %x ",
-				  pstrKey, pstrValue, *(u32 *)pstrData);
 			/*  Set our status to good and exit.  */
 			retVal = DSP_SOK;
 			break;
@@ -217,6 +208,9 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 	if (count && DSP_FAILED(retVal))
 		retVal = REG_E_NOMOREITEMS;
 
+	dev_dbg(bridge, "REG: enum Key %s, Value %s, status = 0x%x",
+					pstrKey, pstrValue, retVal);
+
 	return retVal;
 }
 
@@ -248,6 +242,9 @@ DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 		rv = (struct RegValue *)LST_Next(pRegKey,
 				(struct list_head *)rv);
 	}
+
+	dev_dbg(bridge, "REG: del %s, status = 0x%x", pstrValue, retVal);
+
 	return retVal;
 
 }
-- 
1.6.2.4

