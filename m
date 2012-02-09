From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Thu, 9 Feb 2012 00:11:35 +0000
Message-ID: <20120209001135.GF25414@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk> <20120208184539.GE29796@atomide.com> <87ty312ae0.fsf@ti.com> <20120208235358.GD16877@atomide.com> <20120208235620.GE25414@n2100.arm.linux.org.uk> <87sjikx3xv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47187 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432Ab2BIALr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:11:47 -0500
Content-Disposition: inline
In-Reply-To: <87sjikx3xv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > Does it fix the other issues I mention in the commit log as well?
> 
> Like your patches 1 & 5, my series fixes the oops and also makes the
> error strings simple, non-wrapping ones.
> 
> The one thing it doesn't fix is the spelling typo you fixed in the
> comment, but IMO we can leave that out for -rc.

OK, but it would be much better for that simple fix to go with another
simple patch.  On its own it doesn't make sense as a commit.
