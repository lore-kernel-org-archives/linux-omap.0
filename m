From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
Date: Fri, 19 Oct 2012 08:56:12 -0700
Message-ID: <20121019155612.GA4730@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
 <20121018054934.GE11137@arwen.pp.htv.fi>
 <20121019014917.GL30550@atomide.com>
 <20121019065500.GD12235@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13358 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754695Ab2JSP4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 11:56:17 -0400
Content-Disposition: inline
In-Reply-To: <20121019065500.GD12235@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [121019 00:01]:
> On Thu, Oct 18, 2012 at 06:49:17PM -0700, Tony Lindgren wrote:
> > 
> > Yes. Figured it out, it fails to apply with quilt, but applies
> > with git.
> 
> probably because of file rename.

Yeh so it seems.
 
> > But it does not compile with all configs though, and does
> > not remove plat/usb.h. Thanks anyways. I'll post a proper
> > series shortly with your patch fixed up.
> 
> ok... I'll check it out. I kept the non-static functions in plat/usb.h
> because they didn't belong on platform_data/usb-omap.h. What should be
> done with those, then ? move to mach/ ?

I made a clean-up patch that creates local usb.h file for those
that applies before your patch.

Regards,

Tony
