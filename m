From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v10 00/11] dmtimer adaptation to platform_driver
Date: Thu, 17 Feb 2011 16:57:06 -0800
Message-ID: <20110218005706.GR20795@atomide.com>
References: <1297861220-831-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22323 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab1BRA5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 19:57:11 -0500
Content-Disposition: inline
In-Reply-To: <1297861220-831-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

Hi,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110216 04:56]:
> dmtimer adaptation to platform_driver.
> 
> This patch series is adaptation of dmtimer code to platform driver
> using omap_device and omap_hwmod abstraction.

Looks like this needs rebasing on top of current omap-for-linus
because of the omap4 hwmod data being merged.

Also note that you may need to change things with the clock
init with init_early changes.

That's something we need to consider carefully as we don't
necessarily want to have the system timer depend on hwmod
and clock framework. But that can be fixed later on after
your patch series.

Tony
