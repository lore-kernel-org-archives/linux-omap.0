From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 26/30] mmc: update workqueue usages
Date: Mon, 10 Jan 2011 11:54:48 -0800
Message-ID: <20110110195448.GJ4957@atomide.com>
References: <1292086307-19211-27-git-send-email-tj@kernel.org>
 <20110109023058.GA17232@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14118 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab1AJTy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 14:54:56 -0500
Content-Disposition: inline
In-Reply-To: <20110109023058.GA17232@void.printf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

Hi,

* Chris Ball <cjb@laptop.org> [110108 18:33]:
> Hi linux-omap folks,
> 
> I'd like to merge this patch via the MMC tree; please review/ACK.
> 
> Thanks,
> 
> - Chris.
> 
> From: Tejun Heo <tj@kernel.org>
> 
> Workqueue creation API has been updated and flush_scheduled_work() is
> deprecated and scheduled to be removed.
> 
> * core/core.c: Use alloc_ordered_workqueue() instead of
>   create_singlethread_workqueue().  This removes an unnecessary
>   rescuer.
> 
> * host/omap.c: Create, use and flush mmc_omap_wq instead of the
>   system_wq.
> 
> * Flush host->mmc_carddetect_work directly on removal instead of using
>   flush_scheduled_work().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> ---
> This is part of a series to remove flush_scheduled_work() usage to
> prepare for deprecation of flush_scheduled_work().  Patches in this
> series are self contained and mostly straight-forward.
> 
> Please feel free to take it into the appropriate tree, or just ack it.
> In the latter case, I'll merge the patch through the workqueue tree
> during the next merge window.

Seems to work just fine, tested on n800 for omap.c and omap4 panda
for omap_hsmmc.c. Please feel free to queue via workqueue tree as
long as the MMC people are fine with that:

Tested-by: Tony Lindgren <tony@atomide.com>
