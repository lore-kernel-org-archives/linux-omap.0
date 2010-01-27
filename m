From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH v2 4/5] DSPBRIDGE: Remove multiple initializations of
 REG module
Date: Tue, 26 Jan 2010 19:46:47 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA4DB32C@dlee06.ent.ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-3-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-4-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab0A0Bqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 20:46:53 -0500
In-Reply-To: <1264553848-23555-5-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>



Hi,

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Ramirez Luna, Omar
>Sent: Tuesday, January 26, 2010 6:57 PM
>To: linux-omap
>Cc: Ameya Palande; Hiroshi Doyu; Felipe Contreras; Menon, Nishanth; Ramirez
>Luna, Omar
>Subject: [PATCH v2 4/5] DSPBRIDGE: Remove multiple initializations of REG
>module
>
>REG module should be only initialized by services layer.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/rmgr/dbdcd.c |    9 +--------
> 1 files changed, 1 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c
>b/drivers/dsp/bridge/rmgr/dbdcd.c
>index cb244f4..caa57f1 100644
>--- a/drivers/dsp/bridge/rmgr/dbdcd.c
>+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
>@@ -350,7 +350,6 @@ void DCD_Exit(void)
>
> 	cRefs--;
> 	if (cRefs == 0) {
>-		REG_Exit();
> 		COD_Exit();
> 	}
>
>@@ -821,7 +820,6 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER
>*hDcdMgr,
>  */
> bool DCD_Init(void)
> {
>-	bool fInitREG;
> 	bool fInitCOD;
> 	bool fInit = true;
>
>@@ -833,18 +831,13 @@ bool DCD_Init(void)
> 	if (cRefs == 0) {
> 		/* Initialize required modules. */
> 		fInitCOD = COD_Init();
>-		fInitREG = REG_Init();
>
>-		if (!fInitCOD || !fInitREG) {
>+		if (!fInitCOD) {
> 			fInit = false;
> 			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
> 			/* Exit initialized modules. */
> 			if (fInitCOD)
> 				COD_Exit();
>-
>-			if (fInitREG)
>-				REG_Exit();
>-
> 		}
> 	}

Now DCD_Init() is only initializing COD module maybe you can remove DCD_Init and just call COD_Init(), if it is not good for consistency you can replace the function for something like this:

bool DCD_Init(void)
{
	return COD_Init();
}

All the other stuff are not needed.



Regards,
Fernando.



>
>--
>1.6.2.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
