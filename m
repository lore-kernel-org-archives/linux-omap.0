From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Thu, 25 Oct 2012 10:46:27 -0700
Message-ID: <20121025174627.GU11928@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121023101036.GA1542@n2100.arm.linux.org.uk>
 <20121025010917.GL11928@atomide.com>
 <87d30631ob.fsf@deeprootsystems.com>
 <871ugm310v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12853 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756494Ab2JYRq3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 13:46:29 -0400
Content-Disposition: inline
In-Reply-To: <871ugm310v.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [121025 10:39]:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Tony Lindgren <tony@atomide.com> writes:
> >
> [...]
> 
> >>> omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
> >>> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> >>> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> >>> mmc1: host does not support reading read-only switch. assuming write-enable.
> >>> 
> >>> This looks much better compared to the previous set, but we could still
> >>> do with getting a "\n" on at least one of those messages...
> >>
> >> Kevin, do you have a patch for some of this?
> >>
> >
> > I'll fix up the missing newline right away.
> 
> Patch sent.

OK thanks.
 
> > I was planning to leave the VC mismatch problem because it's fixed in
> > Tero's auto retention series.  However, I haven't been able to get to
> > that series yet due to all the regressions/bugfixes, so I'll at least
> > pull out the part that fixes up the mistmatch and submit it for v3.7.
> 
> On closer look, I don't think a quick fix is right for this one. Those
> I2C config mismatch warnings are legitmate for now, and will be fixed
> when Tero's series is merged.

OK fine with me.

Regards,

Tony
 

> > [1] http://marc.info/?l=linux-omap&m=134859084918176&w=2
