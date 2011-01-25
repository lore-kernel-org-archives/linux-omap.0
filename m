From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 16:13:16 +0000
Message-ID: <20110125161316.GC17286@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk> <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com> <20110125103231.GD11507@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6> <20110125133752.GI13300@n2100.arm.linux.org.uk> <68b4be46e93b4017650bc4bf230afef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49995 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1AYQOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 11:14:04 -0500
Content-Disposition: inline
In-Reply-To: <68b4be46e93b4017650bc4bf230afef6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Colin Cross <ccross@android.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 25, 2011 at 09:34:15PM +0530, Santosh Shilimkar wrote:
> Russell, Thomas
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Tuesday, January 25, 2011 7:08 PM
> > To: Thomas Gleixner
> > Cc: Colin Cross; Santosh Shilimkar; catalin.marinas@arm.com;
> > linus.ml.walleij@gmail.com; linux-omap@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
> >
> [...]
> >
> > I can't say because these patches only add the hooks, there's no
> > implementation yet which uses the hooks.
> >
> > Given the description about _why_ those hooks are necessary, it
> > seems
> > that something is required.  Either we start adding custom hacks to
> > each clockevent driver as is done with this patch, or we get some
> > generic help in place.
> >
> > I'm not thrilled by the custom hack approach - and I thought the
> > clockevent stuff was created to stop this kind of thing happening.
> >
> > I suggest we defer this until there's a visible use case available.
> Got some time to debug this issue. OMAP idle code already has the
> broad-cast notifiers working for sometime. So I removed the existing
> save restore twd code and just used the below patch which Russell
> posted on this thread.
> And things just work and I guess we are done with this issue !!
> Timer framework is doing all right things with notifiers.
> 
> Am going to use this patch for my further work and drop the
> save/restore patch. Will update you if there is any other
> issue on this. I should have validated this patch on my own
> earlier :(
> 
> Thanks for the discussion.

Thanks - I guess that's a tested-by then?
