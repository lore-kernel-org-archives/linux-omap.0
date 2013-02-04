From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Mon, 4 Feb 2013 11:15:52 -0800
Message-ID: <20130204191552.GQ22517@atomide.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
 <20130201215154.GV22517@atomide.com>
 <510C6A3D.70401@ti.com>
 <20130202181147.GC577@atomide.com>
 <510FCE40.5040202@ti.com>
 <20130204174501.GO22517@atomide.com>
 <511001F8.20306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57787 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754406Ab3BDTPz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 14:15:55 -0500
Content-Disposition: inline
In-Reply-To: <511001F8.20306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130204 10:49]:
> On 02/04/2013 11:45 AM, Tony Lindgren wrote:
> > 
> > AFAIK SYSBOOT_n values reflect the boot time values of the actual SYSBOOT
> > pins, so using generic pinconf there makes sense. But this of course should
> > be checked.
> 
> Not sure I am a fan of that idea. It is possible the pins could be
> re-used as GPIOs after reset. Given that the state at reset is latched
> in a register, it is best just to read the register directly.

Yes the physical SYSBOOT pins can be reused as GPIO, but that's are already
handled by the padconf and GPIO registers. This is a different register
showing the boot time pin values for some pins. So it makes sense to use
generic pinconf to make the pin values available to the client drivers
as needed.

The advantage doing it this way is that we don't need to export any omap
custom functions to the drivers from the SCM driver. This way we need zero
platform glue code, and can deal with it directly in the drivers in a
generic way. And all we need to do is just need to map the SoC specific
SYSBOOT pin register in the .dts files.

It may also make sense to export DEVICETYPE this way. At least early omaps
had the GP vs HS mode configured by pulls on some pins during the boot time.
So those bits too may reflect actual physical pins during the boot time
configured by the efuse settings?

> >>> Regarding omap_device, we should find a way to keep the dependencies
> >>> between drivers and the bus code down to minimum. So ideally things
> >>> like this would be only done using just the compatible flag. But the
> >>> pdata we cannot remove quite yet.
> >>
> >> Agree. However, there are several drivers today (gpio, dmtimer, mmc,
> >> serial, dss, etc), that make use of a function pointer to
> >> omap_pm_get_dev_context_loss_count() to determine when the peripheral's
> >> state has been lost. When booting with DT this function pointer is not
> >> populated and so with DT we currently have no way to determine this. I
> >> see this as a blocker to migrating completely to DT. Ideally we would
> >> find a way for RPM to handle this and remove the function pointer.
> >> However, right now we still need a generic way to pass this type of
> >> platform data to drivers.
> > 
> > Yeah pinconf generic won't help us with the legacy boot.
> 
> Right. I view all this sort of thing as system-level device information
> that some drivers may need. It does not seem that we have a good way to
> handle that at the moment. Any ideas?

I suggest just passing it in in pdata for now for the legacy boot. Then
I suggest we make what we can generic with pinconf in the long run.

Regards,

Tony
