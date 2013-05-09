From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3430 fails to boot
Date: Thu, 9 May 2013 08:20:48 -0700
Message-ID: <20130509152047.GA32546@atomide.com>
References: <20130509084906.GL21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14240 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753554Ab3EIPUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 May 2013 11:20:53 -0400
Content-Disposition: inline
In-Reply-To: <20130509084906.GL21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130509 01:54]:
> I've not looked into the reason why yet, so this is a heads-up.  I
> notice this morning that the LDP3430 failed to boot last night,
> whereas it worked the previous night.  However, SDP4430 looks fine.
> 
> Nothing obvious in the diffstat between the two... but then the patch
> between the two kernels is almost 1.5MB.  The arch/arm changes are
> quite small though:
> 
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/Makefile                         |    4 +-
>  arch/arm/boot/dts/xenvm-4.2.dts                    |   13 +
>  arch/arm/include/asm/xen/hypercall.h               |    1 +
>  arch/arm/mach-msm/last_radio_log.c                 |    2 +-
>  arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
>  arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
>  arch/arm/mach-omap2/timer.c                        |    4 +
>  arch/arm/mach-vexpress/v2m.c                       |    1 -
>  arch/arm/mach-virt/virt.c                          |    1 +

Since one boots and one won't, you're probably missing this one:

956e46ef mm/slab: Fix crash during slab init

Looking at your diffstat you probably have this as otherwise
nothing boots:

9affd6be arm: fix mismerge of arch/arm/mach-omap2/timer.c

Let me know if you still have the issue after updating to 956e46ef.

Regards,

Tony
