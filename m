From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Wed, 23 Jun 2010 18:20:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006231819420.1550@utopia.booyaka.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com> <alpine.DEB.2.00.1006211540100.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48846 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0FXAUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 20:20:54 -0400
In-Reply-To: <alpine.DEB.2.00.1006211540100.1550@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Mon, 21 Jun 2010, Paul Walmsley wrote:

> On Sat, 19 Jun 2010, Gadiyar, Anand wrote:
> 
> > Gadiyar, Anand wrote:
> > > We need to wait on the IDLEST bit after the clocks are enabled
> > > before attempting to access any register.
> > > 
> > > Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
> > > while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
> > > i-clock is enabled first, the clkops_omap2_dflt_wait is
> > > short-circuited as the companion f-clock is not enabled.
> > > This can cause a data abort if the IDLEST has not transitioned,
> > > and we try to access a USBTLL register.
> > > 
> > > Since the USBTLL i-clock and f-clock could be enabled in any order,
> > > this is a bug. Fix it by changing the clkops for the f-clock.
> > > 
> > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> 
> It looks fine to me.  I will queue it for a -rc branch. 

Will requeue this for 2.6.36 merge window since it is not a regression, 
and it seems that Linus wants regression fixes for the -rc series...


- Paul
