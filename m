From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Tue, 5 Feb 2013 15:34:07 -0800
Message-ID: <20130205233407.GR25185@atomide.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
 <20130201215154.GV22517@atomide.com>
 <51103247.2030906@ti.com>
 <51103A25.9010401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22911 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755540Ab3BEXeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 18:34:10 -0500
Content-Disposition: inline
In-Reply-To: <51103A25.9010401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130204 14:49]:
> 
> On 02/04/2013 04:12 PM, Jon Hunter wrote:
> > 
> > On 02/01/2013 03:51 PM, Tony Lindgren wrote:
> > 
> >> How about let's fix this properly to start with so we don't add
> >> more blockers moving this code to drivers/bus?
> >>
> >> Looks like gpmc_mem_init() gets called from gpmc_probe() so
> >> we can pass that information in pdev.
> > 
> > I have re-worked this a bit to use platform data. I have also update
> > the logic for testing internal/external boot on omap2430 which is
> > different from omap2420 (according to the TRM). However, I have only
> > boot tested on omap2420. 
> > 
> > Do you know why this was changed in the first place? See below ...
> > 
> > http://permalink.gmane.org/gmane.linux.kernel.commits.head/95931
> > 
> > Heres what I have now ...
> 
> Updated patch (I was missing a kfree()). By the way, this is based
> upon the apollon removal patch. I understand probably needs to be
> rebased on your latest gpmc series too.

Yeah makes sense to me thanks. I'll figure out where to apply this
so we don't get too many dependencies.

Regards,

Tony
