From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/12] dmtimer adaptation to platform_driver
Date: Fri, 17 Dec 2010 16:15:38 -0800
Message-ID: <20101218001538.GY5941@atomide.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20194 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab0LRAPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 19:15:42 -0500
Content-Disposition: inline
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [101214 09:03]:
> dmtimer adaptation to platform_driver.
> 
> This patch series is adaptation of dmtimer code to platform driver
> using omap_device and omap_hwmod abstraction.
> 
> Tested on following platforms:
> OMAP4430, OMAP3430, OMAP3630, OMAP2430
> OMAP2420, OMAP1710(in-progress)

Looks like this we need to wait on for 2.6.39 merge window to
get all the needed testing done.

With the pending GPIO and DMA changes we are already struggling
to have them tested properly and I'm not planning on merging any more
intrusive code for this merge window after the we get the DMA
changes in hopefully today.

Regards,

Tony
