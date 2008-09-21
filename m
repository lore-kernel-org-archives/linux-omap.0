From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP support in mainline?
Date: Sun, 21 Sep 2008 12:04:49 -0700
Message-ID: <20080921190446.GF7961@atomide.com>
References: <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <87y71rqo43.fsf@nokia.com> <20080917165350.GF25885@atomide.com> <20080917165725.GG25885@atomide.com> <20080917203247.GP5484@flint.arm.linux.org.uk> <20080921184232.GD7961@atomide.com> <20080921185103.GB17746@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54234 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIUTCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 15:02:17 -0400
Content-Disposition: inline
In-Reply-To: <20080921185103.GB17746@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kalle Valo <kalle.valo@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080921 11:51]:
> On Sun, Sep 21, 2008 at 11:42:33AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080917 13:33]:
> > > On Wed, Sep 17, 2008 at 09:57:25AM -0700, Tony Lindgren wrote:
> > > > If any ATAGs are needed, such as for the serial console, it needs to
> > > > be a generic ATAG for whole arch/arm.
> > > 
> > > Why is it needed for serial console anyway?  We already have a cross-
> > > architecture way of defining the console - it's the 'console=' argument
> > > given to the kernel at boot time via the argument string.
> > 
> > In this case the hardware changes when the device is connected to a
> > service jig. The serial port won't work without an external level
> > converter that is on the jig.
> 
> If the external level converter is missing, UARTs behave in exactly the
> same way as if the cable isn't connected (provided they have the pull-up
> on the RXD line to keep it at mark state.)

Yeah but 8250 does not know anything about the clock fwk right now. And
unless the service jig is connected, you want to have uarts powered down
and clocks off as they block core retention during idle.

Hmm, does 8250.c even currently know about serial ports that should be
ignored and kept powered down?

> > I guess console= could set UPF_DEAD or something similar for 8250.c to
> > ignore that port rather than leave it out of the plat_serial8250_port.
> 
> Well, by passing an ATAG, you're saying that the boot loader has this
> knowledge.  So, if the boot loader has this knowledge, why can't it
> pass the relevant 'console=' argument appropriate to the hardware
> configuration?
> 
> If it's already doing this via an ATAG, there's no reason it can't do
> it via the command line.

Sure console= could be used. Currently the user must tell the bootloader
to enable "RD mode" over USB, which then tells the kernel to enable the
serial port.

It would be nice to specify all the ports and the status (enabled or
disabled) during uart low-level setup code. Current solution of adding
ports depending on the mode also rearranges the order of the ports,
which is not nice.

Regards,

Tony
