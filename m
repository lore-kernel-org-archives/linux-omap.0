From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Fri, 9 May 2014 09:07:26 -0700
Message-ID: <20140509160725.GG17814@atomide.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
 <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
 <20140421153539.GB23945@atomide.com>
 <CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
 <CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
 <20140506001237.GK25949@atomide.com>
 <CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14451 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbaEIQHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 12:07:30 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140509 05:58]:
> On 6 May 2014 02:12, Tony Lindgren <tony@atomide.com> wrote:
> >
> > OK sorry just noticed you're using it already while was about to
> > apply your patches. Care to update that series again to not use the
> > macro, or by adding the offsets?
> 
> hm, I'd rather add offsets than remove the macro's now.
> 
> How about we introduce a mask parameter in to the OMAP_IOPAD_OFFSET macro?
> Something like this:
> #define OMAP_IOPAD_OFFSET(pa, offset, mask) (((pa) & mask) - ((offset) & mask))
> 
> #define OMAP4_CORE_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0x0040, 0xfff) (val)
> 
> #define OMAP4_WKUP_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0xe040, 0xfff) (val)
> 
> Of course we need to fix the other users as well.

I was thinking that too initially, but then we would have macros that behave
in a different way:

1. Calculate the iopad offset from the iopad register area start based on
   the iopad physical address

2. Calculate the iopad offset from the iopad register area start based on
   the iopadd offset from the driver base address

> One other possibility is to use my original patch in this mail or just
> create a OMAP4_IOPAD with offset 0x040 which will on OMAP4 work for
> both core and wkup.

That also makes the macro behave in a different way depending on the
SoC which is not nice.
 
> What do you think?

I think it's best to add some new macros to avoid confusion.

Regards,

Tony
