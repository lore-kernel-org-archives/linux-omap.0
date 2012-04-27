From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/8] gpio/omap: remaining cleanups and fix
Date: Fri, 27 Apr 2012 13:07:59 -0600
Message-ID: <20120427190759.C6DC43E0B4D@localhost>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:34890 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758719Ab2D0TIC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 15:08:02 -0400
Received: by dadz8 with SMTP id z8so1374369dad.10
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 12:08:02 -0700 (PDT)
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 27 Apr 2012 19:43:30 +0530, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
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

The changes look fine to me.  Which branch should this series be
merged through?  It can either go via arm-soc or my gpio/next branch.

g.

