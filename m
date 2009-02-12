From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/3] musb_hdrc: Clean-up init code for mainline merge
Date: Thu, 12 Feb 2009 21:35:17 +0200
Message-ID: <20090212193515.GO10711@frodo>
References: <20090212191408.19766.62874.stgit@localhost> <20090212192059.GB7562@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42659 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbZBLTf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:35:26 -0500
Content-Disposition: inline
In-Reply-To: <20090212192059.GB7562@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Feb 12, 2009 at 11:21:01AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090212 11:16]:
> > Hi Felipe & Dave,
> > 
> > While creating a patch for usb-musb.c init code for mainline
> > kernel, I ended up cleaning up following stuff in the l-o tree.
> > 
> > Does it look OK to you?
> 
> And here's what the musb_init patch for the mainline. No boards are
> calling musb_init() yet, but that's easy to append.

The attached patch looks nice as well.

> The clock function might cause some merge issues.. I guess eventually
> the driver should just call clk_enable/disable once the omap2 clock
> merge is done.

Yeah, hopefully Russell's work will let us get rid of this
musb_set_clock and use only standard clk_enable/disable() calls.

We only keep that due to different clock names anyway.

-- 
balbi
