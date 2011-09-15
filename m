From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
 include interconnect barriers.
Date: Thu, 15 Sep 2011 12:43:31 -0700
Message-ID: <20110915194330.GC2284@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
 <20110913202701.GF24252@atomide.com>
 <4E7080F8.9020302@ti.com>
 <87obyl7mj8.fsf@ti.com>
 <CAMQu2gy6yVA7zWAPUsnzCtixHkjzkn6UnbapR0mpoJ+AwNMAcQ@mail.gmail.com>
 <20110915175354.GW24252@atomide.com>
 <CAMQu2gzfU0K0Q1Pta4vX=dNBBYQ6wNg_Kf5EeMTCV_WHTs3Y=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25673 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934532Ab1IOTnd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 15:43:33 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzfU0K0Q1Pta4vX=dNBBYQ6wNg_Kf5EeMTCV_WHTs3Y=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [110915 10:49]:
> On Thu, Sep 15, 2011 at 11:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Please also include the errata in the description and set it up with
> > a Kconfig entry with something like ARM_ERRATA_XXXXXX or TI_ERRATA_XXXXXX.
> >
> Sure.
> It's a  TI ERRATA.

OK
 
> > Also it would be best to apply this fix at the end of the PM series so
> > it is easier to verify the bug and potentially remove the hack if
> > a better fix is ever available.
> >
> As such order doesn't matter much because it can be removed either way
> even if it is in the beginning of the series with KCONFIG entry.
> 
> But I can change the order if you prefer that way.

Well it seems that it's the omap4_finish_suspend in this series that
can be used to trigger the bug, although the bug has been around for
few years. So then instead of mentioning random hangups you can have
a better description with something like "Patch xyz added PM idle
support for omap4, however bug 123 causes so and so. Fix the issue
with blah blah".

Also, if you have some easy way to reproduce the bug maybe mention
that too? That would make it easy to verify if issue has been fixed.

Regards,

Tony
