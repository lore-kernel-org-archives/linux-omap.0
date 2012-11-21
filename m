From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/1] twl4030: Fix chained irq handling on resume from
 suspend
Date: Wed, 21 Nov 2012 17:47:29 +0100
Message-ID: <20121121164729.GC18738@sortiz-mobl>
References: <1350399575-13240-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19342 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab2KUQri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 11:47:38 -0500
Content-Disposition: inline
In-Reply-To: <1350399575-13240-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, omaplinuxkernel@gmail.com, linux-i2c@vger.kernel.org, w.sang@pengutronix.de, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, shubhrajyoti@ti.com, huzefank@ti.com, nm@ti.com

Hi Kalle,

On Tue, Oct 16, 2012 at 05:59:35PM +0300, Kalle Jokiniemi wrote:
> The irqs are enabled one-by-one in pm core resume_noirq phase.
> This leads to situation where the twl4030 primary interrupt
> handler (PIH) is enabled before the chained secondary handlers
> (SIH). As the PIH cannot clear the pending interrupt, and
> SIHs have not been enabled yet, a flood of interrupts hangs
> the device.
> 
> Fixed the issue by setting the SIH irqs with IRQF_EARLY_RESUME
> flags, so they get enabled before the PIH.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
> ---
>  drivers/mfd/twl4030-irq.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
Thanks, patch applied to my for-linus branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
