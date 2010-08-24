From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
Date: Mon, 23 Aug 2010 17:11:00 -0700
Message-ID: <87tymkq38r.fsf@deeprootsystems.com>
References: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49140 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0HXALD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 20:11:03 -0400
Received: by pvg2 with SMTP id 2so2469699pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 17:11:02 -0700 (PDT)
In-Reply-To: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Sat, 14 Aug 2010 21:07:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> +/**
> +* omap2_dm_timer_early_init - top level early timer initialization
> +* called in the last part of omap2_init_common_hw
> +*
> +* uses dedicated hwmod api to parse through hwmod database for
> +* given class name and then build and register the timer device.
> +* at the end driver is registered and early probe initiated.
> +**/
> +void __init omap2_dm_timer_early_init(void)
> +{
> +	omap_hwmod_for_each_by_class("timer_1ms",
> +				omap_dm_timer_early_init, NULL);
> +	omap2_dm_timer_setup();
> +	early_platform_driver_register_all("earlytimer");
> +	early_platform_driver_probe("earlytimer", early_timer_count + 1, 0);
> +}

It's not clear (or documented) why on the 1ms timers should be the only
earlydevices.

For example, GPT12 is used as the system timer on Beagle due to a board
bug in early revs of the board.  That will no longer function with this
approach.

Kevin


