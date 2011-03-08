From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DMA: mstandby mode and runtime pm support
Date: Tue, 8 Mar 2011 19:54:45 +0530
Message-ID: <20110308141002.GA19004@m-desktop>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
 <87hbbkqcgk.fsf@ti.com>
 <20110304041826.GA7025@m-desktop>
 <20110307110611.GA8743@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57151 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945Ab1CHO1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 09:27:06 -0500
Received: by ywl2 with SMTP id 2so3492160ywl.40
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 06:27:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110307110611.GA8743@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Mon, Mar 07, 2011 at 04:36:12PM +0530, G, Manjunath Kondaiah wrote:
> On Fri, Mar 04, 2011 at 09:48:26AM +0530, G, Manjunath Kondaiah wrote:
> > On Thu, Mar 03, 2011 at 10:35:23AM -0800, Kevin Hilman wrote:
> > > "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> > > 
> > > > This patch series is remaining part of dma hwmod to support pm runtime 
> > > > and for handling mstandby mode for all applicable DMA mstandby mode errata.
> > > 
> > > This is still not runtime-suspending when I use my DMA test in linking
> > > mode.
> > > 
> > > If I put a large enough period between transfers, it should autosuspend
> > > during transfers.  It seems to do auto-suspend and resume once, but then
> > > it never suspends again.
> > > 
> > > I tested with my dmatest module[1], and loaded with:
> > > 
> > >   # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024
> > > 
> > > Not only does it not auto-suspend between transfers (which I expected),
> > > it also doesn't suspend after removing the module which stops all active
> > > channels.
> > 
> > The normal chaining test cases are executed and which used to show the
> > proper status. Let me reproduce this issue with your test procedure.
> 
> ok. I am able to reproduce this issue and fixed _get_sync usage in
> omap_start_dma if channel linking is used. Earlier it was handled for
> the cases with chaining API's. If linking is done without chaining
> API's, it will result in _get_sync and _put mismatch.
> 
> Thanks for the test case and I will be re posting the patches with the 
> above fix.
While testing your test case with off mode for scenario:
insmod ./dmatest.ko linking=1 forever=1 forever_period=1024 debug=1

the transfer after timer expiry will get corrupted once it comes out of
off mode. Debugging offmode issue... 

Trying to use omap_pm_get_dev_context_loss_count(dev) for checking
offmode count for context restore in omap_start_dma.

-Manjunath
