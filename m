From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] USB: Remove omap2 support from omap_udc.c
Date: Tue, 22 May 2012 09:06:09 -0700
Message-ID: <20120522160608.GB16308@atomide.com>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190111.927.38546.stgit@muffinssi.local>
 <20120522070914.GD30559@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22074 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2EVQGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 12:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20120522070914.GD30559@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120522 00:15]:
> On Mon, May 21, 2012 at 12:01:11PM -0700, Tony Lindgren wrote:
> > There are no active users of this code for omap2 as
> > the boards in use have either TUSB or MUSB controller.
> > 
> > While at it, also fix warnings related to uninitialized
> > dc_clk and hhc_clk.
> > 
> > Cc: linux-usb@vger.kernel.org
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This one doesn't depend on the rest of the series, I can take it myself
> to v3.6 or you can take it with your series:

Yes you can take this one.

Thanks,

Tony
