From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
 support
Date: Wed, 30 Mar 2011 11:40:58 -0700
Message-ID: <20110330184058.GF18334@atomide.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
 <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
 <20110328205027.GC30616@atomide.com>
 <5cbdd88c3ca3fe5c5a0f119be446ce99@mail.gmail.com>
 <20110329170113.GG4016@atomide.com>
 <4D92CA92.50805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54734 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1C3SlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 14:41:01 -0400
Content-Disposition: inline
In-Reply-To: <4D92CA92.50805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

* Santosh <santosh.shilimkar@ti.com> [110329 23:13]:
> On 3/29/2011 10:31 PM, Tony Lindgren wrote:
> >* Santosh Shilimkar<santosh.shilimkar@ti.com>  [110328 22:47]:
> >>>From: Tony Lindgren [mailto:tony@atomide.com]
> >>>
> >>>Do you really need to initialize all of this that early?
> >>>
> >>Yes. It's a interrupt controller extension and needs to work
> >>together with GIC.
> >
> >Hmm to me it seems that the gic_arch_extn functions should be
> >all NULL during runtime operation, and the wake-up generator
> >should be programmed only before entering an idle state.
> >
> >Then the wake-up generator can be cleared after delivering
> >the wake-up event(s).
> >
> >Or am I missing something on why this should be enabled all
> >the time?
> >
> Yep. The WakeupGen sits between GIC and CPU and can
> gate the interrupts in normal operation too. It's
> mandatory that the interrupt mask at GIC and WakeupGen
> matches to deliver the interrupt to CPU.

But it seems that the states of GIC and WakeupGen can be
synced up just before hitting an idle mode.

And then the wake-ups only need to be acked after waking
from idle and delivering the interrupts.

> This is the reason why all the necessary GIC hooks are
> populated with it so that they work together.

Hmm I still see no reason to call these functions for every
interrupt during runtime.

AFAIK, these functions only need to be called only once
right after waking from idle.
 
> So far without this patch all interrupts at WakeupGen
> level were always enabled and hence there was no issue.

OK so things work during runtime without calling these
functions for every interrupt. Why then would we want to
call them for each interrupt?

Regards,

Tony
