From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 4/8] dspbridge: Check pointer returned by MEM_Calloc()
Date: Mon, 31 Aug 2009 15:19:42 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E60@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbZHaUTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:19:51 -0400
In-Reply-To: <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>



Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Thursday, August 27, 2009 7:19 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 4/8] dspbridge: Check pointer returned by MEM_Calloc()
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>In case of NULL return DSP_EMEMORY status instead of DSP_SOK.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/drv.c |   23 +++++++++++++----------
> 1 files changed, 13 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index 691c727..bedc34c 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -1571,17 +1571,18 @@ static DSP_STATUS RequestBridgeResources(u32
>dwContext, s32 bRequest)
> 		/* Releasing resources by deleting the registry key  */
> 		dwBuffSize = sizeof(struct CFG_HOSTRES);
> 		pResources = MEM_Calloc(dwBuffSize, MEM_NONPAGED);
>-		if (DSP_FAILED(REG_GetValue(NULL, (char *)driverExt->szString,
>-		   CURRENTCONFIG, (u8 *)pResources, &dwBuffSize))) {
>-			status = CFG_E_RESOURCENOTAVAIL;
>-			GT_0trace(curTrace, GT_1CLASS,
>-				 "REG_GetValue Failed \n");
>-		} else {
>-			GT_0trace(curTrace, GT_1CLASS,
>-				 "REG_GetValue Succeeded \n");
>-		}
>-
> 		if (pResources != NULL) {
>+			if (DSP_FAILED(REG_GetValue(NULL,
>+			    (char *) driverExt->szString,
>+			    CURRENTCONFIG, (u8 *) pResources, &dwBuffSize))) {
>+				status = CFG_E_RESOURCENOTAVAIL;
>+				GT_0trace(curTrace, GT_1CLASS,
>+					 "REG_GetValue Failed \n");
>+			} else {
>+				GT_0trace(curTrace, GT_1CLASS,
>+					 "REG_GetValue Succeeded \n");
>+			}
>+
> 			dwBuffSize = sizeof(shm_size);
> 			status = REG_GetValue(NULL, CURRENTCONFIG, SHMSIZE,
> 				(u8 *)&shm_size, &dwBuffSize);
>@@ -1646,6 +1647,8 @@ static DSP_STATUS RequestBridgeResources(u32
>dwContext, s32 bRequest)
> 				 (u32)dwBuffSize);
> 			/*  Set all the other entries to NULL */
> 			MEM_Free(pResources);
>+		} else {
>+			status = DSP_EMEMORY;
> 		}
> 		GT_0trace(curTrace, GT_ENTER, " <- RequestBridgeResources \n");
> 		return status;
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

