From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Mon, 17 Sep 2012 14:39:30 -0700
Message-ID: <20120917213930.GE11762@atomide.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
 <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
 <504DE165.4000208@ti.com>
 <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
 <504DE79B.3090302@ti.com>
 <CAMQu2gwT=XHcZtdKfYacGyt21Mo0of8MmSMNE+0PP9wemKSyxw@mail.gmail.com>
 <CAMQu2gzKDLBJmVdm0SUr0ec=LueT0mqBUYmHyGMsav5k=ggKQg@mail.gmail.com>
 <50519FB9.9060208@ti.com>
 <20120917213810.GD11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23621 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752674Ab2IQVjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 17:39:32 -0400
Content-Disposition: inline
In-Reply-To: <20120917213810.GD11762@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig

* Tony Lindgren <tony@atomide.com> [120917 14:39]:
> * Benoit Cousson <b-cousson@ti.com> [120913 01:57]:
> > > 
> > > Enable Cortex A15 generic timer support for OMAP5 based SOCs.
> > > The CPU local timers run on the free running real time counter clock.
> > > 
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > 
> > Acked-by: Benoit Cousson <b-cousson@ti.com>
> > 
> > Tony,
> > 
> > I can potentially add it along with the timer changes in the dts part2
> > series if you ack the timer patch. We don't have tons of OMAP5 content
> > in the dts branch so it should not conflict.
> 
> Yes makes sense to me.

These may cause bad merge conflicts with Jon's timer patches though?

Tony
