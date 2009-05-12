From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 cache line size
Date: Tue, 12 May 2009 09:09:47 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AF66B1E@dlee03.ent.ti.com>
References: <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
	<94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AF66543@dlee03.ent.ti.com>
 <20090512.083840.42792590.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36214 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbZELOJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 10:09:57 -0400
In-Reply-To: <20090512.083840.42792590.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Tuesday, May 12, 2009 12:39 AM
> To: Kanigeri, Hari
> Cc: felipe.contreras@gmail.com; Menon, Nishanth; 
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte 
> alignment for dsp cache line size
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte 
> alignment for dsp cache line size
> Date: Mon, 11 May 2009 20:26:11 +0200
> 
> > To summarize the discussion.
> 
> Thanks
> 
> > We need to have the check for 128 bytes alignment (upper 
> and lower). 
> > The 2 places that this can be done are in flush function or in Map 
> > function.
> > 
> > 	- I prefer the check is done in Map function as Felipe 
> mentioned this 
> > function is bound to be called by MM components as opposed to Flush 
> > function.
> 
> Mapping is totally another thing from this problem.
> 
> Any page mapping is being done, forcing PAGE_SIZE as below, because
> PAGE_SIZE(4KB) is the mininum unit from (io)mmu H/W 
> perspective. This is same as ARM too. They've been aligned on 
> 4KB already. So no need to worry about 128-byte alignement 
> for mapping.
> 

-- pMpuAddr that is passed to the PROC_Map is not aligned on 4KB boundary.
The alignemnt is taken care within the function. If this function is passed
the information of the buffer is read-only (from MPU point of view) then we
can enforce the cache alignment check. 


> DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void 
> *pMpuAddr, u32 ulSize,
> 		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr) {
> 	.....
> 	/* Calculate the page-aligned PA, VA and size */
> 	vaAlign = PG_ALIGN_LOW((u32) pReqAddr, PG_SIZE_4K);
> 	paAlign = PG_ALIGN_LOW((u32) pMpuAddr, PG_SIZE_4K);
> 	sizeAlign = PG_ALIGN_HIGH(ulSize + (u32)pMpuAddr - paAlign,
> 				 PG_SIZE_4K);
> 
> The points which we should take care of are bridge cache
> operations("PROC_Flush/Invalidate..()") and we should/can 
> handle this problem independently. It would cause another 
> dependency and increase another complexity again if we have 
> to assume something(ex:
> "read-only" or "write-only" buffer) on other modules or 
> expecting something on its "protocol".
> 
> > Also, another reason is the flush
> > function in Bridge driver is going to be removed eventually.
> 
> Maybe this should be discussed separately from the current topic.
> 
> > The open issue is the impact on the OMX components. Once if we 
> > finalize that there is no impact on the existing OMX 
> components or we 
> > have a plan to take this into account we can enforce this check.
> 
> This modification impact is a compatibility issue with the 
> existing S/W. Fixing it is the way to go rather than working 
> around the potential risk that userland can cause kernel 
> crash / memory corruption.
> 
> 

-- I agree with you that fixing is the way to go, but I think we should
give some transition time for the applications to adapt to this change.