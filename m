From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP2: fix interrupt number for rng
Date: Wed, 8 Jan 2014 11:18:29 -0800
Message-ID: <20140108191828.GC31323@atomide.com>
References: <1387839579-58292-1-git-send-email-s-anna@ti.com>
 <20140108002843.GI5074@atomide.com>
 <52CD8B7E.8000709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58454 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757056AbaAHTSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 14:18:34 -0500
Content-Disposition: inline
In-Reply-To: <52CD8B7E.8000709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

* Anna, Suman <s-anna@ti.com> [140108 09:33]:
> Tony,
> 
> On 01/07/2014 06:28 PM, Tony Lindgren wrote:
> >* Suman Anna <s-anna@ti.com> [131223 15:01]:
> >>The irq data for rng module defined in hwmod data previously
> >>missed the OMAP_INTC_START relative offset, so the interrupt
> >>number is probably misconfigured during the DT node addition
> >>adjusting for this OMAP_INTC_START. Interrupt #36 is associated
> >>with a watchdog timer, so fix the rng module's interrupt to the
> >>appropriate interrupt #52.
> >
> >Hmm indeed as the .dtsi files were generated from the hwmod
> >data. Are the other interrupts fixed earlier OK?
> 
> GPMC DT nodes are already configured properly, the ISP MMU one needs
> fixing. I left it out to be fixed as part of Florian's patch that
> corrects the ISP MMU DT node. There is no IVA MMU DT node yet, and
> will add the correct number when we add the DT node.

OK thanks, adding this into omap-for-v3.14/dt as it won't
be needed earlier.

Regards,

Tony
