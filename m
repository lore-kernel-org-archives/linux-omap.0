From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Mon, 4 Oct 2010 13:06:16 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C95A@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <201010040915.27745.peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C8C2@dbde02.ent.ti.com>
 <201010041015.35457.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58367 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab0JDHg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:36:28 -0400
In-Reply-To: <201010041015.35457.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>


Peter, 

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] 
> Sent: Monday, October 04, 2010 12:46 PM
> To: G, Manjunath Kondaiah
> Cc: Jarkko Nikula; Tony Lindgren; linux-omap@vger.kernel.org; 
> Liam Girdwood
> Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable 
> bit setting for omap24xx
> 
> On Monday 04 October 2010 09:23:18 ext G, Manjunath Kondaiah wrote:
> > No errata numbers numbers used with TI errata documents 
> till omap2430.
> > Errata numbers avaialable from omap3430 onwards.
> > 
> > > For OMAP3 the errata number is i541, but I do not know the iXYZ 
> > > number for OMAP2 class.
> > 
> > Being said that no errata numbers for omap2 class, it's ok to use
> > omap3 errata numbers for common errata(like your patch 2/2)
> 
> Thanks,
> we are going to use the same errata ID for OMAP2, and OMAP3, 
> but going to use different workaround for them:
> OMAP2: disable buffering

This issue seems to be completly different from omap3 i541.
This is required to flush out fifo contents properly where as with i541, 
it requires DMA controller to be put in no mstandby mode before stoping 
DMA transfer.

> OMAP3: implement the workaround as it is in the errata
> 
> So, as Tony suggested, I'll add the errata handling, and we

If you are introducing errata handling, are you taking care of existing 
errata in DMA driver also? If not, it is better to go ahead current
implementation. DMA hwmod patches will introduce errata handling and these
changes can be rebased once it is available in mainline.


> are going to have:
> DMA_ERRATA_i541_OMAP2, and DMA_ERRATA_i541_OMAP3 to

For OMAP2, you should use "DMA_ERRATA_IFRAME_BUFFERING" since it is different
type of issue.

-Manjunath 
