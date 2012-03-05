From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: dmtimer: fix missing content/correction
 in low-power mode support
Date: Mon, 5 Mar 2012 11:36:35 -0800
Message-ID: <20120305193635.GM12083@atomide.com>
References: <1323237434-4919-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29034 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab2CETgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:36:37 -0500
Content-Disposition: inline
In-Reply-To: <1323237434-4919-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [111206 21:25]:
> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
> to use timer->func_base OCP_CFG should not use this wrapper anymore.
> Instead use __raw_writel() directly and use timer->io_base instead
> to write to OCP_CFG.
> 
> The timer->sys_stat is valid only if timer->revision is 1. In the
> context restore function make this correction.
> 
> Save the contexts and loss count when timer is stopped.
> Also, disable the clock. Else, clock usecount would become imbalanced.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Thanks applying this to fixes-non-critical-part2. Sorry for the
delays, looks like I'm a bit behind with patches..

Regards,

Tony
