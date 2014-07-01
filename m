From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V4 00/16] irqchip: crossbar: Driver fixes
Date: Tue, 1 Jul 2014 08:23:48 -0400
Message-ID: <20140701122348.GE23978@titan.lakedaemon.net>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <20140630192910.GA23978@titan.lakedaemon.net>
 <20140701075930.GN28884@atomide.com>
 <53B28124.40509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19182 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaGAMYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 08:24:06 -0400
Content-Disposition: inline
In-Reply-To: <53B28124.40509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, linux@arm.linux.org.uk, rnayak@ti.com, santosh.shilimkar@ti.com, joe@perches.com, tglx@linutronix.de

On Tue, Jul 01, 2014 at 03:06:36PM +0530, Sricharan R wrote:
> Hi Tony,
> 
> On Tuesday 01 July 2014 01:29 PM, Tony Lindgren wrote:
> > * Jason Cooper <jason@lakedaemon.net> [140630 12:30]:
> >>
> >> Whole series applied to irqchip/crossbar, I'll give it a day or two in
> >> -next, then I'll merge it into irqchip/core.
> >>
> >> Tony: Right now, it's immutable unless you tell me I applied something
> >> incorrectly.  Once it goes into irqchip/core, it's immutable no matter
> >> what you say. ;-)
> > 
> > Thanks, looks good to me. Sricharan and Nishant, can you please
> > check that we can now apply the related .dts changes on top of
> > Jason's branch at:
> > 
> > git://git.infradead.org/users/jcooper/linux.git irqchip/crossbar
> > 
> 
> I applied the dts patches on top of this and it worked fine for
> me on dra72 evm

Awesome, thanks.  irqchip/crossbar has been merged into irqchip/core.

thx,

Jason.
