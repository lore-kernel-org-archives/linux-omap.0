From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 16:39:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C3A9@dbde02.ent.ti.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
 <201010011151.52547.peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
 <201010011341.22238.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366Ab0JALJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 07:09:53 -0400
In-Reply-To: <201010011341.22238.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>



> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] 
> Sent: Friday, October 01, 2010 4:11 PM
> To: G, Manjunath Kondaiah
> Cc: Menon, Nishanth; Tony Lindgren; 
> linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO 
> draining does not finish
> 
> On Friday 01 October 2010 12:29:54 ext G, Manjunath Kondaiah wrote:
> > > But yes, it would make the code much more readable, and we can 
> > > easily track, which errata has been already addressed.
> > 
> > This is already done as a part of dma hwmod which is under review.
> 
> OK, so we shall not bother with this in the 'legacy' code, right?
> 

That's correct but these patches needs to be ported on top of dma
driver with hwmod changes.

-Manjunath

-Manjunath