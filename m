From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 3/8] DSPBRIDGE: Check input value
Date: Mon, 31 Aug 2009 15:14:31 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E54@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38699 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbZHaUOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:14:40 -0400
In-Reply-To: <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


Hi,
	Good finding.

	Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Thursday, August 27, 2009 7:19 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 3/8] DSPBRIDGE: Check input value
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Check input value before dereferencing it.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/wmd/tiomap3430.c |    7 ++++++-
> 1 files changed, 6 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
>b/drivers/dsp/bridge/wmd/tiomap3430.c
>index db48c49..4cb78c7 100644
>--- a/drivers/dsp/bridge/wmd/tiomap3430.c
>+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
>@@ -1266,11 +1266,16 @@ static DSP_STATUS WMD_DEV_Destroy(struct
>WMD_DEV_CONTEXT *hDevContext)
> 	DSP_STATUS status = DSP_SOK;
> 	struct WMD_DEV_CONTEXT *pDevContext = (struct WMD_DEV_CONTEXT *)
> 						hDevContext;
>+
>+	/* It should never happen */
>+	if (!hDevContext)
>+		return DSP_EHANDLE;
>+
> 	DBG_Trace(DBG_ENTER, "Entering WMD_DEV_Destroy:n hDevContext
>::0x%x\n",
> 		  hDevContext);
> 	/* first put the device to stop state */
> 	WMD_BRD_Delete(pDevContext);
>-	if (pDevContext && pDevContext->pPtAttrs) {
>+	if (pDevContext->pPtAttrs) {
> 		pPtAttrs = pDevContext->pPtAttrs;
> 		if (pPtAttrs->hCSObj)
> 			SYNC_DeleteCS(pPtAttrs->hCSObj);
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

