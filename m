From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Tue, 8 May 2012 08:57:07 -0700
Message-ID: <20120508155706.GT5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
 <20120504225857.GB5613@atomide.com>
 <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
 <20120507173749.GE5088@atomide.com>
 <4FA8E525.50506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab2EHP5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:57:11 -0400
Content-Disposition: inline
In-Reply-To: <4FA8E525.50506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

* Cousson, Benoit <b-cousson@ti.com> [120508 02:23]:
> Hi Tony,
> 
> On 5/7/2012 7:37 PM, Tony Lindgren wrote:
> >* R, Sricharan<r.sricharan@ti.com>  [120506 20:39]:
> >>>>+config MACH_OMAP5_SEVM
> >>>>+     bool "OMAP5 sevm Board"
> >>>>+     depends on ARCH_OMAP5
> >>>>+
> >>>>  config OMAP3_EMU
> >>>>       bool "OMAP3 debugging peripherals"
> >>>>       depends on ARCH_OMAP3
> >>>
> >>>No need for it here either. Actually, I think this whole chunk
> >>>can be now left out since it's DT based?
> >>>he
> >>  ok, but the concern here was that without this macro
> >>  the print from compress and subsequently early
> >>prints appear broken.
> >>
> >>machine_is_omap5_sevm becomes zero without this config and
> >>machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
> >>uncompress.h.
> >
> >Ah I see.
> 
> Mmm, still, I guess this mechanism should be deprecated with DT?
> We cannot keep creating fake board entry since we are not supposed
> to have MACHINE_ID anymore.
> That will break DEBUG_LL for sure, but we knew about that current
> limitation with DT.

For most usecases for DEBUG_LL we can get away in two steps:

1. Debug output for uncompress code based on DT parsing (I think
   this is already there)

2. Early console/earlyprintk parsed from DT that gets set up in
   init_early

This should be enough for most users, then the people who need
to debug early kernel code until init_early is done can patch
it in manually.
 
> The point is that we should fix the code to stop relying on a
> machine id going forward.
> And maybe we can parse the FDT at that time?

Yes that should be trivial for most use cases, we just need
to initialize the earlycon/earlyprintk based on the DT.

See kernel/early_printk.c for more info. We just need to
set up the hardware specific function for early_write instead
of printch.

Regards,

Tony
