From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap-usb-tll build broken in linux next
Date: Fri, 21 Sep 2012 15:29:03 -0700
Message-ID: <20120921222903.GM28835@atomide.com>
References: <20120920183442.GH28835@atomide.com>
 <20120921220817.GZ28670@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54120 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754283Ab2IUW3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 18:29:06 -0400
Content-Disposition: inline
In-Reply-To: <20120921220817.GZ28670@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>

* Samuel Ortiz <sameo@linux.intel.com> [120921 15:09]:
> Hi Tony,
> 
> On Thu, Sep 20, 2012 at 11:34:42AM -0700, Tony Lindgren wrote:
> > Hi Keshava & Felipe,
> > 
> > Looks like we have something broken in linux next:
> > 
> > make[2]: *** No rule to make target `drivers/mfd/omap-usb-tll.o', needed by `drivers/mfd/built-in.o'.  Stop.
> > 
> > This is at least with my n8x0 config, see the attached file.
> Thanks for the notification. Felipe was right, I forgot a git add...It should
> be all fixed now.

OK thanks!

Tony
