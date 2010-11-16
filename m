From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using
 Dual-mode Timers
Date: Tue, 16 Nov 2010 12:20:31 -0800
Message-ID: <20101116202031.GD9264@atomide.com>
References: <C9081DFE.1FEE7%marathon96@gmail.com>
 <87hbfhcagv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25411 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0KPUUm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 15:20:42 -0500
Content-Disposition: inline
In-Reply-To: <87hbfhcagv.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [101116 11:43]:
> Grant Erickson <marathon96@gmail.com> writes:
> 
> [...]
> 
> >> Before something like this can merge, I would rather see
> >> 
> >> 1) generic PWM framework pushed along and merged
> >> 2) the dmtimer hwmod conversion finished
> >> 
> >> Yes, I know it's a lot more work to fix the core/framework code before
> >> having a feature included, but having something more generic that can
> >> actually support multiple PWM sources is clearly needed.
> >
> > No disagreement on the long-term architectural and design goals. All good
> > stuff.
> >
> > However, patches have to be submitted against the repository and branch we
> > have today, not those we might have tomorrow.
> 
> This comment is where we diverge. 
> 
> An alternative to waiting for the generic framework cleanup/refactor
> work is to contribute to it and help it along.

Yeah I agree, with Kevin. We should not export any more omap specific
functions in arch/arm/*omap*/ as they always lead into maintenance
nightmares later on. We still have several merge cycles of work just
to get rid of the existing exported functions.

Regards,

Tony

