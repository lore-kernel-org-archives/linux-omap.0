From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
Date: Tue, 8 May 2012 15:17:20 -0700
Message-ID: <20120508221720.GN5088@atomide.com>
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
 <87zk9j5216.fsf@ti.com>
 <20120508205822.GF5088@atomide.com>
 <8762c6mkyc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19001 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab2EHWRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:17:22 -0400
Content-Disposition: inline
In-Reply-To: <8762c6mkyc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120508 14:20]:
> 
> This last "removal" patch depends on the am35x clock changes that are in
> devel-prcm too.  So in order to apply it, I'd need a stable base with
> your cleanup and devel-prcm branches.
> 
> It's not a big deal though, it can wait until v3.5 as well.

OK let's avoid adding more dependencies if possible.. If it just
removes stuff, let's do it at the end of the merge window, or
at v3.5-rc1.

Regards,

Tony
