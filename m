From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Make FS USB omap1 only
Date: Tue, 22 May 2012 09:07:25 -0700
Message-ID: <20120522160724.GC16308@atomide.com>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190109.927.44462.stgit@muffinssi.local>
 <20120522070824.GC30559@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43323 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab2EVQHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 12:07:30 -0400
Content-Disposition: inline
In-Reply-To: <20120522070824.GC30559@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120522 00:14]:
> On Mon, May 21, 2012 at 12:01:09PM -0700, Tony Lindgren wrote:
> > As the FS USB code is not being actively used for omap2+
> > there's no point keeping it around for omap2+.
> > 
> > Let's make the FS USB platform init code omap1 only so
> > we can remove the last user of omap_read/write for omap2+,
> > and simplify things for further USB, DMA, and device tree
> > related work.
> > 
> > While at it, also group the mach includes for the related
> > drivers.
> > 
> > Cc: linux-usb@vger.kernel.org
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Are you planning to send this on v3.5 or v3.6 ? I guess it's too late
> for v3.5 ?!?

First one I can merge as a fix, patches 2 and 3 for v3.6, then
patch 4 up to you, I suggest v3.6.

Regards,

Tony
