From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: omap-usb-tll build broken in linux next
Date: Sat, 22 Sep 2012 00:08:17 +0200
Message-ID: <20120921220817.GZ28670@sortiz-mobl>
References: <20120920183442.GH28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3632 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab2IUWIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 18:08:22 -0400
Content-Disposition: inline
In-Reply-To: <20120920183442.GH28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>

Hi Tony,

On Thu, Sep 20, 2012 at 11:34:42AM -0700, Tony Lindgren wrote:
> Hi Keshava & Felipe,
> 
> Looks like we have something broken in linux next:
> 
> make[2]: *** No rule to make target `drivers/mfd/omap-usb-tll.o', needed by `drivers/mfd/built-in.o'.  Stop.
> 
> This is at least with my n8x0 config, see the attached file.
Thanks for the notification. Felipe was right, I forgot a git add...It should
be all fixed now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
