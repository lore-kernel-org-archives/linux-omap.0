From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Thu, 6 Oct 2011 12:59:46 -0700
Message-ID: <20111006195945.GQ6324@atomide.com>
References: <87aa9mm8ts.fsf@ti.com>
 <87k48pfyvg.fsf@ti.com>
 <4E877E29.7000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23897 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab1JFT7v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 15:59:51 -0400
Content-Disposition: inline
In-Reply-To: <4E877E29.7000309@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Rob Herring <robherring2@gmail.com> [111001 13:21]:
> On 09/30/2011 05:29 PM, Kevin Hilman wrote:
> > Hi Arnd,
> > 
> > Kevin Hilman <khilman@ti.com> writes:
> > 
> >> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
> >> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
> >> in the irq/core branch of Thomas' tip tree[3].
> >>
> >> In the past, I noticed you merged external trees like this to solve
> >> dependencies.
> >>
> >> Could you pull the irq/core branch into your tree to meet this
> >> dependency?
> > 
> > On second thought, since Santosh's branch is the only one with this
> > dependency (and we also have a dependency on Russell's devel-stable)
> > I'll just build up a branch for Santosh's series that includes
> > rmk/devel-stable and tglx/irq-core.
> > 
> 
> Any new platforms will have a dependency on rmk/devel-stable with the
> mach header clean-up. I'll probably have a dependency on tglx's tree as
> well.

Sounds like Arnd should pull this into some branch then.

Tony
