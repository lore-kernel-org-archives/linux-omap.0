From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Revert omap3 WDT changes to avoid merge conflict (Re: linux-next: manual merge of the arm tree)
Date: Tue, 14 Oct 2008 21:40:23 +0100
Message-ID: <20081014204022.GB20614@flint.arm.linux.org.uk>
References: <20081014132745.051f6418.sfr@canb.auug.org.au> <20081014075950.GA22855@flint.arm.linux.org.uk> <200810140107.14647.david-b@pacbell.net> <20081014200805.GF8150@atomide.com> <20081014203017.GH8150@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49968 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYJNUkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 16:40:49 -0400
Content-Disposition: inline
In-Reply-To: <20081014203017.GH8150@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, linux-next@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>, Syed Mohammed Khasim <khasim@ti.com>, David Brownell <david-b@pacbell.net>

On Tue, Oct 14, 2008 at 01:30:24PM -0700, Tony Lindgren wrote:
> And here's the patch for Russell to avoid the merge conflict.
> Also in Russell's patch tracking system as patch 5302/1.

This evening, only now having the time to investigate what's going
on there (as a result of added your other patch to fix the build
error I reported on Saturday) it turns out to be much more trivial
a conflict than I was suspecting from sfr's description.

However, the results of the final merge with 'master' on my devel
branch never go to Linus, so your patch may still be required.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
