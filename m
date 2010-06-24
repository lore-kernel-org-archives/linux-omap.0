From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Thu, 24 Jun 2010 11:38:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AE2A@dbde02.ent.ti.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1006211540100.1550@utopia.booyaka.com>
 <alpine.DEB.2.00.1006231819420.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0FXGIX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:08:23 -0400
In-Reply-To: <alpine.DEB.2.00.1006231819420.1550@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Paul Walmsley wrote:
> On Mon, 21 Jun 2010, Paul Walmsley wrote:
> > On Sat, 19 Jun 2010, Gadiyar, Anand wrote:
> > > Gadiyar, Anand wrote:
> > > > We need to wait on the IDLEST bit after the clocks are enabled
> > > > before attempting to access any register.
> > > > 
> > > > Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
> > > > while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
> > > > i-clock is enabled first, the clkops_omap2_dflt_wait is
> > > > short-circuited as the companion f-clock is not enabled.
> > > > This can cause a data abort if the IDLEST has not transitioned,
> > > > and we try to access a USBTLL register.
> > > > 
> > > > Since the USBTLL i-clock and f-clock could be enabled in any order,
> > > > this is a bug. Fix it by changing the clkops for the f-clock.
> > > > 
> > > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > 
> > It looks fine to me.  I will queue it for a -rc branch. 
> 
> Will requeue this for 2.6.36 merge window since it is not a regression, 
> and it seems that Linus wants regression fixes for the -rc series...
> 

I received a bug-report last Friday from some user of the recently-merged
ohci-omap3 driver about a data-abort caused at driver load. This patch
fixes that issue.

This wasn't known to me when I originally submitted the patch, but looks
like this is a problem caused in a driver that went in in the last merge
window. So maybe this patch can go in in the -rc series. ;)

It's your call. I'm not particular.

- Anand
