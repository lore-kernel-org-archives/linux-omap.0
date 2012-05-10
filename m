From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: irq: Increase no of supported interrupts
 to 128
Date: Thu, 10 May 2012 15:10:13 -0700
Message-ID: <20120510221012.GP21851@atomide.com>
References: <1336486679-15892-1-git-send-email-hvaibhav@ti.com>
 <87lil2o6u1.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA1C06F@DBDE01.ent.ti.com>
 <87d36bvh9a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14446 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761758Ab2EJWKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 18:10:16 -0400
Content-Disposition: inline
In-Reply-To: <87d36bvh9a.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@ti.com> [120510 14:53]:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> >
> > Let me finish up with am33xx baseport upstream activity which is currently 
> > going on at full swing, then next thing I will pick up is this code cleanup.
> >
> > I still feel, this is still a valid cleanup patch, and can be merged, as it 
> > is required/used when we do major cleanup.
> 
> Well, Tony can make that decision.
> 
> Personally, I think this patch continues to add confusion on top of an
> existing mess, and to me provides the proverbial straw that broke the
> camel's back.
> 
> That being said, the INTC core is an obviously important and sensitive
> piece of code so needs to be handled with care.
> 
> In case Tony decides to merge this patch and allow a future** cleanup,
> I'll provide some comments.

Heh I agree with Kevin here :)

Tony

 
> ** since they rarely happen, we tend to not have too much faith in
>    promises of mythical "future" cleanups.  This is not because we don't
>    trust you personally, but simply based on based experience.
