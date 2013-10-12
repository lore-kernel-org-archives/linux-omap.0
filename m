From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Fri, 11 Oct 2013 17:34:33 -0700
Message-ID: <20131012003433.GJ29913@atomide.com>
References: <1381391028-4189-1-git-send-email-r.sricharan@ti.com>
 <5256A7AE.6000605@ti.com>
 <20131010171540.GG29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37486 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752129Ab3JLAei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 20:34:38 -0400
Content-Disposition: inline
In-Reply-To: <20131010171540.GG29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, nm@ti.com, Rajendra Nayak <rnayak@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>

* Tony Lindgren <tony@atomide.com> [131010 10:23]:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [131010 06:20]:
> > On Thursday 10 October 2013 03:43 AM, Sricharan R wrote:
> > > From: R Sricharan <r.sricharan@ti.com>
> > > 
> > > The realtime counter called master counter, produces the count
> > > used by the private timer peripherals in the MPU_CLUSTER. The
> > > CNTFRQ per cpu register is used to denote the frequency of the counter.
> > > Currently the frequency value is passed from the
> > > DT file, but this is not scalable when we have other non-DT guest
> > > OS. This register must be set to the right value by the
> > > secure rom code. Setting this register helps in propagating the right
> > > frequency value across OSes.
> > > 
> > > More discussions and the reason for adding this in a non-DT
> > > way can be seen from below.
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html
> > > 
> > > So configuring this secure register for all the cpus here.
> > > 
> > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Cc: Rajendra Nayak <rnayak@ti.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Tested-by: Nishanth Menon <nm@ti.com>
> > > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > > ---
> > >  [V5] Removed the use of extern variable in omap-smp.c
> > >       as per suggestion from Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > 
> > Thanks for the updates Sricharan. Looks fine now.
> > 
> > Tony, Can you apply this version if you are fine with it.
> 
> Yes thanks looks good to me now. Applying into omap-for-v3.13/soc.

Grr, had to apply the following fix on top of this for some configs.

Tony

8< ---------------------------

From: Tony Lindgren <tony@atomide.com>
Date: Fri, 11 Oct 2013 17:28:04 -0700
Subject: [PATCH] ARM: OMAP2+: Fix build error for realtime counter init if not enabled

Otherwise we can get an error with some configs:

arch/arm/mach-omap2/timer.c:73: undefined reference to `omap_smc1'

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -66,12 +66,15 @@
 
 static struct omap_dm_timer clkev;
 static struct clock_event_device clockevent_gpt;
+
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 static unsigned long arch_timer_freq;
 
 void set_cntfreq(void)
 {
 	omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);
 }
+#endif
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
