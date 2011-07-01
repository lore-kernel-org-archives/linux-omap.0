From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] RETU meets Sparse IRQ
Date: Fri, 1 Jul 2011 00:55:23 -0700
Message-ID: <20110701075522.GI23145@atomide.com>
References: <1309348011-23141-1-git-send-email-balbi@ti.com>
 <c1c24abe84b7634c6751d51e88213424@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26186 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754945Ab1GAHz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:55:27 -0400
Content-Disposition: inline
In-Reply-To: <c1c24abe84b7634c6751d51e88213424@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Leigh Brown <leigh@solinno.co.uk> [110629 14:14]:
> On Wed, 29 Jun 2011 14:46:49 +0300, Felipe Balbi wrote:
> >now with Sparse IRQ numbering, we don't need
> >to add a bunch of defines in <plat/irqs.h>
> >
> >Compile tested with omap2plus_defconfig (+cbus)
> >and omap1_defconfig (+cbus).
> >
> >Felipe Balbi (2):
> >  cbus: retu: use sparse IRQ numbering
> >  cbus: retu: stop polluting <plat/irqs.h>
> >
> > arch/arm/mach-omap1/board-nokia770.c   |    2 --
> > arch/arm/mach-omap2/board-n8x0.c       |    2 --
> > arch/arm/plat-omap/include/plat/irqs.h |   10 +---------
> > drivers/cbus/retu.c                    |   25
> >++++++++++++++++---------
> > include/linux/platform_data/cbus.h     |    2 --
> > 5 files changed, 17 insertions(+), 24 deletions(-)
> 
> Tested-by: Leigh Brown <leigh@solinno.co.uk>
> 
> Booted fine on my N810.

Thanks for testing, applying both into cbus branch.

Tony
