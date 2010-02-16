From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
Date: Tue, 16 Feb 2010 14:38:43 +0200
Message-ID: <1266323923.3092.14.camel@sanganak>
References: <018f9cad9a346b7a841268f4520a73a98c9cf7c9.1266246072.git.ameya.palande@nokia.com>
	 <20100215155958.GA5458@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33873 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab0BPMje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 07:39:34 -0500
In-Reply-To: <20100215155958.GA5458@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "x0095840@ti.com" <x0095840@ti.com>

Hi Felipe,

On Mon, 2010-02-15 at 16:59 +0100, Contreras Felipe (Nokia-D/Helsinki)
wrote:
> On Mon, Feb 15, 2010 at 04:36:31PM +0100, Ameya Palande wrote:
> > This patch fixes following issues:
> > 
> > 1. pDMMRes was dereferenced and modified when it was already freed by
> > PROC_Ummap(). This results in memory corruption.
> > 
> > 2.Instead of passing ulDSPAddr, ulDSPResAddr was passed to PROC_UnMap()
> > which will not retrieve correct DMMRes element.
> 
> You forgot to mention that this patch applies on top of your previous
> reserve resource cleanup patches.
> 
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> 
> And:
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> 
> > ---
> >  drivers/dsp/bridge/rmgr/drv.c |   15 +++++----------
> >  1 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
> > index 9d5c077..747b34c 100644
> > --- a/drivers/dsp/bridge/rmgr/drv.c
> > +++ b/drivers/dsp/bridge/rmgr/drv.c
> > @@ -273,11 +273,14 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
> >  		pDMMList = pDMMList->next;
> >  		if (pDMMRes->dmmAllocated) {
> >  			status = PROC_UnMap(pDMMRes->hProcessor,
> > -				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
> > +				 (void *)pDMMRes->ulDSPAddr, pCtxt);
> > +			/*
> > +			 * PROC_UnMap has freed pDMMRes pointer, so don't access
> > +			 * it now
> > +			 */
> 
> I don't see the need for this comment on the code.

In above code segment, just by looking at PROC_Unmap() it is not
apparent that it will deallocate "pDMMRes" thats why that comment is
present there! I guess this whole memory corruption could have been
easily avoided by presence of that comment ;)

Cheers,
Ameya.

