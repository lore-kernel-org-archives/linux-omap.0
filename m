From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 cache line size
Date: Mon, 11 May 2009 11:26:52 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AF663CA@dlee03.ent.ti.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33740 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZEKQ1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 12:27:05 -0400
In-Reply-To: <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Doyu-san,

> 
> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for
> dsp cache line size
> Date: Mon, 11 May 2009 17:09:03 +0200
> 
> > Hi Doyu-san,
> >
> > > A buffer shared with MPU and DSP has to be aligned on both cache line
> > > size to avoid memory corrupton with some DSP cache operations. Since
> > > there's no way for dspbridge to know how the shared buffer will be
> > > used like: "read-only", "write-only", "rw" through its life span, any
> > > shared buffer passed to DSP should be on this alignment. This patch
> > > adds checking those shared buffer alignement in bridgedriver cache
> > > operations and prevents userland applications from causing the above
> > > memory corruption.
> > >
> >
> > -- It looks like the buffer that are passed to the Bridge are not
> necessarily 128 byte aligned.
> >
> > This is the comment I received from Nikhil Mande (MM Engineer).
> >
> > [Nikhil Mande] "They are not necessarily "aligned" all the time.
> > Sometimes they just have 128 byte padding at the start & end of the
> buffer and the buffer pointer passed to bridge is not guaranteed to be 128
> aligned.
> > So if you are adding such a check, it will require modifications OMX
> > components & test apps."
> 
> The above means that passing unaligned address to dsp can cause memory
> corruption in kernel and this problem can be avoided only in the case
> where OMX(userland) is always supposed to pass aligned address.  

-- Why would there be memory corruption if the OMX components did the 128 bytes padding? The padding is dummy region which is not used by any other process.

> The
> above assumption cannot be accepted because kernel should always be
> robust against any incorrect behaviour of userland application. For
> example, even if an userland application passes any incorrect
> parameters to kernel through ioctl(), kernel shouldn't crash, but just
> returns -EINVAL.

-- I agree with you. I am just cautious to push this change by ensuring it doesn't break any other MM component functionality. 
> 
> 
> >
> > [Hari K] - Even with the above change, this might still be a hack for
> time being until the flushing of the user space buffers is moved from the
> Bridge driver to User-mode.
> >
> >
> > Thank you,
> > Best regards,
> > Hari
> >
> > > -----Original Message-----
> > > From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> > > Sent: Sunday, May 10, 2009 11:55 PM
> > > To: Kanigeri, Hari
> > > Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Hiroshi DOYU
> > > Subject: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for
> dsp
> > > cache line size
> > >
> > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >
> > > A buffer shared with MPU and DSP has to be aligned on both cache line
> > > size to avoid memory corrupton with some DSP cache operations. Since
> > > there's no way for dspbridge to know how the shared buffer will be
> > > used like: "read-only", "write-only", "rw" through its life span, any
> > > shared buffer passed to DSP should be on this alignment. This patch
> > > adds checking those shared buffer alignement in bridgedriver cache
> > > operations and prevents userland applications from causing the above
> > > memory corruption.
> > >
> > > Please refer to:
> > >
> https://omapzoom.org/gf/download/docmanfileversion/52/985/DSP_cache.pdf
> > >
> > > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > ---
> > >  drivers/dsp/bridge/rmgr/proc.c |   17 +++++++++++++++++
> > >  1 files changed, 17 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/dsp/bridge/rmgr/proc.c
> > > b/drivers/dsp/bridge/rmgr/proc.c
> > > index 59073dd..437c3fe 100644
> > > --- a/drivers/dsp/bridge/rmgr/proc.c
> > > +++ b/drivers/dsp/bridge/rmgr/proc.c
> > > @@ -159,6 +159,8 @@
> > >  #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
> > >  #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary
> */
> > >
> > > +#define DSP_CACHE_SIZE 128 /* DSP cacheline size */
> > > +
> > >  extern char *iva_img;
> > >  /* The PROC_OBJECT structure.   */
> > >  struct PROC_OBJECT {
> > > @@ -722,6 +724,13 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR
> > > hProcessor, void *pMpuAddr,
> > >  	enum DSP_FLUSHTYPE FlushMemType = PROC_WRITEBACK_INVALIDATE_MEM;
> > >  	DBC_Require(cRefs > 0);
> > >
> > > +	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_SIZE) ||
> > > +	    !IS_ALIGNED(ulSize, DSP_CACHE_SIZE)) {
> > > +		pr_err("%s: Invalid alignment %p %x\n",
> > > +		       __func__, pMpuAddr, ulSize);
> > > +		return DSP_EALIGNMENT;
> > > +	}
> > > +
> > >  	GT_4trace(PROC_DebugMask, GT_ENTER,
> > >  		 "Entered PROC_FlushMemory, args:\n\t"
> > >  		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags
> > > 0x%x\n",
> > > @@ -753,6 +762,14 @@ DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR
> > > hProcessor, void *pMpuAddr,
> > >  		 "Entered PROC_InvalidateMemory, args:\n\t"
> > >  		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x\n", hProcessor,
> > >  		 pMpuAddr, ulSize);
> > > +
> > > +	if (!IS_ALIGNED((u32)pMpuAddr, DSP_CACHE_SIZE) ||
> > > +	    !IS_ALIGNED(ulSize, DSP_CACHE_SIZE)) {
> > > +		pr_err("%s: Invalid alignment %p %x\n",
> > > +		       __func__, pMpuAddr, ulSize);
> > > +		return DSP_EALIGNMENT;
> > > +	}
> > > +
> > >  	(void)SYNC_EnterCS(hProcLock);
> > >  	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
> > >  	(void)SYNC_LeaveCS(hProcLock);
> > > --
> > > 1.6.0.4
> > >
> >

