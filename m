From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 7/8] DSPBRIDGE: Check return value
Date: Mon, 31 Aug 2009 15:21:50 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E65@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56972 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbZHaUV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:21:59 -0400
In-Reply-To: <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
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
>Subject: [PATCH 7/8] DSPBRIDGE: Check return value
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>PROC_GetProcessorId() potentially could return different to DSP_SOK status.
>We
>need to check it.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/drv.c |    8 ++++++--
> 1 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index 44d7f2d..d21071c 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -990,8 +990,12 @@ static DSP_STATUS PrintProcessInformation(void)
> 		spin_lock(&pCtxtList->proc_list_lock);
> 		list_for_each_entry(proc_obj_ptr, &pCtxtList->processor_list,
> 				proc_object) {
>-			PROC_GetProcessorId(proc_obj_ptr, &procID);
>-			if (procID == DSP_UNIT) {
>+			DSP_STATUS status2 = PROC_GetProcessorId(proc_obj_ptr,
>+								 &procID);
>+			if (DSP_FAILED(status2)) {
>+				GT_0trace(curTrace, GT_7CLASS, "\n***ERROR:"
>+					  "Unable to get Processor Id***\n");
>+			} else if (procID == DSP_UNIT) {
> 				GT_0trace(curTrace, GT_4CLASS,
> 					"\nProcess connected to"
> 					" DSP Processor\n");
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

