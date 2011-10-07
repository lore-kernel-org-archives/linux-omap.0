From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 7 Oct 2011 18:04:11 +0200
Message-ID: <201110071804.11494.arnd@arndb.de>
References: <87aa9mm8ts.fsf@ti.com> <4E877E29.7000309@gmail.com> <20111006195945.GQ6324@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54495 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab1JGQEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 12:04:30 -0400
In-Reply-To: <20111006195945.GQ6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thursday 06 October 2011, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [111001 13:21]:
> > On 09/30/2011 05:29 PM, Kevin Hilman wrote:
> > > Hi Arnd,
> > > 
> > > Kevin Hilman <khilman@ti.com> writes:
> > > 
> > >> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
> > >> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
> > >> in the irq/core branch of Thomas' tip tree[3].
> > >>
> > >> In the past, I noticed you merged external trees like this to solve
> > >> dependencies.
> > >>
> > >> Could you pull the irq/core branch into your tree to meet this
> > >> dependency?
> > > 
> > > On second thought, since Santosh's branch is the only one with this
> > > dependency (and we also have a dependency on Russell's devel-stable)
> > > I'll just build up a branch for Santosh's series that includes
> > > rmk/devel-stable and tglx/irq-core.
> > > 
> > 
> > Any new platforms will have a dependency on rmk/devel-stable with the
> > mach header clean-up. I'll probably have a dependency on tglx's tree as
> > well.
> 
> Sounds like Arnd should pull this into some branch then.

I've pulled in rmk/devel-stable as a dependency now, thanks for
reminding me of that.

Thomas, where should I get the irq-core branch (or whichever
I should wait for) to pull in as another dependency. Is that
branch one that never gets rebased? 

	Arnd
