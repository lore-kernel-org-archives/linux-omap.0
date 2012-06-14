From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 04:23:22 -0700
Message-ID: <20120614112322.GJ12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <20120614092957.GE12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9997F4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51872 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab2FNLXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 07:23:25 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9997F4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 02:46]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 14:59:57, Tony Lindgren wrote:
> > * Afzal Mohammed <afzal@ti.com> [120611 07:21]:
> 
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
> > > +
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> > > +
> > 
> > Thinking about this, the CONFIG1 bits have been set with
> > gpmc_cs_write_reg because these are part of the static configuration
> > and do not need to be dynamically calculated as they are tick based.
> > For example, tusb6010 sets GPMC_CONFIG1_CLKACTIVATIONTIME(1) during init.
> 
> But aren't we deciding number of ticks based on clock period ?
> If we take case of onenand, based on the knowledge of clock period,
> number of ticks are calculated.
> 
> And similarly to decide cycle2cycledelay, busturnaround, we decide number
> of ticks based on peripheral datasheet timings & gpmc clock, hence
> shouldn't it also be dynamically calculated similar to timings that were
> existing earlier.

Hmm indeed onenand is setting that dynamically. OK, let's try your
approach and make sure we patch in the missing values so we don't
overwrite the values set with gpmc_cs_write_reg.

Regards,

Tony
