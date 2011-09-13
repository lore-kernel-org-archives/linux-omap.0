From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Tue, 13 Sep 2011 13:36:16 -0700
Message-ID: <20110913203616.GG24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15400 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932562Ab1IMUgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 16:36:21 -0400
Content-Disposition: inline
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:23]:
> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
> 
> The WakeupGen unit is responsible for generating wakeup event
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
> WakeupGen delivers external interrupts directly to the GIC.
...

> +	/*
> +	 * Override GIC architecture specific functions to add
> +	 * OMAP WakeupGen interrupt controller along with GIC
> +	 */
> +	gic_arch_extn.irq_mask = wakeupgen_mask;
> +	gic_arch_extn.irq_unmask = wakeupgen_unmask;
> +	gic_arch_extn.irq_set_wake = wakeupgen_set_wake;
> +	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;

As I've commented before, there should not be any need to tweak
the wakeupgen registers for each interrupt during the runtime.

AFAIK the wakeupgen registers only need to be armed every time
before entering idle.

Regards,

Tony
