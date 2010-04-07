From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [PATCH v4 1/5] omap3: pm: fix for twl4030 script load
Date: Wed, 7 Apr 2010 06:42:11 -0700
Message-ID: <20100407134211.GJ7153@atomide.com>
References: <1270030828-2032-1-git-send-email-leslyam@ti.com>
 <20100402102240.GE8010@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab0DGNmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 09:42:12 -0400
Content-Disposition: inline
In-Reply-To: <20100402102240.GE8010@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lesly A M <leslyam@ti.com>, linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

* Samuel Ortiz <sameo@linux.intel.com> [100402 03:18]:

<snip>

> Tony, I think it would make sense for this patchset to go through the
> linux-omap tree.
> If you agree, please add my:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> to the patch below.

I'm pretty much overwhelmed already with all the patches already,
so I'd rather stay out of the drivers/* path for now thanks.

How about if somebody familiar with the twl hardware and driver
sets up the drivers/mfd/twl* patches to some git tree? Then we
keep merging that into linux-omap master branch for testing. And
then Samuel pulls it as needed and sends them to Linus.

Maybe Peter p2 De Schrijver could do it? Peter knows a lot about
this driver and hardware, deals with it on regular basis, and
wrote a lot of the code that Amit later got merged upstream.

Comments?

Regards,

Tony
