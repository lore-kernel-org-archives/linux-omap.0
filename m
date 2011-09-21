From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Wed, 21 Sep 2011 09:14:24 -0700
Message-ID: <20110921161424.GG2937@atomide.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
 <20110920231340.GT18894@atomide.com>
 <201109211612.33504.arnd@arndb.de>
 <20110921152812.GE2937@atomide.com>
 <CAK=WgbZ_1M-p+BtJnhw_uvaCnLaFRPA_tyv-rSGWMv2GQcB5Cw@mail.gmail.com>
 <CAK=WgbZw=q1HkU2U6iuzjSW==za5saFXmnf0yaYoHWkJfduZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33847 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752436Ab1IUQOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:14:35 -0400
Content-Disposition: inline
In-Reply-To: <CAK=WgbZw=q1HkU2U6iuzjSW==za5saFXmnf0yaYoHWkJfduZVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>

* Ohad Ben-Cohen <ohad@wizery.com> [110921 08:34]:
> On Wed, Sep 21, 2011 at 6:56 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > On Wed, Sep 21, 2011 at 6:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> Ohad can you please try this first? Just please make sure your patches are
> >> first in next tree before sending in the pull request.
> >
> > Sure thing.
> >
> > Stephen, I'll send you the location of my tree in a few.
> 
> Just before I do, Tony can I please have your Ack for the mach-omap2
> part of this patch-set:
> 
>  arch/arm/mach-omap2/hwspinlock.c         |    8 +-

OK acked the related patch.

Tony
