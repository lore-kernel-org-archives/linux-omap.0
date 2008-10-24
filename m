From: "Bright, Dan" <dan.bright@windriver.com>
Subject: RE: Small patch for dsp bridge code
Date: Fri, 24 Oct 2008 09:12:16 -0700
Message-ID: <3DD728A3B927AA438D6367166CC67D0902B1DEA2@ala-mail10.corp.ad.wrs.com>
References: <3DD728A3B927AA438D6367166CC67D0902B1DCFE@ala-mail10.corp.ad.wrs.com> <20081024.190008.265201299.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33105 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbYJXQMZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 12:12:25 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20081024.190008.265201299.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Oops, I apologize. dma_alloc_coherent does return NULL.

Dan Bright


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Friday, October 24, 2008 9:00 AM
> To: Bright, Dan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Small patch for dsp bridge code
> 
> Hi Dan,
> 
> Would it be possible to explain how "dma_alloc_coherent()" returned
~0?
> 
>       Hiroshi DOYU
> 
> From: "ext Bright, Dan" <dan.bright@windriver.com>
> Subject: Small patch for dsp bridge code
> Date: Thu, 23 Oct 2008 15:03:31 -0700
> 
> > Hello,
> >
> > I'm not sure if this code ever get exercised, but I found a small
> > problem with the
> > dsp bridge driver code while debugging the kernel, and thought I'd
> bring
> > it to
> > someone's attention.
> >
> > Thanks,
> > Dan Bright
> >
> > diff --git a/drivers/dsp/bridge/services/mem.c
> > b/drivers/dsp/bridge/services/mem.c
> > index 565b0b8..fff1c4a 100644
> > --- a/drivers/dsp/bridge/services/mem.c
> > +++ b/drivers/dsp/bridge/services/mem.c
> > @@ -355,9 +355,14 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign,
> OUT
> > u32 *pPhysicalAddress)
> >  		if (extPhysMemPoolEnabled) {
> >  			pVaMem = MEM_ExtPhysMemAlloc(cBytes, ulAlign,
> >  						    (u32 *)&paMem);
> > -		} else
> > +		} else {
> >  			pVaMem = dma_alloc_coherent(NULL, cBytes,
> > &paMem,
> >  						   GFP_ATOMIC);
> > +			/* dma_alloc_coherent returns ~0 on error */
> > +			if(pVaMem == (void *)~0)
> > +				pVaMem = NULL;
> > +		}
> > +
> >  		if (pVaMem == NULL) {
> >  			*pPhysicalAddress = 0;
> >  			GT_1trace(MEM_debugMask, GT_6CLASS,
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
linux-omap"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
