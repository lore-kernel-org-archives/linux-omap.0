From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 32/33] add omap 1-wire interface driver
Date: Mon, 8 Sep 2008 21:07:15 +0100
Message-ID: <20080908200715.GQ8266@flint.arm.linux.org.uk>
References: <1220116593-862-28-git-send-email-me@felipebalbi.com> <1220116593-862-29-git-send-email-me@felipebalbi.com> <1220116593-862-30-git-send-email-me@felipebalbi.com> <1220116593-862-31-git-send-email-me@felipebalbi.com> <1220116593-862-32-git-send-email-me@felipebalbi.com> <1220116593-862-33-git-send-email-me@felipebalbi.com> <04db01c90c34$f1d1eff0$LocalHost@wipultra1303> <20080905175902.GP24202@atomide.com> <03de01c911ac$8eca9ce0$LocalHost@wipultra1303> <20080908180520.GH29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36918 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbYIHUHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 16:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20080908180520.GH29054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 08, 2008 at 11:05:21AM -0700, Tony Lindgren wrote:
> * Madhusudhan Chikkature <madhu.cr@ti.com> [080908 05:15]:
> > 
> > ----- Original Message ----- 
> > From: "Tony Lindgren" <tony@atomide.com>
> > To: "Madhusudhan Chikkature" <madhu.cr@ti.com>
> > Cc: "Felipe Balbi" <me@felipebalbi.com>; <linux-omap@vger.kernel.org>; "Felipe Balbi" <felipe.balbi@nokia.com>
> > Sent: Friday, September 05, 2008 11:29 PM
> > Subject: Re: [PATCH 32/33] add omap 1-wire interface driver
> > 
> > 
> > >* Madhusudhan Chikkature <madhu.cr@ti.com> [080901 06:16]:
> > >> Hi,
> > >> 
> > >> The HDQ patchset that I posted to Tony were given ACK by Evgeniy Polyakov on the omap list. I hope that helps.
> > > 
> > > Madhu, can you post your 1-wire driver to LKML and Cc Evgeniy Polyakov
> > > so we can get that integrated? Also Cc l-o list.
> > I have a question regarding this. In fact it can be a generic question which might apply for other drivers as well. How do we post the OMAP3 related driver patches to LKML or any other driver specific lists if OMAP3 base support is not already  present there?
> 
> Well the drivers should not have dependencies to omap3 headers.
> And hopefully we'll have the minimal omap3 support integrated when
> 2.6.28 opens.
> 
> Also, you're already getting IORESOURCE_MEM as rerource. And isn't
> this driver also on 24XX chips too?
> 
> BTW, how about change it to use __raw_read/write instead of
> omap_read/write? Just ioremap the IORESOURCE_MEM, see
> the recent ioremap changes.

Last point - shouldn't it be converted to using mutexes instead of
semaphores?
