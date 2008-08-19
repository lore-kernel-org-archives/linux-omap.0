From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/16] Omap2 patches for post 2.6.26
Date: Tue, 19 Aug 2008 22:23:00 +0100
Message-ID: <20080819212300.GF17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41942 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795AbYHSVXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 17:23:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:47:41PM -0700, Tony Lindgren wrote:
> This patch series contains various omap2 patchs from linux-omap tree.
> Big chunk of the patches still improve the clock code. Also more
> clean-up to allow compiling omap2 and omap3 support into the same
> kernel. The patch also adds core omap3430 support, but no board
> files or PM at at this point.

Apart from the comments I've made, the rest seem "fine" as far as I can
tell.

There's a _lot_ of churn in there, some of which is caused there not
being sufficient review of the OMAP code before it was merged into
mainline.  Such things as:

	if (unlikely((u32)clk->parent))

stick out like a sore thumb.  And that's a direct result of me getting
to the point of "tonnes more omap churn, sod it, I'm just going to
apply this."

If the (considerable) upstream workload is going to be reduced to an
acceptable level, people further downstream need to take on board that
they have a certain element of responsibility with their patches to
ensure that they are acceptable _before_ they hit any of these git
trees.

That also means sometimes combining two or more patches before it goes
upstream - in other words, what's visible to mainline is the "finished
product" of development of a new feature _without_ all the historical
baggage associated with it.

That said, I'll probably guess that you are completely overloaded by
the amount of work coming out of the OMAP trees themselves and can't
keep up with it either, so you're probably doing the best you can.  I
can well believe that now that I have visibility of how the various
OMAP trees are structured.

Eg, I don't think you have any way to apply any pressure to downstream
people to encourage them to only submit tested patches - because the
"downstream people" is just another tree ?
