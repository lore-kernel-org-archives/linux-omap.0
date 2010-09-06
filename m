From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 6 Sep 2010 11:03:47 -0700
Message-ID: <20100906180346.GC20849@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49703 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab0IFSEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 14:04:01 -0400
Content-Disposition: inline
In-Reply-To: <20100906104413.GD20903@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100906 03:36]:
> Here's my latest patch (which is combined from two patches.)
> 
> Tony, could you follow up with patches for anything which is still
> required - I think there's two things you've addressed which this
> currently misses:
> 
> 1. not initializing twd_base (I'm not convinced this is safe - rather
>    making smp_prepare_cpus() return early is probably a better idea.)
> 2. __flush_icache_all()
> 
> Note that (2) seems to be complicated by the instruction only being
> available on ARMv7 and later.

Yeah will check probably on Tuesday, heading to a BBQ as it's a holiday
here. Also my laptop cooling fan broke a few days ago, got it patched up
temporarily though: An external fan duct taped to the side of the machine
until the replacement arrives :)
 
> Also note that this should only be used for comparing SMP vs UP versions
> of the same architecture - in other words, not ARMv6 vs ARMv6K.

Right, ARMv6 vs ARMv6K can be dealt with in another patch once this
is done.
 
> Lastly, what's happening about ARMv6 and ARMv7 processor setup functions?
> Are we going to split them into those which need SMP bits twiddled and
> those which don't?  If we are going to split them, someone needs to follow
> up on this email with patches to do it (preferably to be slotted in
> before these changes.)

No need to split them any longer AFAIK. Or do you have some case in mind
that's not being handled now, maybe I don't follow you?

Regards,

Tony 
