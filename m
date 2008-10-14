From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: linux-next: manual merge of the arm tree
Date: Tue, 14 Oct 2008 08:59:50 +0100
Message-ID: <20081014075950.GA22855@flint.arm.linux.org.uk>
References: <20081014132745.051f6418.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47438 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYJNIAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 04:00:14 -0400
Content-Disposition: inline
In-Reply-To: <20081014132745.051f6418.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-next@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>, Syed Mohammed Khasim <khasim@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Oct 14, 2008 at 01:27:45PM +1100, Stephen Rothwell wrote:
> Hi Russell,
> 
> Today's linux-next merge of the arm tree got a conflict in
> arch/arm/plat-omap/devices.c between commit
> 2817142f31bfbf26c216bf4f9192540c81b2d071 ("[WATCHDOG] omap_wdt.c: sync
> linux-omap changes") from Linus' tree and commit
> cc26b3b01bc96a8b8c36671b0dc4898b2a152ea8 ("ARM: OMAP3: Add minimal
> omap3430 support") from the arm tree.
> 
> The former removed code that the latter modified.  I fixed it up
> by just removing the section of code as the former patch seems to take
> account of what the latter is trying to do (but it may not be correct).
> You can fix it by merging Linus' tree and doing this or a similar (maybe
> correct) fixup.

This sounds very messy.  I suspect I need Tony to look at that and
tell me what the right solution is.  However...

Since the OMAP updates I merged from Tony are already broken due to
missing definitions, and I'm not getting any response from Tony on
fixing those, I will be dropping the problematical updates so we can
at least keep mainline OMAP in a buildable state.  That seems to mean
dropping the new OMAP3 support.

That would include dropping the above commit causing the merge conflict.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
