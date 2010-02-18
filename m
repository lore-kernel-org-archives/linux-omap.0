From: Ameya Palande <ameya.palande@nokia.com>
Subject: RE: [PATCHv4 2/4] DSPBRIDGE: New reserved memory accounting
 framework
Date: Thu, 18 Feb 2010 16:48:54 +0200
Message-ID: <1266504534.2105.13.camel@sanganak>
References: <cover.1266429436.git.ameya.palande@nokia.com>
	 <7b2296a1856ed89b24b63b978a15acfe675e12ce.1266429437.git.ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602CA2B9AD0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17918 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757556Ab0BROtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:49:39 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9AD0@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Fernando,

On Thu, 2010-02-18 at 02:40 +0100, ext Guzman Lugo, Fernando wrote:
> Hi,
> 
> >-----Original Message-----
> >From: Ameya Palande [mailto:ameya.palande@nokia.com]
> >Sent: Wednesday, February 17, 2010 12:06 PM
> >To: linux-omap@vger.kernel.org
> >Cc: felipe.contreras@nokia.com; Menon, Nishanth; Chitriki Rudramuni,
> >Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar
> >Subject: [PATCHv4 2/4] DSPBRIDGE: New reserved memory accounting framework
> >
> >DSP_RSV_OBJECT is introduced to track reserved memory accounting
> >information.
> >This will allow us to do proper cleanup for memory reserved using
> >PROC_ReserveMemory().
> >
> >Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> >---
> >@@ -1720,18 +1736,32 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR
> >hProcessor, void *pRsvAddr)
> > 			 "InValid Processor Handle \n");
> > 		goto func_end;
> > 	}
> >+
> > 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
> >-	if (DSP_FAILED(status))
> >+	if (DSP_FAILED(status)) {
> > 		GT_1trace(PROC_DebugMask, GT_7CLASS,
> > 			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
> > 			 "handle: 0x%x\n", status);
> >-	else
> >-		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
> >+		goto func_end;
> >+	}
> >+
> >+	status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
> >+	if (status != DSP_SOK)
> >+		goto func_end;
> >+
> >+	spin_lock(&pr_ctxt->dmm_rsv_lock);
> >+	list_for_each_entry_safe(rsv_obj, temp, &pr_ctxt->dmm_rsv_list, link)
> 
> list_for_each_entry_safe is used when you delete a element from the list and continue but this is not the case. You should use list_for_each_entry instead, which has simpler logic and we can get ride of temp variable.

Thanks! V5 should take care of this :)

Cheers,
Ameya.

