From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: don't use potential invalid pointer
Date: Mon, 14 Sep 2009 20:43:23 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A6121F46@dlee06.ent.ti.com>
References: <1252310555-20952-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707AbZIOBnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 21:43:24 -0400
In-Reply-To: <1252310555-20952-1-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>



Good,

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Monday, September 07, 2009 3:03 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 1/1] DSPBRIDGE: don't use potential invalid pointer
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/proc.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/proc.c
>b/drivers/dsp/bridge/rmgr/proc.c
>index 832930e..52e2d54 100644
>--- a/drivers/dsp/bridge/rmgr/proc.c
>+++ b/drivers/dsp/bridge/rmgr/proc.c
>@@ -323,6 +323,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct
>DSP_PROCESSORATTRIN *pAttrIn,
> 			 "PROC_Attach: Could not allocate "
> 			 "storage for notification \n");
> 		MEM_FreeObject(pProcObject);
>+		goto func_end;
> 	}
> #ifndef RES_CLEANUP_DISABLE
> 	spin_lock(&pr_ctxt->proc_list_lock);
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

