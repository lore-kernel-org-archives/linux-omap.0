From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/12] ARM: omap2plus_defconfig: Shrink with savedefconfig
Date: Thu, 18 Sep 2014 08:57:32 -0700
Message-ID: <20140918155731.GC14505@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
 <1410837126-31553-8-git-send-email-tony@atomide.com>
 <20140916045603.GA10498@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20563 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756224AbaIRP5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 11:57:46 -0400
Content-Disposition: inline
In-Reply-To: <20140916045603.GA10498@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140915 21:57]:
> Hi,
> 
> On Mon, Sep 15, 2014 at 08:12:02PM -0700, Tony Lindgren wrote:
> > This saves few lines and makes it easier to make patches
> > against omap2plus_defconfig.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> while at that, can you enable voluntary preemption ?

OK, can you do a separate patch for that with a brief description
why it should be enabled?

Regards,

Tony
