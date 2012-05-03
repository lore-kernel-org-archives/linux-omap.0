From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/8] gpio/omap: remaining cleanups and fix
Date: Thu, 03 May 2012 16:47:44 +0530
Message-ID: <4FA26958.4010304@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47889 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755522Ab2ECLRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 07:17:50 -0400
Received: by obceq6 with SMTP id eq6so2921453obc.23
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 04:17:49 -0700 (PDT)
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Tarun,

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> Here are the remaining cleanup patches. There are broadly
> two categories of cleanups.
> 
> Cat-1: Those missed while introducing new feature like SPARSE_IRQ
>        handling and DT support; use edge/level handlers from
>        generic IRQ framework.
> 
> Cat-2: Removal of redundant fields from struct gpio_bank{} as a
>        result of they being already covered by members within
>        context field of struct gpio_bank{}.
> 
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: 66f75a5d028beaf67c931435fdc3e7823125730c (Linux 3.4-rc4)
> 
> Series is available for reference here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev.git for_3.5/gpio_more_cleanup_fixes
> 
> Test info:
> OMAP2+ platforms: OMAP2430SDP, OMAP3430SDP, OMAP4430SDP
> OMAP1: Bootup test on OMAP1710SDP.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Tarun Kanti DebBarma (8):
>   gpio/omap: remove virtual_irq_start variable
>   gpio/omap: remove saved_fallingdetect, saved_risingdetect
>   gpio/omap: remove suspend_wakeup field from struct gpio_bank
>   gpio/omap: remove saved_wakeup field from struct gpio_bank
>   gpio/omap: remove retrigger variable in gpio_irq_handler
>   gpio/omap: remove suspend/resume callbacks
>   gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()
>   gpio/omap: fix missing check in *_runtime_suspend()
> 
I have reviewed the remaining 3 patches from this series.
Thanks.

Regards
santosh
