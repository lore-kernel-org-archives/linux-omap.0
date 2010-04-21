From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MFD: TWL4030: changes for TRITON glitch fix
Date: Wed, 21 Apr 2010 14:22:03 -0700
Message-ID: <20100421212202.GL18272@atomide.com>
References: <1270809191-17007-1-git-send-email-leslyam@ti.com>
 <877ho1d8se.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58536 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab0DUVWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 17:22:06 -0400
Content-Disposition: inline
In-Reply-To: <877ho1d8se.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Lesly A M <leslyam@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100420 16:01]:
> Lesly A M <leslyam@ti.com> writes:
> 
> > Fix for TWL5030 Silicon Errata 27 & 28:
> > 	27 - VDD1, VDD2, may have glitches when their output value is updated.
> > 	28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
> > 	     is switched from internal to external.
> >
> > Workaround requires the TWL DCDCs to use HFCLKIN instead of internal oscillator.
> >
> > There is a chance for VDD1/VDD2 to collapse to 0 Volt,
> > if we switch the TWL DCDCs to internal oscillator form HFCLKIN
> > while VDD1/VDD2 is active. So during first time when we switch TWLDCDC to
> > HFCLKIN, TWL watchdog timer is used to recover if the VDD1/VDD2 stop working.
> >
> > Using HFCLKIN for TWL DCDCs uncovers another issue when going in and
> > out of OFF mode, if HFCLK is disabled in OFFMODE. So the sleep/wakeup
> > sequence and setuptimes are modified to make sure the switching will
> > happen only when HFCLKIN is stable.
> >
> > This fix is required for TWL5030 Silicon version less than or equal to ES1.1
> > Since the IDCODE register on TWL5030 Si is not updated correctly,
> > version check may not be correct. So if someone want to disable the
> > glitch fix changes during menuconfig, the changes are done under the macro
> > CONFIG_TWL5030_GLITCH_FIX.
> >
> > Changes taken from Nishanth Menons gaia glitch fix patch.
> >
> > Signed-off-by: Lesly A M <leslyam@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: David Derrick <dderrick@ti.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> 
> Thanks for the much improved changelog.  
> 
> Also, this is better called an errata workaround instead of a glitch
> fix.  I'd rather see "glitch" here replaced by the errata numbers.
> Down the road we'll be asking "which glitch?"
> 
> As in the first review, I don't like the Kconfig option.  This errata
> workaround should be in common code and enabled by an optional
> flag in board code.  More on this below...

Me neither. This needs to be set dynamically based on the twl
version.

Tony
