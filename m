From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Tue, 7 Sep 2010 17:17:09 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8D@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <87eidawoj6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab0IGLrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:47:15 -0400
In-Reply-To: <87eidawoj6.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, September 04, 2010 2:09 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as 
> platform driver
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > This patch series has review comments incorporated which 
> are received
> > for v1 version.
> > The review comments can be found at:
> > http://www.spinics.net/lists/linux-omap/msg34291.html
> > http://www.spinics.net/lists/linux-omap/msg34292.html
> > http://www.spinics.net/lists/linux-omap/msg34078.html
> > http://www.spinics.net/lists/linux-omap/msg34083.html
> >
> > These changes are tested on following boards:
> > - Zoom3     (OMAP3630)
> > - Beagle    (OMAP3530)
> > - OMAP4 SDP (OMAP4430)
> > I don't have omap1 and omap2 boards and appreciate if 
> > some one can test these boards and provides feedback.
> >
> > Build tested for both omap1 and omap2 plus boards.
> 
> Your team now has OMAP2 hardware, please test on OMAP2 as 
> well as you're
> making significant changes that affect code in OMAP2, 3 and 4.

Let me check omap2 board boot status. If it is working, I can
test next version of patches on omap2 also.

-Manjunath

> 
> Kevin
> 