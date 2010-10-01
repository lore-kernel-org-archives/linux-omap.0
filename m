From: Tony Lindgren <tony@atomide.com>
Subject: Re: Dropping omap3430 ES1.0 support in mainline
Date: Fri, 1 Oct 2010 14:58:32 -0700
Message-ID: <20101001215832.GC3117@atomide.com>
References: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52299 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab0JAV6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:58:38 -0400
Content-Disposition: inline
In-Reply-To: <d0443bbf588bf1e8a7efbd0014816753@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar@ti.com> [101001 14:38]:
> Tony, all,
> 
> The OMAP3430 ES1.0 was pretty much a test chip, with the only known board
> being the 3430ES1.0 SDP. There are only a small number of these boards
> outside TI and within TI, they've likely never been used in over 2 years.
> It's unlikely that these boards still work on mainline, and likely have
> been broken in linux-omap since the very beginning.
> 
> Between ES1.0 and ES2.0 we've had several major changes in the clock
> nodes,
> and IPs. However we're still keeping code/data on these in the kernel
> today.
> 
> Since all later OMAP3 chips have been very similar to ES2.0, it probably
> makes sense to drop support for the ES1.0. This would result in a small
> but probably significant reduction in the current code. If you're okay
> with dropping this support, we can slowly start working on this.
> 
> What do you think?

No thanks!

Tony
