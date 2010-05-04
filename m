From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 4/5(7)] input: serio: add support for Amstrad Delta
	serial keyboard port
Date: Tue, 4 May 2010 21:48:36 +0100
Message-ID: <20100504204836.GJ30601@n2100.arm.linux.org.uk>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl> <201004280310.52678.jkrzyszt@tis.icnet.pl> <20100504204041.GL29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53516 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933657Ab0EDUtT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 16:49:19 -0400
Content-Disposition: inline
In-Reply-To: <20100504204041.GL29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, e3-hacking@earth.li, linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 04, 2010 at 01:40:41PM -0700, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100427 18:09]:
> > The patch introduces a serio driver that supports a keyboard serial port found
> > on the Amstrad Delta videophone board.
> > 
> > After initializing the hardware, the driver reads its input data from a buffer
> > filled in by the board FIQ (Fast Interrupt Request) handler.
> > 
> > Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
> > handling the E3 keyboard (called mailboard) connected to the port. Since the 
> > device generated scancodes differ from what the atkbd expects, a custom key 
> > code to scan code table must be loaded from userspace for the keyboard to be 
> > useable.

What's the rationale for this approach?  There's no requirement for the
atkbd driver to be used for all keyboards.  It seems very obscure (and
backward) way to do things.

Why not implement the serio driver for the IO level, and a separate
keyboard driver which can handle the protocol and interpret the
scancodes?
