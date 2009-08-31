From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 8/8] dspbridge: Check pointer before usage
Date: Mon, 31 Aug 2009 15:47:38 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E95@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-9-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZHaUrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:47:46 -0400
In-Reply-To: <1251375541-1866-9-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


Hi,

Please see my comments below.

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Thursday, August 27, 2009 7:19 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 8/8] dspbridge: Check pointer before usage
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/rmgr/drv.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index d21071c..491dd39 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -1545,6 +1545,10 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext,
>struct DRV_OBJECT *hDrvObject)
> 	for (pszdevNode = (struct DRV_EXT *)DRV_GetFirstDevExtension();
> 	    pszdevNode != NULL; pszdevNode = (struct DRV_EXT *)
> 	    DRV_GetNextDevExtension((u32)pszdevNode)) {
>+		if (!pDRVObject->devNodeString) {
>+			/* When this could happen? */
>+			continue;
>+		}

The function DSP_STATUS DRV_ReleaseResources is only called after call DRV_Create where the list is created:
...
/* Create and Initialize List of device Extension */
			pDRVObject->devNodeString = LST_Create();
...
If the list creation fails DRV_ReleaseResources is never call neither. Even if it was possible pDRVObject->devNodeString is not changing between "for" iterations so if you put a "continue" it will enter to the "for" loop and check again pDRVObject->devNodeString what will be still null, so I think is should be a "break" instead of "continue". What do you think?


> 		if ((u32)pszdevNode == dwContext) {
> 			/* Found it */
> 			/* Delete from the Driver object list */
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Fernando.

