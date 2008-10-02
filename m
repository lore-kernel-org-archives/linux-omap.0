From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 16:06:41 +0300
Message-ID: <20081002130641.GG9133@gandalf.research.nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <20081002061237.GB7942@atomide.com> <200810021601.18006.peter.ujfalusi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62408 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYJBNIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 09:08:09 -0400
Content-Disposition: inline
In-Reply-To: <200810021601.18006.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Oct 02, 2008 at 04:01:17PM +0300, ext Peter Ujfalusi wrote:
> 
> Hello,
> 
> the diff between l-o and mainline are these commits regarding to omap-keypad.c:
> 
> commit fdee8764947cde1e6933e7d981ce5b9de00e83e6
> Author: Tony Lindgren <tony@atomide.com>
> Merge current mainline tree into linux-omap tree
> 
> commit ed39c59ff267249e7e789ea3bb64afc1e9afb5bd
> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> omap: fix a load of "warning: symbol 'xxx' was not declared. Should it be static?"
> 
> commit e85a9daa48453a4e7ffedf174b4358cdb444fbbb
> Author: David Brownell <dbrownell@users.sourceforge.net>
> some drivers switch away from OMAP-specific GPIO calls
> 
> Should I take the relevant parts from these commits and send it to linux-input?
> 
> Also there are other things broken in the omap-keypad driver.
> One thing came to my mind is in the omap_kp_enable_store: 
> No matter what platform the code is running it tries to
> enable/disable IRQ number 33 (IH2_BASE + 1), which is not a nice thing
> to do...

you can pass the irq number via a struct resource and use
platform_get_irq() on driver probe and exit calls to handle the
request_irq() and free_irq();

Then you're sure the irq is correct as long as the struct resource as
well initialized.


-- 
balbi
