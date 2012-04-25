From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 12/19] ARM: OMAP4: PM: update ROM return address for
 OSWR and OFF
Date: Wed, 25 Apr 2012 10:24:14 +0300
Message-ID: <1335338654.2149.101.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <1334914432-26456-13-git-send-email-t-kristo@ti.com>
	 <20120424163916.GN3739@atomide.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2DYHYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 03:24:20 -0400
In-Reply-To: <20120424163916.GN3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Carlos Leija <cileija@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Bryan Buckley <bryan.buckley@ti.com>

On Tue, 2012-04-24 at 09:39 -0700, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [120420 02:39]:
> > @@ -384,6 +386,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> >  	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
> >  
> >  	if (omap4_mpuss_read_prev_context_state()) {
> > +		/*
> > +		 * Dummy dispatcher call after OSWR and OFF
> > +		 * Restore the right return Kernel address (with MMU on) for
> > +		 * subsequent calls to secure ROM. Otherwise the return address
> > +		 * will be to a PA return address and the system will hang.
> > +		 */
> > +		if (omap_type() != OMAP2_DEVICE_TYPE_GP)
> > +			omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
> > +					       FLAG_START_CRITICAL,
> > +					       0, 0, 0, 0, 0);
> > +
> >  		restore_ivahd_tesla_regs();
> >  		restore_l3instr_regs();
> 
> This SoC test here too should be only done once during init.

You sure about this one? I will end up creating a variable omap_is_gp or
such, which looks somewhat silly and is going to be a duplicate (it will
not provide any extra value in addition to the existing omap_type()
check.) Also, similar checks are used elsewhere in the kernel, look at
omap-wakeupgen.c, pm34xx.c, pm44xx.c, control.c for example. Should all
of these be replaced? Well, most of these are related to secure context
saving so maybe the mechanism behind these should be changed somehow
globally.

-Tero


