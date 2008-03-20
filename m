From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: OMAP: Fix clockevent support for hrtimers
Date: Thu, 20 Mar 2008 17:03:28 +0200
Message-ID: <20080320150327.GN14978@atomide.com>
References: <1205423119-22292-1-git-send-email-tony@atomide.com> <1205423119-22292-2-git-send-email-tony@atomide.com> <20080320144346.GA16166@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56654 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbYCTPD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 11:03:56 -0400
Content-Disposition: inline
In-Reply-To: <20080320144346.GA16166@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080320 16:45]:
> On Thu, Mar 13, 2008 at 05:45:14PM +0200, Tony Lindgren wrote:
> > Signed-off-by: Tim Bird <tim.bird@am.sony.com>
> > Signed-off-by: Kevin Hilman <khilman@mvista.com.
> 
> Only just spotted this... That trailing '.' should be a '>'.
> 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Any chance of getting that fixed and I'll re-pull?

Sure, it's now rebased against v2.6.25-rc6-117-g457fb60 with the
typo fixed.

Tony
