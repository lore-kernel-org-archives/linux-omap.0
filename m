From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP support in mainline?
Date: Sun, 21 Sep 2008 19:51:03 +0100
Message-ID: <20080921185103.GB17746@flint.arm.linux.org.uk>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <87y71rqo43.fsf@nokia.com> <20080917165350.GF25885@atomide.com> <20080917165725.GG25885@atomide.com> <20080917203247.GP5484@flint.arm.linux.org.uk> <20080921184232.GD7961@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42522 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYIUSvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 14:51:37 -0400
Content-Disposition: inline
In-Reply-To: <20080921184232.GD7961@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Sun, Sep 21, 2008 at 11:42:33AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080917 13:33]:
> > On Wed, Sep 17, 2008 at 09:57:25AM -0700, Tony Lindgren wrote:
> > > If any ATAGs are needed, such as for the serial console, it needs to
> > > be a generic ATAG for whole arch/arm.
> > 
> > Why is it needed for serial console anyway?  We already have a cross-
> > architecture way of defining the console - it's the 'console=' argument
> > given to the kernel at boot time via the argument string.
> 
> In this case the hardware changes when the device is connected to a
> service jig. The serial port won't work without an external level
> converter that is on the jig.

If the external level converter is missing, UARTs behave in exactly the
same way as if the cable isn't connected (provided they have the pull-up
on the RXD line to keep it at mark state.)

> I guess console= could set UPF_DEAD or something similar for 8250.c to
> ignore that port rather than leave it out of the plat_serial8250_port.

Well, by passing an ATAG, you're saying that the boot loader has this
knowledge.  So, if the boot loader has this knowledge, why can't it
pass the relevant 'console=' argument appropriate to the hardware
configuration?

If it's already doing this via an ATAG, there's no reason it can't do
it via the command line.
