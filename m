From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: MEM_VFree() cleanup
Date: Tue, 02 Feb 2010 20:44:25 +0200
Message-ID: <1265136265.26885.1.camel@sanganak>
References: <48172f2f93a66f4d34c79aa6164236b01e706e3e.1265046944.git.ameya.palande@nokia.com>
	 <4B6732F8.1010809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49153 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0BBSo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 13:44:56 -0500
In-Reply-To: <4B6732F8.1010809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "nm@ti.com" <nm@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On Mon, 2010-02-01 at 21:00 +0100, ext Menon, Nishanth wrote:
> Ameya Palande said the following on 02/01/2010 07:56 PM:
> > Since vfree() checks for null pointer, there is no need to check is again in
> > MEM_VFree(). This patch also reorganizes the function to make it more readable.
> > 
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > ---
> >  drivers/dsp/bridge/services/mem.c |   42 +++++++++++++++----------------------
> >  1 files changed, 17 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
> > index dfe352d..c2887b3 100644
> > --- a/drivers/dsp/bridge/services/mem.c
> > +++ b/drivers/dsp/bridge/services/mem.c
> > @@ -456,35 +456,27 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
> >  void MEM_VFree(IN void *pMemBuf)
> >  {
> >  #ifdef MEM_CHECK
> > -	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
> > +	struct memInfo *pMem;
> >  #endif
> > -
> > -	DBC_Require(pMemBuf != NULL);
> does'nt this remove a warning for us?
> > -
> >  	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_VFree: pMemBufs 0x%x\n",
> > -		  pMemBuf);
> > -
> > -	if (pMemBuf) {
> > -#ifndef MEM_CHECK
> > -		vfree(pMemBuf);
> > +			pMemBuf);
> probably an un-needed formattig change -> messed the diff a little bit 
> here
> 
> > +#ifdef MEM_CHECK
> > +	if (!pMemBuf) {
> > +		GT_1trace(MEM_debugMask, GT_7CLASS,
> > +			"Invalid allocation or Buffer underflow\n");
> > +		return;
> > +	}
> > +	pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
> > +	if (pMem && pMem->dwSignature == memInfoSign) {
> > +		spin_lock(&mMan.lock);
> > +		MLST_RemoveElem(&mMan.lst, (struct list_head *)pMem);
> > +		spin_unlock(&mMan.lock);
> > +		pMem->dwSignature = 0;
> ^^^^^^^^^^^^^ Dumb question: signature should be locked? (yep the prev 
> code was as such)..
> > +		vfree(pMem);
> > +	}
> >  #else
> > -		if (pMem) {
> > -			if (pMem->dwSignature == memInfoSign) {
> > -				spin_lock(&mMan.lock);
> > -				MLST_RemoveElem(&mMan.lst,
> > -						(struct list_head *)pMem);
> > -				spin_unlock(&mMan.lock);
> > -				pMem->dwSignature = 0;
> > -				vfree(pMem);
> > -			} else {
> > -				GT_1trace(MEM_debugMask, GT_7CLASS,
> > -					"Invalid allocation or "
> > -					"Buffer underflow at %x\n",
> > -					(u32) pMem + sizeof(struct memInfo));
> > -			}
> > -		}
> > +	vfree(pMemBuf);
> ^^^^^^^^^^ it looks to me that if you put pMemBuf = pMem in the #ifdef 
> case, you could probably move vfree out of the #ifdef altogether..
> >  #endif
> > -	}
> >  }
> >  
> >  /*
> 
> Regards,
> Nishanth Menon

NACK!

Nishanth, thanks for the review :)
I found a better solution, will send patches soon.

Cheers,
Ameya.

