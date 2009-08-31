From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/8] dspbridge: Drop useless memory allocation
Date: Mon, 31 Aug 2009 15:49:37 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E96@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZHaUtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:49:43 -0400
In-Reply-To: <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
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
>Subject: [PATCH 2/8] dspbridge: Drop useless memory allocation
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>strcmp() should do the job without additional memory allocation and
>strncpy()/strcmp() calls.
>
>Additionally fix spelling.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/node.c |   15 ++++-----------
> 1 files changed, 4 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/node.c
>b/drivers/dsp/bridge/rmgr/node.c
>index d3f0e34..e213b22 100644
>--- a/drivers/dsp/bridge/rmgr/node.c
>+++ b/drivers/dsp/bridge/rmgr/node.c
>@@ -404,7 +404,6 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT
>*hProcessor,
> 	DSP_STATUS status = DSP_SOK;
> 	struct CMM_OBJECT *hCmmMgr = NULL; /* Shared memory manager hndl */
> 	u32 procId;
>-	char *label;
> 	u32 pulValue;
> 	u32 dynextBase;
> 	u32 offSet = 0;
>@@ -691,18 +690,16 @@ func_cont2:
> 		}
> 	}
>
>-	/* Comapare value read from Node Properties and check if it is same
>as
>+	/* Compare value read from Node Properties and check if it is same as
> 	 * STACKSEGLABEL, if yes read the Address of STACKSEGLABEL, calculate
> 	 * GPP Address, Read the value in that address and override the
> 	 * uStackSeg value in task args */
> 	if (DSP_SUCCEEDED(status) &&
> 	   (char *)pNode->dcdProps.objData.nodeObj.ndbProps.uStackSegName !=
> 	   NULL) {
>-		label = MEM_Calloc(sizeof(STACKSEGLABEL)+1, MEM_PAGED);
>-               strncpy(label, STACKSEGLABEL, sizeof(STACKSEGLABEL)+1);
>-
>-               if (strcmp((char *)pNode->dcdProps.objData.nodeObj.
>-				     ndbProps.uStackSegName, label) == 0) {
>+		if (strcmp((char *)
>+		    pNode->dcdProps.objData.nodeObj.ndbProps.uStackSegName,
>+		    STACKSEGLABEL) == 0) {
> 			status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
> 				 hNldrNode, "DYNEXT_BEG", &dynextBase);
> 			if (DSP_FAILED(status)) {
>@@ -744,10 +741,6 @@ func_cont2:
> 				ulStackSegVal;
>
> 		}
>-
>-		if (label)
>-			MEM_Free(label);
>-
> 	}
>
>
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

