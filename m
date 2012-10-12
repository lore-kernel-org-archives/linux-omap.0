From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
	serial stuff)
Date: Fri, 12 Oct 2012 17:31:06 +0100
Message-ID: <20121012163106.GP28061@n2100.arm.linux.org.uk>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51475 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab2JLQbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 12:31:12 -0400
Content-Disposition: inline
In-Reply-To: <20121012162452.GD30339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Afzal Mohammed <afzal@ti.com>, =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>

On Fri, Oct 12, 2012 at 09:24:52AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
> > As of today, I've rebased my serial changes as far forward as I dare at
> > the moment (to the commit before removal of DMA), and then merged it
> > into the latest trees from armsoc and myself, fixing up all the horrid
> > conflicts. I've finally got it to a stage where at least it compiles,
> > but unfortunately something has broken serial output from userspace
> > quite badly to the point that it doesn't work.
> > 
> > I know that my serial changes were fine before I tried rebasing them (the
> > set I posted to the mailing list certainly did work) so I suspect that
> > it's down to incompatibilities between the fixes done by others (who didn't
> > really understand all issues involved) and those done by myself.
> 
> Have you been able to locate the breaking patches, maybe those could
> be reverted?

Not yet; I'll look into it this weekend.  I've only recently got stuff
back into a state where the kautobuild kernels don't error out during
the build for the OMAP and SA11x0 stuff.  OMAP ended up in that
situation because of the duplicated serial efforts causing rather
disgusting and horrid conflicts.
