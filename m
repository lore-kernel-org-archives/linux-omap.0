From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: gpmc: Print error message in
 set_gpmc_timing_reg()
Date: Wed, 29 Oct 2014 07:13:24 -0700
Message-ID: <20141029141323.GY2542@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
 <1413895309-9152-2-git-send-email-rogerq@ti.com>
 <20141028222349.GV2542@atomide.com>
 <5450AA4D.9040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36308 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbaJ2OOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 10:14:39 -0400
Content-Disposition: inline
In-Reply-To: <5450AA4D.9040708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

* Roger Quadros <rogerq@ti.com> [141029 01:51]:
> On 10/29/2014 12:23 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [141021 05:43]:
> >> Simplify set_gpmc_timing_reg() and always print error message
> >> if the requested timing cannot be achieved due to a too fast
> >> GPMC functional clock, irrespective if whether DEBUG is defined
> >> or not. This should help us debug timing configuration issues,
> >> which were otherwise simply not being displayed in the kernel log.
> > 
> > I think some newer versions of GPMC have a divider in the
> > GPMC_CONFIG regs somewhere but we're not currently using it.
> > Probably does not affect this patch, just FYI.
> 
> Right, we don't use it. In the future it could be a possibility that the GPMC
> driver scales the clock as necessary by using the GPMC_FCLK divider
> to accommodate slower devices. But then again, who needs slower devices? ;)

I think some devices need such slow timings that we're already
hitting the issue with 200MHz L3 on 37xx connected to a SMSC
LAN9220 at least. With LAN9221 this is not an issue with faster
timings. Anyways, I think the issue is out of the way now with
LAN9220 and GPMC_FCLK divider support can be added later on as
needed.

Regards,

Tony
