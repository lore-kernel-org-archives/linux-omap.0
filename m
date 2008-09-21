From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP support in mainline?
Date: Sun, 21 Sep 2008 11:42:33 -0700
Message-ID: <20080921184232.GD7961@atomide.com>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <87y71rqo43.fsf@nokia.com> <20080917165350.GF25885@atomide.com> <20080917165725.GG25885@atomide.com> <20080917203247.GP5484@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56801 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbYIUSjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 14:39:54 -0400
Content-Disposition: inline
In-Reply-To: <20080917203247.GP5484@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kalle Valo <kalle.valo@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080917 13:33]:
> On Wed, Sep 17, 2008 at 09:57:25AM -0700, Tony Lindgren wrote:
> > If any ATAGs are needed, such as for the serial console, it needs to
> > be a generic ATAG for whole arch/arm.
> 
> Why is it needed for serial console anyway?  We already have a cross-
> architecture way of defining the console - it's the 'console=' argument
> given to the kernel at boot time via the argument string.

In this case the hardware changes when the device is connected to a
service jig. The serial port won't work without an external level
converter that is on the jig. I guess console= could set UPF_DEAD
or something similar for 8250.c to ignore that port rather than leave
it out of the plat_serial8250_port.

Regards,

Tony
