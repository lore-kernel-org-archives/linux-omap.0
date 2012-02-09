From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 8 Feb 2012 16:40:27 -0800
Message-ID: <20120209004027.GF16877@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com>
 <87ty312ae0.fsf@ti.com>
 <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk>
 <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk>
 <87ipjgx3g3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17320 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab2BIAkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:40:32 -0500
Content-Disposition: inline
In-Reply-To: <87ipjgx3g3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120208 15:49]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> > Does it fix the other issues I mention in the commit log as well?
> >> 
> >> Like your patches 1 & 5, my series fixes the oops and also makes the
> >> error strings simple, non-wrapping ones.
> >> 
> >> The one thing it doesn't fix is the spelling typo you fixed in the
> >> comment, but IMO we can leave that out for -rc.
> >
> > OK, but it would be much better for that simple fix to go with another
> > simple patch.  On its own it doesn't make sense as a commit.
> 
> Agreed.  We'll have some other VC/VP cleanup for v3.4, and I'll add this
> into that cleanup.

Eek, looking at it, I'd rather stay away from this formatting patch
for -rc series because the flaming potential causes me rash!

Russell's patch 5 has way better description for the -rc series.

So I now suggest that Russell drops patch 1 and updates patch 5 to
cover both vp.c and vc.c.

Then I'll move the following patches queued by Kevin from cleanup
into fixes:

d269914ece0498f31603ecd85ed3d7a586b3cbcd ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
af9a2ed9667b49e7e125eac526d8f655183ce53e ARM: OMAP2+: voltage: add check for missing PMIC info in VP init

Everybody OK with that?

Tony
