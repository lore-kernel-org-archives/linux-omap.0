From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Wed, 9 Mar 2011 14:02:41 -0800
Message-ID: <20110309220241.GR26463@atomide.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15012 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1CIWCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 17:02:46 -0500
Content-Disposition: inline
In-Reply-To: <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> switch-over to platform device driver through following changes:
> (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> in timer-gp.c. This is equivalent of timer_init()->timer->init().
> (b) modify plat-omap/dmtimer routines to use new register map and
> platform data.

This patch breaks booting for 2420 and makes boot hang early
on 2430. Note that to test with omap-for-linus branch you need
to disable the following in omap2plus_defconfig:

CONFIG_ARCH_OMAP3
CONFIG_ARCH_OMAP4
CONFIG_CPU_32v6K

In general, let's continue with this series after the merge
window. We must merge intrusive changes like this early around
-rc2, not late in the merge window.

Regards,

Tony
