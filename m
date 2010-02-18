From: Ameya Palande <ameya.palande@nokia.com>
Subject: RE: [PATCHv4 4/4] DSPBRIDGE: Improved mapped memory cleanup
Date: Thu, 18 Feb 2010 14:15:55 +0200
Message-ID: <1266495355.2105.5.camel@sanganak>
References: <cover.1266429436.git.ameya.palande@nokia.com>
	 <f57155cbfa5cca493333eff553f6887217273a3b.1266429437.git.ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602CA2B9AD9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39194 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab0BRMQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 07:16:55 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9AD9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Fernando,

On Thu, 2010-02-18 at 02:52 +0100, ext Guzman Lugo, Fernando wrote:
> Hi,
> 
> >-----Original Message-----
> >From: Ameya Palande [mailto:ameya.palande@nokia.com]
> >Sent: Wednesday, February 17, 2010 12:06 PM
> >To: linux-omap@vger.kernel.org
> >Cc: felipe.contreras@nokia.com; Menon, Nishanth; Chitriki Rudramuni,
> >Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar
> >Subject: [PATCHv4 4/4] DSPBRIDGE: Improved mapped memory cleanup
> >
> >This patch improves current mapped memory cleanup mechanism by using linux
> >native list implementation. As a side effect we also get following
> >benefits:
> >
> >1. Unnecessary data members in DMM_MAP_OBJECT are removed which results in
> >   memory saving.
> >
> >2. Following functions are removed as they are not needed anymore:
> >   DRV_ProcFreeDMMRes()
> >   DRV_UpdateDMMResElement()
> >   DRV_InsertDMMResElement()
> >   DRV_GetDMMResElement()
> >   DRV_RemoveDMMResElement()
> >
> >Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> >---
> >@@ -1334,11 +1333,17 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void
> >*pMpuAddr, u32 ulSize,
> >       }
> >       (void)SYNC_LeaveCS(hProcLock);
> >
> >-      if (DSP_SUCCEEDED(status)) {
> >-              DRV_InsertDMMResElement(&dmmRes, pr_ctxt);
> >-              DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
> >-                              (u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
> >+      if (DSP_FAILED(status))
> >+              goto func_end;
> >+
> >+      map_obj = kmalloc(sizeof(struct DMM_MAP_OBJECT), GFP_KERNEL);
> >+      if (map_obj) {
> >+              map_obj->dsp_addr = (u32)*ppMapAddr;
> >+              spin_lock(&pr_ctxt->dmm_map_lock);
> >+              list_add(&map_obj->link, &pr_ctxt->dmm_map_list);
> >+              spin_unlock(&pr_ctxt->dmm_map_lock);
> >       }
> 
> What do you think about it?
> Instead of removing DRV_InsertDMMResElement make it an inline function with your code inside:

Making DRV_InsertDMMResElement inline doesn't make sense since we are
not calling it multiple times.

> inline void DRV_InsertDMMResElement(u32 ppMapAddr)
> {
>         map_obj = kmalloc(sizeof(struct DMM_MAP_OBJECT), GFP_KERNEL);
>         if (map_obj) {
>                 map_obj->dsp_addr = (u32)*ppMapAddr;
>                 spin_lock(&pr_ctxt->dmm_map_lock);
>                 list_add(&map_obj->link, &pr_ctxt->dmm_map_list);
>                 spin_unlock(&pr_ctxt->dmm_map_lock);
>         }
> }
> 
> It could make the code more understandable about what it is actually doing.
> It also applies to the functions which removes this patch.

I can put a comment here to clarify what this code is doing ;)

Cheers,
Ameya.

