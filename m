From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/0] Refreshed omap2 clock and powerdomain patches
Date: Fri, 25 Jul 2008 10:06:49 +0300
Message-ID: <20080725070648.GB21000@atomide.com>
References: <20080716094103.GD23468@flint.arm.linux.org.uk> <20080716152243.GA8414@atomide.com> <f17812d70807231941p7aef9434g763fcc26921acc25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57712 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYGYHGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2008 03:06:55 -0400
Content-Disposition: inline
In-Reply-To: <f17812d70807231941p7aef9434g763fcc26921acc25@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* eric miao <eric.y.miao@gmail.com> [080724 05:41]:
> On Wed, Jul 16, 2008 at 11:22 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080716 12:41]:
> >> On Wed, Jul 16, 2008 at 11:53:20AM +0300, Tony Lindgren wrote:
> >> > This series contains the refreshed omap2 clock and powerdomain
> >> > patches as some of the patches in this series have been already
> >> > integrated.
> >>
> >> I think the clock and power domain patches need much more review.
> >> They're introducing a couple of new management subsystems which may
> >> be of interest to other SoCs, maybe even different architectures.
> >
> > Sure the power domain and clock domain code can be worked into
> > something more generic once we've figured out what can be shared.
> >
> 
> This is, unfortunately, not so useful to PXA likely. Although there's
> power domain and clock domain concepts in PXA silicon, the power
> states of those domains are controlled in a integrated way along with
> the power state of the whole chip, perhaps to reduce the software
> complexity in software domain management, and mimics the ACPI
> concepts to some extent.

OK, thanks for looking through it.

> I don't want to give an early conclusion, but I may look more into the
> usage of these power domains and clock domains ( it's not merely
> to setup the PRCM registers correctly, no? )

Well lots of it deals with the omap PRCM registers yeah. But maybe some
of the domain manamgent code could be shared.

Tony

> 
> > I've posted these patches to LKML and linux-pm for other arch people to
> > look at too.
> >
> > Regards,
> >
> > Tony
> >
> > -------------------------------------------------------------------
> > List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> > FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> > Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> >
> 
> 
> 
> -- 
> Cheers
> - eric
