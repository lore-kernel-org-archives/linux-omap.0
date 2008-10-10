From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Fri, 10 Oct 2008 08:32:51 +0100
Message-ID: <20081010073251.GN435@flint.arm.linux.org.uk>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36646 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYJJHdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 03:33:09 -0400
Content-Disposition: inline
In-Reply-To: <20081009151724.GK26230@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Oct 09, 2008 at 06:17:25PM +0300, Tony Lindgren wrote:
> Sure, I'll post a minimal LDP patch separately tomorrow. I don't have
> an LDP so I can't verify it boots though.

Unfortunately, Linus has been unpredictable, and released 2.6.27 last
night, rather than the usual one week after -rc9.

What this means is that the merge window is now open, and I shouldn't
be accepting anything else into my kernel tree.

However, if you can get LDP in by this evening, I'll pull it into the
tree.  That will be the final devel code merged into my tree for 2.6.28.
