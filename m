From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 6/8] dspbridge: Check status before use return value
Date: Mon, 31 Aug 2009 15:21:06 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E64@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35701 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbZHaUVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:21:14 -0400
In-Reply-To: <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
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
>Subject: [PATCH 6/8] dspbridge: Check status before use return value
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/drv.c |   14 ++++++++++++--
> 1 files changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index bedc34c..44d7f2d 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -825,7 +825,13 @@ DSP_STATUS DRV_ProcDisplayResInfo(u8 *pBuf1, u32
>*pSize)
> 	u32 tempStrLen = 0, tempStrLen2 = 0;
> 	DSP_STATUS status = DSP_SOK;
>
>-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>+	if (DSP_FAILED(CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT))) {
>+		/* Should we print something? */
>+		*pBuf1 = 0;
>+		*pSize = 0;
>+		return DSP_EHANDLE;
>+	}
>+
> 	DRV_GetProcCtxtList(&pCtxt, (struct DRV_OBJECT *)hDrvObject);
> 	GT_0trace(curTrace, GT_ENTER, "*********************"
> 		 "DRV_ProcDisplayResourceInfo:*\n");
>@@ -954,8 +960,12 @@ static DSP_STATUS PrintProcessInformation(void)
> 	u32 tempCount;
> 	u32  procID;
>
>+	if (DSP_FAILED(CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT))) {
>+		/* Should we print something? */
>+		return DSP_EHANDLE;
>+	}
>+
> 	/* Get the Process context list */
>-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> 	DRV_GetProcCtxtList(&pCtxtList, hDrvObject);
> 	GT_0trace(curTrace, GT_4CLASS, "\n### Debug information"
> 			" for DSP bridge ##\n");
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

