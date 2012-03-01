From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3: Modify omap_hsmmc_late_init to handle
 deleting mmc devices
Date: Thu, 1 Mar 2012 10:58:54 -0800
Message-ID: <20120301185854.GA18901@atomide.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
 <1330077537-19618-6-git-send-email-rnayak@ti.com>
 <20120225003352.GC18901@atomide.com>
 <4F48677E.30803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23399 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116Ab2CAS65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 13:58:57 -0500
Content-Disposition: inline
In-Reply-To: <4F48677E.30803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120224 20:14]:
> On Saturday 25 February 2012 06:03 AM, Tony Lindgren wrote:
> >Hi,
> >
> >* Rajendra Nayak<rnayak@ti.com>  [120224 01:27]:
> >>omap_hsmmc_late_init() adds deferred (if any) mmc devices which are
> >>dependent on twl4030-gpio device to be available.
> >>If twl4030-gpio is built as a module and inserted and deleted multiple
> >>times, the mmc devices also should be added and deleted accordingly.
> >>Split omap_hsmmc_late_init() into omap_hsmmc_deferred_add() and
> >>omap_hsmmc_deferred_del() to handle this.
> >>The .setup board hook for twl4030-gpio handles the runtime adding
> >>on deferred mmc devices. Similarly a .teardown board hook for twl4030-gpio
> >>should handle the runtime deletion by calling omap_hsmmc_deferred_del().
> >>This is done for all existing omap3 boards in subsequent patches.
> >
> >This gets complex.. But I think I've found a simpler way where we
> >can use the twl gpio offsets and let the drivers take care of the rest.
> >I'll post some patches hopefully on Monday.
> 
> I agree it gets complex. If you have a simpler way to handle this, that
> would be great.

Posted now, sorry it too a bit longer, I got distracted with other
stuff. The thread is "[PATCH 0/4] Start getting rid of pdata callbacks
with gpio_find_by_chip_name()". Some further testing would be
appreciated.

Regards,

Tony
