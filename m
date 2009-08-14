From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 08/13] DSPBRIDGE: Use pr_ctxt in DRV_RemoveProcContext
Date: Fri, 14 Aug 2009 14:22:17 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D36@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-7-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-8-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756932AbZHNTWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:22:25 -0400
In-Reply-To: <1249953714-20972-9-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Hi,

	Please see my comments below.

Regards,
Fernando.

>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Monday, August 10, 2009 8:22 PM
>To: linux-omap@vger.kernel.org
>Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando;
>Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
>Subject: [PATCH 08/13] DSPBRIDGE: Use pr_ctxt in DRV_RemoveProcContext
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>---
> .../plat-omap/include/dspbridge/resourcecleanup.h  |    2 +-
> drivers/dsp/bridge/rmgr/drv.c                      |   32 ++++++++++------
>----
> drivers/dsp/bridge/rmgr/drv_interface.c            |    4 +-
> 3 files changed, 19 insertions(+), 19 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
>b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
>index b43fa16..5592f38 100644
>--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
>+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
>@@ -43,7 +43,7 @@ extern DSP_STATUS DRV_GetProcContext(u32 phProcess,
> extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
>
> extern DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
>-				     HANDLE hPCtxt, HANDLE hProcess);
>+				     HANDLE hPCtxt);
>
> extern DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE nodeRes,
> 					HANDLE pCtxt);
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index e64b997..6cfd349 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -317,36 +317,36 @@ DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT
>*hDrVObject, HANDLE hPCtxt)
>
> /* Delete a process context from process resource context list */
> DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
>-				     HANDLE hPCtxt, HANDLE hProcess)
>+		HANDLE pr_ctxt)
> {
> 	DSP_STATUS status = DSP_SOK;
>-	struct PROCESS_CONTEXT    *pCtxt2 = NULL;
>-	struct PROCESS_CONTEXT    *pTmp = NULL;
>-	struct PROCESS_CONTEXT    *pCtxtList = NULL;
>+	struct PROCESS_CONTEXT *pr_ctxt_list = NULL;
>+	struct PROCESS_CONTEXT *ptr_prev;
>
> 	DBC_Assert(hDRVObject != NULL);
>-	DRV_GetProcContext((u32)hProcess, hDRVObject, &pCtxt2, NULL, 0);
>
> 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 12");
>-	DRV_GetProcCtxtList(&pCtxtList, hDRVObject);
>+	DRV_GetProcCtxtList(&pr_ctxt_list, hDRVObject);
>+	ptr_prev = pr_ctxt_list;
>+
> 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 13");
>-	pTmp = pCtxtList;
>-	while ((pCtxtList != NULL) && (pCtxtList != pCtxt2)) {
>-		pTmp = pCtxtList;
>-		pCtxtList = pCtxtList->next;
>+	while (pr_ctxt_list && (pr_ctxt_list != pr_ctxt)) {
>+		ptr_prev = pr_ctxt_list;
>+		pr_ctxt_list = pr_ctxt_list->next;
> 		GT_0trace(curTrace, GT_ENTER,
> 			 "DRV_RemoveProcContext: 2");
> 	}
>+
> 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 3");
>-	if (hDRVObject->procCtxtList == pCtxt2)
>-		hDRVObject->procCtxtList = pCtxt2->next;
>
>-	if (pCtxtList == NULL)
>+	if (!pr_ctxt_list)
> 		return DSP_ENOTFOUND;
>-	else if (pTmp->next != NULL)
>-		pTmp->next = pTmp->next->next;
>+	else if (pr_ctxt_list->next != NULL)
>+		ptr_prev->next = pr_ctxt_list->next;
If the process context is the first element of the list above sentence is not doing anything and the element is not removed from the list

>+	else
>+		hDRVObject->procCtxtList = NULL;
If the process context is the last element of the list the above sentence is losing the pointer to the process context list even if there are more elements in the list.

That's my proposal:
	if (!pr_ctxt_list)
		return DSP_ENOTFOUND;
	else if (hDRVObject->procCtxtList == pr_ctxt_list)
		hDRVObject->procCtxtList = pr_ctxt_list->next;
	else
		ptr_prev->next = pr_ctxt_list->next;


However I think process contest list should disappear at all.

>
>-	MEM_Free(pCtxt2);
>+	MEM_Free(pr_ctxt);
> 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 7");
>
> 	return status;
>diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
>b/drivers/dsp/bridge/rmgr/drv_interface.c
>index 1cb3d74..fa79695 100644
>--- a/drivers/dsp/bridge/rmgr/drv_interface.c
>+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>@@ -481,7 +481,7 @@ static int __devexit omap34xx_bridge_remove(struct
>platform_device *pdev)
> 		}
> 		pTmp = pCtxtclosed->next;
> 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
>-				     pCtxtclosed, (void *)pCtxtclosed->pid);
>+				pCtxtclosed);
> 		pCtxtclosed = pTmp;
> 	}
>
>@@ -630,7 +630,7 @@ static int bridge_release(struct inode *ip, struct file
>*filp)
> 				PROC_Detach(proc_obj_ptr, pr_ctxt);
> 			}
> 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
>-					pr_ctxt, (void *)pr_ctxt->pid);
>+					pr_ctxt);
> 		} else {
> 			status = -EIO;
> 		}
>--
>1.6.2.4
>

