From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] watchdog: move omap_wdt.h to include/linux/watchdog
Date: Fri, 19 Sep 2008 00:10:34 +0100
Message-ID: <20080918231034.GI14307@flint.arm.linux.org.uk>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <1221776622-22906-4-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38309 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbYIRXKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:10:51 -0400
Content-Disposition: inline
In-Reply-To: <1221776622-22906-4-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 01:23:40AM +0300, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Create a new include/linux/watchdog directory
> for holding watchdog chips headers, move omap_wdt.h
> to the new location and update the include patch in
> the driver source.

What's the reasoning for this change?  As far as I can see, omap_wdt.h
is private to omap_wdt.c, and shouldn't be exposed to anyone else.
In which case, leaving it along side omap_wdt.c is the right thing to
do.

We don't have any rules which say all header files must be in the
include/ sub-tree.
