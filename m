From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
 driver
Date: Fri, 3 Dec 2010 01:34:54 +0530
Message-ID: <20101202200454.GA27696@manju-desktop>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-10-git-send-email-manjugk@ti.com>
 <20101202184419.GR17222@atomide.com>
 <20101202184617.GS17222@atomide.com>
 <20101202184925.GT17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48593 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752829Ab0LBUFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 15:05:36 -0500
Received: by ywf9 with SMTP id 9so4351444ywf.39
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 12:05:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202184925.GT17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Dec 02, 2010 at 10:49:25AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [101202 10:36]:
> > * Tony Lindgren <tony@atomide.com> [101202 10:34]:
> > > 
> > > This fails on omap1 as d is not allocated. Please merge the
> > > following fix.
> > 
> > And another fix here:
> 
> One more fix below.

Thanks. I will merge these fixes.

> 
> Note that even with these three fixes, 5912OSK still fails to
> boot to init. Maybe something wrong with the framebuffer DMA?

Not sure. I don't have omap1 board for testing. Patch series is only 
build tested for omap1.

Can you pls confirm if OSK5912 boots successfully without this patch
series?

If yes, I will cross verify omap1 changes again.

-Manjunath

