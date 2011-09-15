From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP voltage layer cleanup for v3.2
Date: Thu, 15 Sep 2011 16:30:22 -0700
Message-ID: <20110915233021.GE2284@atomide.com>
References: <87d3f14n4k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34303 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935411Ab1IOXa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 19:30:26 -0400
Content-Disposition: inline
In-Reply-To: <87d3f14n4k.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [110915 11:59]:
> Tony,
> 
> Please pull the OMAP voltage layer cleanup for v3.2.
> 
> This is a combination of the series A..E that have been posted, with
> a handful of updates throughout the comments and kerneldoc.
> 
> It is based on the powerdomain/clockdomain OMAP_CHIP cleanup from Paul
> (his pwrdm_clkdm_remove_omap_chip_cleanup_3.2 branch.)

Thanks, I've pulled Paul's omap_chip_remove_cleanup_3.2 into cleanup
branch and your voltage changes into voltage branch and rebuilt linux-omap
master branch. Then assuming no issues, I'll ask Arnd to pull these
on Friday.

Regards,

Tony
