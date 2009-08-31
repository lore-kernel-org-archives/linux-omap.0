From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 1/8] dspbridge: Remove useless check
Date: Mon, 31 Aug 2009 15:12:28 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E4D@dlee06.ent.ti.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38581 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbZHaUMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 16:12:36 -0400
In-Reply-To: <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


Hi,
	Looks good.

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Thursday, August 27, 2009 7:19 AM
>To: linux-omap@vger.kernel.org
>Cc: Andy Shevchenko
>Subject: [PATCH 1/8] dspbridge: Remove useless check
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>Before this check zlLib already dereferenced on one hand and DBC_Require()
>checks for NULL on other hand.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> drivers/dsp/bridge/pmgr/dbll.c |   34 ++++++++++++++++------------------
> 1 files changed, 16 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/dsp/bridge/pmgr/dbll.c
>b/drivers/dsp/bridge/pmgr/dbll.c
>index 7c3cd40..e655f89 100644
>--- a/drivers/dsp/bridge/pmgr/dbll.c
>+++ b/drivers/dsp/bridge/pmgr/dbll.c
>@@ -909,26 +909,24 @@ void DBLL_unload(struct DBLL_LibraryObj *lib, struct
>DBLL_Attrs *attrs)
> 		goto func_end;
>
> 	zlLib->pTarget->attrs = *attrs;
>-	if (zlLib != NULL) {
>-		if (zlLib->mHandle) {
>-			err = Dynamic_Unload_Module(zlLib->mHandle,
>-				&zlLib->symbol.dlSymbol,
>-				&zlLib->allocate.dlAlloc, &zlLib->init.dlInit);
>-			if (err != 0) {
>-				GT_1trace(DBLL_debugMask, GT_5CLASS,
>-					 "Dynamic_Unload_Module "
>-					 "failed: 0x%x\n", err);
>-			}
>-		}
>-		/* remove symbols from symbol table */
>-		if (zlLib->symTab != NULL) {
>-			GH_delete(zlLib->symTab);
>-			zlLib->symTab = NULL;
>+	if (zlLib->mHandle) {
>+		err = Dynamic_Unload_Module(zlLib->mHandle,
>+			&zlLib->symbol.dlSymbol,
>+			&zlLib->allocate.dlAlloc, &zlLib->init.dlInit);
>+		if (err != 0) {
>+			GT_1trace(DBLL_debugMask, GT_5CLASS,
>+				 "Dynamic_Unload_Module "
>+				 "failed: 0x%x\n", err);
> 		}
>-		/* delete DOFF desc since it holds *lots* of host OS
>-		 * resources */
>-		dofClose(zlLib);
> 	}
>+	/* remove symbols from symbol table */
>+	if (zlLib->symTab != NULL) {
>+		GH_delete(zlLib->symTab);
>+		zlLib->symTab = NULL;
>+	}
>+	/* delete DOFF desc since it holds *lots* of host OS
>+	 * resources */
>+	dofClose(zlLib);
> func_end:
> 	DBC_Ensure(zlLib->loadRef >= 0);
> }
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

