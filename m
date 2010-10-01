From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 15:15:47 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2E2@dbde02.ent.ti.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com>
 <4CA59188.5020904@ti.com> <201010011151.52547.peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
 <4CA5AD3A.50700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab0JAJqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 05:46:11 -0400
In-Reply-To: <4CA5AD3A.50700@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, October 01, 2010 3:13 PM
> To: G, Manjunath Kondaiah
> Cc: Peter Ujfalusi; Tony Lindgren; 
> linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO 
> draining does not finish
> 
> G, Manjunath Kondaiah had written, on 10/01/2010 04:29 AM, 
> the following:
> > 
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org 
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Peter Ujfalusi
> >> Sent: Friday, October 01, 2010 2:22 PM
> >> To: Menon, Nishanth
> >> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Jarkko Nikula; Liam 
> >> Girdwood
> >> Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO 
> draining does 
> >> not finish
> > ...
> > 
> >>>> +	if (cpu_is_omap34xx() && (l & 
> OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
> >>> does it make sense to use an dma_errata variable and populate it?
> >> Hmmm, the errata handling via dma_errata shall be done separately 
> >> IMHO, since if we do that, than we need to revisit other 
> parts of the 
> >> code as well, and replace the existing errata handling.
> >>
> >> But yes, it would make the code much more readable, and we 
> can easily 
> >> track, which errata has been already addressed.
> >>
> > 
> > This is already done as a part of dma hwmod which is under review.
> > 
> > -Manjunath
> Apologies, but does that mean:
> a) the errata i541 is handled as well as part of hwmod series?
No. 
> b) the patch needs to be ported ontop of hwmod series?
Yes.

-Manjunath