From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Build error while adding debug LL support for new board
Date: Thu, 20 Oct 2011 17:50:04 +0100
Message-ID: <20111020165004.GE22076@n2100.arm.linux.org.uk>
References: <1318856432-20219-1-git-send-email-afzal@ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930328B2D71D@dbde02.ent.ti.com> <20111020125721.GD22076@n2100.arm.linux.org.uk> <20111020161251.GL3842@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36095 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1JTQxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Oct 2011 12:53:30 -0400
Content-Disposition: inline
In-Reply-To: <20111020161251.GL3842@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Oct 20, 2011 at 09:12:52AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111020 05:23]:
> > On Thu, Oct 20, 2011 at 05:09:07PM +0530, Mohammed, Afzal wrote:
> > > Hi Russell,
> > > 
> > > n Mon, Oct 17, 2011 at 18:30:32, Mohammed, Afzal wrote:
> > > > Hi, Russell,
> > > > 
> > > > While adding low level debug support for new board in OMAP2+ family, we
> > > > came across following error,
> > > > 
> > > > arch/arm/kernel/debug.S: Assembler messages:
> > > > arch/arm/kernel/debug.S:138: Error: invalid constant (428) after fixup
> > > > 
> > > > Following patch fixes it, I am not sure whether this is the right fix,
> > > > please let us know your comments.
> > > 
> > > ping
> > 
> > The patch looks fine.  Who's merging it?
> 
> Can you please take it?
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

If it finds its way into the patch system.  Note that I'm not applying
patches after end of today until after the kernel summit.
