From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs
	dummytimersupportruntime
Date: Wed, 23 Feb 2011 19:55:33 +0000
Message-ID: <20110223195533.GC16041@n2100.arm.linux.org.uk>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com> <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com> <20110220110341.GA15494@n2100.arm.linux.org.uk> <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com> <20110223163635.GA16041@n2100.arm.linux.org.uk> <780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com> <2d63c430d007703753afa4ae98902341@mail.gmail.com> <20110223190305.GB16041@n2100.arm.linux.org.uk> <b9ea630b656efc370b6c5da78dedd41d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37162 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab1BWTzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 14:55:51 -0500
Content-Disposition: inline
In-Reply-To: <b9ea630b656efc370b6c5da78dedd41d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, Feb 24, 2011 at 12:41:38AM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Thursday, February 24, 2011 12:33 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> > kernel@lists.infradead.org; tony@atomide.com; David Brown; Daniel
> > Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> > Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> > Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs
> > dummytimersupportruntime
> >
> > On Wed, Feb 23, 2011 at 11:28:11PM +0530, Santosh Shilimkar wrote:
> > > Patch 6759/1 and patch 6760/1 in patch system
> >
> > Was there any difference between 6760 and 6753 ?
> Nope.
> I just rebased them together and pushed

Well, both patches are identical, so I'll stick with 6753/1 which I've
already merged.

Thanks
