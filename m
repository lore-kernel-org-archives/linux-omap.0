From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3: Modify omap_hsmmc_late_init to handle
 deleting mmc devices
Date: Fri, 24 Feb 2012 16:33:52 -0800
Message-ID: <20120225003352.GC18901@atomide.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
 <1330077537-19618-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38088 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab2BYAdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 19:33:55 -0500
Content-Disposition: inline
In-Reply-To: <1330077537-19618-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Rajendra Nayak <rnayak@ti.com> [120224 01:27]:
> omap_hsmmc_late_init() adds deferred (if any) mmc devices which are
> dependent on twl4030-gpio device to be available.
> If twl4030-gpio is built as a module and inserted and deleted multiple
> times, the mmc devices also should be added and deleted accordingly.
> Split omap_hsmmc_late_init() into omap_hsmmc_deferred_add() and
> omap_hsmmc_deferred_del() to handle this.
> The .setup board hook for twl4030-gpio handles the runtime adding
> on deferred mmc devices. Similarly a .teardown board hook for twl4030-gpio
> should handle the runtime deletion by calling omap_hsmmc_deferred_del().
> This is done for all existing omap3 boards in subsequent patches.

This gets complex.. But I think I've found a simpler way where we
can use the twl gpio offsets and let the drivers take care of the rest.
I'll post some patches hopefully on Monday.

Regards,

Tony
