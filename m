From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 13:21:25 -0800
Message-ID: <200901101321.26068.david-b@pacbell.net>
References: <20090107111415.GF27566@atomide.com> <20090110155612.GA2601@sortiz.org> <20090110162048.GA1327@n2100.arm.linux.org.uk>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39307 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755107AbZAJVVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 16:21:30 -0500
In-Reply-To: <20090110162048.GA1327@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@openedhand.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Saturday 10 January 2009, Russell King - ARM Linux wrote:
> In other words:
> 
>         if (cpu_is_omap2430())
>                 osc = clk_get(NULL, "osc_ck");
>         else
>                 osc = clk_get(NULL, "osc_sys_ck");
> 
> becomes:
> 
>         osc = clk_get(dev, "hfclk");
> 
> since "hfclk" is the name of the input on the device, or it should be
> NULL if it is the only input on the device (iow, you don't want to
> distinguish it from the 32kHz clock.)

Sort of.  The twl4030 has "hfclkin" ... from which it
generates "hfclkout", and that likely becomes "osc_sys_ck"
(or "osc_ck" on omap2430).  Agreed that the OMAP main
clock is actually a proxy for what's needed.


> And that eliminates the need for any platform specific includes (which
> is the whole point of the clk API - giving drivers a _generic_ way to
> get at clock information without resorting to platform specific crap.)

Yeah but ... remembering that the twl4030 is an I2C
device, which is initialized well after the clock
framework and associated SoC platform devices, that
implementation approach begs a few questions:

 - How to associate clocks with non-SoC devices.

   This is an issue that comes up repeatedly when folk
   want to apply <linux/clk.h> calls to things like
   off-chip codecs ... sometimes fed by programmable
   off-chip clock generators, for which one would
   naturally want portable drivers.

 - How to perform *this* association "late", as part
   of setting up the I2C device when its i2c_adapter
   is set up ... and before i2c_driver.probe() for
   the device is called.  This obviously generalizes...

 - Likewise, how to reverse that association when
   that device is removed (e.g. because the adapter
   driver gets removed or unbound).  Also generalizes.

Full answers for those questions imply some degree of
implementation framework for <linux/clk.h> ... a change
from its current status as a pure interface.

Probably "Answers Mark I" would depend on extensions
to the platform specific <linux/clk.h> implementation 
frameworks.

- Dave
