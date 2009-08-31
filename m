From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 5/8] dspbridge: Check pointer before dereferencing it
Date: Mon, 31 Aug 2009 15:20:25 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E62@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56900 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbZHaUUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:20:32 -0400
In-Reply-To: <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


It looks good.

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Thursday, August 27, 2009 7:19 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 5/8] dspbridge: Check pointer before dereferencing it
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/nldr.c |   15 ++++++++++++++-
> 1 files changed, 14 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/nldr.c
>b/drivers/dsp/bridge/rmgr/nldr.c
>index 79f7505..8c162a1 100644
>--- a/drivers/dsp/bridge/rmgr/nldr.c
>+++ b/drivers/dsp/bridge/rmgr/nldr.c
>@@ -1560,6 +1560,13 @@ static DSP_STATUS LoadOvly(struct NLDR_NODEOBJECT
>*hNldrNode,
> 	}
>
> 	DBC_Assert(i < hNldr->nOvlyNodes);
>+
>+	if (!pONode) {
>+		/* Should we print warning here? */
>+		status = DSP_ENOTFOUND;
>+		goto func_end;
>+	}
>+
> 	switch (phase) {
> 	case NLDR_CREATE:
> 		pRefCount = &(pONode->createRef);
>@@ -1877,6 +1884,13 @@ static void UnloadOvly(struct NLDR_NODEOBJECT
>*hNldrNode, enum NLDR_PHASE phase)
> 	}
>
> 	DBC_Assert(i < hNldr->nOvlyNodes);
>+
>+	if (!pONode) {
>+		/* Should we print warning here? */
>+		status = DSP_ENOTFOUND;
>+		goto func_end;
>+	}
>+
> 	switch (phase) {
> 	case NLDR_CREATE:
> 		pRefCount = &(pONode->createRef);
>@@ -1917,7 +1931,6 @@ static void UnloadOvly(struct NLDR_NODEOBJECT
>*hNldrNode, enum NLDR_PHASE phase)
> 	}
> 	if (pOtherRef && *pOtherRef == 0)
> 		FreeSects(hNldr, pOtherSects, nOtherAlloc);
>-
> }
>
> /*
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

